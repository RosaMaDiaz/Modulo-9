DROP DATABASE IF EXISTS GestionComercial
GO
CREATE DATABASE GestionComercial
GO

USE GestionComercial
GO

/* TABLA CIUDAD
========================== */
CREATE TABLE ciudad (
id_ciudad INT IDENTITY ( 1, 1),
ciudad VARCHAR ( 50 ) NOT NULL,
CONSTRAINT PK_ciudad
PRIMARY KEY ( id_ciudad )
)
GO

/* TABLA SUCURSAL
========================== */
CREATE TABLE sucursal (
id_sucursal INT IDENTITY ( 1, 1),
sucursal VARCHAR ( 50 ) NOT NULL,
id_ciudad INT NOT NULL,
CONSTRAINT PK_sucursal
PRIMARY KEY ( id_sucursal ),
CONSTRAINT FK_sucursal_ciudad
FOREIGN KEY ( id_ciudad )
REFERENCES ciudad ( id_ciudad )
)
GO

/* TABLA VENDEDOR
========================== */
CREATE TABLE vendedor (
id_vendedor INT IDENTITY ( 1, 1),
nombre VARCHAR ( 60 ) NOT NULL,
telefono VARCHAR ( 14 ),
correo VARCHAR ( 80 ),
id_sucursal INT NOT NULL,
CONSTRAINT PK_vendedor
PRIMARY KEY ( id_vendedor ),
CONSTRAINT FK_vendedor_sucursal
FOREIGN KEY ( id_sucursal )
REFERENCES sucursal ( id_sucursal )
)
GO

/* TABLA CLIENTE
========================== */
CREATE TABLE cliente (
id_cliente INT IDENTITY ( 1, 1),
nombre VARCHAR ( 60 ) NOT NULL,
telefono VARCHAR ( 14 ),
correo VARCHAR ( 80 ),
direccion VARCHAR ( 100 ),
id_ciudad INT NOT NULL,
CONSTRAINT PK_cliente
PRIMARY KEY ( id_cliente ),
CONSTRAINT FK_cliente_ciudad
FOREIGN KEY ( id_ciudad )
REFERENCES ciudad ( id_ciudad )
)
GO

/* TABLA VENTA
========================== */
CREATE TABLE venta (
id_venta INT IDENTITY ( 1, 1),
fecha_venta DATE NOT NULL,
monto SMALLMONEY NOT NULL,
id_cliente INT NOT NULL,
id_vendedor INT NOT NULL,
CONSTRAINT PK_venta
PRIMARY KEY ( id_venta ),
CONSTRAINT FK_venta_cliente
FOREIGN KEY ( id_cliente )
REFERENCES cliente ( id_cliente ),
CONSTRAINT FK_venta_vendedor
FOREIGN KEY ( id_vendedor )
REFERENCES vendedor ( id_vendedor )
)
GO

INSERT INTO ciudad ( ciudad )
VALUES
( 'Santo Domingo' ),
( 'Santiago' ),
( 'La Vega' ),
( 'San Cristobal' ),
( 'Puerto Plata' )
GO

INSERT INTO sucursal ( sucursal , id_ciudad )
VALUES
( 'Sucursal Central' , 1),
( 'Sucursal Norte' , 2),
( 'Sucursal Cibao' , 3),
( 'Sucursal Sur' , 4),
( 'Sucursal Atlantica' , 5)
GO

INSERT INTO vendedor
( nombre , telefono , correo , id_sucursal )
VALUES
( 'Carlos Martinez' , '1-809-555-1001' , 'carlos@empresa.com' , 1),
( 'Ana Rodriguez' , '1-829-555-1002' , 'ana@empresa.com' , 1),
( 'Luis Gomez' , '1-849-555-1003' , 'luis@empresa.com' , 2),
( 'Maria Perez' , '1-809-555-1004' , 'maria@empresa.com' , 2),
( 'Jose Ramirez' , '1-829-555-1005' , 'jose@empresa.com' , 3),
( 'Laura Santana' , '1-849-555-1006' , 'laura@empresa.com' , 3),
( 'Pedro Cruz' , '1-809-555-1007' , 'pedro@empresa.com' , 4),
( 'Carmen Diaz' , '1-829-555-1008' , 'carmen@empresa.com' , 4),
( 'Miguel Torres' , '1-849-555-1009' , 'miguel@empresa.com' , 5),
( 'Rosa Jimenez' , '1-809-555-1010' , 'rosa@empresa.com' , 5)
GO

INSERT INTO cliente
( nombre , telefono , correo , direccion , id_ciudad )
VALUES
( 'Juan Perez' , '1-809-111-1111' , 'juan@gmail.com' , 'Los Alcarrizos' , 1),
( 'Maria Lopez' , '1-829-111-1112' , 'maria@gmail.com' , 'Villa Mella' , 1),
( 'Pedro Sanchez' , '1-849-111-1113' , 'pedro@gmail.com' , 'Santiago Centro' , 2),
( 'Ana Garcia' , '1-809-111-1114' , 'ana@gmail.com' , 'Tamboril' , 2),
( 'Carlos Reyes' , '1-829-111-1115' , 'carlos@gmail.com' , 'La Vega' , 3),
( 'Luisa Martinez' , '1-849-111-1116' , 'luisa@gmail.com' , 'Jarabacoa' , 3),
( 'Miguel Cruz' , '1-809-111-1117' , 'miguel@gmail.com' , 'San Cristobal' , 4),
( 'Rosa Fernandez' , '1-829-111-1118' , 'rosa@gmail.com' , 'Bajos de Haina' , 4),
( 'Jose Diaz' , '1-849-111-1119' , 'jose@gmail.com' , 'Puerto Plata' , 5),
( 'Laura Castillo' , '1-809-111-1120' , 'laura@gmail.com' , 'Sosua' , 5)
GO

