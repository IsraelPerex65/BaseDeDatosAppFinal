-- Funciones de Fecha

-- Seleccionar los años, dias, mes y cuatrimestre de las ordenes
use northwind;

select GETDATE()

-- Funcion que devuelve alguna parte de una fecha 

select DATEPART(year, '2024-06-06') as 'Año',
DATEPART(month, '2024-06-06') as 'Mes',
DATEPART(quarter, '2024-06-06') as 'Trimestre',
DATEPART(week, '2024-06-06') as 'Semana',
DATEPART(day, '2024-06-06') as 'Dia',
DATEPART(weekday, '2024-06-06') as 'Dia de la semana',
DATEPART(yy, '2024-06-06') as 'Anio 2'


select DATEPART(year, orderdate) as 'Año',
DATEPART(month, orderdate) as 'Mes',
DATEPART(quarter, orderdate) as 'Trimestre',
DATEPART(week, orderdate) as 'Semana',
DATEPART(day, orderdate) as 'Dia',
DATEPART(weekday, orderdate) as 'Dia de la semana',
DATEPART(yy, orderdate) as 'Anio 2'
from orders;


-- Funcion que regresa el nombre de un mes o dia etc

select DATENAME(month, GETDATE()) as mes

set LANGUAGE spanish

select DATENAME(month, GETDATE()) as mes, DATENAME(weekday, GETDATE()) as dia

set LANGUAGE english

select DATENAME(month, GETDATE()) as mes, DATENAME(weekday, GETDATE()) as dia


set LANGUAGE spanish
select DATENAME(year, orderdate) as 'Año',
DATENAME(month, orderdate) as 'Mes',
DATENAME(quarter, orderdate) as 'Trimestre',
DATENAME(week, orderdate) as 'Semana',
DATENAME(day, orderdate) as 'Dia',
DATENAME(weekday, orderdate) as 'Dia de la semana',
DATENAME(yy, orderdate) as 'Anio 2'
from orders;

-- Funcion para obtener la diferencia entre anios, meses, dias, etc

select DATEDIFF(year,'1983-04-06', getdate()) as 'Tiempo de vejez';


-- seleccionar el numero de dias trancurridos entre la fecha de pedidio y la fecha de entrega
select orderid, orderDate  ,DATEDIFF(day, orderdate, shippeddate) as 'Dias trancurridos' from ORDERS;
