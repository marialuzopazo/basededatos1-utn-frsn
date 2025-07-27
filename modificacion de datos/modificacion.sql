--Transacciones
BEGIN TRANSACTION 
  UPDATE savings 
SET balance = balance - 100 
WHERE custid = 78910 
  IF @@ERROR <> 0 
BEGIN 
  RAISERROR ('Error, transaction not completed!', 16, -1) 
  ROLLBACK TRANSACTION 
END 
  UPDATE checking 
SET balance = balance +100 
WHERE custid = 78910 
  IF @@ERROR <> 0 
BEGIN 
  RAISERROR ('Error, transaction not completed!', 16, -1) 
  ROLLBACK TRANSACTION 
END 
COMMIT TRANSACTION

--INSERT
USE northwind 
INSERT customers 
(customerid, companyname, contactname, contacttitle 
,address, city, region, postalcode, country, phone 
,fax) 
VALUES ('PECOF', 'Pecos Coffee Company','Michael Dunn' 
 ,'Owner', '1900 Oak Street', 'Vancouver', 'BC' 
 ,'V3F 2K1', 'Canada', '(604) 555-3392' 
 ,'(604) 555-7293') 
GO 

--Revisamos
USE northwind 
SELECT companyname, contactname 
 FROM customers 
 WHERE customerid = 'PECOF' 
GO 

--INSERT...SELECT
USE northwind 
INSERT customers 
 SELECT substring (firstname, 1, 3) 
+ substring (lastname, 1, 2) 
 ,lastname, firstname, title, address, city 
 ,region, postalcode, country, homephone, NULL 
 FROM employees 
GO

--SELECT...INTO
USE northwind
 SELECT productname AS products
      ,unitprice AS price
      ,(unitprice * 1.1) AS tax
 INTO #pricetable
 FROM products
 GO

 --pricetable es una tabla temporal local
USE northwind 
SELECT * FROM #pricetable 
GO

--Inserci�n de datos parciales
USE northwind 
INSERT shippers (companyname) 
VALUES ('Fitch & Mather') 
GO

--Comprobamos
USE northwind 
SELECT * 
FROM shippers 
WHERE companyname = 'Fitch & Mather' 
GO 

--usando DEFAULT
USE northwind 
INSERT shippers (companyname, Phone) 
VALUES ('Fitch & Mather', DEFAULT) 
GO 

--Si borramos una de las filas en las que se repite CompanyName
--y agregaramos esta restricci�n veamos que ocurre si luego
--queremos insertar nuevamente
ALTER TABLE shippers
 ADD CONSTRAINT CK_CompanyName
 UNIQUE (CompanyName)
 GO 

 --Inserci�n de datos mediante valores de columna predeterminados
 --Palabra clave DEFAULT
 USE northwind 
INSERT shippers (companyname, phone) 
 VALUES ('Kenya Coffee Co.', DEFAULT) 
GO 

--Revisamos
USE northwind 
SELECT * 
 FROM shippers 
 WHERE companyname = 'Kenya Coffee Co.' 
GO 

--Eliminaci�n de datos
--Uso de la instrucci�n DELETE 

--Eliminamos todos los registros
USE northwind 
DELETE orders 
GO

--DELETE condicional
USE northwind 
DELETE orders 
WHERE OrderID = 10248
GO

--Existen elementos realacionados en la tabla Order Details, veamos
SELECT * FROM [Order Details]
WHERE OrderID = 10248

--DELETE condicional
USE northwind 
DELETE orders 
WHERE DATEDIFF(MONTH, shippeddate, GETDATE()) >= 6 
GO

--Sentencia TRUNCATE
USE northwind 
TRUNCATE TABLE orders 
GO 

--Como no podemos eliminar por elementos relacionados
--podemos crear una transacci�n paa eliminar primero lod detalles de orden
--y si todo fue bien, luego eliminamos la orden relcionada
BEGIN TRANSACTION 
 DELETE [Order Details]
 WHERE OrderID = 10248 
 IF @@ERROR <> 0 
 BEGIN 
  RAISERROR ('Error, transaction not completed!', 16, -1) 
  ROLLBACK TRANSACTION 
 END 
 DELETE Orders
 WHERE OrderID = 10248 
 IF @@ERROR <> 0 
 BEGIN 
  RAISERROR ('Error, transaction not completed!', 16, -1) 
  ROLLBACK TRANSACTION 
 END 
COMMIT TRANSACTION

--Eliminaci�n de filas basada en otras tablas
--Antes de eliminar miremos
SELECT * FROM  orders AS o 
  INNER JOIN [order details] AS od 
  ON o.orderid = od.orderid 
 WHERE orderdate = '1998/4/14' 

--Uso de una cl�usula FROM adicional 
USE northwind 
DELETE FROM [order details] 
 FROM orders AS o 
 INNER JOIN [order details] AS od 
  ON o.orderid = od.orderid 
 WHERE orderdate = '1998/4/14' 
GO

--Especificaci�n de condiciones en la cl�usula WHERE
USE northwind 
DELETE FROM [order details] 
 WHERE orderid IN ( 
  SELECT orderid 
  FROM orders 
  WHERE orderdate = '1998/4/14' ) 
GO

--Actualizaci�n de datos 
USE northwind 
UPDATE products 
 SET unitprice = (unitprice * 1.1) 
GO 

--Antes veamos
USE northwind 
SELECT * FROM Products
GO

--Especificaci�n de filas para actualizar con combinaciones 
USE northwind 
UPDATE products 
 SET unitprice = unitprice + 2 
 FROM products 
 INNER JOIN suppliers 
  ON products.supplierid = suppliers.supplierid 
 WHERE suppliers.country = 'USA' 
GO 

--Especificaci�n de filas para actualizar con subconsultas 
USE northwind 
UPDATE products 
 SET unitprice = unitprice + 2 
 WHERE supplierid IN ( 
                      SELECT supplierid 
                       FROM suppliers 
                       WHERE country = 'USA' 
                     ) 
GO

--Otro ejemplo
--Antes debemos crar la columna todatesales
USE Northwind
ALTER TABLE products
ADD todatesales MONEY DEFAULT 0
GO

--Ahora
USE northwind 
UPDATE products 
 SET todatesales = ( 
                    SELECT SUM(quantity) 
                     FROM [order details] AS od 
                     WHERE products.productid = od.productid 
                    ) 
GO

--Veamos como qued� Products
USE Northwind
SELECT * from Products
GO

