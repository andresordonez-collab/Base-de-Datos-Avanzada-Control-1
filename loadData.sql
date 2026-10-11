-- Datos ficticios para el Control 1 de Bases de Datos Avanzadas (PostgreSQL).
-- Compatible con el dbCreate.sql.
-- Cada obra vendida figura en una sola venta; algunas ventas incluyen varias obras.
-- Ejecutar sobre tablas vacías, después de dbCreate.sql.

BEGIN;

-- REGIONES (4 registros)
INSERT INTO regiones (id_region, nombre_region) VALUES
    (1, 'Metropolitana de Santiago'),
    (2, 'Valparaíso'),
    (3, 'Biobío'),
    (4, 'Maule');

-- COMUNAS (6 registros)
INSERT INTO comunas (id_comuna, id_region, nombre_comuna) VALUES
    (1, 1, 'Santiago'),
    (2, 1, 'Providencia'),
    (3, 2, 'Valparaíso'),
    (4, 2, 'Viña del Mar'),
    (5, 3, 'Concepción'),
    (6, 4, 'Talca');

-- GALERIAS (4 registros)
INSERT INTO galerias (id_galeria, id_comuna, nombre_galeria) VALUES
    (1, 1, 'Galería Arte Central'),
    (2, 2, 'Galería Mirador'),
    (3, 3, 'Galería Puerto Arte'),
    (4, 5, 'Galería del Biobío');

-- TIPOS (2 registros)
INSERT INTO tipos (id_tipo, tipo_de_arte) VALUES
    (1, 'Pintura'),
    (2, 'Escultura');

-- CLIENTES (10 registros)
INSERT INTO clientes (id_cliente, id_comuna, nombre_cliente) VALUES
    (1, 1, 'Camila González'),
    (2, 2, 'Matías Rojas'),
    (3, 3, 'Sofía Araya'),
    (4, 5, 'Diego Castro'),
    (5, 4, 'Valentina Herrera'),
    (6, 6, 'Gabriel Lagos'),
    (7, 1, 'Fernanda Figueroa'),
    (8, 2, 'Javier Orellana'),
    (9, 5, 'Antonia Cáceres'),
    (10, 3, 'Tomás Jara');

-- EMPLEADOS (12 registros)
INSERT INTO empleados (id_empleado, id_galeria, nombre_empleado, genero, sueldo) VALUES
    (1, 1, 'Ana Pérez', 'Mujer', 850000),
    (2, 1, 'Luis Ortega', 'Hombre', 940000),
    (3, 1, 'Paula Torres', 'Mujer', 1100000),
    (4, 2, 'María Salinas', 'Mujer', 890000),
    (5, 2, 'Carlos Soto', 'Hombre', 990000),
    (6, 2, 'Julia Valdés', 'Mujer', 1050000),
    (7, 3, 'Andrés Fuentes', 'Hombre', 780000),
    (8, 3, 'Carolina Reyes', 'Mujer', 950000),
    (9, 3, 'Jorge Muñoz', 'Hombre', 1200000),
    (10, 4, 'Daniela Ruiz', 'Mujer', 920000),
    (11, 4, 'Pedro Silva', 'Hombre', 1020000),
    (12, 4, 'Lorena Díaz', 'Mujer', 1150000);

-- VENDEDORES (8 registros)
INSERT INTO vendedores (id_vendedor, id_empleado) VALUES
    (1, 1),
    (2, 2),
    (3, 4),
    (4, 5),
    (5, 7),
    (6, 8),
    (7, 10),
    (8, 11);

