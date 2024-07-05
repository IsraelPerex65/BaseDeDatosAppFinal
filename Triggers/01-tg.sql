--SINTAXIS
-- CREATE TRIGGER Nombre_Trigger
--	ON nombre_tabla
-- After insert, delete, update
-- as
-- begin 
-- CODIGO
-- END

		
CREATE DATABASE PruebaTriggersG3;
use PruebaTriggersG3;
go 
	Create table tabla1 (id int not null primary key, nombre varchar(50) not null)
	go 

	--TRIGGERS

	--TRIGGER QUE VERIFICA EL EVENTO QUE SE EJECUTÓ
	Create trigger 
	on tabla1
	after insert
	as 
	begin
		print 'se ejecuto el evento insert en la tabla1'
	end

	insert into tabla1
	values (1,'nombre 1')

	--TRIGER DELETE
	Create trigger tg_verificar_delete
	on tabla1
	after delete
	as 
	begin
		print 'se ejecuto el evento delete en la tabla1'
	end

	Create trigger tg_verificar_update
	on tabla1
	after update
	as 
	begin
		print 'se ejecuto el evento update en la tabla1'
	end


	delete tabla1 
	where id = 1

	insert into tabla1
	values (1,'nombre')

	update tabla1 set nombre = 'nombre nuevo' where id =1


	select * from tabla1


	drop trigger tg_verificar_update

	--verficar contenido de inserted
	create trigger tg_verificar_contenido_inserted
	on tabla1
	after insert
	as
	begin
		--ver los datos de la tabla insert
		select * from inserted
	end

	insert into tabla1
	values (2,'nombre 2')

	select * from tabla1 

--------------------------NORTHWIND--------------------------------
	use Northwind

	create trigger sp_northwind_verificar_inserted_categories
	on categories
	after insert
	as
	begin
		select categoryid, categoryname, [description] from inserted
	end

	insert into categories (categoryname, [description])
	values ( 'categoria nueva', 'prueba triggers'	
	)


	----------TRIGER QUE MUESTRE UPDATE------------------
	create or alter trigger sp_northwind_verificar_update1_categories
	on categories
	after update
	as
	begin
		select categoryid, categoryname, [description] from inserted
		select categoryid, categoryname, [description] from deleted
	end

	select * from categories

	update categories 
	set categoryname = 'categorianueva2', [description] = 'si esta miennn ' 
	where categoryid = 9

	---controlz
	begin transaction
	rollback

	drop trigger sp_northwind_verificar_update1_categories

	---------------------------------------------------------
	create or alter trigger verificar_inserted_deleted
	on categories
	after insert, update, delete
	as
	begin
		if exists(select 1 from inserted) and not exists(select 1 from deleted)
		begin
			print 'existen datos en la tabla inserted, se ejecuto un insert'
		end
		if exists(select 1 from deleted) and not exists(select 1 from inserted)
		begin
			print 'existen datos en la tabla deleted, se ejecuto un deleted'
		end
		else if exists(select 1 from deleted) and exists (select 1 from inserted)
		begin
			print 'existen datos en las dos tablas, se ejecuto un update'
		end
	end;

	insert into categories(categoryname, [description])
	values ('categoria10', 'pinpon')

	delete categories 
	where categoryid = 10

	update categories 
	set categoryname = 'categoriaupdate'
	where categoryid = 1

	select * from categories

	--CREAR UN TRIGGER EN LA BD prueba triggerss para la tabla empleado debe evitar que se inserten salarios mayores a 50000

	use PruebaTriggersG3
	
	create table empleado (id int not null primary key, nombre varchar(50) not null, salario money not null)

	create or alter trigger verificar_salario
	on empleado
	after update, insert
	as
	begin 
	
		if exists (select 1 from inserted) and not exists (select 1 from deleted)
		begin
			declare @salarioNuevo money set @salarioNuevo = (select salario from inserted)
			end
				if @salarioNuevo > 50000
				begin
					raiserror('el salario es mayor a 50000 y no esta permitido', 16, 1)
					rollback transaction;
				end	
				end

				
