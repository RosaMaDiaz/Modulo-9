DROP DATABASE IF EXISTS almacen ;
GO

CREATE DATABASE almacen ;
GO

USE almacen ;
GO

/* TABLA SUPERIOR */
CREATE TABLE superior (
idsuperior INT IDENTITY ( 1, 1) NOT NULL PRIMARY KEY ,
nombre VARCHAR ( 50 ) NOT NULL,
cuota DECIMAL ( 10 , 2) NOT NULL
);
GO

/* TABLA SUPERVISOR */
CREATE TABLE supervisor (
idsupervisor INT IDENTITY ( 1, 1) NOT NULL PRIMARY KEY ,
nombre VARCHAR ( 50 ) NOT NULL,
cuota DECIMAL ( 10 , 2) NOT NULL
);
GO

/* TABLA OFICINA */
CREATE TABLE oficina (
idoficina INT IDENTITY ( 1, 1) NOT NULL PRIMARY KEY ,
descripcion VARCHAR ( 50 ) NOT NULL,
ciudad VARCHAR ( 50 ) NOT NULL,
region VARCHAR ( 50 ) NOT NULL,
idsupervisor INT NULL,
objetivo DECIMAL ( 12 , 2) NULL,
CONSTRAINT rel_soficina
FOREIGN KEY ( idsupervisor )
REFERENCES supervisor ( idsupervisor )
);
GO

/* TABLA EMPLEADOS */
CREATE TABLE empleados (
idempleado INT IDENTITY ( 1, 1) NOT NULL PRIMARY KEY ,
idoficina INT NULL,
idsuperior INT NULL,
idjefe INT NULL,
nombre VARCHAR ( 50 ) NOT NULL,
email VARCHAR ( 150 ) NOT NULL UNIQUE ,
fechanac DATE ,
puesto VARCHAR ( 45 ),
contacto VARCHAR ( 12 ),

cuota DECIMAL ( 10 , 2) NULL,
ventas DECIMAL ( 10 , 2) NULL,
fechacontrato DATE ,
CONSTRAINT chk_empleado_cuota
CHECK ( cuota >= 0),

CONSTRAINT chk_empleado_ventas
CHECK ( ventas >= 0),

CONSTRAINT rel_eoficina
FOREIGN KEY ( idoficina )
REFERENCES oficina ( idoficina ),

CONSTRAINT rel_esuperior
FOREIGN KEY ( idsuperior )
REFERENCES superior ( idsuperior ),

CONSTRAINT rel_ejefe
FOREIGN KEY ( idjefe )
REFERENCES empleados ( idempleado )
);
GO

/* TABLA CLIENTE */
CREATE TABLE cliente (
	idcliente INT IDENTITY ( 1, 1) NOT NULL PRIMARY KEY ,
	idoficina INT NULL,
	nombre VARCHAR ( 50 ) NOT NULL,
	limite_credito DECIMAL ( 12 , 2) NULL,


CONSTRAINT rel_coficina
FOREIGN KEY ( idoficina )
REFERENCES oficina ( idoficina )
);

GO
/* TABLA SUPLIDOR */
CREATE TABLE suplidor (
	idsuplidor INT IDENTITY ( 1, 1) NOT NULL PRIMARY KEY ,
	nombre VARCHAR ( 100 ) NOT NULL,
	direccion VARCHAR ( 255 ),
	telefono VARCHAR ( 15 ),
	email VARCHAR ( 100 ),
	fechaRegistro DATE
);
GO

/* TABLA PRODUCTOS */
CREATE TABLE productos (
	idproducto INT IDENTITY (1,1) NOT NULL PRIMARY KEY ,
	idsuplidor INT NULL,
	descripcion VARCHAR ( 45 ) NOT NULL,
	preciocompra DECIMAL ( 10 , 2) NOT NULL,
	ganancia DECIMAL ( 5, 2) NOT NULL,
	preciov AS (
	preciocompra +
		( preciocompra * ganancia / 100 )
		),
	itb DECIMAL ( 5, 2),
	existencia DECIMAL ( 10 , 2),
	stock DECIMAL ( 10 , 2),

CONSTRAINT chk_producto_ganancia
CHECK ( ganancia >= 0),

CONSTRAINT rel_psuplidor
FOREIGN KEY ( idsuplidor )
REFERENCES suplidor ( idsuplidor )
);