-- VENTAS (38 registros)
INSERT INTO ventas (id_venta, id_cliente, id_vendedor, fecha_venta, precio_final) VALUES
    (1, 1, 1, '2019-02-04 12:00:00', 480000),
    (2, 1, 3, '2019-02-05 13:00:00', 395000),
    (3, 2, 5, '2019-02-06 14:00:00', 610000),
    (4, 3, 7, '2019-02-07 15:00:00', 320000),
    (5, 4, 2, '2019-02-19 16:00:00', 1090000),
    (6, 5, 4, '2019-02-20 16:00:00', 720000),
    (7, 1, 6, '2019-02-21 16:00:00', 1450000),
    (8, 6, 8, '2019-02-22 16:00:00', 690000),
    (9, 9, 1, '2019-07-10 13:30:00', 380000),
    (10, 5, 5, '2019-07-18 17:15:00', 680000),
    (11, 1, 1, '2020-06-11 11:00:00', 260000),
    (12, 2, 3, '2020-06-12 11:00:00', 880000),
    (13, 3, 5, '2020-06-13 11:00:00', 180000),
    (14, 4, 7, '2020-06-14 11:00:00', 940000),
    (15, 1, 1, '2021-05-06 12:00:00', 450000),
    (16, 5, 3, '2021-05-11 12:00:00', 760000),
    (17, 1, 5, '2021-05-16 12:00:00', 115000),
    (18, 7, 7, '2021-05-22 12:00:00', 390000),
    (19, 8, 2, '2025-03-04 10:00:00', 225000),
    (20, 9, 4, '2025-03-07 10:00:00', 185000),
    (21, 10, 6, '2025-03-14 10:00:00', 45000),
    (22, 6, 8, '2025-03-23 10:00:00', 310000),
    (23, 3, 1, '2025-11-03 17:00:00', 570000),
    (24, 2, 3, '2025-11-08 17:00:00', 1030000),
    (25, 4, 5, '2025-11-15 17:00:00', 435000),
    (26, 1, 7, '2025-11-28 17:00:00', 880000),
    (27, 2, 1, '2026-08-05 12:00:00', 125000),
    (28, 10, 3, '2026-08-12 12:00:00', 350000),
    (29, 9, 5, '2026-08-18 12:00:00', 265000),
    (30, 8, 7, '2026-08-26 12:00:00', 410000),
    (31, 4, 2, '2026-09-15 13:00:00', 550000),
    (32, 4, 4, '2026-09-16 13:00:00', 890000),
    (33, 7, 6, '2026-09-17 13:00:00', 465000),
    (34, 7, 8, '2026-09-18 13:00:00', 625000),
    (35, 5, 1, '2026-09-24 18:00:00', 1235000),
    (36, 1, 3, '2026-09-25 18:00:00', 510000),
    (37, 6, 5, '2026-09-26 18:00:00', 970000),
    (38, 8, 7, '2026-09-27 18:00:00', 1640000);

-- PRODUCTOS (50 registros)
INSERT INTO productos (id_producto, id_tipo, nombre_producto, precio, peso_kg, disponible) VALUES
    (1, 1, 'Amanecer en el Valle 01', 480000, 2.4, FALSE),
    (2, 1, 'Bruma de Invierno 02', 395000, 1.75, FALSE),
    (3, 1, 'Atardecer de Colores 03', 610000, 3.1, FALSE),
    (4, 1, 'Mar en Calma 04', 320000, 2.2, FALSE),
    (5, 2, 'Figura de Bronce 01', 880000, 22.6, FALSE),
    (6, 1, 'Los Andes al Alba 05', 210000, 1.55, FALSE),
    (7, 2, 'Raíces de Piedra 02', 720000, 18.5, FALSE),
    (8, 2, 'Vuelo de Acero 03', 1150000, 33.4, FALSE),
    (9, 1, 'Paisaje de Otoño 06', 300000, 2.7, FALSE),
    (10, 2, 'Rostro en Mármol 04', 690000, 16.2, FALSE),
    (11, 1, 'Luz del Puerto 07', 380000, 2.35, FALSE),
    (12, 2, 'La Espiral 05', 680000, 17.8, FALSE),
    (13, 1, 'Ciudad en Silencio 08', 260000, 1.9, FALSE),
    (14, 2, 'Equilibrio 06', 880000, 25.0, FALSE),
    (15, 1, 'Jardín del Sur 09', 180000, 1.4, FALSE),
    (16, 2, 'Manos del Tiempo 07', 940000, 30.7, FALSE),
    (17, 1, 'Cielo de Verano 10', 450000, 2.1, FALSE),
    (18, 1, 'Bosque de Niebla 11', 760000, 4.25, FALSE),
    (19, 1, 'Reflejos del Río 12', 115000, 1.05, FALSE),
    (20, 1, 'Flores de Primavera 13', 390000, 2.8, FALSE),
    (21, 1, 'Retrato del Viento 14', 225000, 2.15, FALSE),
    (22, 1, 'Patio Interior 15', 185000, 1.8, FALSE),
    (23, 1, 'Horizonte de Luz 16', 45000, 0.85, FALSE),
    (24, 1, 'Casa en la Colina 17', 310000, 2.25, FALSE),
    (25, 2, 'Origen Andino 08', 570000, 11.25, FALSE),
    (26, 2, 'Formas del Mar 09', 910000, 26.4, FALSE),
    (27, 1, 'Costa Azul 18', 120000, 1.1, FALSE),
    (28, 2, 'Viento Tallado 10', 435000, 9.75, FALSE),
    (29, 2, 'Ecos del Bosque 11', 690000, 18.25, FALSE),
    (30, 1, 'Plaza Antigua 19', 190000, 1.6, FALSE),
    (31, 1, 'Memorias del Desierto 20', 125000, 1.2, FALSE),
    (32, 1, 'Cordillera Nevada 21', 350000, 3.3, FALSE),
    (33, 1, 'Bahía del Atardecer 22', 265000, 2.75, FALSE),
    (34, 1, 'Amanecer en el Valle 23', 410000, 3.65, FALSE),
    (35, 2, 'Abstracción en Hierro 12', 550000, 14.4, FALSE),
    (36, 2, 'Encuentro de Formas 13', 890000, 27.5, FALSE),
    (37, 2, 'Luz en Piedra 14', 465000, 12.3, FALSE),
    (38, 2, 'Volumen del Norte 15', 625000, 19.1, FALSE),
    (39, 2, 'Alas de Cobre 16', 1050000, 32.7, FALSE),
    (40, 1, 'Bruma de Invierno 24', 185000, 1.9, FALSE),
    (41, 2, 'Círculo de Vida 17', 510000, 15.6, FALSE),
    (42, 2, 'Nudo de Bronce 18', 970000, 29.4, FALSE),
    (43, 2, 'Piedra Austral 19', 1320000, 38.8, FALSE),
    (44, 1, 'Atardecer de Colores 25', 320000, 3.0, FALSE),
    (45, 1, 'Mar en Calma 26', 75000, 1.2, TRUE),
    (46, 2, 'Diálogo de Acero 20', 1200000, 41.5, TRUE),
    (47, 1, 'Los Andes al Alba 27', 95000, 0.9, TRUE),
    (48, 2, 'Figura de Bronce 21', 580000, 14.2, TRUE),
    (49, 1, 'Paisaje de Otoño 28', 340000, 3.7, TRUE),
    (50, 2, 'Raíces de Piedra 22', 770000, 23.1, TRUE);

