-- GRUPO 2 (Base de datos de galerías de arte)

-- Creamos la tabla de region
CREATE TABLE regiones(id_region BIGSERIAL PRIMARY KEY, 
	nombre_region VARCHAR (100) NOT NULL);

-- Creamos la tabla de comuna
CREATE TABLE comunas(id_comuna BIGSERIAL PRIMARY KEY,
	id_region BIGINT,
	nombre_comuna VARCHAR(100) NOT NULL,
	FOREIGN KEY (id_region) REFERENCES regiones(id_region));

-- Creamos la tabla de galeria
CREATE TABLE galerias(id_galeria BIGSERIAL PRIMARY KEY,
	id_comuna BIGINT,
	nombre_galeria VARCHAR(100) NOT NULL,
	FOREIGN KEY (id_comuna) REFERENCES comunas(id_comuna));

-- Creamos la tabla de tipos de arte.
CREATE TABLE tipos(
    id_tipo BIGSERIAL PRIMARY KEY, 
	tipo_de_arte VARCHAR(10) NOT NULL
);


-- Creamos la tabla de clientes
CREATE TABLE clientes(
    id_cliente BIGSERIAL PRIMARY KEY, 
    id_comuna BIGINT, 
    nombre_cliente VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_comuna) REFERENCES comunas(id_comuna));


-- Creamos la tabla de ventas
CREATE TABLE ventas(
    id_venta BIGSERIAL PRIMARY KEY,
    id_cliente BIGINT,
    id_vendedor BIGINT,
    fecha_venta TIMESTAMP NOT NULL,
    precio_final DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor));


-- Creamos la tabla de productos
create table productos(
    id_producto BIGSERIAL PRIMARY KEY,
	id_tipo BIGINT,
	id_local BIGINT,
	nombre_producto VARCHAR(100) NOT NULL UNIQUE,
	precio DECIMAL(10,2) NOT NULL,
	peso_kg DECIMAL(6,2) NOT NULL,
    disponible BOOLEAN NOT NULL DEFAULT TRUE,
	FOREIGN KEY (id_tipo) REFERENCES tipos(id_tipo),
);

-- Creamos la tabla de empleado
CREATE TABLE empleados(id_empleado BIGSERIAL PRIMARY KEY,
	id_galeria BIGINT,
    nombre_empleado VARCHAR(100),
    genero VARCHAR(20) NOT NULL,
    sueldo DECIMAL(6,2) NOT NULL,
    FOREIGN KEY (id_galeria) REFERENCES galerias(id_galeria));


-- Creamos la tabla de vendedor
CREATE TABLE vendedores(
	id_vendedor BIGSERIAL PRIMARY KEY,
	id_empleado BIGINT,
	FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado));

-- Creamos la tabla de productos_ventas.
CREATE TABLE productos_ventas(
    id_producto BIGINT,
    id_venta BIGINT,
    PRIMARY KEY (id_producto, id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta)
);
