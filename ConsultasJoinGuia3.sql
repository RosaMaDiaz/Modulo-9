/*GUIA 3 MODULO 9*/

USE SCRUM
GO

SELECT personass.nombre, personass.apellido, personass.nombre, ciudad.ciudad
from personass INNER JOIN ciudad ON personass.id_ciudad = ciudad.id_ciudad;

/*Ejemplo Práctico 2: Combinación de Tres Tablas con INNER JOIN*/
SELECT personass.nombre, personass.apellido, personass.nacimiento, roles.rol, ciudad.ciudad
FROM personass INNER JOIN ciudad ON personass.id_ciudad = ciudad.id_ciudad
INNER JOIN roles on personass.id_rol = roles.id_rol

/*Ejemplo Práctico 3: Analizando el Comportamiento de LEFT JOIN*/
SELECT personass.nombre,
		personass.apellido,
		Ciudad.ciudad
FROM ciudad
LEFT JOIN personass
ON personass.id_ciudad = ciudad.id_ciudad

/*Caso B: Todas las Personas - Ejemplo Práctico 4: Full Join*/
SELECT personass.nombre,
	personass.apellido,
	Ciudad.ciudad
FROM ciudad
FULL JOIN personass
ON personass.id_ciudad = ciudad.id_ciudad


/*Ejemplo Práctico: Combinaciones Personas-País*/
SELECT personass.nombre,
	Ciudad.ciudad
FROM personass CROSS JOIN ciudad;


/* Combinaciones personas-pais usando where*/

SELECT personass.nombre,
	Ciudad.ciudad
FROM personass CROSS JOIN ciudad
WHERE personass.id_ciudad = ciudad.id_ciudad;

/*Ejemplos Creación Alias - Ejemplo Sin Alias*/
SELECT personass.nombre,
	personass.apellido,
	ciudad.ciudad
FROM personass
INNER JOIN ciudad
ON personass.id_ciudad = ciudad.id_ciudad

/*Ejemplos Creación Alias - Ejemplo Con Alias*/
SELECT p.nombre,
	p.apellido,
	c.ciudad
FROM personass p
INNER JOIN ciudad c
ON p.id_ciudad = c.id_ciudad;


/*Ejercicios de Consultas Multitablas*/
