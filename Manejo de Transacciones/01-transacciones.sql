/* 
Las transacciones son fundamentales para asegurar la consistencia 
y la integridad de los datos
	Transaccion: Es una unidad de trabajo que se ejecuta de manera
	completamente exitosa o no se ejecuta en absoluto

BEGIN TRANSACTION: INICIA UNA NUEVA TRANSACCION
COMMIT TRANSACTION: CONFIRMA TODOS LOS CAMBIOS REALIZADOS DURANTE LA TRANSACCION
ROLLBACK TRANSACTION: REVIRTE TODOS LOS CAMBIOS REALIZADOS DURANTE LA TRANSACCION
*/

use Northwind;

Select * from Categories

begin transaction
commit transaction
rollback transaction

insert into Categories (CategoryName, [Description])
values
	('categoria 11', 'los remediales')