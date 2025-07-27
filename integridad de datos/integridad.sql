
--Integridad de datos
USE northwind 
CREATE TABLE dbo.ProductsNew
( 
   ProductID      int IDENTITY (1,1) NOT NULL, 
   ProductName    nvarchar (40) NOT NULL, 
   SupplierID     int      NULL, 
   CategoryID     int      NULL, 
   QuantityPerUnit nvarchar (20) NULL, 
   UnitPrice      money    NULL     CONSTRAINT DF_ProductsNew_UnitPrice  DEFAULT(0), 
   UnitsInStock   smallint NULL     CONSTRAINT DF_ProductsNew_UnitsInStock DEFAULT(0), 
   UnitsOnOrder   smallint NULL     CONSTRAINT DF_ProductsNew_UnitsOnOrder DEFAULT(0), 
   ReorderLevel   smallint NULL     CONSTRAINT DF_ProductsNew_ReorderLevel DEFAULT(0), 
   Discontinued   bit      NOT NULL CONSTRAINT DF_ProductsNew_Discontinued DEFAULT(0), 
 
   CONSTRAINT PK_ProductsNew PRIMARY KEY CLUSTERED (ProductID), 
 
   CONSTRAINT FK_ProductsNew_Categories FOREIGN KEY (CategoryID) 
      REFERENCES dbo.Categories (CategoryID) ON UPDATE CASCADE, 
   CONSTRAINT FK_ProductsNew_Suppliers  FOREIGN KEY (SupplierID) 
      REFERENCES dbo.Suppliers  (SupplierID) ON DELETE CASCADE, 
 
   CONSTRAINT CK_Products_UnitPriceNew CHECK (UnitPrice >= 0), 
   CONSTRAINT CK_ReorderLevelNew       CHECK (ReorderLevel >= 0), 
   CONSTRAINT CK_UnitsInStockNew       CHECK (UnitsInStock >= 0), 
   CONSTRAINT CK_UnitsOnOrderNew       CHECK (UnitsOnOrder >= 0) 
) 
GO 

--Consultamos las restricciones de la tabla
EXEC sp_helpconstraint ProductsNew

--Eliminamos la tabla
DROP TABLE ProductsNew

--Restricciones DEFAULT 
USE Northwind 
ALTER TABLE dbo.Customers 
ADD 
CONSTRAINT DF_contactname DEFAULT 'UNKNOWN' FOR ContactName

--Restricciones CHECK
USE Northwind 
ALTER TABLE dbo.Employees 
ADD
CONSTRAINT CK_birthdate 
CHECK (BirthDate > '01-01-1900' AND BirthDate < getdate()) 

--Como ya existe la podemos eliminar y volver a crear
USE Northwind
ALTER TABLE dbo.Employees 
DROP CONSTRAINT CK_Birthdate
GO

--Tambi�n es posible agregar otra restricci�n al mismo campo
USE Northwind 
ALTER TABLE dbo.Employees 
ADD
CONSTRAINT CK_birthdateNew 
CHECK (BirthDate > '01-01-1900' AND BirthDate < getdate())

--Restricciones PRIMARY KEY 
USE northwind 
ALTER TABLE dbo.Customer
ADD 
CONSTRAINT PK_Customer 
PRIMARY KEY NONCLUSTERED (CustID) 

--Restricciones UNIQUE (probar repitiendo nombre de compa�ia -> Edit Top 200 rows)
USE northwind 
ALTER TABLE dbo.Suppliers 
ADD 
CONSTRAINT U_CompanyName 
UNIQUE NONCLUSTERED (CompanyName)

--Restricciones FOREIGN KEY 
USE northwind 
ALTER TABLE dbo.Orders 
ADD CONSTRAINT FK_Orders_Customers 
FOREIGN KEY (CustomerID) 
REFERENCES dbo.Customers(CustomerID)

--dropeamos la FK (y luego la volvemos a crear porque ya existe)
USE Northwind
ALTER TABLE dbo.Orders 
DROP CONSTRAINT FK_Orders_Customers
GO

--Deshabilitaci�n de la comprobaci�n de las restricciones en los datos existentes 
USE northwind 
ALTER TABLE dbo.Employees 
WITH NOCHECK 
ADD CONSTRAINT FK_Employees_Employees 
FOREIGN KEY (ReportsTo) 
REFERENCES dbo.Employees(EmployeeID)

--dropeamos la FK (y luego la volvemos a crear porque ya existe)
USE Northwind
ALTER TABLE dbo.Employees 
DROP CONSTRAINT FK_Employees_Employees
GO

--Deshabilitaci�n de la comprobaci�n de las restricciones al cargar datos nuevos 
USE northwind 
ALTER TABLE dbo.Employees 
NOCHECK 
CONSTRAINT FK_Employees_Employees

--Probar Employees -> Edit Top 200 rows, actualizando el valor del campo ReportsTo
--con un EmployeeID que no existe, por ejemplo: 24 y permitir� hacerlo
--esto ser�a un grave inconveniente si no sabemos bien lo que estamos haciendo

--Habilitaci�n de la comprobaci�n de las restricciones al cargar datos nuevos 
USE northwind 
ALTER TABLE dbo.Employees 
CHECK 
CONSTRAINT FK_Employees_Employees

--Uso de valores predeterminados y reglas
USE Northwind 
GO 
CREATE DEFAULT phone_no_default 
 AS '(000)000-0000' 
GO 
EXEC sp_bindefault phone_no_default, 'Customers.Phone'

--unbound
EXEC sp_unbindefault 'Customers.Phone'

--Eliminar DEFAULT
DROP DEFAULT phone_no_default

--consultamos y vemos que da error porque ya no existe
EXEC sp_help phone_no_default

--Creaci�n de una regla 
USE Northwind 
GO 
CREATE RULE regioncode_rule 
 AS @regioncode IN ('IA', 'IL', 'KS', 'MO') 
GO 
EXEC sp_bindrule regioncode_rule, 'Customers.Region' 

--unbound
EXEC sp_unbindrule 'Customers.Region'

--Eliminar DEFAULT
DROP RULE regioncode_rule

--consultamos y vemos que da error porque ya no existe
EXEC sp_help regioncode_rule
