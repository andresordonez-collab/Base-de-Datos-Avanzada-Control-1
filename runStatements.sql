-- 1) Escultura más cara vendida por galería en el último mes. 


-- Seleccionamos las columnas correspondientes a una tabla en particular ademas de extraer el mes y año respectivo de cada venta del producto
SELECT galerias.nombre_galeria, tipos.tipo_de_arte, EXTRACT(MONTH FROM ventas.fecha_venta) AS mes, EXTRACT(YEAR FROM ventas.fecha_venta) AS anio, MAX(productos.precio) AS precio_maximo_de_escultura FROM galerias
INNER JOIN empleados ON empleados.id_galeria = galerias.id_galeria   -- Filtramos por id en las tablas galerias, empleados, vendedores, ventas, productos, productos_ventas y tipos, comparando si coincidian en ID
INNER JOIN vendedores ON vendedores.id_empleado = empleados.id_empleado
INNER JOIN ventas ON ventas.id_vendedor = vendedores.id_vendedor
INNER JOIN productos_ventas ON productos_ventas.id_venta = ventas.id_venta
INNER JOIN productos ON productos.id_producto = productos_ventas.id_producto
INNER JOIN tipos ON tipos.id_tipo = productos.id_tipo
WHERE tipos.tipo_de_arte = 'Escultura' -- La condicion logica para que la consulta sea correcta, los tipos de arte deben de ser tipo escultura
	AND productos.disponible = FALSE --  que el producto se haya vendido (es decir disponible != TRUE)
	AND EXTRACT(MONTH FROM ventas.fecha_venta) = (SELECT EXTRACT(MONTH FROM MAX(fecha_venta)) FROM ventas) -- Compararamos que el mes que estemos analizando sea el ultimo mes que se tenga registrado
	AND EXTRACT(YEAR FROM ventas.fecha_venta) = (SELECT EXTRACT(YEAR FROM MAX(fecha_venta)) FROM ventas) -- Compararamos que el año que estemos analizando sea el ultimo año que se tenga registrado 
GROUP BY galerias.nombre_galeria, tipos.tipo_de_arte, EXTRACT(MONTH FROM ventas.fecha_venta), EXTRACT(YEAR FROM ventas.fecha_venta) -- Agrupamos las columnas
ORDER BY anio DESC, mes DESC, precio_maximo_de_escultura DESC; -- Ordenamos de mayor a menor


-- 2) Pintura más económica vendida el año pasado.


-- Seleccionamos los productos vendidos durante 2025, relacionando
-- las ventas con sus productos y los tipos de arte.
SELECT
    v.id_venta,
    v.fecha_venta,
    p.id_producto,
    p.nombre_producto,
    p.precio,
    t.tipo_de_arte
FROM ventas v
JOIN productos_ventas pv
    ON v.id_venta = pv.id_venta
JOIN productos p
    ON pv.id_producto = p.id_producto
JOIN tipos t
    ON p.id_tipo = t.id_tipo

-- Filtramos las ventas realizadas en 2025 y consideramos solo las pinturas.
WHERE v.fecha_venta >= '2025-01-01'
  AND v.fecha_venta < '2026-01-01'
  AND t.tipo_de_arte = 'Pintura'

-- Ordenamos las pinturas por precio ascendente y obtenemos la más económica.
ORDER BY p.precio ASC
LIMIT 1;



-- 3) Vendedor con mas ventas por galeria 

-- Seleccionamos las columnas correspondientes a la tabla y conservamos unicamente la primera fila que encuentre para cada valor unico de esa columna sin elementos duplicados
-- Tambien contamos la cantidad de ventas que haga un vendedor existente en cada galeria
SELECT DISTINCT ON (galerias.nombre_galeria) galerias.nombre_galeria, empleados.nombre_empleado, COUNT(ventas.id_venta) AS cantidad_ventas FROM galerias
INNER JOIN empleados ON empleados.id_galeria = galerias.id_galeria -- Filtramos por id en las tablas galerias, empleados, vendedores y ventas
INNER JOIN vendedores ON vendedores.id_empleado = empleados.id_empleado
INNER JOIN ventas ON ventas.id_vendSELECT nombre_galeria, 
		EXTRACT (YEAR FROM fecha_venta) AS año,
		EXTRACT (MONTH FROM fecha_venta) AS mes,
		MAX(precio_final) AS venta_maxima 
		FROM ventas