GO

/* TABLA PEDIDOS */
CREATE TABLE pedidos (
nopedido INT IDENTITY ( 1, 1) NOT NULL PRIMARY KEY ,
fecha DATE NOT NULL,
idcliente INT NULL,
idempleado INT NULL,
importe DECIMAL ( 12 , 2) NULL,
condiciones VARCHAR ( 45 ),
CONSTRAINT rel_pcliente
FOREIGN KEY ( idcliente )
REFERENCES cliente ( idcliente ),
CONSTRAINT rel_pempleado
FOREIGN KEY ( idempleado )
REFERENCES empleados ( idempleado )
);
GO

/* TABLA DETALLE PEDIDO */
CREATE TABLE detpedido (
	nopedido INT NOT NULL,
	idproducto INT NOT NULL,
	descripcion VARCHAR ( 45 ),
	cantidad DECIMAL ( 10 , 2) NOT NULL,
	precio DECIMAL ( 10 , 2) NOT NULL,
	total AS ( cantidad * precio ) PERSISTED ,
	itbis AS (( cantidad * precio ) * 0.18 ) PERSISTED ,
	importe AS (
		(cantidad * precio) +
		(( cantidad * precio ) * 0.18 )
) PERSISTED ,

CONSTRAINT pk_detpedido
PRIMARY KEY ( nopedido , idproducto ),

CONSTRAINT rel_dpedido
FOREIGN KEY ( nopedido )
REFERENCES pedidos ( nopedido ),

CONSTRAINT rel_dproductos
FOREIGN KEY ( idproducto )
REFERENCES productos ( idproducto )
);
GO

/* ÍNDICES */
CREATE INDEX idx_cliente_oficina
ON cliente ( idoficina );
GO

CREATE INDEX idx_pedido_cliente
ON pedidos ( idcliente );
GO

CREATE INDEX idx_pedido_empleado
ON pedidos ( idempleado );
GO

CREATE INDEX idx_producto_suplidor
ON productos ( idsuplidor );
GO

CREATE INDEX idx_empleado_oficina
ON empleados ( idoficina );
GO

/*INSERTANDO REGISTROS*/
INSERT INTO supervisor ( nombre , cuota ) VALUES
( 'Juan Pérez' , 5000 ),
( 'María Gómez' , 7000 );

INSERT INTO superior ( nombre , cuota ) VALUES
( 'Carlos Sánchez' , 6000 ),
( 'Ana Martínez' , 7500 ),
( 'Luis Rodríguez' , 8000 ),
( 'Sofía Fernández' , 6500 );

INSERT INTO oficina ( descripcion , ciudad , region , idsupervisor , objetivo ) VALUES
( 'Oficina Central' , 'Santo Domingo' , 'Distrito Nacional' , 1, 100000.0 ),
( 'Oficina Norte' , 'Santiago' , 'Cibao' , 1, 80000.0 ),
( 'Oficina Este' , 'La Romana' , 'Este' , 2, 75000.0 ),
( 'Oficina Sur' , 'Barahona' , 'Sur' , 2, 70000.0 );

