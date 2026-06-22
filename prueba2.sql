DROP database if EXISTS prueba2
CREATE DATABASE prueba2
GO

USE prueba2
GO

CREATE TABLE vtaxciudad(
nom_ciudad varchar(25),
tot_ventas smallmoney)

INSERT INTO vtaxciudad (nom_ciudad, tot_ventas)
VALUES
('Santo Domingo', 3456.99),
('Santiago', 12456.23),
('La Vega', 6356.99),
('San Francisco de Macorix', 956.00),
('Nagua', 13756.45);

CREATE TABLE vtaxvendedor(
vendedor varchar(25),
tot_ventas smallmoney,
sucursal int
)
GO

INSERT INTO vtaxvendedor (vendedor, tot_ventas, sucursal)
VALUES
('Efrain Burgos', 345.56, 1),
('Carlos Olmos', 2345.00, 1),
('Efrain Burgos', 509.87, 2),
('Karla Alas', 3123.05, 3),
('Carlos Olmos', 323.76, 3),
('Efrain Burgos', 800.00, 2),
('Carlos Olmos', 654.43, 2),
('Karla Alas', 123.34, 4),
('Carlos Olmos', 450.34, 5);

/*Consultas*/
/*Ejemplo 1. Ciudades con ventas entre 1,000 y 10,000*/
SELECT nom_ciudad , tot_ventas
FROM vtaxciudad
WHERE tot_ventas BETWEEN 1000 AND 10000 ;

/*Ejemplo 2. Ciudades con ventas entre RD$500 y RD$2,000*/
SELECT vendedor AS Vendedor , tot_ventas AS Ventas
FROM vtaxvendedor
WHERE tot_ventas BETWEEN 500 AND 2000


/*Ejemplo Combinado*/
SELECT nom_ciudad ,
tot_ventas
FROM vtaxciudad
WHERE tot_ventas BETWEEN 1000 AND 15000
ORDER BY tot_ventas DESC ;

/*Clausula IN*/
SELECT vendedor , tot_ventas , sucursal
FROM vtaxvendedor
WHERE sucursal IN ( 1, 3, 5);


/*Clausula IN con texto*/
SELECT vendedor , tot_ventas , sucursal
FROM vtaxvendedor
WHERE vendedor IN ('Carlos Olmos', 'Karla Alas');

/*Cláusula LIKE*/
SELECT vendedor , tot_ventas
FROM vtaxvendedor
WHERE vendedor LIKE 'C%';

/*Buscar registros que comiencen con una secuencia de caracteres*/
SELECT vendedor , tot_ventas
FROM vtaxvendedor
WHERE vendedor LIKE '%Alas' ;

/*Buscar registros que contengan una palabra o conjunto de caracteres*/
SELECT vendedor , tot_ventas
FROM vtaxvendedor
WHERE vendedor LIKE '%Burgos%' ;

/*Utilizando el comodín _ (guion bajo)*/
SELECT vendedor
FROM vtaxvendedor
WHERE vendedor LIKE 'Karla Ala_' ;


/*Combinando LIKE con otras cláusulas*/
SELECT vendedor ,
tot_ventas
FROM vtaxvendedor
WHERE vendedor LIKE '%Carlos%'
ORDER BY tot_ventas DESC ;





