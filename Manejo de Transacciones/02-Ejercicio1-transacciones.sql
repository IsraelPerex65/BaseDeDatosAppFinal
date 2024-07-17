-- Ejercicio 1. Realizar una venta dentro de la bd Northwind 
-- usando transacciones y store procedures

CREATE OR ALTER PROCEDURE sp_nuevaVenta
	@CustomerID nchar(5),
    @EmployeeID int,
    @OrderDate datetime,
    @RequiredDate datetime,
    @ShippedDate datetime,
    @ShipVia int,
    @Freight money = null,
    @ShipName nvarchar(40)=null,
    @ShipAddress nvarchar(60)=null,
    @ShipCity nvarchar(15)=null,
    @ShipRegion nvarchar(15)=null,
    @ShipPostalCode nvarchar(15) = null,
    @ShipCountry nvarchar(15) = null,
    @ProductID int,
    @UnitPrice money,
    @Quantity smallint,
    @Discount real
AS
BEGIN
Begin transaction
	begin try
	--Insertar en la tabla order
	INSERT INTO Northwind.dbo.Orders
           ([CustomerID]
           ,[EmployeeID]
           ,[OrderDate]
           ,[RequiredDate]
           ,[ShippedDate]
           ,[ShipVia]
           ,[Freight]
           ,[ShipName]
           ,[ShipAddress]
           ,[ShipCity]
           ,[ShipRegion]
           ,[ShipPostalCode]
           ,[ShipCountry])
     VALUES
           (@CustomerID,
           @EmployeeID,
           @OrderDate,
           @RequiredDate,
           @ShippedDate, 
           @ShipVia, 
           @Freight,
           @ShipName, 
           @ShipAddress, 
           @ShipCity, 
           @ShipRegion, 
           @ShipPostalCode, 
           @ShipCountry);

		   -- Obtener el ID insertado de la orden
		   Declare @orderId int
		   set @orderId = SCOPE_IDENTITY();

		   -- INSERTAR EN DETALLE_ORDEN EL PRODUCTO
		   -- OBTENER EL PRECIO DEL PRODUCTO A INSERTAR
		   DECLARE @PrecioVenta money 
		   select @PrecioVenta = UnitPrice from Products
		   where ProductID = @ProductID
		   --INSERTAR EN LA TABLA ORDER DETAILS
		   INSERT INTO Northwind.dbo.[Order Details]
           ([OrderID]
           ,[ProductID]
           ,[UnitPrice]
           ,[Quantity]
           ,[Discount])
     VALUES
           (@orderId,
           @ProductID,
           @PrecioVenta, 
           @Quantity, 
           @Discount);

		   -- actualizar la tabla products reduciendo el unitsinstock con la cantidad vendida 
		   UPDATE Northwind.dbo.Products
		   set UnitsInStock = UnitsInStock - @Quantity
		   where ProductID=@ProductID

	commit transaction
	end try
	begin catch
		rollback transaction
		declare @mensajeError varchar(400)
		set @mensajeError = ERROR_MESSAGE()
		print @mensajeError
	end catch


END
necesito algo similar a esto pero en lugar de insertar un producto elimine una orden y que se vea afectado las tablas order details, orders y products ademas que actualice el stock del producto
GO;

exec sp_nuevaVenta 



use Northwind
select * from Products