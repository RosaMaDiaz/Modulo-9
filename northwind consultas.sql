USE northwind;
GO

/*Ejercicio 1. Uso de la cláusula FROM
1. Seleccionar todas las columnas de la tabla Categories*/
SELECT * FROM Categories;


/*2. Seleccionar los campos CategoryName y CategoryID de la tabla Categories*/
SELECT CategoryName, CategoryID FROM Categories


/*Ejercicio 2. Uso de la cláusula WHERE
1. Seleccionar los campos OrderID, ProductID y UnitPrice de la tabla Order Details donde el
OrderID sea igual a 10251*/
SELECT OrderID, ProductID, UnitPrice from [Order Details] WHERE OrderID = 10251


/*2. Seleccionar el campo CompanyName de la tabla Customers donde este sea igual a Alfreds
Futterkiste*/
SELECT CompanyName FROM Customers WHERE CompanyName='Alfreds Futterkiste'


/*3. Seleccionar los campos OrderID, ProductID y UnitPrice de la tabla Order Details donde
OrderID sea igual a 10251 y ProductID sea igual a 57*/
SELECT OrderID, ProductID, UnitPrice FROM [Order Details]
WHERE OrderID = 10251 AND ProductID = 57


/*4. Seleccionar los campos OrderID, ProductID y UnitPrice de la tabla Order Details donde el
dato almacenado en OrderID sea mayor o igual a 11000 y OrderID sea menor o igual a 11003
(con BETWEEN)*/
SELECT OrderID, ProductID, UnitPrice FROM [Order Details]
WHERE OrderID BETWEEN 11000 AND 11003


/*5. Seleccionar el campo CompanyName de la tabla Customers donde el dato almacenado en
ese campo termine con los caracteres MA*/
SELECT CompanyName FROM Customers WHERE CompanyName LIKE '%MA'


/*6. Seleccionar el campo OrderID de la tabla Order Details donde el dato almacenado en el
campo comience con un numero cualquiera, pero el cual debe terminar con los dígitos 0285*/
SELECT OrderID FROM [Order Details] WHERE OrderID LIKE '_0285'


/*7. Seleccionar todos los campos de la tabla Order Details donde el campo OrderID tenga
alguno de los siguientes datos: 10248, 10255 y 10270*/
SELECT * FROM [Order Details] WHERE OrderID IN (10248, 10255, 10270)


/*Ejercicio 3. Uso de la cláusula ORDER BY
1. Ordenar de manera ascendente los registros almacenados en los campos CategoryName y
CategoryID de la tabla Categories*/
SELECT CategoryName, CategoryID FROM Categories ORDER BY CategoryName ASC

/*Ejercicio 4. Uso de la instrucción DISTINCT
1. Digitar la siguiente consulta*/
SELECT SupplierID, CategoryID FROM Products


/*Se obtienen los siguientes resultados:
2. Con la siguiente consulta, se obtendrán los mismos resultados, pero mostrando un único registro de todos los que están repetidos que se mostraron en
la consulta anterior. Seleccionar un único registro de los campos SupplierID y CategoryID de la tabla Products*/
SELECT DISTINCT SupplierID, CategoryID FROM Products


/*Observa los resultados que se obtienen:
Ejercicio 5. Renombrar columnas de una consulta
1. Con la instrucción AS se está renombrando una columna del resultado de una consulta en este
ejercicio se está colocando un sobrenombre a las columnas CategoryID y CategoryName de la tabla
Categories*/
SELECT CategoryID AS [Codigo de la Categoria],
CategoryName AS [Nombre de la Categoria] FROM Categories


/*2. En este ejemplo se ha colocado a la columna el sobrenombre Aumento a la operación de calcular
un aumento del 10% al precio original del producto*/
SELECT ProductID, ProductName, UnitPrice, UnitPrice*1.10 AS Incremento
FROM products


/*Ejercicio 6. Uso de la instrucción TOP N
Para estos ejercicios se ha calculado la venta (unidades vendidas por el precio unitario) de cada
orden y se ha renombrado a la columna con el nombre Venta Total*/
1. Seleccionar las primeras 3 mejores ventas de la tabla Order Details
SELECT TOP 3 OrderID, (UnitPrice*Quantity) AS [Venta Total]
FROM [Order Details]
ORDER BY [Venta Total] DESC


/*2. Seleccionar las tres mejores ventas, utilizando la instrucción WITH TIES se permitirá incluir en los
resultados los registros que tengan el mismo valor en el cálculo de la Venta Total*/
SELECT TOP 3 WITH TIES OrderID, (UnitPrice*Quantity) AS [Venta Total]
FROM [Order Details]
ORDER BY [Venta Total] DESC



/*3. Seleccionar el 25% del total de registros de las ventas las cuales están almacenadas en la tabla
Order Details*/
SELECT TOP 25 PERCENT OrderID, (UnitPrice*Quantity) AS [Venta Total]
FROM [Order Details]
ORDER BY [Venta Total] DESC