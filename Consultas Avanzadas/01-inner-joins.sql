        Use Northwind
--  Seleccionar cuatos productos tienen cada categoria
        SELECT CategoryID, COUNT(*)
        from Products
        GROUP BY CategoryID

        SELECT c.CategoryName AS 'categorias', COUNT(*) as 'Numero de Producto' from
        Categories as c
        INNER JOIN Products as p 
        on c.CategoryID = p.CategoryID
        GROUP BY c.CategoryName

--  Seleccionar para mostrar todos los productos junto con sus categorias y sus precios
        SELECT p.ProductName as 'Nombre', c.CategoryName as 'categorias', p.UnitPrice as 'precio' from
        Products as p 
        INNER JOIN Categories as c
        ON p.CategoryID = c.CategoryID

-- Consulta para mostrar los nombres de los productos y los nombres de los proveedores
        SELECT p.ProductName as 'Nombre', s.CompanyName from 
        Products as p 
        INNER JOIN Suppliers as s 
        ON p.ProductID = s.SupplierID
        ORDER BY S.CompanyName ASC

-- Seleccionar las ordenes de comprar mostrando los nombres de los producto y sus importes
        
        SELECT op.OrderID as 'ID', p.ProductName as 'Nombre', (op.UnitPrice * op.Quantity) as 'Importe' from 
        [Order Details] as op 
        INNER JOIN Products as p 
        ON op.ProductID = p.ProductID
        where (op.UnitPrice * op.Quantity) >= 15000
        order by Importe DESC

        Select * from [Order Details]
        SELECT * from Products

-- Mostrar las ordenes de compras y los nombres de los empleados que la realizaron
        select od.OrderID as 'ID', e.FirstName as 'Nombre' from 
        [Orders] as od
        INNER JOIN Employees as e 
        on od.EmployeeID = e.
        WHERE YEAR(OrderDate) in ('1996','1999')

--Ejercicio 1: Obtener el nombre del cliente y el nombre del empleado del representante de ventas de cada pedido.
        SELECT o.OrderID as 'numero de orden', o.OrderDate as 'fecha de orden', c.CompanyName as 'Nombre del cliente', CONCAT(e.FirstName,'',e.LastName) as 'Nombre del empleado'  FROM
        Employees as e 
        JOIN Orders as o
        ON e.EmployeeID = o.EmployeeID
        JOIN Customers as c 
        ON o.CustomerID = c.CustomerID

-----------------------------------------------------------------------------------------------------------------------
--Ejercicio 2: Mostrar el nombre del producto, el nombre del proveedor y el precio unitario de cada producto.
        SELECT p.ProductName as 'nombre del producto', s.CompanyName as 'nombre del proveedor', p.UnitPrice as 'precio'
        FROM Products as p
        INNER JOIN Suppliers as s 
        ON P.SupplierID = S.SupplierID
----------------------------------------------------------------------------
        SELECT P.ProductName, s.CompanyName, p.UnitPrice
        FROM (
                SELECT SupplierID, ProductName, UnitPrice FROM Products
        ) AS P
        INNER JOIN Suppliers as s 
        ON P.SupplierID=s.SupplierID
-----------------------------------------------------------------------------
         SELECT P.ProductName, s.CompanyName, p.UnitPrice
        FROM (
                SELECT SupplierID, ProductName, UnitPrice FROM Products
        ) AS P
        INNER JOIN (
                SELECT SupplierID, CompanyName FROM Suppliers
        ) as S
        ON p.SupplierID=s.SupplierID
------------------------------------------------------------------------------

--Ejercicio 3: Listar el nombre del cliente, el ID del pedido y la fecha del pedido para cada pedido.
        SELECT c.CompanyName as 'nombre del cliente', o.OrderID as 'id del pedido', o.OrderDate as 'fecha'
        FROM Customers as c
        INNER JOIN Orders as o
        on c.CustomerID = o.CustomerID
-------------------------------------------------------------------------------
        SELECT c.CompanyName, o.OrderID, O.OrderDate
        FROM (
                SELECT CompanyName, CustomerID from Customers
        ) as C
        INNER JOIN (
                SELECT OrderID, OrderDate, CustomerID from Orders
        ) as O
        ON C.CustomerID = O.CustomerID
-----------------------------------------------------------------------------------
--Ejercicio 4: Obtener el nombre del empleado, el título del cargo y el departamento del empleado para cada empleado.
        SELECT CONCAT(e.FirstName, ' ', e.LastName) as 'Nombre del empleado', e.Title as 'titulo', t.TerritoryDescription as 'territorio'
        FROM EmployeeTerritories AS et 
        INNER JOIN Employees AS e 
        ON et.EmployeeID=e.EmployeeID
        INNER JOIN Territories as t
        ON t.TerritoryID=et.TerritoryID
