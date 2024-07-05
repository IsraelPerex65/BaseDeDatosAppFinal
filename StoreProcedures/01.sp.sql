-- PROCEDIMIENTOS ALMACENADOS PARAMETROS DE SALIDA 
	--AREA DE UN CIRCULO
	CREATE OR ALTER PROCEDURE SP_Area_Circulo_01
	@radio float, 
	@area float output
	AS 
	BEGIN
		set @area = PI()*@radio * @radio


	END;
	DECLARE @resultado float
	exec SP_Area_Circulo_01 @RADIO= 22.3, @area = @resultado output
	print 'el valor del area es: '+ cast(@resultado as varchar)
	GO

	CREATE OR ALTER PROCEDURE sp_obtener_informacion_empleados
	@EmployeeID int = -1,
	@apellido nvarchar(20) output,
	@nombre nvarchar(10) output
	as 
	begin
		if @EmployeeID <> -1
		begin
		select FirstName, LastName from Northwind.dbo.Employees
		Where EmployeeID = @EmployeeID
		end
		else
		begin
			print ('el valor del empleado no es valido ')
		end
	end

	declare @firtsname as nvarchar(10),
	@lastname as nvarchar (20)

	exec sp_obtener_informacion_empleados 
	@nombre = @firtsName output,
	@apellido = @LastName output;

	print ('el nombre es: ' + @firtsname)
	print ('el apellido es: ' + @lastname)


-----------------PRIMER SP----------------------------------
CREATE OR ALTER PROCEDURE sp_obtener_informacion_empleados_2
	@EmployeeID int = -1,
	@apellido nvarchar(20) output,
	@nombre nvarchar(10) output
	as 
		declare @existe int
		set @existe = (select count (*) from Northwind.dbo.Employees where EmployeeID = @EmployeeID)
		print(@existe)
	begin
		if  @existe > 0
		begin
		select FirstName, LastName from Northwind.dbo.Employees
		Where EmployeeID = @EmployeeID
		end
		else
		begin
		if @EmployeeID = -1
		begin
			if @existe = 0
			begin 
			print 'se debe introducir un valor'
			end
			else if @existe = 0
			begin
				print'el valor del empleado no existe en la tabla'
			end
		end
	end


-----------------------------------------------------------------------------	
	CREATE OR ALTER PROCEDURE sp_obtener_ventas_por_cliente
	@customerID nchar(5),
	@fechainicial date,
	@fechafinal date, 
	@total1 decimal (10,2) output
	as	
	begin
	select @total1 = sum(od.unitprice * od.quantity)
	from [Order Details] as od
	inner join orders as o
	on od.OrderID = o.OrderID
	where  CustomerID = @customerid and
	o.OrderDate between @fechainicial and @fechafinal
	end

	exec sp_obtener_ventas_por_cliente --VALORES
	


	--USAMOS NORTHWIND 
use Northwind;
--CREAMOS EL PRIMER STORE PROCEDURE
CREATE OR ALTER PROCEDURE sp_Actualizar_Insertar_Clientes
AS
BEGIN
    SET NOCOUNT ON;
    -- ACTUALIZAR SI YA EXISTE EL DATO
    IF EXISTS (SELECT 1 FROM AlmacenDeDatos.dbo.Customers AS a INNER JOIN Northwind.dbo.Customers AS n ON a.CustomerBk = n.CustomerID)
    BEGIN 
        UPDATE a
        SET 
            CustomerBk = n.CustomerID,
            CompanyName = n.CompanyName, 
            [Address] = n.[Address],
            City = n.City,
            Region = ISNULL(n.Region, 'sin region'),
            Country = n.Country
        FROM AlmacenDeDatos.dbo.Customers AS a
        INNER JOIN Northwind.dbo.Customers AS n ON a.CustomerBk = n.CustomerID;
        PRINT 'Registro actualizado.';
    END
    ELSE
    BEGIN
        -- INSERTAR DATOS
        INSERT INTO AlmacenDeDatos.dbo.Customers (CustomerBk, CompanyName, [Address], City, Region, Country)
        SELECT 
            n.CustomerID,
            n.CompanyName,
            n.[Address],
            n.City,
            ISNULL(n.Region, 'sin region') AS Region,
            n.Country
        FROM Northwind.dbo.Customers AS n;
    END
END;
----------------------------------------------------------------------------------------------

