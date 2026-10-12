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