-- EJERCICIO DE RETO. SELECCIONAR TODAS LAS ORDENES MOSTRANDO EL EMPLEADO QUE LA REALIZO, EL CLIENTE AL QUE SE ELE VENDIO
--, NOMBRE DE PRODCUTOS, CATEGORIAS, PRECIO QUE SE VENDIO, UNIDADES VENDIDAS Y EL IMPORTE PARA DE ENERO DE 1997 A FEBRERO DE 1998
        SELECT O.OrderID, CONCAT(E.FirstName, ' ', E.LastName) as 'Nombre', C.CompanyName, p.ProductID,
        CG.CategoryName, p.UnitPrice, p.UnitsInStock, (OD.UnitPrice*OD.Quantity) as importe 
        FROM [Orders] as O
        INNER JOIN Employees as E
        ON o.EmployeeID = E.EmployeeID
        INNER JOIN Customers AS c 
        ON O.CustomerID = C.CustomerID
        INNER JOIN [Order Details] as OD
        ON O.OrderID = OD.OrderID
        INNER JOIN Products as P
        on OD.ProductID = P.ProductID
        INNER JOIN Categories as CG 
        on CG.CategoryID = P.CategoryID
        WHERE O.OrderDate BETWEEN '1997-01-01' AND '1998-02-28'
        and cg.CategoryName in ('Beverages')
        ORDER BY c.CompanyName asc 
-- CUANTO HA VENDIDO DE LA CaTEGORIA BEVERAGES de enero de 1997 a febrero de 1998
       SELECT 
    SUM(od.UnitPrice * od.Quantity) AS TotalSold
FROM 
    Orders as o
JOIN 
    [Order Details] od ON o.OrderID = od.OrderID
JOIN 
    Products as p ON od.ProductID = p.ProductID
JOIN 
    Categories as cat ON p.CategoryID = cat.CategoryID
WHERE 
    cat.CategoryName = 'Beverages' AND
    o.OrderDate BETWEEN '1997-01-01' AND '1998-02-28';



--Ejercicio 5: Mostrar el nombre del proveedor, el nombre del contacto y el teléfono del contacto para cada proveedor.

        SELECT s.CompanyName, 
        FROM [Suppliers] as s 

--Ejercicio 6: Listar el nombre del producto, la categoría del producto y el nombre del proveedor para cada producto.
	SELECT 
    p.ProductName AS NombreProducto,
    c.CategoryName AS CategoriaProducto,
    s.CompanyName AS NombreProveedor
FROM 
    Products p
JOIN 
    Categories c ON p.CategoryID = c.CategoryID
JOIN 
    Suppliers s ON p.SupplierID = s.SupplierID;

--Ejercicio 7: Obtener el nombre del cliente, el ID del pedido, el nombre del producto y la cantidad del producto para cada detalle del pedido.
SELECT 
    c.CompanyName AS NombreCliente,
    od.OrderID AS IDPedido,
    p.ProductName AS NombreProducto,
    od.Quantity AS CantidadProducto
FROM 
    [Order Details] od
JOIN 
    Orders o ON od.OrderID = o.OrderID
JOIN 
    Customers c ON o.CustomerID = c.CustomerID
JOIN 
    Products p ON od.ProductID = p.ProductID;

--Ejercicio 8: Obtener el nombre del empleado, el nombre del territorio y la región del territorio para cada empleado que tiene asignado un territorio.
SELECT 
    e.FirstName + ' ' + e.LastName AS NombreEmpleado,
    t.TerritoryDescription AS NombreTerritorio,
    r.RegionDescription AS RegionTerritorio
FROM 
    Employees e
JOIN 
    EmployeeTerritories et ON e.EmployeeID = et.EmployeeID
JOIN 
    Territories t ON et.TerritoryID = t.TerritoryID
JOIN 
    Region r ON t.RegionID = r.RegionID;

--Ejercicio 9: Mostrar el nombre del cliente, el nombre del transportista y el nombre del país del transportista para cada pedido enviado por un transportista.
SELECT 
    c.CompanyName AS NombreCliente,
    sh.CompanyName AS NombreTransportista,
    sh.Country AS PaisTransportista
FROM 
    Orders o
JOIN 
    Customers c ON o.CustomerID = c.CustomerID
JOIN 
    Shippers sh ON o.ShipVia = sh.ShipperID;

--Ejercicio 10: Obtener el nombre del producto, el nombre de la categoría y la descripción de la categoría para cada producto que pertenece a una categoría.
SELECT 
    p.ProductName AS NombreProducto,
    c.CategoryName AS NombreCategoria,
    c.Description AS DescripcionCategoria
FROM 
    Products p
JOIN 
    Categories c ON p.CategoryID = c.CategoryID;


