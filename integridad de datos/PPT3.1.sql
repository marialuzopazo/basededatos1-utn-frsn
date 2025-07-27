--Creación y eliminación de tipos de datos definidos por el usuario
EXEC sp_addtype  city, 'nvarchar(15)', NULL
EXEC sp_addtype  region, 'nvarchar(15)', NULL
EXEC sp_addtype  country, 'nvarchar(15)', NULL

--Para verlo creado: Northwind -> Programmability -> Types -> User Defined Data Types
-- para consultar el tipo de datos
EXEC sp_help city

--Para eliminar el tipo de datos
EXEC  sp_droptype city
EXEC  sp_droptype region
EXEC  sp_droptype country

-- para consultar sobre la bd
EXEC sp_helpdb Northwind

--Creación de una tabla
CREATE TABLE dbo.CategoriesNew 
(CategoryID int IDENTITY (1, 1) NOT NULL,
CategoryName nvarchar(15) NOT NULL, 
Descripción ntext NULL, 
Picture image NULL) 

--Eliminar una tabla
DROP TABLE dbo.CategoriesNew

--Para consultar como quedó la tabla
EXEC sp_help CategoriesNew

--Agregar columna
ALTER TABLE CategoriesNew
ADD Commission money null

--Quitar columna
ALTER TABLE CategoriesNew
DROP COLUMN Commission

--Creación de una tabla con identity con semilla y salto diferentes
CREATE TABLE Class 
 (StudentID int  IDENTITY(100, 5) NOT NULL,  
 Name varchar(16)) 

 --agregar valores haciendo botón derecho del mouse sobre la tabla -> Edit Top 200 rows
 --observar como se incrementa el id

--Eliminamos la tabla Class
DROP TABLE Class

--Creación de una tabla con NEWID()
CREATE TABLE Customer
 (CustID uniqueidentifier NOT NULL DEFAULT NEWID(),
 CustName char(30) NOT NULL)

--consultamos
EXEC sp_help Customer

 --agregar valores haciendo botón derecho del mouse sobre la tabla -> Edit Top 200 rows
 --observar como no muestra id
 --consultar registros de la tabla para ver que creo como CustID
 SELECT * FROM Customer





 






