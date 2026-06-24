USE almacen;
GO

/*Unidad 4. Procedimientos Almacenados
Creación de Procedimientos Almacenados - Ejemplo 1: Mostrar todos los clientes*/

CREATE PROCEDURE sp_ListarClientes
AS
BEGIN
	SELECT *
	FROM cliente;
END
GO
--Para su Ejecucion
EXEC sp_ListarClientes
GO

/*Ejemplo 2: Mostrar productos existentes*/
CREATE PROCEDURE sp_ListarProductos
AS
BEGIN
	SELECT
		idproducto,
		descripcion,
		existencia,
		stock
	FROM productos;
END
GO

EXEC sp_ListarProductos;
GO

/*Parámetros de Entrada
Ejemplo 1: Buscar cliente por código*/
CREATE PROCEDURE sp_BuscarCliente
	@IdCliente	INT
AS
BEGIN
	SELECT *
	FROM cliente
	WHERE idcliente = @IdCliente;
END
GO

EXEC sp_BuscarCliente 5;
GO

/*Ejemplo 2: Consultar pedidos de un cliente*/
CREATE PROCEDURE sp_PedidosCliente
	@IdCliente	INT
AS
BEGIN
	SELECT 
		nopedido,
		fecha,
		importe
	FROM pedidos
	WHERE idcliente = @IdCliente;
END
GO

EXEC sp_PedidosCliente 3;
GO

/*Múltiples Parámetros*/
CREATE PROCEDURE sp_ProductosPorExistencia
	@Minimo FLOAT,
	@Maximo FLOAT
AS
BEGIN
	SELECT *
	FROM productos
	WHERE existencia BETWEEN @Minimo AND @Maximo
END
GO

EXEC sp_ProductosPorExistencia 20,50;
GO

/*Parámetros de Salida - Ejemplo: Cantidad de Clientes*/
CREATE PROCEDURE sp_TotalCliente
	@Total INT OUTPUT
AS
BEGINx
	SELECT
		@Total = COUNT (*)
	FROM cliente;
END
GO

DECLARE @Cantidad INT;

EXEC sp_TotalCliente
	@Cantidad OUTPUT;

SELECT @Cantidad AS TotalCliente;


/*Ejemplo: Total de Pedidos*/
CREATE PROCEDURE sp_TotalPedidos
	@CantidadPedidos INT OUTPUT
AS
BEGIN
	SELECT
		@CantidadPedidos = COUNT(*)
	FROM pedidos;
END
GO

DECLARE @Total INT;
EXEC sp_TotalPedidos
	@Total OUTPUT;

SELECT @Total AS TotalPedidos;
go

/*Modificación de Procedimientos*/
CREATE OR ALTER PROCEDURE sp_ListarEmpleados
AS
BEGIN
	SELECT
		idempleado,
		nombre,
		puesto,
		ventas
	FROM empleados;
END
GO

EXEC sp_ListarEmpleados;

/*Eliminar un Procedimiento*/
DROP PROCEDURE sp_ListarEmpleados;
GO