INSERT INTO venta
( fecha_venta, monto, id_cliente, id_vendedor )
VALUES
( '2026-01-10' , 1200 , 11, 21),
( '2026-01-12' , 850 , 12, 22),
( '2026-01-15' , 650 , 13, 23),
( '2026-01-18' , 900 , 14, 24),
( '2026-01-20' , 1500 , 15, 25),
( '2026-01-21' , 750 , 16, 26),
( '2026-01-22' , 600 , 17, 27),
( '2026-01-23' , 950 , 18, 28),
( '2026-01-24' , 1800 , 19, 9),
( '2026-01-25' , 1300 , 20 , 10 ),
( '2026-02-01' , 500 , 11, 11),
( '2026-02-02' , 700 , 12, 12),
( '2026-02-03' , 1200 , 23, 13),
( '2026-02-04' , 400 , 24, 14),
( '2026-02- 05' , 950 , 25, 15)
GO

/*Ejemplo 1. Registros sin correo electrónico*/
SELECT nombre, telefono, correo 
FROM vendedor 
WHERE correo IS NULL;

/*Ejemplo 2. Registros con correo electrónico registrado*/
SELECT nombre , telefono , correo
FROM vendedor
WHERE correo IS NOT NULL;


/*Ejemplo 1. Vendedores sin correo
electrónico pertenecientes a una
sucursal específica*/
SELECT nombre ,
telefono ,
correo ,
id_sucursal
FROM vendedor
WHERE correo IS NULL
AND id_sucursal = 2;


/*Ejemplo 2. Clientes sin correo o sin teléfono registrado*/
SELECT nombre ,
telefono ,
correo
FROM cliente
WHERE correo IS NULL
OR telefono IS NULL;


/*Ejemplo 3. Vendedores con correo registrado y asignados a una sucursal*/
SELECT nombre ,
correo ,
id_sucursal
FROM vendedor
WHERE correo IS NOT NULL
AND id_sucursal = 1;

/*Cláusula ORDER BY  -  Orden Ascendente (ASC)*/
SELECT nombre
FROM vendedor
ORDER BY nombre ASC;


/*Orden Descendente (DESC)*/
SELECT nombre , id_sucursal
FROM vendedor
ORDER BY nombre DESC


/*Ejemplo 2. Mostrar las ciudades donde existen clientes registrados*/

SELECT DISTINCT id_ciudad
FROM cliente ;

/*DISTINCT sobre Múltiples Columnas*/
SELECT DISTINCT nombre , id_sucursal
FROM vendedor;

/*Cláusula TOP  -  Ejemplo 1. Mostrar los primeros 5 vendedores*/
SELECT TOP 5 *
FROM vendedor ;

/*TOP y ORDER BY  -  Ejemplo 2. Mostrar las 3 ventas más altas.*/
SELECT TOP 3 *
FROM venta
ORDER BY monto DESC ;


/*TOP WITH TIES - Ejemplo 3. Mostrar los 5 vendedores con mayores ventas*/
SELECT TOP 5 WITH TIES *
FROM venta
ORDER BY monto DESC ;

/*Ejemplo: Resumen General de la Empresa*/
SELECT 
    (SELECT COUNT(*) FROM ciudad) AS Total_Ciudades,
    (SELECT COUNT(*) FROM sucursal) AS Total_Sucursales,
    (SELECT COUNT(*) FROM cliente) AS Total_Clientes,
    (SELECT COUNT(*) FROM vendedor) AS Total_Vendedores,
    (SELECT COUNT(*) FROM venta) AS Total_Ventas,
    (SELECT SUM(monto) FROM venta) AS Total_Vendido,
    (SELECT AVG(monto) FROM venta) AS Promedio_Ventas,
    (SELECT MAX(monto) FROM venta) AS Venta_Mayor,
    (SELECT MIN(monto) FROM venta) AS Venta_Menor;


/*Funciones de Texto en SQL Server*/
/*Función UPPER()*/
SELECT UPPER(nombre) AS Nombre_Mayúscula
FROM vendedor;


/*Función LOWER()*/
SELECT UPPER(nombre) AS 'Nombre en Mayúscula',
LOWER(correo) AS Correo
FROM vendedor;

/*Función LEN()*/
SELECT nombre,
    LEN(nombre) AS Cantidad_Caracteres
FROM vendedor;

/*Función SUBSTRING()*/
/*Extraer los tres primeros caracteres del nombre del vendedor*/
SELECT nombre,
    SUBSTRING(nombre,1,3) AS Iniciales
FROM vendedor;

/*Ejemplo 2. Extraer los primeros cinco caracteres del correo electrónico*/
SELECT correo,
    SUBSTRING(correo,1,5) AS Fragmento
FROM vendedor;

/*Combinando Funciones de Texto*/
SELECT 
    UPPER(nombre) AS Nombre_Mayuscula,
    LEN(nombre) AS Cantidad_Caracteres,
    SUBSTRING(nombre,1,3) AS Iniciales
FROM vendedor;


/*Funciones de Fecha en SQL Server - Ejemplo Integrado*/
SELECT
    GETDATE() as FechaAcutal,
    YEAR(GETDATE()) AS año,
    MONTH(GETDATE()) AS mes,
    DAY(GETDATE()) AS DIA;