------------CREAMOS EL SEGUNDO STORE PROCEDURE EMPLOYEES-----------
CREATE OR ALTER PROCEDURE sp_Actualizar_Insertar_Employees
AS
BEGIN
    SET NOCOUNT ON;
    -- ACTUALIZAR SI YA EXISTE EL DATO
    IF EXISTS (SELECT 1 FROM AlmacenDeDatos.dbo.Employees AS a INNER JOIN Northwind.dbo.Employees AS n ON a.EmployeeBk = n.EmployeeID)
    BEGIN 
        UPDATE a
        SET 
			[EmployeeBk] = n.EmployeeID,
            Fullname = CONCAT(n.FirstName, ' ',n.LastName), 
            Title = n.Title,
            HireDate = n.HireDate,
            Region = n.Region,
            Country = n.Country
        FROM AlmacenDeDatos.dbo.Employees AS a
        INNER JOIN Northwind.dbo.Employees AS n ON a.EmployeeBk = n.EmployeeID;
        PRINT 'Registro actualizado.';
    END
    ELSE
    BEGIN
        -- INSERTAR DATOS
        INSERT INTO AlmacenDeDatos.dbo.Employees (EmployeeBk, Fullname, title, HireDate, [Address], City, Region, Country)
        SELECT 
            n.EmployeeID,
            CONCAT(n.FirstName, ' ',n.LastName), 
            n.Title,
            n.HireDate,
			n.[Address],
			n.city,
            ISNULL(n.Region, 'sin region') AS Region,
            n.Country
        FROM Northwind.dbo.Employees AS n;
    END
END;
	EXEC sp_Actualizar_Insertar_Employees
	select * from AlmacenDeDatos.dbo.Employees



----------------------------------------------------------------------------------------------

------------CREAMOS EL TERCER STORE PROCEDURE PRODUCT-----------
CREATE OR ALTER PROCEDURE sp_Actualizar_Insertar_Products
AS
BEGIN
    SET NOCOUNT ON;
    -- ACTUALIZAR SI YA EXISTE EL DATO
    IF EXISTS (SELECT 1 FROM AlmacenDeDatos.dbo.Products AS a INNER JOIN Northwind.dbo.Products AS n ON a.ProductsBk = n.ProductID)
    BEGIN 
        UPDATE a
        SET 
            ProductsBk = n.ProductID,
            ProductsName = n.ProductName, 
            CategoryName = c.CategoryName
        FROM AlmacenDeDatos.dbo.Products AS a
        INNER JOIN Northwind.dbo.Products AS n ON a.ProductsBk = n.ProductID
		INNER JOIN Northwind.dbo.Categories as c on n.ProductID = c.CategoryID
        PRINT 'Registro actualizado.';
    END
    ELSE
    BEGIN
        -- INSERTAR DATOS
        INSERT INTO AlmacenDeDatos.dbo.Products(ProductsBk, ProductsName, CategoryName)
        SELECT 
            n.ProductID,
            n.ProductName,
            c.CategoryName
        FROM Northwind.dbo.Products AS n
		INNER JOIN Northwind.dbo.Categories as c on n.ProductID = c.CategoryID
    END
END;

	EXEC sp_Actualizar_Insertar_Products
	select * from AlmacenDeDatos.dbo.Products
	delete from AlmacenDeDatos.dbo.Customers
	
----------------------------------------------------------------------------------------------
------------CREAMOS EL TERCER STORE PROCEDURE SUPPLIERS-----------
CREATE OR ALTER PROCEDURE sp_Actualizar_Insertar_Suppliers
AS
BEGIN
    SET NOCOUNT ON;
    -- ACTUALIZAR SI YA EXISTE EL DATO
    IF EXISTS (SELECT 1 FROM AlmacenDeDatos.dbo.Supplier AS a INNER JOIN Northwind.dbo.Suppliers AS n ON a.SupplierBk = n.SupplierID)
    BEGIN 
        UPDATE a
        SET 
            SupplierBk = n.SupplierID,
            CompanyName = n.CompanyName, 
            Country = n.Country,
            [Address] = n.[Address],
            City = n.City
        FROM AlmacenDeDatos.dbo.Supplier AS a
        INNER JOIN Northwind.dbo.Suppliers AS n ON a.SupplierBk = n.SupplierID;
        PRINT 'Registro actualizado.';
    END
    ELSE
    BEGIN
        -- INSERTAR DATOS
        INSERT INTO AlmacenDeDatos.dbo.Supplier (SupplierBk, CompanyName, Country, [address], City)
        SELECT 
            n.SupplierID,
            n.CompanyName,
            n.Country,
            n.[Address],
            n.City
        FROM Northwind.dbo.Suppliers AS n;
    END