INSERT INTO empleados
(
idoficina ,idsuperior ,idjefe ,nombre ,email ,fechanac ,puesto ,contacto ,cuota ,ventas ,fechacontrato
)
VALUES
( 1, 1,NULL, 'Pedro López' , 'pedro@almacen.com' , '1985-05-10' , 'Gerente' , '809-123-4567' , 50000 , 45000 , '2023-01-15'),
( 1, 1, 1, 'Laura Méndez' , 'laura@almacen.com' , '1990-08-15' , 'Asistente' , '809-234-5678' , 30000 , 28000 , '2023-02-10'),
( 1, 2,NULL, 'José Ramírez' , 'jose@almacen.com' , '1982-11-20' , 'Gerente' , '809-345-6789' , 55000 , 50000 , '2022-08-01'),
( 1, 2, 3, 'Ana Torres' , 'ana@almacen.com' , '1988-02-25' , 'Asistente' , '809-456-7890' , 32000 , 30000 , '2023-03-05'),
( 2, 1,NULL, 'Miguel Díaz' , 'miguel@almacen.com' , '1979-07-30' , 'Gerente' , '809-567-8901' , 52000 , 48000 , '2021-05-20'),
( 2, 1, 5, 'Carmen Reyes' , 'carmen@almacen.com' , '1992-03-05' , 'Asistente' , '809-678-9012' , 31000 , 29000 , '2023-04-15'),
( 3, 2,NULL, 'Luis García' , 'luis@almacen.com' , '1983-12-10' , 'Gerente' , '809-789-0123' , 53000 , 49000 , '2022-02-01'),
( 3, 2, 7, 'Elena Cruz' , 'elena@almacen.com' , '1987-06-15' , 'Asistente' , '809-890-1234' , 33000 , 31000 , '2023-06-01'),
( 4, 1, 7, 'Raúl Fernández' , 'raul@almacen.com' , '1991-09-20' , 'Vendedor' , '809-901-2345' , 40000 , 38000 , '2023-08-10'),
( 4, 2, 7, 'Patricia Gómez' , 'patricia@almacen.com' , '1984-04-25' , 'Vendedor' , '809-012-3456' , 42000 , 40000 , '2023-09-01');

INSERT INTO cliente ( idoficina , nombre , limite_credito ) VALUES
( 1, 'Alejandro Torres' , 10000.0 ),
( 1, 'Beatriz López' , 15000.0 ),
( 1, 'Carlos Mendoza' , 20000.0 ),
( 1, 'Diana Fernández' , 25000.0 ),
( 2, 'Eduardo García' , 12000.0 ),
( 2, 'Fernanda Ruiz' , 18000.0 ),
( 2, 'Gabriel Martínez' , 22000.0 ),
( 2, 'Helena Castro' , 27000.0 ),
( 3, 'Ignacio Pérez' , 13000.0 ),
( 3, 'Julia Morales' , 19000.0 ),
( 3, 'Kevin Ramírez' , 23000.0 ),
( 3, 'Laura González' , 28000.0 ),
( 4, 'Manuel Ortiz' , 14000.0 ),
( 4, 'Natalia Herrera' , 20000.0 ),
( 4, 'Oscar Jiménez' , 24000.0 ),
( 4, 'Patricia Vega' , 29000.0 ),
( 1, 'Ricardo Díaz' , 16000.0 ),
( 2, 'Sofía Sánchez' , 21000.0 ),
( 3, 'Tomás Castillo' , 26000.0 ),
( 4, 'Valeria Ríos' , 30000.0 );

INSERT INTO suplidor
(
nombre,direccion,telefono,email,fechaRegistro
)
VALUES
( 'Jacinta Peña' , 'Calle 123, Santo Domingo' , '809-123-4567' , 'suplidorA@example.com' ,
'2024 - 01 - 15' ),
( 'Wilson Soto' , 'Avenida 456, Santiago' , '809-234-5678' , 'suplidorB@example.com' , '2024-02-20' ),
( 'Dioris Rojas' , 'Boulevard 789, La Romana' , '809-345-6789' , 'suplidorC@example.com' ,
'2024-03-25' ),
( 'Philips Made' , 'Calle 101, Barahona' , '809-456-7890' , 'suplidorD@example.com' , '2024-04-30' ),
( 'Alejandro Montaño' , 'Avenida 202, Punta Cana' , '809-567-8901' , 'suplidorE@example.com' ,
'2024-05-05' );

-- 1. Borra los registros actuales de la tabla productos
DELETE FROM productos;

-- 2. Reinicia el contador de identidad para que el próximo registro sea el 1
DBCC CHECKIDENT ('productos', RESEED, 0);

