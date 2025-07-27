--Recuperaci�n de datos mediante la instrucci�n SELECT 
USE northwind 
SELECT *
FROM employees 
GO 

USE northwind 
SELECT employeeid, lastname, firstname, title 
FROM employees 
GO 

--Uso de la cl�usula WHERE para especificar filas 
USE northwind 
SELECT employeeid, lastname, firstname, title 
FROM employees 
WHERE employeeid = 5 
GO

--Filtros de datos
--Uso de los operadores de comparaci�n 
USE northwind 
SELECT lastname, city 
FROM employees 
WHERE country = 'USA' 
GO 

USE northwind 
SELECT orderid, customerid 
FROM orders 
WHERE orderdate < '1996/8/1' 
GO

--Uso de comparaciones de cadenas 
USE northwind 
SELECT companyname 
FROM customers 
WHERE companyname LIKE '%Restaurant%' 
GO

--Uso de operadores l�gicos 
USE northwind 
SELECT productid, productname, supplierid, unitprice 
 FROM products 
 WHERE (productname LIKE 'T%' OR productid = 46) 
  AND (unitprice > 16.00) 
GO 

--otro ejemplo
USE northwind 
SELECT productid, productname, supplierid, unitprice 
 FROM products 
 WHERE (productname LIKE 'T%') 
  OR   (productid = 46 AND unitprice > 16.00) 
GO

--Obtenci�n de un intervalo de valores 
USE northwind 
SELECT productname, unitprice 
FROM products 
WHERE unitprice BETWEEN 10 AND 20 
GO 

--otro ejemplo
USE northwind 
SELECT productname, unitprice 
FROM products 
WHERE (unitprice > 10) 
 AND  
(unitprice < 20) 
GO 

--Uso de una lista de valores como criterio de b�squeda
USE northwind 
SELECT companyname, country 
FROM suppliers 
WHERE country IN ('Japan', 'Italy') 
GO 

--otro ejemplo
USE northwind 
SELECT companyname, country 
FROM suppliers 
WHERE country = 'Japan' OR country = 'Italy' 
GO 

--Obtenci�n de valores desconocidos 
USE northwind 
SELECT companyname, fax 
FROM suppliers 
WHERE fax IS NULL 
GO 

--Dar formato a los conjuntos de resultados
--Ordenaci�n de los datos 
USE northwind 
SELECT productid, productname, categoryid, unitprice 
 FROM products 
 ORDER BY categoryid, unitprice DESC 
GO 

--lo mismo otra sintaxis
USE northwind 
SELECT productid, productname, categoryid, unitprice 
 FROM products 
 ORDER BY 3, 4 DESC 
GO 

--Eliminaci�n de filas duplicadas
USE northwind 
SELECT DISTINCT country 
 FROM suppliers 
 ORDER BY country 
GO

--la misma consulta sin DISTINCT
USE northwind 
SELECT country 
 FROM suppliers 
 ORDER BY country 
GO

--Cambio del nombre de las columnas
USE northwind 
SELECT  firstname AS First, lastname AS Last 
 ,employeeid AS 'Employee ID:' 
FROM employees 
GO 

--Uso de literales
USE northwind 
SELECT  firstname, lastname 
       ,'N�mero de identificaci�n:', employeeid 
FROM employees 
GO
