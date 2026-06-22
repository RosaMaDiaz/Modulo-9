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


/*10. Lo mismo que la anterior, pero queremos que aparezca también la ciudad de las oficinas (tanto del
empleado como de su jefe).*/


/*11. Total de pedidos por cliente
Listar cada cliente mostrando su código, nombre y la cantidad de pedidos realizados. Ordenar el
resultado de mayor a menor cantidad de pedidos*/


/*12. Importe total vendido por empleado
Mostrar el código y nombre de cada empleado junto con el importe total de los pedidos gestionados
por dicho empleado.*/


/*13. Cantidad de productos vendidos
Mostrar cada producto indicando su código, descripción y la cantidad total vendida en todos los
pedidos.*/


/*14. Clientes con mayor límite de crédito
Listar los clientes cuyo límite de crédito sea superior al promedio de crédito de todos los clientes.*/


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
• Consultas multitablas
*/
