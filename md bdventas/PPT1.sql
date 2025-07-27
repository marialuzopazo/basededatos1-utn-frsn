--Instrucciones del Lenguaje de definición de datos
USE northwind
CREATE TABLE customer
(cust_id int, company varchar(40), 
contact varchar(30), phone char(12) )
GO

--Instrucciones del Lenguaje de control de datos
USE northwind
GRANT SELECT ON customer TO public
GO

USE Northwind 
DROP TABLE customer
GO

--Instrucciones del Lenguaje de tratamiento de datos
USE northwind
SELECT categoryid, productname, productid, unitprice 
FROM products
GO

--Comentarios de línea
SELECT productname, (unitsinstock - unitsonorder) as inventario -- Calcula el inventario
, supplierIDFROM products
GO

--Comentarios de bloque
/* 
 Este código devuelve todas las filas de la tabla products
 y muestra el precio por unidad, el precio aumentado en un 
 10 por ciento y el nombre del producto. 
*/
USE northwind
SELECT unitprice, (unitprice * 1.1) precioaumentado, productname 
FROM products
GO

--Comentarios de bloque
/* 
DECLARE @v1 int 
SET @v1 = 0 
WHILE @v1 < 100 
BEGIN 
 SELECT @v1 = (@v1 + 1) 
 SELECT @v1 
END 
*/

--Variables
USE northwind
DECLARE  @EmpID  varchar(11)
        ,@vlName char(20)
SET @vlname = 'Dodsworth'
SELECT @EmpID = employeeid 
 FROM  employees
 WHERE LastName = @vlname
SELECT @EmpID AS EmployeeID 
GO 

USE Northwind 
SELECT * FROM Employees
WHERE EmployeeID = 9
GO

--Funciones de agregado
USE northwind
SELECT AVG (unitprice) AS AvgPrice FROM products
GO

--Funciones escalares
USE northwind
SELECT DB_NAME() AS 'database'
GO

--Ejemplos de función del sistema
SELECT 'ANSI:', CONVERT(varchar(30), GETDATE(), 102) AS Style
UNION
SELECT 'Japanese:', CONVERT(varchar(30), GETDATE(), 111)
UNION
SELECT 'European:', CONVERT(varchar(30), GETDATE(), 113)
GO

--Otros seteos
SET DATEFORMAT dmy 
GO 
DECLARE @vdate datetime 
SET @vdate = '29/11/98' 
SELECT @vdate 
GO 

--Otras funciones
USE Northwind  
SELECT user_name(), app_name() 
GO

USE Northwind 
SELECT COLUMNPROPERTY(OBJECT_ID('Employees'), 'FirstName', 'AllowsNull') 
GO

USE Northwind 
SELECT COLUMNPROPERTY(OBJECT_ID('Employees'), 'Title', 'AllowsNull') 
GO

--Expresiones
SELECT  OrderID, ProductID,(UnitPrice * Quantity) as ExtendedAmount
 FROM  [Order Details]
 WHERE (UnitPrice * Quantity) > 10000
GO

--Elementos del lenguaje de control de flujo
DECLARE @n tinyint
SET @n = 5
IF (@n BETWEEN 4 and 6)
 BEGIN
  WHILE (@n > 0)
   BEGIN
    SELECT  @n AS 'Number'
      ,CASE
        WHEN (@n % 2) = 1
          THEN 'ODD'
        ELSE 'EVEN'
       END AS 'Type'
    SET @n = @n - 1
   END
 END
ELSE
 PRINT 'NO ANALYSIS'
GO

--Otros
SELECT * FROM orders 
WHERE customerid = 'frank'

USE northwind 
IF EXISTS (SELECT * FROM orders 
WHERE customerid = 'frank') 
  PRINT '*** Customer cannot be deleted ***' 
ELSE 
  BEGIN 
 DELETE customers WHERE customerid = 'frank' 
 PRINT '*** Customer deleted ***' 
  END 
GO 


