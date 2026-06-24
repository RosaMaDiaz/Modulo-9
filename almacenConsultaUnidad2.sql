USE almacen;
GO

/*SUBCONSULTAS*/
/*SUBCONSULTA DE UN VALOR UNICO*/
SELECT nombre, cuota
FROM empleados
WHERE cuota >
	(
		SELECT AVG(cuota)
		FROM empleados
	);

/*SUBCONSULTA DE MULTIPLES VALORES*/
SELECT nombre, idoficina
FROM cliente
where idoficina IN
(
	SELECT idoficina
	FROM oficina
) 
ORDER BY idoficina ASC;

/*SUBCONSULTA CORRELACIONADA*/
SELECT E.Nombre
FROM empleados E
Where cuota >
(
SELECT AVG(cuota)
FROM empleados
Where idsuperior = e.idsuperior
);


/*Ejemplo: Mostrar clientes que realizaron pedidos igual al pedido más costoso*/
SELECT nombre
FROM cliente
Where idcliente IN
(
	SELECT idcliente
	FROM pedidos
	WHERE importe = 
	(
		SELECT MAX(importe)
		FROM pedidos
	)
);	

SELECT C.nombre,
	P.importe
FROM cliente C
INNER JOIN pedidos P
	ON C.idcliente = P.idcliente
WHERE P.importe =
(
	SELECT MAX(importe)
	FROM pedidos
);

/*Consulta Anidada en FROM. Ejemplo Consulta 1: Promedio General de los Pedidos*/
SELECT PromedioPedidos
FROM
(
	SELECT AVG(importe)
	AS PromedioPedidos
	FROM pedidos
 ) AS Datos;

 /*Ejemplo Consulta 2: Ventas Totales por Oficina Mayores a 2,000*/
 SELECT *
 FROM
 (
	SELECT E.idoficina,
		SUM(P.importe) AS TotalVentas
	FROM pedidos P
		INNER JOIN empleados E
			ON P.idempleado = E.idempleado
	GROUP BY E.idoficina
) AS VentasOficina
WHERE TotalVentas > 2000;


/*Ejemplo Consulta 3: Descripción de la Oficina y Total de Ventas*/
SELECT O.descripcion,
		V.TotalVentas
FROM
(
	SELECT E.idoficina,
		SUM(P.importe) AS TotalVentas
	FROM pedidos P
		INNER JOIN empleados E
			ON P.idempleado = E.idempleado
	GROUP BY E.idoficina
) AS V
INNER JOIN oficina O
	ON V.idoficina = O.idoficina;

/*Consulta Anidada en SELECT. Ejemplo Count 1: Cantidad de Pedidos por Cliente*/
SELECT C.nombre,
(
	SELECT COUNT(*)
	FROM pedidos P
	WHERE P.idcliente = C.idcliente
) AS CantidadPedidos
FROM cliente C;


/*Ejemplo Sum 2: Total Comprado por Cada Cliente*/
SELECT C.nombre,
(
	SELECT SUM(P.importe)
	FROM pedidos P
	WHERE P.idcliente = C.idcliente
) AS TotalComprado
FROM cliente C
WHERE EXISTS
(
	SELECT *
	FROM pedidos P
	WHERE P.idcliente = C.idcliente
);


/*Ejemplo Sum 3: Total de Ventas Gestionadas por Cada Empleado*/
SELECT E.nombre,
(
	SELECT SUM(P.importe)
	FROM pedidos P
	WHERE P.idempleado = E.idempleado
) AS TotalVentas
FROM empleados E
WHERE EXISTS
(
	SELECT *
	FROM pedidos P
	WHERE P.idempleado = E.idempleado
);


/*Ejemplo Count 4: Cantidad de Empleados por Oficina*/
SELECT O.descripcion,
(
	SELECT COUNT(*)
	FROM empleados E
	WHERE E.idoficina = O.idoficina
) AS CantidadEmpleados
FROM oficina O;


/*UNION y UNION ALL.  Ejemplo Union 1: Clientes y Suplidores*/
SELECT nombre FROM cliente
UNION
	SELECT nombre FROM suplidor;

/*Ejemplo Union 2: Ciudades Registradas*/
SELECT ciudad FROM oficina
UNION
SELECT direccion FROM suplidor;


/*CONSULTA CON UNION ALL*/
SELECT nombre FROM cliente
UNION ALL
SELECT nombre FROM empleados;


/*Uso de Alias con UNION*/
SELECT nombre AS persona
FROM cliente
UNION
SELECT nombre
FROM suplidor;


/*ORDENAMIENTO RESULTADOS CON ORDER BY*/
SELECT nombre
FROM cliente
UNION
SELECT nombre
FROM suplidor
ORDER BY nombre;


/*UNION DE MAS DE DOS CONSULTAS*/
SELECT nombre 
	FROM cliente
UNION
SELECT nombre 
	FROM empleados
UNION
SELECT nombre 
	FROM suplidor;


/*Caso Práctico de Análisis. Supongamos que la gerencia desea conocer todas las personas relacionadas con la 
empresa: clientes, empleados, suplidores.  La consultoría seria:*/
SELECT nombre, 'Cliente' AS Tipo
	FROM cliente
UNION
SELECT nombre, 'Empleado'
	FROM empleados
UNION
SELECT nombre, 'Suplidor'
	FROM suplidor;


/*Casos Prácticos de Análisis de Datos. Caso 1: Cliente con Mayor Volumen de Compras*/

SELECT TOP 1
	C.idcliente,
	C.nombre,
	SUM(P.importe) AS TotalComprado
FROM pedidos P
INNER JOIN cliente C
	ON P.idcliente = C.idcliente
GROUP BY C.idcliente, C.nombre
ORDER BY TotalComprado DESC;


/*Caso 2: Producto mas Vendido.*/
SELECT TOP 1
	P.idproducto,
	P.descripcion,
	COUNT(*) as CantidadVentas
FROM detpedido D
INNER JOIN productos P
	ON D.idproducto = P.idproducto
GROUP BY P.idproducto, P.descripcion
ORDER BY CantidadVentas DESC;



/*Caso 3: Oficinas con Mas de un Empleados*/
SELECT O.idoficina,
	O.descripcion,
	COUNT (*) AS	CantidadEmpleados
FROM empleados E
INNER JOIN oficina O
	ON E.idoficina = O.idoficina
	GROUP BY O.idoficina, O.descripcion
	HAVING COUNT(*) > 1;

/*Caso 4: Clientes con Compras Superiores al Promedio*/
SELECT C.nombre,
	P.importe,
	(
		SELECT AVG(importe)
		FROM pedidos
	) AS PromedioGeneral
FROM cliente C
INNER JOIN pedidos P
	ON C.idcliente = P.idcliente
WHERE P.importe >
(
	SELECT AVG(importe)
	FROM pedidos
);

