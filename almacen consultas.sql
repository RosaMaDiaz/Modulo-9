/*CONSULTAS DE LA BASE DE DATOS ALLMACEN*/
USE almacen ;
GO
/*1. Listar las oficinas del este indicando para cada una su id, ciudad, id y nombres de sus empleados.*/
SELECT O.idoficina AS Numero_Oficina,
		O.ciudad AS Ciudad,
		E.idempleado AS Numero_Empleado,
		E.nombre AS Nombre_Empleado
FROM oficina O
INNER JOIN empleados E ON O.idoficina = E.idoficina
WHERE O.region = 'Este' 
ORDER BY O.idoficina, E.nombre;

/*2. Listar los pedidos mostrando su número, importe, nombre del cliente, y el límite de crédito del
cliente correspondiente (todos los pedidos tienen cliente y representante).*/
SELECT P.nopedido AS Numero_Pedido,
		P.importe AS Importe,
		C.nombre AS Nombre_cliente,
		C.limite_credito AS Limite_Credito
FROM pedidos P
INNER JOIN cliente C ON P.idcliente = C.idcliente
ORDER BY Numero_Pedido


/*3. Prueba la siguiente consulta y escribe su descripción general.*/
SELECT dp.nopedido AS Numero_Pedido,
	dp.idproducto AS Codigo_Producto,
	dp.descripcion AS Descripcion_Producto,
	dp.cantidad As Cantidad,
	dp.precio AS Precio,
	dp.total As Total,
	dp.itbis As Itbis,
	dp.importe As Importe,
	p.idcliente
FROM almacen.dbo.detpedido dp
	INNER JOIN almacen.dbo.pedidos p ON dp.nopedido = p.nopedido
ORDER BY dp.nopedido, dp.idproducto;

/*4. Listar los pedidos superiores a 1000 pesos, mostrando el nombre del cliente que solicitó el pedido y
el nombre del vendedor asignado a ese cliente.*/

SELECT 
    p.nopedido AS Numero_Pedido, 
    p.importe AS Importe,
    c.nombre AS Nombre_Cliente,
    e.nombre AS Nombre_Vendedor
FROM almacen.dbo.pedidos p
INNER JOIN almacen.dbo.cliente c ON p.idcliente = c.idcliente
INNER JOIN almacen.dbo.empleados e ON p.idempleado = e.idempleado 
WHERE p.importe >= 1000
ORDER BY p.importe DESC;


/*5. Listar los pedidos superiores a 250 euros, mostrando además el nombre del cliente que solicitó el
pedido y el nombre del vendedor asignado a ese cliente y la ciudad de la oficina donde el vendedor
trabaja.*/
SELECT
	p.nopedido AS Numero_Pedido, 
    p.importe AS Importe,
    c.nombre AS Nombre_Cliente,
    e.nombre AS Nombre_Vendedor,
	o.ciudad AS Ciudad_Oficina
FROM almacen.dbo.pedidos p
INNER JOIN almacen.dbo.cliente c ON p.idcliente = c.idcliente
INNER JOIN almacen.dbo.empleados e ON p.idempleado = e.idempleado 
INNER JOIN almacen.dbo.oficina o ON e.idoficina = o.idoficina
WHERE p.importe >= 250
ORDER BY p.importe DESC;

/*6. Mostrar de cada empleado su código, nombre, ventas, oficina y ciudad en la que está ubicada su
oficina.*/

SELECT 
	E.idempleado AS Numero_Empleado,
	E.nombre AS Nombre_Empleado,
	E.ventas AS Ventas,
	O.idoficina AS Numero_Oficina,
	O.ciudad AS Ciudad_Oficina
FROM empleados E
INNER JOIN oficina O ON E.idoficina = O.idoficina

/*7. Listar los empleados con una cuota superior a la de su jefe, los campos a obtener son el número,
nombre y cuota del empleado y número, nombre y cuota de su jefe.*/
SELECT 
    e.idempleado AS ID_Empleado,
    e.nombre AS Nombre_Empleado,
    e.cuota AS Cuota_Empleado,
    j.idempleado AS ID_Jefe,
    j.nombre AS Nombre_Jefe,
    j.cuota AS Cuota_Jefe
FROM almacen.dbo.empleados e
INNER JOIN almacen.dbo.empleados j ON e.idjefe = j.idempleado 
WHERE e.cuota > j.cuota; 

/*8. Listar los empleados que no están asignados a la misma oficina que su jefe, queremos número,
nombre y número de oficina tanto del empleado como de su jefe.*/
SELECT 
    e.idempleado AS ID_Empleado,
    e.nombre AS Nombre_Empleado,
    e.idoficina AS Oficina_Empleado,
    j.idempleado AS ID_Jefe,
    j.nombre AS Nombre_Jefe,
    j.idoficina AS Oficina_Jefe
