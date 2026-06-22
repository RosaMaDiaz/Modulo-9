CREATE DATABASE SCRUM
GO


USE SCRUM
GO


CREATE TABLE roles (
id_rol int IDENTITY ( 1, 1),
rol varchar ( 20 ) not null,
CONSTRAINT PK_roles PRIMARY KEY ( id_rol )
)
GO


INSERT INTO roles VALUES ( 'ScrumMaster' )
INSERT INTO roles VALUES ( 'ProductOwner' )
INSERT INTO roles VALUES ( 'Team' )
INSERT INTO roles VALUES ( 'Stakeholders' )
GO


CREATE TABLE ciudad (
id_ciudad INT IDENTITY ( 1, 1),
ciudad VARCHAR ( 50 ) NOT NULL,
CONSTRAINT PK_ciudad PRIMARY KEY ( id_ciudad )
)
GO


INSERT INTO ciudad VALUES ( 'Santo Domingo Este' )
INSERT INTO ciudad VALUES ( 'Santiago de los Caballeros' )
INSERT INTO ciudad VALUES ( 'La Romana' )
INSERT INTO ciudad VALUES ( 'San Pedro de Macoris' )
INSERT INTO ciudad VALUES ( 'Puerto Plata' )
INSERT INTO ciudad VALUES ( 'San Cristobal' )
INSERT INTO ciudad VALUES ( 'La Vega' )
INSERT INTO ciudad VALUES ( 'Bonao' )
INSERT INTO ciudad VALUES ( 'Higuey' )
INSERT INTO ciudad VALUES ( 'Moca' )
GO


CREATE TABLE personass (
id_personas int IDENTITY ( 1, 1),
apellido varchar ( 40 ) not null,
nombre varchar ( 40 ) not null,
sueldo smallmoney ,
direccion varchar ( 100 ),
celular varchar ( 14 ),
sexo varchar ( 1),
nacimiento date ,
id_rol int not null,
id_ciudad int not null,
CONSTRAINT PK_personas PRIMARY KEY (id_personas),
CONSTRAINT FK_rol FOREIGN KEY (id_rol)
REFERENCES roles (id_rol),
CONSTRAINT FK2_ciudad FOREIGN KEY (id_ciudad )
REFERENCES ciudad (id_ciudad)
)
GO


INSERT INTO personass VALUES ( 'Romero Peña' , 'Sandra Y' , 1200 , 'Calle E No. 1542, Santo Domingo Este' , '1-829-120-1234', 'F' , '1972/3/3' , 3, 1)
INSERT INTO personass VALUES ( 'Arevalo' , 'Maria Johana' , 950 , 'Calle A No. 152, Santiago de los Caballeros' , '1-809-234-5678', 'F' , '1976/2/16' , 3, 3)
INSERT INTO personass VALUES ( 'Hernandez Mancia' , 'Marielos' , 958 , 'Calle B No. 172, La Romana' , '1-849-345-6789', 'F' , '1986/7/4' , 3, 4)
INSERT INTO personass VALUES ( 'Perez Juarez' , 'Joaquin' , 850 , 'Calle C No. 1288, San Pedro de Macoris' , '1-829-456-7890' , 'M' , '1969/9/2' , 3, 1)
INSERT INTO personass VALUES ( 'Solis Castro' , 'Eduardo' , 600 , 'Calle D No. 128, Puerto Plata' , '1-809-567-8901' , 'M' , '1972/3/11' , 3, 1)
INSERT INTO personass VALUES ( 'Ramos Nieto' , 'Jorge' , 550 , 'Calle F No. 192, San Cristobal' , '1-849-678-9012' , 'M' , '1972/10/4' , 4, 1)
INSERT INTO personass VALUES ( 'Hernandez Carias' , 'Johanna' , 1800 , 'Calle G No. 182, La Vega' , '1-829-789-0123' , 'F' , '1952/3/4' , 1, 1)
INSERT INTO personass VALUES ( 'Romero Peña' , 'Manuel Alberto' , 0, 'Calle I No. 122, Bonao' , '1-809-890-1234' , 'M' , '1969/12/4' , 2, 1)
INSERT INTO personass VALUES ( 'Garcia Alvarado' , 'Roxana' , 1600 , 'Calle J No. 14, Higuey' , '1-849-901-2345' , 'F' , '1970/4/4' , 1, 1)
INSERT INTO personass VALUES ( 'Torres Castro' , 'Alfredo' , 450 , 'Calle K No. 13, Moca' , '1-829-112-3456' , 'M' , '1980/2/9' , 3, 5)
GO