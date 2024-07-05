--creamos la base de datos
create database pruebajoins;

--utilizamos la base de datos
use pruebajoins
--crear la tabla categorias
create table categorias(
    categoriaid int not null IDENTITY (1,1),
    nombre VARCHAR(50) not null DEFAULT 'no categoria',
    constraint pk_categoria
    PRIMARY KEY (categoriaid)
);

-- Crar la tabla producto 
CREATE TABLE producto(
        productoID int not null IDENTITY(1,1),
        nombre varchar(50) not null,
        existencia int NOT null, 
        precio money not null,
        categoriaID int,
        CONSTRAINT pk_producto 
        PRIMARY key(productoID),
        CONSTRAINT unico_nombre
        unique(nombre),
        CONSTRAINT fk_prodcuto_categoria
        FOREIGN KEY (categoriaID)
        REFERENCES categorias(categoriaID)
);

--agregar registros a la tabla categoria

INSERT into categorias(nombre)
values('LB'),
       ('LACTEOS'),
       ('ROPA')     ,
       ('BEBIDAS'),
       ('CARNES FRIAS');

SELECT * from categorias

insert into producto (nombre, existencia, precio, categoriaID)
VALUES('REFRIGERADOR', 3, 10000.0, 1),
       ('ESTUFA', 3, 9000.04, 1),
       ('CREMA', 2, 10.5,2),
       ('YOGURT', 3, 13.45, 2);

SELECT * FROM producto;

SELECT *
from producto AS P 
INNER JOIN categorias as c 
on p.categoriaID = c.categoriaid;

--consulta utilizando un left join

SELECT * 
FROM categorias as c 
left JOIN producto as p 
on p.categoriaid = c.categoriaid;

--
SELECT c.categoriaid, c.nombre
FROM categorias as c 
left JOIN producto as p 
on p.categoriaid = c.categoriaid
Where p.categoriaid is not NULL; 

--
SELECT * 
FROM producto as c 
FULL JOIN categorias as p 
on p.categoriaid = c.categoriaid;

--EJERCICIO 
-- 1. crear una base de datos llamada ejerciciojoins
-- 2. crear una tabla empleados tomando como base la tabla employees de northwind (no tomar todos los campos)
-- 3. llenar la tabla con una consulta a la tabla employees
-- 4. agregar nuevos datos a la tabla empleados por lo menos dos 
-- 5. actualizar la tabla empleados con los nuevos registros, la cual se llenaran en una nueva tabla llamada dim_producto 