END;
exec sp_Actualizar_Insertar_Suppliers
select * from AlmacenDeDatos.dbo.Supplier

----------------------------------------------------------------------------------------------
------------CREAMOS EL QUINTO STORE PROCEDURE SALES-------------------------------------------
CREATE OR ALTER PROCEDURE sp_Actualizar_Insertar_Sales
AS
BEGIN
    SET NOCOUNT ON;

    -- Actualizar si ya existe el dato
    IF EXISTS (
        SELECT 1 
        FROM AlmacenDeDatos.dbo.Sales AS a
        INNER JOIN Northwind.dbo.[Order Details] AS n ON a.ProductID = n.ProductID
        INNER JOIN Northwind.dbo.Orders AS o ON n.OrderID = o.OrderID
        INNER JOIN AlmacenDeDatos.dbo.Customers AS c ON o.CustomerID = c.CustomerID
    )
    BEGIN
        UPDATE a
        SET 
            Quantity = n.Quantity,
            UnitPrice = n.UnitPrice
        FROM AlmacenDeDatos.dbo.Sales AS a
        INNER JOIN Northwind.dbo.[Order Details] AS n ON a.ProductID = n.ProductID
        INNER JOIN Northwind.dbo.Orders AS o ON n.OrderID = o.OrderID
        INNER JOIN AlmacenDeDatos.dbo.Customers AS c ON o.CustomerID = c.CustomerID;
        
        PRINT 'Registro actualizado.';
    END
    ELSE
    BEGIN
        -- Insertar datos
        INSERT INTO AlmacenDeDatos.dbo.Sales (CustomerID, ProductID, EmployeeID, SupplierID, Quantity, UnitPrice)
        SELECT 
            o.CustomerID,
            n.ProductID,
            NULL AS EmployeeID, -- Ajusta esto según sea necesario
            NULL AS SupplierID, -- Ajusta esto según sea necesario
            n.Quantity,
            n.UnitPrice
        FROM Northwind.dbo.[Order Details] AS n
        INNER JOIN Northwind.dbo.Orders AS o ON n.OrderID = o.OrderID
        INNER JOIN AlmacenDeDatos.dbo.Customers AS c ON o.CustomerID = c.CustomerID;
        
        PRINT 'Registro insertado.';
    END
END;

-- Ejecutar el procedimiento
EXEC sp_Actualizar_Insertar_Sales;

-- Consultar los datos actualizados/integrados
SELECT * FROM AlmacenDeDatos.dbo.Sales;

-------------CAMPO DE PRUEBAS--------------------

	EXEC sp_Actualizar_Insertar_Clientes
	select * from AlmacenDeDatos.dbo.Customers

	EXEC sp_Actualizar_Insertar_Employees
	select * from AlmacenDeDatos.dbo.Employees

	EXEC sp_Actualizar_Insertar_Products
	select * from AlmacenDeDatos.dbo.Products

	EXEC sp_Actualizar_Insertar_Suppliers
	select * from AlmacenDeDatos.dbo.Supplier


	INSERT INTO AlmacenDeDatos.dbo.Sales (CustomerID, ProductID, EmployeeID,SupplierID, Quantity, UnitPrice)
		SELECT 
			ISNULL(c.CustomerID, 'No tiene cliente ID'),
			ISNULL(p.ProductID, 'No tiene id de producto'),
			ISNULL(n.employeeID, 'No tiene id de empleado'),
			ISNULL(s.supplierID, 'No tiene id de supplier'), 
			ISNULL(od.UnitPrice, 0) as UnitPrice,
			ISNULL(od.Quantity,0) as Quantity
			FROM Northwind.dbo.Orders as n 
				LEFT JOIN AlmacenDeDatos.dbo.Customers as c
					on n.CustomerID = C.CustomerBk
				LEFT JOIN AlmacenDeDatos.dbo.Employees as e 
					on n.EmployeeID = EmployeeBk
				LEFT JOIN Northwind.dbo.[Order Details] as od 
					on n.OrderID = od.OrderID
				LEFT JOIN AlmacenDeDatos.dbo.Products as p
					on od.ProductID = p.ProductsBk
				LEFT JOIN Northwind.dbo.Products as np 
					on p.ProductsBk = np.ProductID
				LEFT JOIN AlmacenDeDatos.DBO.Supplier as s 
					on np.SupplierID = s.SupplierBk 
				LEFT JOIN AlmacenDeDatos.dbo.Sales as v
					on c.CustomerID = v.CustomerID
			WHERE v.CustomerID is null
	
