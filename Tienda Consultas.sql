/*CONSULTAS TIENDA*/
/*1. Lista el nombre de todos los productos de la tabla producto*/
USE tienda ;

SELECT nombre FROM producto;

/*2. Lista los nombres y los precios de todos los productos*/
SELECT nombre, precio FROM	producto;

/*3. Lista todas las informaciones de los productos.*/
SELECT * FROM producto;

/*4. Lista el código de los fabricantes que tienen productos registrados.*/
SELECT  codigo_fabricante
FROM producto; 

/*5. Lista el código de los fabricantes que tienen productos registrados, sin duplicados.*/
SELECT DISTINCT codigo_fabricante
FROM producto; 

/*6. Lista los nombres de los fabricantes ordenados ascendentemente.*/
SELECT nombre FROM producto ORDER BY nombre ASC;

/*7. Lista los 5 primeros registros de la tabla fabricante.*/
SELECT TOP 5 *
FROM fabricante;

/*8. Lista el nombre y el precio del producto más barato (ORDER BY y TOP).*/
SELECT TOP 1 nombre, precio FROM producto ORDER BY precio DESC;

/*9. Lista el nombre y el precio de todos los productos del fabricante con código 2*/
SELECT nombre, precio FROM producto WHERE codigo = 2;

/*10. Lista el nombre y el precio de los productos con precio menor o igual a 120.*/
SELECT nombre, precio FROM producto WHERE codigo <=120;

/*11. Lista el nombre y el precio de los productos con precio entre 60 y 200.*/
SELECT nombre, precio FROM producto WHERE precio >=60 AND precio <=200;

/*12. Lista todos los productos cuyos códigos de fabricante sean 1, 3 o 5.*/
SELECT * FROM producto WHERE codigo = 1 OR codigo = 3 OR codigo = 5;

/*13. Lista los nombres de los fabricantes que empiecen por la letra S.*/
SELECT nombre FROM fabricante WHERE nombre LIKE 'S%';

/*14. Mostrar los cinco productos con el precio más alto registrados en la tienda*/
SELECT TOP 5 WITH TIES *
FROM producto
ORDER BY precio DESC;
