-- Consultas Simples (a una sola tabla)
	use Northwind;

-- Seleccionar todos los customers (clientes)
	select * from Customers

-- Proyeccion y selecciona 10 registros
	select top 10 CustomerID, CompanyName, city, country
	from Customers

-- Alias de columna
-- country as pais
-- country pais
-- coutriy 'pais'
-- country as 'pais'
-- coutry as 'pais de las maravillas'

select top 10 CustomerID as 'Numero de cliente', CompanyName as 'Nombre de la empresa', city, country
	from Customers


-- Campo calculado
	select *, (p.UnitPrice * p.UnitsInStock) as 'Costo Inventario'
	from Products as p
	
	select ProductName as 'Nombre Producto', UnitsInStock as 'Existencia',
	UnitPrice as 'Precio Unitario', (p.UnitPrice * p.UnitsInStock) as 'Costo Inventario'
	from Products as p

-- Filtrar Datos
-- Clausula Where y operadores 
-- < Menor que += Igual
-- > Mayor que += Igual
-- <> != Diferente
-- = Igual

	select * from Customers

-- Seleccionar todos los clientes de Alemania
	select * from Customers Where Country = 'Germany'  

-- Seleccionar todos los productos que tengan un stock mayor a 20 mostrando solamente el nombre del producto el precio y la exitencia
	select ProductName as 'Nombre del Producto', UnitPrice as 'Precio Unitario', UnitsInStock as 'Unidades en Stock' 
	from Products Where UnitsInStock > 20	
	order by 1 desc 

-- Seleccionar todos los clientes ordenados de forma asecendente por pais y dentro del pais ordenados de forma descendente por ciudad 
	SELECT top 5 *
	FROM Customers
	WHERE Country='Germany'
	ORDER BY Country ASC, City DESC;

-- Eliminar valores repetidos en una consulta. Seleccionar los paises de los clientes
	select distinct country from Customers order by 1 asc


	select count(distinct Country) from Customers
	order by 1 asc

-- Seleciona todos lo productos donde el precio es mayor o igual a 18
	select * from Products as p
	where p.UnitPrice >=18.0

	select * from Products as p
	where p.UnitPrice >=18.0

	select * from Products as p
	where p.UnitPrice >=18.0

-- Seleccionar todos los productos que tengan un precio
-- entre 18 y 25 dolares

	select * from Products as cosulta
	where not(UnitPrice>=18 and UnitPrice<=25)
	order by UnitPrice desc
	-- UnitPrice between 18 and 25

-- Seleccionar todos los productos donde precio sea mayor y su existencia sea mayor o igual a 22
	select ProductName, UnitPrice, UnitsInStock from Products 
	where (UnitPrice>38 and UnitsInStock>=22)

-- Seleccionar todos los clientes de alemania, mexico, francia

	SELECT * FROM Customers WHERE Country IN ('Germany', 'Mexico', 'France');

-- Seleccionar todos los clientes que no tengan region
	SELECT * FROM Customers WHERE Region IS NOT NULL;

