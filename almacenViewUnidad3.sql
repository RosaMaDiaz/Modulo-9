USE almacen;
GO

/*Unidad 3. Vistas (Views) – SIN VISTA*/
SELECT C.nombre,
	P.importe
FROM cliente C
INNER JOIN pedidos P
	ON C.idcliente = P.idcliente;

	/*Ejemplo 1: Vista de Cliente CON VISTA*/
CREATE VIEW vw_PedidosClientes
AS
SELECT idcliente, nombre, limite_credito
FROM dbo.Cliente;
GO
	
	
SELECT * FROM vw_PedidosClientes;


/*Ejemplo 2: Vista de Pedidos con Clientes*/
CREATE VIEW vw_PedidosClientes2
AS
select P.nopedido,
		P.fecha,
		C.nombre,
		P.importe
from pedidos P
INNER JOIN cliente C
	ON P.idcliente = C.idcliente
GO

select * from vw_PedidosClientes2
GO


/*Ejemplo 3: Vista de Ventas por Empleado*/
CREATE VIEW vw_VentasEmpleado
AS
SELECT E.idempleado,
		E.nombre,
		SUM(P.importe) AS TotalVentas
FROM empleados E
INNER JOIN pedidos P
	ON E.idempleado = P.idempleado
GROUP BY E.idempleado, E.nombre;
GO

SELECT * FROM vw_VentasEmpleado;

/*filtrar informacion*/
SELECT * FROM vw_PedidosClientes2
WHERE importe > 800;

/*ordenar resultados*/
SELECT *
FROM vw_PedidosClientes2
ORDER BY importe DESC;

/*utilizar funciones de agregacion*/
SELECT avg(TotalVentas)
FROM vw_VentasEmpleado;

/*Consultar vistas dentro de otras consultas*/
SELECT *
FROM vw_VentasEmpleado
WHERE TotalVentas >
(
	select AVG(TotalVentas)
		from vw_VentasEmpleado
);


/*Modificación y Eliminación de Vistas. Modificar una Vista con alter view*/
CREATE OR ALTER VIEW vw_Clientes
AS
SELECT idcliente,
	nombre,
	limite_credito,
	idoficina
FROM cliente;
GO

SELECT * FROM vw_Clientes
GO

/*Casos de Uso de las Vistas - Caso 1: Reporte de Clientes*/
CREATE VIEW vw_ReporteClientes
AS
SELECT nombre,
	limite_credito
FROM cliente;
GO

SELECT * FROM vw_ReporteClientes


/*Caso 2: Ventas por Oficina*/

CREATE VIEW vw_VentasOficina
AS
SELECT O.descripcion,
	SUM(P.importe) AS TotalVEntas
FROM oficina O
INNER JOIN empleados E
	ON O.idoficina = e.idoficina
INNER JOIN pedidos P
	ON E.idempleado = P.idempleado
GROUP BY O.descripcion;
GO

SELECT * FROM vw_VentasOficina
GO


/*Caso 3: Productos con Bajo Inventario*/
CREATE VIEW vw_ProductosBajoStock
AS
SELECT idproducto,
		descripcion,
		existencia,
		stock
FROM productos
WHERE existencia <= stock;
GO

SELECT * FROM vw_ProductosBajoStock;

/*Caso 4: Clientes con Compras Importantes*/
CREATE VIEW vw_MejoresClientes
AS
SELECT C.nombre,
	SUM(P.importe) AS TotalComprado
FROM cliente C
INNER JOIN pedidos P
	ON C.idcliente = P.idcliente
GROUP BY C.nombre
GO

SELECT * FROM vw_MejoresClientes
WHERE TotalComprado > 2000;
GO