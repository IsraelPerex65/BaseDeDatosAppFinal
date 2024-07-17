CREATE OR ALTER PROCEDURE sp_eliminarVenta
    @OrderID int
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        
        UPDATE P
        SET P.UnitsInStock = P.UnitsInStock + OD.Quantity
        FROM Northwind.dbo.Products P
        INNER JOIN Northwind.dbo.[Order Details] as OD
        ON P.ProductID = OD.ProductID
        WHERE OD.OrderID = @OrderID;

        
        DELETE FROM Northwind.dbo.[Order Details]
        WHERE OrderID = @OrderID;

       
        DELETE FROM Northwind.dbo.Orders
        WHERE OrderID = @OrderID;

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        DECLARE @mensajeError varchar(400);
        SET @mensajeError = ERROR_MESSAGE();
        PRINT @mensajeError;
    END CATCH
END

exec sp_eliminarVenta 

select * from [Order Details]
select * from Products
select * from Orders