-- Seleccionar todas las ordenes enviadas de julio de 1996 a abril 1998 para los empleados Buchanan c Davolio
	select * from Orders as o
	where o.ShippedDate between '1996-07-01' and '1997-04-30'
	and o.EmployeeID in (5,3,1)

	select e.LastName, o.ShippedDate from 
	Employees as e
	inner join Orders as o
	on o.EmployeeID = o.EmployeeID
	where o.ShippedDate between '1996-07-01' and '1997-04-30'
	and e.LastName in ('Buchanan','Leverling','Davolio')

	SELECT * FROM Orders
	WHERE
	ShippedDate >= '1996-07-01' and ShippedDate <= '1998-04-30'
	and EmployeeID = 5 or EmployeeID=3 or EmployeeID=1 

	-- MAS OPTIMA
	SELECT * from Orders
	WHERE ShippedDate BETWEEN '1996-07-01' and '1998-04-30'
	and EmployeeID in (5,3,1)

	-- Seleccionar solo los años de las ordenes de compra
	SELECT YEAR(OrderDate) from Orders;

	-- Selecciona todas las ordenes de compra en donde para 1996
	select * from Orders
	where YEAR(OrderDate)=1996
	
	-- Selecciona todas las ordenes de compra mostrando el numero de orden, fecha de orde, año, mes y dia de 1996 y 1998
	SELECT OrderID AS 'NUMERO DE COMPRA', OrderDate as 'Fecha orden', YEAR(OrderDate) as 'año', MONTH(OrderDate) as 'mes',
	DAY(OrderDate) as 'Dia' from Orders
	WHERE YEAR(OrderDate)= '1996' or year(OrderDate) ='1998' 

	SELECT OrderID AS 'NUMERO DE COMPRA', OrderDate as 'Fecha orden', YEAR(OrderDate) as 'año', MONTH(OrderDate) as 'mes',
	DAY(OrderDate) as 'Dia' from Orders
	WHERE YEAR(OrderDate) in ('1996','1998')

	-- Slecciona todos los apellidos de los empleados que comienencen con d
	SELECT LastName as 'apellidos' from Employees
	WHERE LastName LIKE 'D%'

	-- Selecciona todos los apellidos que comiencen con Da
	SELECT LastName as 'apellidos' from Employees
	WHERE LastName LIKE 'Da%'

	SELECT LastName as 'apellidos' from Employees
	WHERE LastName LIKE '%a'

	-- Apellido con la letra a
	SELECT LastName as 'apellidos' from Employees
	WHERE LastName LIKE '%a%'

	-- Apellido sin a
	SELECT LastName as 'apellidos' from Employees
	WHERE LastName NOT LIKE '%a%'

	-- Cualquier letra y i
	SELECT LastName as 'apellidos' from Employees
	WHERE LastName LIKE '%_i%'

	-- Nombre contenga 3 caracteres la palabra li despues un caracter y finalmente la letra d
	SELECT FirstName as 'apellidos' from Employees
	WHERE FirstName LIKE '%___li_d'

	SELECT LastName as 'apellidos' from Employees
	WHERE LastName LIKE '[DL]%'

	SELECT LastName as 'apellidos' from Employees
	WHERE LastName LIKE '[SC]%'

	-- TODOS LOS QUE EN SU APELLIDO CONTENGAN D O L
	SELECT LastName as 'apellidos' from Employees
	WHERE LastName LIKE '%[DL]%'

	-- TODOS DONDE SU APELLIDO CONTENGA ENTRE LA A Y LA F
	SELECT LastName as 'apellidos' from Employees
	WHERE LastName LIKE '%[ABCDEF]%'

	SELECT COUNT(*) as 'total' from Employees
	WHERE LastName LIKE '%[ABCDEF]%'

	-- TODOS DONDE SUS APELLIDOS NO TERMINEN CON CB
	SELECT LastName as 'apellidos' from Employees
	WHERE LastName LIKE '[^CB]%'

	-- Funciones de agregado, JOIN && HAVING
	/*
	SUM
	COUNT(*)
	AVG
	MAX
	MIN
	*/

	SELECT * from Orders
	SELECT COUNT(*) as 'total' FROM Orders

	SELECT * from Orders

	-- Selecciona el numero de paises a los que les he enciado ordenes
	SELECT COUNT(distinct ShipCountry) as 'total'
	FROM Orders
	
	-- Selecciona el total de ordenes enviadas a Francia entre 1996 y 1998
	SELECT COUNT(*) as 'numero de ordenes' from Orders
	WHERE ShipCountry = 'france'
	and YEAR(ShippedDate) BETWEEN '1996' AND '1998'

	-- Selecciona el minimo de los produtos
	SELECT Min(UnitPrice) from Products

	-- Selecciona el maximo de los produtos
	SELECT Min(UnitPrice) from Products

	-- Selecciona el precio y nombre del mas caro
	SELECT top 1 ProductName, UnitPrice from Products
	ORDER BY UnitPrice desc

	-- Seleccionar el monto total de todas las ordenes
	SELECT SUM((UnitPrice * Quantity)) as 'ventas' from [Order Details]
	

	-- Seleccionar el total de ventas realizadas a los prodcutos que no tienen descuento
	SELECT SUM((UnitPrice * Quantity)) as 'ventas' from [Order Details]
	WHERE Discount=0

	-- Seleccionar el promedio de ventas para los productos 
	SELECT AVG((UnitPrice*Quantity)) as 'promedio' FROM [Order Details]
	where ProductID in (72,42)

	-- Seleccionar el total de ventas para el cliente 
	/*
	Select (campo)
	from Tabla1 as T1
	INNER JOIN Tabla2 as T2
	ON campo1=campo2
	*/

	-- Seleccionar los datos de las tablas de categorias y de produtos
	Select c.CategoryName as 'categoria', p.ProductName as 'prodcuto', p.UnitPrice as 'precio unitario', p.UnitsInStock as 'existencia', (p.UnitPrice*p.UnitsInStock) as 'precio inventario'
	 FROM Categories AS c 
	INNER JOIN Products as p
	ON C.CategoryID = p.ProductID
	

	-- Seleccionar los productos de la categoria Beverages
	Select c.CategoryName as 'categoria', p.ProductName as 'producto', p.UnitPrice as 'precio unitario', p.UnitsInStock as 'existencia', (p.UnitPrice*p.UnitsInStock) as 'precio inventario'
	FROM Categories AS c 
	INNER JOIN Products as p
	ON C.CategoryID = p.CategoryID
	 WHERE c.CategoryName='Beverages'


	Select c.CategoryName as 'categoria', p.ProductName as 'producto', p.UnitPrice as 'precio unitario', p.UnitsInStock as 'existencia', (p.UnitPrice*p.UnitsInStock) as 'precio inventario'
	FROM Categories AS c 
	INNER JOIN Products as p
	ON C.CategoryID = p.CategoryID
	WHERE c.CategoryName='Beverages'
	
	-- Seleccionar el total de ventas para el cliente chop suey

	Select COUNT(Products) from Categories

	select * from Categories
	