
--Muestra todos los registros de la tabla personass
SELECT * FROM personass

-- Muestra el campo ciudad de la tabla ciudad.
SELECT ciudad FROM ciudad

--Muestra los campos nombre, apellido y sueldo de la tabla personass
SELECT nombre , apellido , sueldo FROM personass

-- Muestra los campos nombre y apellido de la tabla personass donde el sexo sea igual a F
SELECT nombre , apellido FROM personass WHERE sexo = 'F'

--Muestra los campos nombre, apellido, id_ciudad y sexo de la tabla personass donde el sexo sea igual a F y la ciudad igual a 1
SELECT nombre , apellido , id_ciudad , sexo FROM personass WHERE sexo = 'F' AND id_ciudad = 1

--Muestra el nombre, apellido, id_ciudad, sexo de la tabla personass donde el sexo es igual a F o el id_ciudad es igual a 1
SELECT nombre , apellido , id_ciudad , sexo FROM personass WHERE sexo = 'F' OR id_ciudad = 1


--Muestra el campo ciudad de la tabla ciudad
SELECT ciudad FROM ciudad

--Muestra el campo nombre, apellido, id_ciudad, sexo de la tabla personass donde el sexo es igual a F y elid_ciudad es igual a 1 
SELECT nombre , apellido , id_ciudad , sexo FROM personass WHERE sexo = 'F' OR id_ciudad = 1


--Muestra el apellido y sueldo de la tabla personass donde el sueldo es mayor que 500
SELECT apellido , sueldo FROM personass WHERE sueldo > 500


--Muestra nombre, apellido, sueldo de la tabla personas donde el sueldo mayor que 500 y sueldo menor que 700 y el sexo igual a M
SELECT nombre , apellido , sueldo FROM personass WHERE sueldo > 500 AND sueldo < 700 AND sexo ='M'

--mostrar los campos nombre y sustituirlo por NOMBRE, tambien muestra los campos apellido sustituido por APELLIDO y nacimiento sustituido por
--CUMPLEAÑOS, de la tabla personass
SELECT nombre AS NOMBRE, apellido AS APELLIDO , nacimiento AS CUMPLEAÑOS FROM personass

--Mostrar apellido y nacimiento de la tabla personas ordenado por nacimiento
SELECT apellido , nacimiento FROM personass ORDER BY nacimiento


--Agregando los registros
INSERT INTO personass
( apellido , nombre , sueldo , direccion , celular , sexo , nacimiento , id_rol , id_ciudad )
VALUES
( 'Molina Vasquez' , 'Alejandro' , 897 , '10 Avenida Sur y 12 Calle Poniente' , '45633423' ,
'M' , '1970 - 04 - 21' , 2, 3),
( 'Rivas Alba' , 'Yesenia A' , 234 , '4 Calle Oriten y parque Los Arboles' , '54534243' ,
'F' , '1979 - 11 - 01' , 2, 4),
( 'Marquez' , 'Roxana Elizabeth' , 434 , NULL, NULL, NULL, NULL, 4, 1);
GO

--Actualizando los registros
UPDATE personass SET nacimiento = '1985/11/2' WHERE id_personas = 14
UPDATE personass SET sexo = 'f' WHERE sexo = 'F'
UPDATE personass SET celular = ''


--Eliminando campos
DELETE personass WHERE sueldo < 500
DELETE personass WHERE id_personas = 5
DELETE personass WHERE sexo = 'M'