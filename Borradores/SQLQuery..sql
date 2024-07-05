use Northwind

CREATE OR ALTER PROCEDURE sp_Actualizar_Insertar_Clientes 
AS
BEGIN 
    SET NOCOUNT ON;

    -- Actualizar registros existentes
    UPDATE AlmacenDeDatos.dbo.Customers
    SET
        CustomerBk = n.CustomerID,
        CompanyName = n.CompanyName, 
        [Address] = n.[Address],
        City = n.City,
        Region = n.Region,
        Country = n.Country
    FROM Northwind.dbo.Customers AS n
    INNER JOIN AlmacenDeDatos.dbo.Customers AS a
    ON n.CustomerID = a.CustomerBk
    WHERE
        a.CustomerBk <> n.CustomerID OR 
        a.CompanyName <> n.CompanyName OR 
        a.[Address] <> n.[Address] OR 
        a.City <> n.City OR 
        ISNULL(a.Region, '') <> ISNULL(n.Region, '') OR
        a.Country <> n.Country;

    -- Insertar registros nuevos 
    INSERT INTO AlmacenDeDatos.dbo.Customers (CustomerBK, CompanyName, [Address], City, Region, Country)
    SELECT
        ISNULL(n.CustomerID, 'default_value'),
        n.[CompanyName],
        n.[Address], 
        n.[City], 
        ISNULL(n.Region, 'sin region'),
        n.Country
    FROM Northwind.dbo.Customers AS n
    LEFT JOIN AlmacenDeDatos.dbo.Customers AS a
    ON n.CustomerID = a.CustomerBk
    WHERE a.CustomerID IS NULL
    AND n.CustomerID IS NOT NULL; -- Ensure CustomerID is not NULL before attempting to insert

END;


	EXEC sp_Actualizar_Insertar_Clientes