INNER JOIN vendedores ON ventas.id_vendedor = vendedores.id_vendedor
INNER JOIN empleados ON vendedores.id_empleado = empleados.id_empleado
INNER JOIN galerias ON empleados.id_galeria = galerias.id_galeria

WHERE fecha_venta >= '2019-01-01 00:00:00'
AND fecha_venta < '2020-01-01 00:00:00'

GROUP BY nombre_galeria, año, mes
ORDER BY mes;edor = vendedores.id_vendedor
GROUP BY galerias.nombre_galeria, empleados.nombre_empleado -- Agrupamos las columnas
ORDER BY galerias.nombre_galeria, cantidad_ventas DESC; -- Ordenamos de mayor a menor

-- 4) Cliente que ha invertido más en arte por año.

-- Hacemos una subconsulta para calcular el gasto anual de cada cliente, agrupando por año y cliente, y sumando el precio final de las ventas.
WITH gasto_anual AS (
    SELECT EXTRACT(YEAR FROM v.fecha_venta) AS year, c.id_cliente, c.nombre_cliente, SUM(v.precio_final) AS total
    FROM ventas v
    JOIN clientes c ON c.id_cliente = v.id_cliente
    GROUP BY year, c.id_cliente, c.nombre_cliente
),

-- Se hace otra subconsulta para obtener el gasto máximo por año.
maximos AS (
    SELECT year, MAX(total) AS max_total
    FROM gasto_anual
    GROUP BY year
)

SELECT g.year, g.id_cliente, g.nombre_cliente, g.total
FROM gasto_anual g
JOIN maximos m ON m.year = g.year AND m.max_total = g.total
ORDER BY g.year;

-- 5) Tipo de arte más vendido por año.

-- Hacemos una subconsulta para calcular la cantidad de ventas por tipo de arte y año.
WITH ventas_por_tipo AS (
    SELECT EXTRACT(YEAR FROM v.fecha_venta) AS year, t.id_tipo, t.tipo_de_arte, COUNT(*) AS cant_vendidas
    FROM productos_ventas pv
    JOIN ventas v ON v.id_venta = pv.id_venta
    JOIN productos p ON p.id_producto = pv.id_producto
    JOIN tipos t ON t.id_tipo = p.id_tipo
    GROUP BY year, t.id_tipo, t.tipo_de_arte
),

-- Se hace otra subconsulta para obtener la cantidad máxima de ventas por tipo de arte y año.
maximos AS (
    SELECT year, MAX(cant_vendidas) AS max_cant
    FROM ventas_por_tipo
    GROUP BY year
)

SELECT v.year, v.tipo_de_arte, v.cant_vendidas
FROM ventas_por_tipo v
JOIN maximos m ON m.year = v.year AND m.max_cant = v.cant_vendidas
ORDER BY v.year;

-- 6) Lista de regiones y sus galerías por comuna.

SELECT regiones.nombre_region, 
		comunas.nombre_comuna, 
		galerias.nombre_galeria FROM regiones

-- Se relaciona galería a través de la comuna
INNER JOIN comunas ON comunas.id_region = regiones.id_region
INNER JOIN galerias ON galerias.id_comuna = comunas.id_comuna

-- Se ordena para legibilidad
ORDER BY regiones.nombre_region;


-- 7) Venta más cara por mes, por galería en el 2019.

SELECT nombre_galeria, 
		EXTRACT (YEAR FROM fecha_venta) AS año,
		EXTRACT (MONTH FROM fecha_venta) AS mes,
		MAX(precio_final) AS venta_maxima -- Venta más cara
		FROM ventas

-- Se relaciona con la galeria
INNER JOIN vendedores ON ventas.id_vendedor = vendedores.id_vendedor
INNER JOIN empleados ON vendedores.id_empleado = empleados.id_empleado
INNER JOIN galerias ON empleados.id_galeria = galerias.id_galeria

