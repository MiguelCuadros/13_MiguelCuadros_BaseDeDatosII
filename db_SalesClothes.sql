/* ACTIVIDAD 1 */
--Crear un nuevo script New Query.

--Eliminar y crear la base de datos db_SalesClothes.
USE master;
DROP DATABASE IF EXISTS db_SalesClothes;
CREATE DATABASE db_SalesClothes;

--Poner en uso la base de datos db_SalesClothes.
USE db_SalesClothes;

--Configurar el idioma español el motor de base de datos.
SET LANGUAGE Español
GO
SELECT @@language AS 'Idioma'
GO

--Configurar el formato de fecha en dmy (día, mes y año) en el motor de base de datos.
SET DATEFORMAT dmy
GO

--Crear la tabla client con la siguiente estructura:
CREATE TABLE client
(
	id int identity(1,1),
	type_document char(3),
	number_document char(15),
	names varchar(60),
	last_name varchar(90),
	email varchar(80),
	cell_phone char(9),
	birthdate date,
	active bit
	CONSTRAINT client_pk PRIMARY KEY (id)
)
GO

--El campo id es clave principal y autoincrementable, empieza en 1 e incrementa de 1 en uno.
ALTER TABLE client
	DROP CONSTRAINT client_pk
GO
ALTER TABLE client
	DROP COLUMN id
GO
ALTER TABLE client
	ADD id int identity(1,1)
GO
ALTER TABLE client
	ADD CONSTRAINT client_pk 
	PRIMARY KEY (id)
GO

--El campo type_document sólo puede admitir datos como DNI ó CNE
ALTER TABLE client
	ADD CONSTRAINT type_document_client 
	CHECK(type_document ='DNI' OR type_document ='CNE')
GO

