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

-- Creamos la tabla de tipo
CREATE TABLE tipo(id_tipo INT PRIMARY KEY, 
	tipo_de_arte VARCHAR(10));


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



-- Creamos la tabla de empleado
CREATE TABLE empleados(id_empleado BIGSERIAL PRIMARY KEY,
	id_galeria BIGINT,
    nombre_empleado VARCHAR(100),
    genero VARCHAR(20) NOT NULL,
    sueldo DECIMAL(6,2) NOT NULL,
    FOREIGN KEY (id_galeria) REFERENCES galeria(id_galeria));


-- Creamos la tabla de vendedor
CREATE TABLE vendedores(
	id_vendedor BIGSERIAL PRIMARY KEY,
	id_empleado BIGINT,
	FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado));
