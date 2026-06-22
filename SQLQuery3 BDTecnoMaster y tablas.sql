CREATE DATABASE TecnoMarket

USE TecnoMarket

CREATE TABLE Clientes (
	id_cliente int	primary key NOT NULL,
	nombre varchar (50) NOT NULL,
	apellido varchar (50) NOT NULL,
	telefono varchar (20) NOT NULL,
	correo varchar (100) NOT NULL,
	fecha_registro date NOT NULL,
	activo bit NOT NULL
);
go

CREATE TABLE Productos (
	id_producto int primary key  NOT NULL,
	nombre_producto varchar (100)  NOT NULL,
	categoria varchar (50) NOT NULL,
	precio decimal (10,2) NOT NULL,
	existencia	int NOT NULL,
	fecha_ingreso date  NOT NULL
);
go

INSERT INTO Clientes (id_cliente, nombre, apellido, telefono, correo, fecha_registro, activo) 
VALUES
(1, 'Rosa', 'Díaz', '809-123-3344', 'rosa.diaz@correo.com', '2025-09-10', 1),
(2, 'Javier', 'Santana', '829-344-5676', 'javier.santana@correo.com', '2025-11-11', 0),
(3, 'Oscar', 'Ruiz', '849-311-3876', 'oscar.ruiz@correo.com', '2025-01-03', 1),
(4, 'Ana', 'Cespedes', '809-987-3321', 'anacespedes87@correo.com', '2025-09-01', 0),
(5, 'María', 'Abreu', '829-421-11-55', 'mariaabreuM@correo.com', '2025-07-12', 1);
go

INSERT INTO Productos (id_producto, nombre_producto, categoria, precio, existencia, fecha_ingreso)
VALUES
(1, 'Mouse', 'Electronico', 200.50, 70, '2026-02-02'),
(2, 'Teclado', 'Electronico', 1000.95, 50, '2026-03-02'),
(3, 'Bocinas Inalambrica', 'Electronico', 1500.50, 100, '2026-03-04'),
(4, 'Portatiles', 'Electronico', 36500.00, 90, '2026-04-05'),
(5, 'Computadora Desktop', 'Electronico', 20000.50, 55, '2026-02-05');
go

-- 1. Agregar una nueva columna
ALTER TABLE Clientes 
ADD cedula varchar(20);
go

--2. Modificar una columna -  el tamaño del campo telefono
ALTER TABLE Clientes 
ALTER COLUMN telefono VARCHAR(30);
go

-- 3. Cambiar nombre de una tabla usando sp_rename
EXEC sp_rename 'Productos', 'Inventario';
go

--4. Agregar una tabla temporal y Eliminar la tabla
CREATE TABLE Temporal (
id_temporal int primary key,
nombre_temporal varchar(50)
);
go

--Eliminando
DROP TABLE Temporal;
GO

-- 5. VERIFICACION
select * from Clientes;

select * from Inventario;


-- nueva columna agregada
select cedula from Clientes;


--Mostrando el campo telefono con su nuevo tamaño
select telefono from Clientes;

