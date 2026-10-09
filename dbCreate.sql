-- GRUPO 2 (Base de datos de galerías de arte)

-- Creamos la tabla de region
CREATE TABLE region(id_region INT PRIMARY KEY, nombre_region VARCHAR (100));

-- Creamos la tabla de comuna
CREATE TABLE comuna(id_comuna INT PRIMARY KEY,
	id_region INT,
	nombre_comuna VARCHAR(100),
	CONSTRAINT fk_comuna_region FOREIGN KEY (id_region) REFERENCES region(id_region));



-- Creamos la tabla de galeria
CREATE TABLE galeria(id_galeria INT PRIMARY KEY,
	id_comuna INT,
	nombre_galeria VARCHAR(100),
	CONSTRAINT fk_galeria_comuna FOREIGN KEY (id_comuna) REFERENCES comuna(id_comuna));



-- Creamos la tabla local
CREATE TABLE tienda(id_tienda INT PRIMARY KEY,
	id_comuna INT,
	nombre_local VARCHAR(100),
	CONSTRAINT fk_tienda_comuna FOREIGN KEY (id_comuna) REFERENCES comuna(id_comuna));



-- Creamos la tabla de tipo
CREATE TABLE tipo(id_tipo INT PRIMARY KEY, 
	tipo_de_arte VARCHAR(100));


-- Creamos la tabla de tipo
CREATE TABLE cliente(id_cliente INT PRIMARY KEY, 
	id_comuna INT, 
	nombre_cliente VARCHAR(100), 
	genero VARCHAR(100),
	CONSTRAINT fk_cliente_comuna FOREIGN KEY (id_comuna) REFERENCES comuna(id_comuna));


-- Creamos la tabla de venta
CREATE TABLE venta(id_venta INT PRIMARY key,
	id_producto INT,
    id_cliente INT,
    id_vendedor INT,
    fecha_venta DATE,
    CONSTRAINT fk_venta_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    CONSTRAINT fk_venta_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    CONSTRAINT fk_venta_vendedor FOREIGN KEY (id_vendedor) REFERENCES vendedor(id_vendedor));


-- Creamos la tabla de producto
create table producto(id_producto INT primary key,
	id_tipo INT,
	id_local INT,
	nombre_producto VARCHAR(100),
	precio INT,
	peso_kg INT,
	CONSTRAINT fk_producto_tipo FOREIGN KEY (id_tipo) REFERENCES tipo(id_tipo),
	CONSTRAINT fk_producto_local FOREIGN KEY (id_local) REFERENCES local(id_local));




-- Creamos la tabla de vendedor
CREATE TABLE vendedor(id_vendedor INT PRIMARY key,
	id_empleado INT, 
	CONSTRAINT fk_vendedor_empleado FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)));

-- Creamos la tabla de empleado
CREATE TABLE empleado(id_empleado INT PRIMARY key,
    id_galeria INT,
    nombre_empleado VARCHAR(100),
    genero VARCHAR(20),
    sueldo INT,
    CONSTRAINT fk_empleado_galeria FOREIGN KEY (id_galeria) REFERENCES galeria(id_galeria));



