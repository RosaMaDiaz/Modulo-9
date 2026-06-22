DROP DATABASE IF EXISTS tienda ;
CREATE DATABASE tienda ;

USE tienda ;

CREATE TABLE fabricante (
codigo INT IDENTITY ( 1, 1) PRIMARY KEY ,
nombre VARCHAR ( 100 ) NOT NULL);

CREATE TABLE producto (
codigo INT IDENTITY ( 1, 1) PRIMARY KEY ,
nombre VARCHAR ( 45 ) NOT NULL,
precio FLOAT NOT NULL,
codigo_fabricante INT NOT NULL,
CONSTRAINT rel_fab FOREIGN KEY ( codigo_fabricante ) REFERENCES fabricante ( codigo )
);

INSERT INTO fabricante VALUES
( 'Asus' ),
( 'Lenovo' ),
( 'Hewlett - Packard' ),
( 'Samsung' ),
( 'Seagate' ),
( 'Crucial' ),
( 'Gigabyte' ),
( 'Huawei' ),
( 'Xiaomi' );

INSERT INTO producto VALUES
( 'Disco Duro SATA 1TB' , 89.99 , 5),
( 'Memoria Ram DDR4 8GB' , 120 , 6),
( 'Disco SSD 1 TB' , 150.99 , 4),
( 'GeForce GTX 1050Ti' , 185 , 7),
( 'GeForce GTX 1080 Xtreme' , 755 , 6),
( 'Monitor 24 LED Full HD' , 202 , 1),
( 'Monitor 27 LED Full HD' , 245.99 , 1),
( 'Portatil Yoga 520' , 559 , 2),
( 'Portatil Ideapd 320' , 444 , 2),
( 'Impresora HP Deskjet 3720' , 59.99 , 3),
( 'Impresora HP Laserjet Pro M26nw' , 180 , 3);