--El campo number_document sólo permite dígitos entre 0 a 9, y serán 8 cuando es DNI y 9 cuando sea CNE.
ALTER TABLE client
	ADD CONSTRAINT number_document_client
	CHECK ((type_document = 'DNI' AND number_document LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') OR
  (type_document = 'CNE' AND number_document LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO

--El el campo email sólo permite correos electrónicos válidos, por ejemplo: mario@gmail.com
ALTER TABLE client
	ADD CONSTRAINT email_client
	CHECK(email LIKE '%@%._%')
GO

--El campo cell_phone acepta solamente 9 dígitos numéricos, por ejemplo: 997158238.
ALTER TABLE client
	ADD CONSTRAINT cellphone_client
	CHECK (cell_phone like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
GO

--El campo birthdate sólo permite la fecha de nacimiento de clientes mayores de edad.
ALTER TABLE client
	ADD CONSTRAINT birthdate_client
	CHECK((YEAR(GETDATE())- YEAR(birthdate )) >= 18)
GO

--El campo active tendrá como valor predeterminado 1, que significa que el cliente está activo.
ALTER TABLE client
	DROP COLUMN active
GO
ALTER TABLE client
	ADD active bit DEFAULT (1)
GO

--Crear la tabla seller con la siguiente estructura:
CREATE TABLE seller
(
	id int identity(1,1),
	type_document char(3),
	number_document char(15),
	names varchar(60),
	last_name varchar(90),
	salary decimal(8,2),
	cell_phone char(9),
	email varchar(80),
	active bit
	CONSTRAINT seller_pk PRIMARY KEY (id)
)
GO

--El campo id es clave principal y autoincrementable, empieza en 1 e incrementa de 1 en uno.
ALTER TABLE seller
	DROP CONSTRAINT seller_pk
GO
ALTER TABLE seller
	DROP COLUMN id
GO
ALTER TABLE seller
	ADD id int identity(1,1)
GO
ALTER TABLE seller
	ADD CONSTRAINT seller_pk 
	PRIMARY KEY (id)
GO

--El campo type_document sólo puede admitir datos como DNI ó CNE
ALTER TABLE seller
	ADD CONSTRAINT type_document_seller
	CHECK(type_document ='DNI' OR type_document ='CNE')
GO

--El campo number_document sólo permite dígitos entre 0 a 9, y serán 8 cuando es DNI y 9 cuando sea CNE.
ALTER TABLE seller
	ADD CONSTRAINT number_document_seller
	CHECK ((type_document = 'DNI' AND number_document LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') OR
  (type_document = 'CNE' AND number_document LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO

--El campo salary tiene como valor predeterminado 1025
ALTER TABLE seller
	DROP COLUMN salary
GO
ALTER TABLE seller
	ADD salary decimal(8,2) DEFAULT (1025)
GO

--El campo cell_phone acepta solamente 9 dígitos numéricos, por ejemplo: 997158238.
ALTER TABLE seller
	ADD CONSTRAINT cellphone_seller
	CHECK (cell_phone like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
GO

--El el campo email sólo permite correos electrónicos válidos, por ejemplo: roxana@gmail.com
ALTER TABLE seller
	ADD CONSTRAINT email_seller
	CHECK(email LIKE '%@%._%')
GO

--El campo active tendrá como valor predeterminado 1, que significa que el cliente está activo.
ALTER TABLE seller
	DROP COLUMN active
GO
ALTER TABLE seller
	ADD active bit DEFAULT (1)
GO

--Crear la tabla clothes con la siguiente estructura:
CREATE TABLE clothes
(
	id int identity(1,1),
	descriptions varchar(60),
	brand varchar(60),
	amount int,
	size varchar(10),
	price decimal(8,2),
	active bit
	CONSTRAINT clothes_pk PRIMARY KEY (id)
)
GO

--El campo id es clave principal y autoincrementable, empieza en 1 e incrementa de 1 en uno.
ALTER TABLE clothes
	DROP CONSTRAINT clothes_pk
GO
ALTER TABLE clothes
	DROP COLUMN id
GO
ALTER TABLE clothes
	ADD id int identity(1,1)
GO
ALTER TABLE clothes
	ADD CONSTRAINT clothes_pk 
	PRIMARY KEY (id)
GO

--El campo active tendrá como valor predeterminado 1, que significa que el cliente está activo.
ALTER TABLE clothes
	DROP COLUMN active
GO
ALTER TABLE clothes
	ADD active bit DEFAULT (1)
GO

--Crear tabla sale con la siguiente estructura:
CREATE TABLE sale
(
	id int identity(1,1),
	date_time datetime,
	seller_id int,
	client_id int,
	active bit
	CONSTRAINT sale_pk PRIMARY KEY (id)
)
GO

--El campo id es clave principal y autoincrementable, empieza en 1 e incrementa de 1 en uno.
ALTER TABLE sale
	DROP CONSTRAINT sale_pk
GO
ALTER TABLE sale
	DROP COLUMN id
GO
ALTER TABLE sale
	ADD id int identity(1,1)
GO
ALTER TABLE sale
	ADD CONSTRAINT sale_pk 
	PRIMARY KEY (id)
GO

--El campo date_time debe tener como valor predeterminado la fecha y hora del servidor.
ALTER TABLE sale
	ADD CONSTRAINT date_time_sale
	DEFAULT GETDATE()
	FOR date_time
GO

--El campo active tendrá como valor predeterminado 1, que significa que el cliente está activo.
ALTER TABLE sale
	DROP COLUMN active
GO
ALTER TABLE sale
	ADD active bit DEFAULT (1)
GO

--Crear tabla sale_detail con la siguiente estructura:
CREATE TABLE sale_detail
(
	id int identity(1,1),
	sale_id int,
	clothes_id int,
	amount int
)
GO

--Utilizando código T-SQL crear las relaciones entre las tablas de acuerdo a la siguiente imagen:
/* Relacionar tabla sale con tabla client */
ALTER TABLE sale
	ADD CONSTRAINT sale_client FOREIGN KEY (client_id)
	REFERENCES client (id)
	ON UPDATE CASCADE 
	ON DELETE CASCADE
GO

/* Relacionar tabla sale con seller */
ALTER TABLE sale
	ADD CONSTRAINT sale_seller FOREIGN KEY (seller_id)
	REFERENCES seller (id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
GO

/* Relacionar tabla sale_detail con clothes */
ALTER TABLE sale_detail
	ADD CONSTRAINT sale_detail_clothes FOREIGN KEY (clothes_id)
	REFERENCES clothes (id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
GO

/* Relacionar tabla sale con sale_detail */
ALTER TABLE sale_detail
	ADD CONSTRAINT sale_detail_sale FOREIGN KEY (sale_id)
	REFERENCES sale (id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
GO


/* ACTIVIDAD 2 */
--Crear un nuevo script New Query.
--Eliminar y crear la base de datos db_SalesClothes.
--Poner en uso la base de datos db_SalesClothes.
--Configurar el idioma español el motor de base de datos.
--Configurar el formato de fecha en dmy (día, mes y año) en el motor de base de datos.
--Insertar los siguientes registros en la tabla client
INSERT INTO client 
(type_document, number_document, names, last_name, email, cell_phone, birthdate)
VALUES
('DNI', '78451233', 'Fabiola', 'Perales Campos', 'fabiolaperales@gmail.com', '991692597', '19/01/2005'),
('DNI', '14782536', 'Marcos', 'Dávila Palomino', 'marcosdavila@gmail.com', '982514752', '03/03/1990'),
('DNI', '78451236', 'Luis Alberto', 'Barrios Paredes', 'luisbarrios@outlook.com', '985414752', '03/10/1995'),
('CNE', '352514789', 'Claudia María', 'Martínez Rodríguez', 'claudiamartinez@yahoo.com', '995522147', '23/09/1992'),
('CNE', '142536792', 'Mario Tadeo', 'Farfán Castillo', 'mariotadeo@outlook.com', '973125478', '25/11/1997'),
('DNI', '58251433', 'Ana Lucrecia', 'Chumpitaz Prada', 'anachumpitaz@gmail.com', '982514361', '17/10/1992')
GO

--Insertar los siguientes registros en la tabla seller
INSERT INTO seller
(type_document, number_document, names, last_name, salary, email, cell_phone)
VALUES
('DNI', '11224578', 'Oscar', 'Paredes Flores', '1025.00', 'oparedes@miempresa.com', '985566251'),
('CNE', '889922365', 'Azucena', 'Valle Alcazar', '1025.00', 'avalle@miempresa.com', '966338874'),
('DNI', '44771123', 'Rosario', 'Huarca Tarazona', '1025.00', 'rhuaraca@miempresa.com', '933665521')
GO

--Insertar los siguientes registros en la tabla clothes
INSERT INTO clothes
(descriptions, brand, amount, size, price)
VALUES
('Polo camisero', 'Adidas', '20', 'Medium', '40.50'),
('Short playero', 'Nike', '30', 'Medium', '55.50'),
('Camisa sport', 'Adams', '60', 'Large', '60.80'),
('Camisa sport', 'Adams', '70', 'Medium', '58.75'),
('Buzo de verano', 'Reebok', '45', 'Small', '62.90'),
('Pantalón jean', 'Lewis', '35', 'Large', '73.60')
GO

--Listar todos los datos de los clientes (client) cuyo tipo de documento sea DNI
SELECT * FROM client 
	WHERE type_document = 'DNI'
GO

--Listar todos los datos de los clientes (client) cuyo servidor de correo electrónico sea outlook.com.
SELECT * FROM client 
	WHERE email LIKE '%outlook.com'
GO

--Listar todos los datos de los vendedores (seller) cuyo tipo de documento sea CNE.
SELECT * FROM seller 
	WHERE type_document = 'CNE'
GO

--Listar todas las prendas de ropa (clothes) cuyo costo sea menor e igual que S/. 55.00
SELECT * FROM clothes 
	WHERE price <= '55.00'
GO

--Listar todas las prendas de ropa (clothes) cuya marca sea Adams.
SELECT * FROM clothes 
	WHERE brand = 'Adams'
GO

--Eliminar lógicamente los datos de un cliente client de acuerdo a un determinado id (Ejm: 4).
UPDATE client
SET active = '0' 
WHERE id = '4'
GO

--Eliminar lógicamente los datos de un cliente seller de acuerdo a un determinado id (Ejm: 2).
UPDATE client
SET active = '0' 
WHERE id = '2'
GO

--Eliminar lógicamente los datos de un cliente clothes de acuerdo a un determinado id (Ejm: 5). 
UPDATE client
SET active = '0' 
WHERE id = '5'
GO