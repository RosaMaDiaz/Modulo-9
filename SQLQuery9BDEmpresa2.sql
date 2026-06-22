CREATE DATABASE Empresa2;
GO

USE Empresa2;
GO

--TABLA UBICACION
CREATE TABLE Ubicacion (
	idubicacion INT IDENTITY (1,1),
	descripcion VARCHAR(45),
	CONSTRAINT pd_ubicacion PRIMARY KEY(idubicacion)
);
GO

--TABLA PAGO
CREATE TABLE pago (
	idpago INT IDENTITY (1,1),
	descripcion VARCHAR(45),
	CONSTRAINT pk_pago PRIMARY KEY(idpago)
);
GO

--TABLA PROVEEDOR
CREATE TABLE proveedor (
	idproveedor INT IDENTITY(1,1),
	nombre VARCHAR(45),
	idubicacion INT,
	idpago INT,
	CONSTRAINT pk_proveedor PRIMARY KEY(idproveedor),
	CONSTRAINT fk_proveedor_ubicacion FOREIGN KEY(idubicacion)
		REFERENCES ubicacion(idubicacion),
	CONSTRAINT fk_proveedor_pago FOREIGN KEY(idpago)
		REFERENCES pago(idpago)
);
go