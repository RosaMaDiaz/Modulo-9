USE prueba2
GO

/*COUNT*/
SELECT COUNT( tot_ventas ) AS 'Total Registros' FROM vtaxvendedor
SELECT COUNT( tot_ventas ) AS 'Ventas de Karla' FROM vtaxvendedor
WHERE vendedor = 'Karla Alas';

/*SUM*/
SELECT SUM(tot_ventas) AS TOTAL_VENDIDOS FROM vtaxvendedor;
SELECT vendedor AS Vendedor, SUM(tot_ventas) AS 'Total Vendido' 
FROM vtaxvendedor
GROUP BY vendedor;

/*AVG*/
SELECT AVG(tot_ventas) AS TOTAL_VENDIDOS FROM vtaxvendedor;
SELECT vendedor AS Vendedor, AVG(tot_ventas) AS 'Total Vendido' 
FROM vtaxvendedor
GROUP BY vendedor;

/*MAX y MIN*/
SELECT MAX( tot_ventas ) AS 'VENTA MAYOR' FROM vtaxciudad
SELECT MIN( tot_ventas ) AS 'VENTA MENOR' FROM vtaxciudad
SELECT MAX( tot_ventas ) AS 'VENTA MAYOR' , MIN( tot_ventas ) AS 'VENTA MENOR' FROM vtaxciudad;

/*Cláusula GROUP BY*/
/*Ejemplo 1. Total de Ventas por Vendedor*/
SELECT vendedor,
	SUM(tot_ventas) AS Total_Vendido
FROM vtaxvendedor
GROUP BY vendedor;

/*Ejemplo 2. Promedio de Ventas por Vendedor*/
SELECT vendedor,
	AVG(tot_ventas) AS Total_Vendido
FROM vtaxvendedor
GROUP BY vendedor;

/*Ejemplo 3. Cantidad de Registros por
Vendedor*/
SELECT vendedor,
	COUNT(*) AS Cantidad_Registros
	FROM vtaxvendedor
GROUP BY vendedor;

/*Ejemplo 4. Venta Más Alta por Vendedor*/
SELECT vendedor,
	MAX(tot_ventas) AS Venta_Mayor
FROM vtaxvendedor
GROUP BY vendedor;

/*Ejemplo: Resumen General de la Empresa
	Realizado en Gestion Comercial*/

/*Ejemplo 1. Vendedores con Ventas Superiores a 1,000*/
SELECT vendedor,
	SUM(tot_ventas) AS Total_Vendido
FROM vtaxvendedor
GROUP BY vendedor
HAVING SUM(tot_ventas) > 1000;


/*Ejemplo 2. Vendedores con Promedio de Ventas Superior a 700*/
SELECT vendedor,
	AVG(tot_ventas) AS Total_Ventas
FROM vtaxvendedor
GROUP BY vendedor
HAVING AVG(tot_ventas) > 700;


/*Ejemplo 3. Vendedores con Más de Dos Registros de Venta*/
SELECT vendedor,
	COUNT(*) AS Cantidad_Ventas

FROM vtaxvendedor
GROUP BY vendedor;

/*Combinando WHERE y HAVING*/
SELECT vendedor,
	SUM(tot_ventas) AS Total_Vendido
FROM vtaxvendedor
WHERE tot_ventas > 300
GROUP BY vendedor
HAVING SUM(tot_ventas) > 1000;

/*HAVING y ORDER BY*/
SELECT vendedor,
	SUM(tot_ventas) AS Total_Vendido
FROM vtaxvendedor
GROUP BY vendedor
HAVING SUM(tot_ventas) > 1000
ORDER BY Total_Vendido DESC;

