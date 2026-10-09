-- GRUPO 2 (Base de datos de galerías de arte)

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
