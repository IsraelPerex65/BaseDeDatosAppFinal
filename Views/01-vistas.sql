create database vistaspractica;

USE vistaspractica;


-- Crear una vista de la siguiente consulta

CREATE OR ALTER VIEW view_categorias_productos
AS

    select c.CategoryName,
    p.ProductName, 
    p.UnitPrice, 
    p.UnitsInStock
    from 
    northwind.dbo.Categories AS c
    inner join northwind.dbo.Products As p
    on c.CategoryID = p.CategoryID;


select * from view_categorias_productos



select *, (precio * Existencia) as [Precio Inventario]
from view_categorias_productos
where [nombre Categoria] in ('Beverages', 'Condiments')
order by [nombre categoria] desc;

-- seleccionar la suma del precio del inventario agrupado por categoria utilizando la vista

Select categoryname as 'Cataegoria',sum(UnitPrice * UnitsInStock) as 'Suma del Precio del Inventario' 
from view_categorias_productos
group by categoryname;