-- Segunda forma de Borra los registros actuales de la tabla productos

TRUNCATE TABLE productos;


INSERT INTO productos ( idsuplidor , descripcion , preciocompra , ganancia , itb , existencia ,
stock ) VALUES
( 1, 'Laptop Dell Inspiron' , 500.0 , 20.0 , 18.0 , 50 , 10 ),
( 1, 'Monitor Samsung 24"' , 150.0 , 25.0 , 18.0 , 30 , 5),
( 2, 'Teclado Mecánico Logitech' , 70.0 , 30.0 , 18.0 , 40 , 15 ),
( 2, 'Mouse Inalámbrico HP' , 25.0 , 35.0 , 18.0 , 60 , 20 ),
( 3, 'Impresora HP LaserJet' , 200.0 , 22.0 , 18.0 , 20 , 8),
( 3, 'Disco Duro Externo 1TB' , 80.0 , 28.0 , 18.0 , 25 , 10 ),
( 4, 'Memoria USB 64GB' , 15.0 , 40.0 , 18.0 , 100 , 50 ),
( 4, 'Router WiFi TP - Link' , 45.0 , 32.0 , 18.0 , 35 , 12 ),
( 5, 'Tarjeta Gráfica NVIDIA GTX 1660' , 300.0 , 18.0 , 18.0 , 10 , 3),
( 5, 'Fuente de Poder 600W' , 60.0 , 25.0 , 18.0 , 15 , 5),
( 1, 'Monitor LG 27"' , 200.0 , 20.0 , 18.0 , 25 , 7),
( 1, 'Laptop HP Pavilion' , 550.0 , 22.0 , 18.0 , 30 , 8),
( 2, 'Teclado Inalámbrico Microsoft' , 40.0 , 30.0 , 18.0 , 50 , 20 ),
( 2, 'Mouse Gaming Razer' , 60.0 , 35.0 , 18.0 , 45 , 15 ),
( 3, 'Impresora Canon Pixma' , 150.0 , 25.0 , 18.0 , 20 , 6),
( 3, 'Disco Duro SSD 512GB' , 100.0 , 28.0 , 18.0 , 30 , 10 ),
( 4, 'Memoria RAM 16GB' , 80.0 , 32.0 , 18.0 , 40 , 15 ),
( 4, 'Router WiFi ASUS' , 70.0 , 30.0 , 18.0 , 25 , 10 ),
( 5, 'Tarjeta Madre ASUS' , 150.0 , 20.0 , 18.0 , 15 , 5),
( 5, 'Fuente de Poder 750W' , 80.0 , 25.0 , 18.0 , 10 , 3);

-- Insertar pedidos para cada cliente
INSERT INTO pedidos ( fecha , idcliente , importe , idempleado , condiciones ) VALUES
( '2024-10-01' , 1, 500.0 , 1, 'Contado' ),
( '2024-10-02' , 1, 600.0 , 2, 'Crédito' ),
( '2024-10-01' , 2, 700.0 , 3, 'Contado' ),
( '2024-10-02' , 2, 800.0 , 4, 'Crédito' ),
( '2024-10-01' , 3, 900.0 , 5, 'Contado' ),
( '2024-10-02' , 3, 1000.0 , 6, 'Crédito' ),
( '2024-10-01' , 4, 500.0 , 1, 'Contado' ),
( '2024-10-02' , 4, 600.0 , 2, 'Crédito' ),
( '2024-10-01' , 2, 700.0 , 3, 'Contado' ),
( '2024-10-02' , 2, 800.0 , 4, 'Crédito' ),
( '2024-10-01' , 3, 900.0 , 5, 'Contado' ),
( '2024-10-01' , 3, 500.0 , 1, 'Contado' ),
( '2024-10-02' , 4, 600.0 , 2, 'Crédito' ),
( '2024-10-01' , 4, 700.0 , 3, 'Contado' ),
( '2024-10-02' , 5, 800.0 , 4, 'Crédito' ),
( '2024-10-01' , 5, 900.0 , 5, 'Contado' ),
( '2024-10-02' , 6, 1000.0 , 6, 'Crédito' ),
( '2024-10-01' , 6, 500.0 , 1, 'Contado' ),
( '2024-10-02' , 7, 600.0 , 2, 'Crédito' ),
( '2024-10-01' , 7, 700.0 , 3, 'Contado' ),
( '2024-10-02' , 8, 800.0 , 4, 'Crédito' ),
( '2024-10-01' , 8, 900.0 , 5, 'Contado' ),
( '2024-10-01' , 9, 700.0 , 3, 'Contado' ),
( '2024-10-02' , 9, 800.0 , 4, 'Crédito' ),
( '2024-10-01' , 10 , 900.0 , 5, 'Contado' ),
( '2024-10-02' , 10 , 1000.0 , 6, 'Crédito' );