FROM almacen.dbo.empleados e
INNER JOIN almacen.dbo.empleados j ON e.idjefe = j.idempleado
WHERE e.idoficina <> j.idoficina;

/*9. En el punto anterior no salen los que no tienen oficina, cambiar la sentencia para que aparezcan.*/
SELECT 
    e.idempleado AS ID_Empleado,
    e.nombre AS Nombre_Empleado,
    e.idoficina AS Oficina_Empleado,
    j.idempleado AS ID_Jefe,
    j.nombre AS Nombre_Jefe,
    j.idoficina AS Oficina_Jefe
FROM almacen.dbo.empleados e
LEFT JOIN almacen.dbo.empleados j ON e.idjefe = j.idempleado
WHERE (e.idoficina <> j.idoficina)
   OR e.idoficina IS NULL
   OR j.idoficina IS NULL;



/*10. Lo mismo que la anterior, pero queremos que aparezca también la ciudad de las oficinas (tanto del
empleado como de su jefe).*/
SELECT 
    e.idempleado AS ID_Empleado,
    e.nombre AS Nombre_Empleado,
    e.idoficina AS Oficina_Empleado,
    o.ciudad AS Ciudad_Oficinas,
    j.idempleado AS ID_Jefe,
    j.nombre AS Nombre_Jefe,
    j.idoficina AS Oficina_Jefe
FROM almacen.dbo.empleados e
LEFT JOIN almacen.dbo.empleados j ON e.idjefe = j.idempleado
LEFT JOIN almacen.dbo.oficina o ON o.idoficina = e.idoficina
WHERE (e.idoficina <> j.idoficina)
   OR e.idoficina IS NULL
   OR j.idoficina IS NULL;


/*11. Total de pedidos por cliente
Listar cada cliente mostrando su código, nombre y la cantidad de pedidos realizados. Ordenar el
resultado de mayor a menor cantidad de pedidos*/

SELECT
    c.idcliente AS Codigo_Cliente,
    c.nombre AS Nombre_Cliente,
    COUNT(p.nopedido) AS Cantidad_Pedidos
FROM almacen.dbo.cliente c
INNER JOIN almacen.dbo.pedidos p ON c.idcliente = p.idcliente
GROUP BY c.idcliente, c.nombre
ORDER BY Cantidad_Pedidos DESC;



/*12. Importe total vendido por empleado
Mostrar el código y nombre de cada empleado junto con el importe total de los pedidos gestionados
por dicho empleado.*/
SELECT
    e.idempleado AS Codigo_Empleado,
    e.nombre AS Nombre_Empleado,
    SUM(p.importe) AS Importe_Total
FROM almacen.dbo.empleados e
INNER JOIN almacen.dbo.pedidos p ON p.idempleado = e.idempleado
GROUP BY e.idempleado, e.nombre
ORDER BY Importe_Total DESC;

/*13. Cantidad de productos vendidos
Mostrar cada producto indicando su código, descripción y la cantidad total vendida en todos los
pedidos.*/
SELECT
    p.idproducto AS Codigo_Producto,
    p.descripcion AS Descripcion,
    SUM(dp.cantidad) AS Cantidad_Total_Vendida
FROM almacen.dbo.productos p
INNER JOIN almacen.dbo.detpedido dp ON dp.idproducto = p.idproducto
GROUP BY p.idproducto, p.descripcion
ORDER BY Cantidad_Total_Vendida DESC;

/*14. Clientes con mayor límite de crédito
Listar los clientes cuyo límite de crédito sea superior al promedio de crédito de todos los clientes.*/
SELECT
    c.idcliente AS Codigo_Cliente,
    c.nombre AS Nombre_Cliente,
    c.limite_credito AS Limite_Credito
FROM almacen.dbo.cliente c
WHERE c.limite_credito > (
    SELECT AVG(limite_credito) 
    FROM almacen.dbo.cliente
)
ORDER BY c.limite_credito DESC;

/*15. Resumen de ventas por oficina
Mostrar el código de oficina, descripción, ciudad y el importe total de los pedidos gestionados por
empleados de dicha oficina.
Tablas involucradas:
• oficina
• empleados
• pedidos
• Conceptos:
• INNER JOIN
• SUM()
• GROUP BY
• Consultas multitablas. pregunta 15
*/

SELECT 
    o.idoficina AS Codigo_Oficina,
    o.descripcion AS Descripcion_Oficina,
    o.ciudad AS Ciudad,
    SUM(p.importe) AS Importe_Total
FROM almacen.dbo.oficina o
INNER JOIN almacen.dbo.empleados e ON o.idoficina = e.idoficina
INNER JOIN almacen.dbo.pedidos p ON e.idempleado = p.idempleado
GROUP BY o.idoficina, o.descripcion, o.ciudad
ORDER BY Importe_Total DESC;

