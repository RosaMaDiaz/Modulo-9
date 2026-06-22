/*CONUSULTAS DE LA BASE DE DATOS ADVENTUREWORKS2022*/

USE AdventureWorks2022;
/*1. Seleccionar todos los datos de la tabla Sales.SalesPerson.*/
SELECT * FROM  Sales.SalesPerson;

/*2. Seleccionar todos los registros de los primeros 4 campos de la tabla
Production.Product*/
SELECT ProductID, Name, ProductNumber, MakeFlag FROM Production.Product;

/*3. Mostrar los 10 productos con el costo (StandardCost) más alto almacenados en la
tabla Production.ProductCostHistory*/
SELECT TOP 10 WITH TIES *
FROM Production.ProductCostHistory
ORDER BY StandardCost DESC;

/*4. Seleccionar los campos Name, ProductNumber, ListPrice de la tabla Production.Product, 
debe renombrar cada campo en el siguiente orden: Nombre Producto, Numero de Producto y Precio, 
los registros y se deben ordenar de forma ascendente*/
SELECT Name AS [Nombre], ProductNumber AS [Numero de Producto], ListPrice AS [Precio]
FROM Production.Product 
ORDER BY Nombre ASC;

/*5. Seleccionar los primeros tres campos de la tabla Purchansing.Vendor donde el dato
almacenado en el campo AccountNumber comience con cualquier letra del rango de
la G a la T*/

SELECT * FROM Purchasing.Vendor;

SELECT 
    BusinessEntityID AS [ID], 
    AccountNumber AS [Numero de Cuenta], 
    Name AS [Nombre]
FROM Purchasing.Vendor
WHERE AccountNumber LIKE '[G-T]%'

/*. Mostrar los datos de la tabla Person.CountryRegion donde el campo CountryRegionCode contenga cualquiera 
de los siguientes datos: AR, BO, CO, ES, SV y VN*/
SELECT 
    CountryRegionCode, 
    Name, 
    ModifiedDate
FROM Person.CountryRegion
WHERE CountryRegionCode IN ('AR', 'BO', 'CO', 'ES', 'SV', 'VN')

/*Seleccionar los campos CountryRegionCode de la tabla Person.StateProvince, pero
en el resultado los datos no tienen que repetirse.*/
SELECT DISTINCT CountryRegionCode
FROM Person.StateProvince;

/*8. Seleccionar los campos SalesOrderID, OrderQty de la tabla Sales.SalesOrderDetail
en donde los datos del campo UnitPrice se encuentre entre los valores de 200 y
1000.*/
SELECT SalesOrderID, OrderQty, UnitPrice
FROM Sales.SalesOrderDetail
WHERE UnitPrice BETWEEN 200 AND 1000;

/*9. Mostrar los campos ProductID, ListPrice de la tabla Production.Product y una
columna más que muestre un aumento del 15% del dato almacenado en ListPrice
renombrar esta nueva columna con el nombre Aumento de Precio */
SELECT * FROM Production.Product;

SELECT 
    ProductID, ListPrice, 
    (ListPrice * 1.15) AS [Aumento de Precio]
FROM Production.Product;


/*VERIFICANDO SI HAY LISTA DE PRECIO > 0 */
SELECT 
    ProductID, 
    ListPrice, 
    (ListPrice * 1.15) AS [Aumento de Precio]
FROM Production.Product
WHERE ListPrice > 0;

/*USANDO UPDATE*/
UPDATE Production.Product
SET ListPrice = ListPrice * 1.15
WHERE ListPrice > 0;


/*10. Seleccionar el 20% de los registros almacenados en la tabla Sales.SalesOrderDetail*/
SELECT TOP 20 PERCENT *
FROM Sales.SalesOrderDetail;