-- PRODUCTOS_VENTAS (44 registros)
INSERT INTO productos_ventas (id_producto, id_venta) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 5),
    (7, 6),
    (8, 7),
    (9, 7),
    (10, 8),
    (11, 9),
    (12, 10),
    (13, 11),
    (14, 12),
    (15, 13),
    (16, 14),
    (17, 15),
    (18, 16),
    (19, 17),
    (20, 18),
    (21, 19),
    (22, 20),
    (23, 21),
    (24, 22),
    (25, 23),
    (26, 24),
    (27, 24),
    (28, 25),
    (29, 26),
    (30, 26),
    (31, 27),
    (32, 28),
    (33, 29),
    (34, 30),
    (35, 31),
    (36, 32),
    (37, 33),
    (38, 34),
    (39, 35),
    (40, 35),
    (41, 36),
    (42, 37),
    (43, 38),
    (44, 38);

-- Sincronización de secuencias BIGSERIAL al utilizar IDs explícitos.
SELECT setval(pg_get_serial_sequence('regiones', 'id_region'), (SELECT MAX(id_region) FROM regiones));
SELECT setval(pg_get_serial_sequence('comunas', 'id_comuna'), (SELECT MAX(id_comuna) FROM comunas));
SELECT setval(pg_get_serial_sequence('galerias', 'id_galeria'), (SELECT MAX(id_galeria) FROM galerias));
SELECT setval(pg_get_serial_sequence('tipos', 'id_tipo'), (SELECT MAX(id_tipo) FROM tipos));
SELECT setval(pg_get_serial_sequence('clientes', 'id_cliente'), (SELECT MAX(id_cliente) FROM clientes));
SELECT setval(pg_get_serial_sequence('empleados', 'id_empleado'), (SELECT MAX(id_empleado) FROM empleados));
SELECT setval(pg_get_serial_sequence('vendedores', 'id_vendedor'), (SELECT MAX(id_vendedor) FROM vendedores));
SELECT setval(pg_get_serial_sequence('ventas', 'id_venta'), (SELECT MAX(id_venta) FROM ventas));
SELECT setval(pg_get_serial_sequence('productos', 'id_producto'), (SELECT MAX(id_producto) FROM productos));

COMMIT;