--CREAR UN TRIGGER QUE PERMITA GESTIONAR UNA VENTA, EN LA CUAL SE DEBE ACTUALIZAR LA EXISTENCIA DE 1 PRODUCTO
--VENDIDO, BAJO LAS SIGUIENTES CONDICIONCES:

--1.- VERIFICAR SI LA EXISTENCIA ES SUFICIENTE, SI LA EXISTENCIA NO ES SUFICIENTE CANCELAR LA INSERCCION
--2.-SI ES SUFICIENTE, AGREGAR LA VENTA Y DISMINUIR EL STOCK DEL PRODUCTO 
--NOTA UTILIZAR LA BASE DE DATOS NORTHWIND

--PARA ESTE PROCESO TENEMOS ESTA INFORMACION
--1.-INSERTAR EN ORDERS
--2.- INSERTAR EN ORDERSDETAILS
--3.-VERIFICAR SI EL UNITINSTOCK ES SUFICIENTE
--4.- SI ES SUFICIENTE ACEPTAR LA INSERCCION Y DISMINUIR EL UNITIBSTOCK LO VENDIDO

use Northwind

CREATE TRIGGER trg_GestionarVenta
ON Sales
FOR INSERT
AS
BEGIN
    DECLARE @ExistenciaSuficiente INT;

    -- 1. Verificar si la existencia es suficiente
    SELECT @ExistenciaSuficiente = 1
    FROM Products
    WHERE ProductID = NEW.ProductID
    AND (QuantityInStock - NEW.QuantitySold) >= 0;

    -- Si la existencia no es suficiente, cancelar la inserción
    IF @ExistenciaSuficiente = 0
    BEGIN
        ROLLBACK;
        RAISERROR('No hay suficiente existencia del producto.', 16, 1);
    END
    ELSE
    BEGIN
        -- 2. Agregar la venta y disminuir el stock
        INSERT INTO Sales
        (SalesOrderID, CustomerID, OrderDate, EmployeeID, ProductID, QuantitySold, UnitPrice, Discount)
        VALUES
        (NEW.SalesOrderID, NEW.CustomerID, NEW.OrderDate, NEW.EmployeeID, NEW.ProductID, NEW.QuantitySold, NEW.UnitPrice, NEW.Discount);

        UPDATE Products
        SET QuantityInStock = QuantityInStock - NEW.QuantitySold
        WHERE ProductID = NEW.ProductID;
    END
END;


---------------------------------------------------------
USE Northwind;
GO

-- Crear el trigger en la tabla OrderDetails
CREATE TRIGGER trg_ManageSale
ON OrderDetails
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @ProductID INT;
    DECLARE @Quantity INT;
    DECLARE @OrderID INT;
    DECLARE @ExistingStock INT;

    -- Obtener los valores de ProductID y Quantity de la nueva orden
    SELECT @ProductID = i.ProductID, @Quantity = i.Quantity, @OrderID = i.OrderID
    FROM inserted i;

    -- Verificar la existencia del producto en la tabla Products
    SELECT @ExistingStock = UnitsInStock
    FROM Products
    WHERE ProductID = @ProductID;

    -- Si la existencia no es suficiente, cancelar la inserción
    IF @ExistingStock < @Quantity
    BEGIN
        RAISERROR('No hay suficiente existencia para el producto.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        -- Si la existencia es suficiente, insertar la orden y los detalles de la orden, y actualizar el stock del producto
        INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice, Discount)
        SELECT i.OrderID, i.ProductID, i.Quantity, i.UnitPrice, i.Discount
        FROM inserted i;

        UPDATE Products
        SET UnitsInStock = UnitsInStock - @Quantity
        WHERE ProductID = @ProductID;
    END
END;
GO

		
