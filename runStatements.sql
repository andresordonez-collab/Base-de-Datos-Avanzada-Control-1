-- 1) Escultura más cara vendida por galería en el último mes. (Consulta al Ayudante)


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



-- 3) Vendedor con mas ventas por galeria 

-- Seleccionamos las columnas correspondientes a la tabla y conservamos unicamente la primera fila que encuentre para cada valor unico de esa columna sin elementos duplicados
-- Tambien contamos la cantidad de ventas que haga un vendedor existente en cada galeria
SELECT DISTINCT ON (galerias.nombre_galeria) galerias.nombre_galeria, empleados.nombre_empleado, COUNT(ventas.id_venta) AS cantidad_ventas FROM galerias
INNER JOIN empleados ON empleados.id_galeria = galerias.id_galeria -- Filtramos por id en las tablas galerias, empleados, vendedores y ventas
INNER JOIN vendedores ON vendedores.id_empleado = empleados.id_empleado
INNER JOIN ventas ON ventas.id_vendedor = vendedores.id_vendedor
GROUP BY galerias.nombre_galeria, empleados.nombre_empleado -- Agrupamos las columnas
ORDER BY galerias.nombre_galeria, cantidad_ventas DESC; -- Ordenamos de mayor a menor



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