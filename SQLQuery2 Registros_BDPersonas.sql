USE Universidad
GO

CREATE TABLE Autos (
	id_auto int NOT NULL,
	marca VARCHAR(30) NOT NULL,
	modelo VARCHAR(30) NOT NULL,
	anio INT,
	color VARCHAR(20),
	precio DECIMAL(10,2) -- Precio con 2 decimales
);
GO

INSERT INTO Autos (id_auto, marca, modelo, anio, color, precio)
VALUES
(1, 'Toyota', 'Corolla', 2020, 'Gris', 165000.00),
(2, 'Honda', 'Civic', 2019, 'Negro', 172000.00),
(3, 'Ford', 'Focus', 2018, 'Rojo', 150000.00),
(4, 'Hyundai', 'Elantra', 2021, 'Blanco', 168000.00),
(5, 'Chevrolet', 'Cruze', 2017, 'Azul', 140000.00),
(6, 'Kia', 'Rio', 2020, 'Plata', 135000.00),
(7, 'Nissan', 'Sentra', 2022, 'Negro', 180000.00),
(8, 'Volkswagen', 'Jetta', 2019, 'Gris', 175000.00),
(9, 'Mazda', '3', 2021, 'Rojo', 190000.00),
(10, 'Renault', 'Logan', 2016, 'Blanco', 125000.00);
GO