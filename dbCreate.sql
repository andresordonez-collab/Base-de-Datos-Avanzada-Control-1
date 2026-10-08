# GRUPO 2 (Base de datos de galerías de arte)

CREATE TABLE region(id_region INT PRIMARY KEY, nombre_region VARCHAR (100));
CREATE TABLE comuna(id_comuna INT PRIMARY KEY, 
nombre_region VARCHAR(100), 
nombre_comuna VARCHAR(100), 
CONSTRAINT fk_id_region FOREIGN KEY (id_region) REFERENCES region(id_region));

CREATE TABLE galeria(id_galeria INT PRIMARY KEY, 
nombre_galeria VARCHAR(100),
CONSTRAINT fk_id_comuna FOREIGN KEY (id_comuna) REFERENCES comuna(id_comuna));

CREATE TABLE tipo_(id_tipo INT PRIMARY KEY, tipo_de_arte VARCHAR(100));
CREATE TABLE cliente(id_cliente INT PRIMARY KEY, nombre_cliente VARCHAR(100), genero VARCHAR(100));
CREATE TABLE venta(id_venta INT PRIMARY KEY);
CREATE TABLE vendedor(id_vendedor INT PRIMARY KEY);
CREATE TABLE empleado(id_empleado INT PRIMARY KEY);