-- Se filtra solo para trabajar con ventas del 2019
WHERE fecha_venta >= '2019-01-01 00:00:00'
AND fecha_venta < '2020-01-01 00:00:00'

-- Se agrupa por galeria y cada mes 
GROUP BY nombre_galeria, año, mes
ORDER BY mes, nombre_galeria;


-- 8) Cliente que ha comprado más pinturas entre 2019 y 2021.

-- Relacionamos las ventas con sus productos, tipos de arte y clientes.
SELECT
    c.id_cliente,
    c.nombre_cliente,
    COUNT(*) AS cantidad_pinturas
FROM ventas v
JOIN productos_ventas pv
    ON v.id_venta = pv.id_venta
JOIN productos p
    ON pv.id_producto = p.id_producto
JOIN tipos t
    ON p.id_tipo = t.id_tipo
JOIN clientes c
    ON v.id_cliente = c.id_cliente

-- Filtramos las ventas realizadas entre 2019 y 2021, considerando solo pinturas.
WHERE v.fecha_venta >= '2019-01-01'
  AND v.fecha_venta < '2022-01-01'
  AND t.tipo_de_arte = 'Pintura'

-- Agrupamos por cliente para contar la cantidad de pinturas compradas por cada uno.
GROUP BY c.id_cliente

-- Ordenamos por cantidad de pinturas de mayor a menor y obtenemos al cliente con más compras.
ORDER BY cantidad_pinturas DESC
LIMIT 1;



-- 9) Promedio de sueldos de hombres y mujeres mensual por galería
-- Nota: La tabla empleados registra el sueldo mensual base vigente (no histórico),
-- por lo que no requiere filtro temporal mensual.

SELECT 
    g.id_galeria, 
    g.nombre_galeria,
    -- AVG ignora los NULL: promedia solo el sueldo de empleados hombres
    ROUND(AVG(CASE WHEN e.genero = 'Hombre' THEN e.sueldo END), 2) AS promedio_hombres,
    -- Promedia solo el sueldo de empleadas mujeres
    ROUND(AVG(CASE WHEN e.genero = 'Mujer' THEN e.sueldo END), 2) AS promedio_mujeres,
    -- COUNT ignora NULL: cuenta cuántos hombres trabajan en la galería
    COUNT(CASE WHEN e.genero = 'Hombre' THEN 1 END) AS n_hombres,
    -- Cuenta cuántas mujeres trabajan en la galería
    COUNT(CASE WHEN e.genero = 'Mujer' THEN 1 END) AS n_mujeres
FROM galerias g
JOIN empleados e ON e.id_galeria = g.id_galeria
GROUP BY g.id_galeria, g.nombre_galeria
ORDER BY g.id_galeria;

-- 10) Venta más pesada en kilogramos por mes en los últimos 12 meses

WITH peso_ventas AS (
    SELECT
        EXTRACT(YEAR FROM v.fecha_venta) AS year,
        EXTRACT(MONTH FROM v.fecha_venta) AS mes,
        v.id_venta, 
        v.fecha_venta,  
        -- Suma el peso de todas las obras incluidas en cada venta
        SUM(p.peso_kg) AS peso_total
    FROM ventas v
    JOIN productos_ventas pv ON pv.id_venta = v.id_venta
    JOIN productos p ON p.id_producto = pv.id_producto
    -- Filtra los últimos 12 meses respecto a la fecha más reciente registrada
    WHERE v.fecha_venta >= (SELECT MAX(fecha_venta) FROM ventas) - INTERVAL '12 months'
    GROUP BY v.id_venta, v.fecha_venta
)
-- DISTINCT ON conserva una única fila por combinación de (año, mes)
SELECT DISTINCT ON (year, mes) 
    year, 
    mes, 
    id_venta, 
    fecha_venta, 
    peso_total
FROM peso_ventas
-- Al ordenar por peso_total DESC, la primera fila de cada mes es siempre la más pesada
ORDER BY year ASC, mes ASC, peso_total DESC;