-- Insertar detalles de pedidos para cada pedido
INSERT INTO detpedido ( nopedido , idproducto , descripcion , cantidad , precio ) VALUES
( 1, 1, 'Laptop Dell Inspiron' , 1, 500.0 ),
( 1, 2, 'Monitor Samsung 24"' , 2, 150.0 ),
( 1, 3, 'Teclado Mecánico Logitech' , 1, 70.0 ),
( 1, 4, 'Mouse Inalámbrico HP' , 3, 25.0 ),
( 2, 5, 'Impresora HP LaserJet' , 1, 200.0 ),
( 2, 6, 'Disco Duro Externo 1TB' , 2, 80.0 ),
( 2, 7, 'Memoria USB 64GB' , 4, 15.0 ),
( 2, 8, 'Router WiFi TP - Link' , 1, 45.0 ),
( 3, 8, 'Laptop Dell Inspiron' , 1, 500.0 ),
( 3, 9, 'Monitor Samsung 24"' , 2, 150.0 ),
( 3, 10 , 'Teclado Mecánico Logitech' , 1, 70.0 ),
( 3, 11 , 'Mouse Inalámbrico HP' , 3, 25.0 ),
( 4, 12 , 'Impresora HP LaserJet' , 1, 200.0 ),
( 4, 13 , 'Disco Duro Externo 1TB' , 2, 80.0 ),
( 4, 14 , 'Memoria USB 64GB' , 4, 15.0 ),
( 4, 15 , 'Router WiFi TP - Link' , 1, 45.0 ),
( 5, 1, 'Laptop Dell Inspiron' , 1, 500.0 ),
( 5, 2, 'Monitor Samsung 24"' , 2, 150.0 ),
( 5, 3, 'Teclado Mecánico Logitech' , 1, 70.0 ),
( 5, 4, 'Mouse Inalámbrico HP' , 3, 25.0 ),
( 6, 5, 'Impresora HP LaserJet' , 1, 200.0 ),
( 6, 6, 'Disco Duro Externo 1TB' , 2, 80.0 ),
( 6, 7, 'Memoria USB 64GB' , 4, 15.0 ),
( 6, 8, 'Router WiFi TP - Link' , 1, 45.0 ),
( 7, 8, 'Laptop Dell Inspiron' , 1, 500.0 ),
( 7, 9, 'Monitor Samsung 24"' , 2, 150.0 ),
( 7, 10 , 'Teclado Mecánico Logitech' , 1, 70.0 ),
( 7, 11 , 'Mouse Inalámbrico HP' , 3, 25.0 ),
( 8, 12 , 'Impresora HP LaserJet' , 1, 200.0 ),
( 8, 13 , 'Disco Duro Externo 1TB' , 2, 80.0 ),
( 8, 14 , 'Memoria USB 64GB' , 4, 15.0 ),
( 8, 15 , 'Router WiFi TP - Link' , 1, 45.0 ),
( 9, 17 , 'Memoria RAM 16GB' , 2, 80.0 ),
( 9, 18 , 'Router WiFi ASUS' , 1, 70.0 ),
( 9, 19 , 'Tarjeta Madre ASUS' , 1, 150.0 ),
( 9, 20 , 'Fuente de Poder 750W' , 1, 80.0 );


