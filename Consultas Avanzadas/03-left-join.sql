-- Crear base de datos para demostrar el uso del left join 

create database pruebajoins;

-- Utiizamos la base de datos

use pruebajoins;

-- Crear la tabla categorias

create table categoria(
    categoriaid int not null identity(1,1),
    nombre varchar(50) not null default 'No Categoria',
    constraint pk_categoria
    primary key(categoriaid)
);

-- Crear la tabla producto

create table producto(
    productoid int not null identity(1,1),
    nombre varchar(50) not null, 
    existencia int not null, 
    precio money not null, 
    categoriaid int,
    constraint pk_producto
    primary key(productoid),
    constraint unico_nombre
    unique(nombre), 
    constraint fk_producto_categoria
    foreign key (categoriaid)
    references categoria(categoriaid)
);

-- Agregar registros a la tabla categoria

insert into categoria(nombre)
values('LB'),
      ('LACTEOS'),
      ('ROPA'),
      ('BEBIDAS'),
      ('CARNES FRIAS');

-- Agregar registros a la tabla producto

select * from categoria;

INSERT INTO producto (nombre, existencia, precio, categoriaid)
VALUES('REFRIGERADOR', 3, 10000.0, 1),
      ('ESTUFA', 3, 9000.04, 1),
      ('CREMA', 2, 10.5, 2),
      ('YOGURT',3 , 13.45, 2);

SELECT * FROM producto;

SELECT * 
FROM PRODUCTO AS p
INNER JOIN CATEGORIA AS c 
on p.categoriaid = c.categoriaid;

-- Consulta utilizando un left join 

-- Sellecionar todas las categorias que no tienen asignado productos

SELECT * 
FROM CATEGORIA AS c
LEFT JOIN PRODUCTO AS p 
on p.categoriaid = c.categoriaid;

SELECT c.categoriaid, c.nombre 
FROM CATEGORIA AS c
LEFT JOIN PRODUCTO AS p 
on p.categoriaid = c.categoriaid
where p.productoid is null;


SELECT *
FROM PRODUCTO AS c
RIGHT JOIN CATEGORIA AS p 
on p.categoriaid = c.categoriaid;


SELECT *
FROM PRODUCTO AS c
LEFT JOIN CATEGORIA AS p 
on p.categoriaid = c.categoriaid;

-- fULL JOIN 

SELECT *
FROM PRODUCTO AS c
FULL JOIN CATEGORIA AS p 
on p.categoriaid = c.categoriaid;

SELECT *
FROM PRODUCTO AS c
FULL JOIN CATEGORIA AS p 
on p.categoriaid = c.categoriaid;

-- EJERCICIO

-- 1. crear una base de datos llamada ejerciciojoins

create database ejerciciojoins;
use ejerciciojoins;
-- 2. crear una tabla empleados tomando como base la tabla employees de nortwind(no tomar todos los campos)

select * from northwind.dbo.employees;


select top 0 employeeid as 'empleadoid', 
       CONCAT(firstname, ' ', lastname) as 'NombreCompleto',
       title as 'titulo',
       hiredate as 'Fechacontratacion'
into ejerciciojoins.dbo.empleados
from northwind.dbo.employees;

select * from ejerciciojoins.dbo.empleados;


-- 3. llenar la tabla con una consulta a la tabla employees
insert into ejerciciojoins.dbo.empleados (NombreCompleto,titulo,Fechacontratacion)
select  
       CONCAT(firstname, ' ', lastname) as 'NombreCompleto',
       title as 'titulo',
       hiredate as 'Fechacontratacion'
from northwind.dbo.employees;

select top 0 * 
into ejerciciojoins.dbo.dimempleados
from ejerciciojoins.dbo.empleados

select * from dimempleados

-- 4. Agregar nuevos datos a la tabla empleados por lo menos dos 
-- 5. actualizar la tabla empleados con los nuevos registros, la cual se llenaran en una nueva tabla llamada 
-- dim_producto
