-- 9) Promedio de sueldos de hombres y mujeres mensual por galería, en los últimos 12 meses. 
--Debe indicar cantidad de hombres, de mujeres, y promedio de sueldos por género.

SELECT g.id_galeria, g.nombre_galeria,
    ROUND(
        AVG(
            CASE WHEN e.genero = 'Hombre'THEN e.sueldo END), 2) AS promedio_hombres,
    ROUND(
        AVG(
            CASE WHEN e.genero = 'Mujer' THEN e.sueldo END), 2) AS promedio_mujeres,
    COUNT(
        CASE WHEN e.genero = 'Hombre' THEN 1 END) AS n_hombres,
    COUNT(
        CASE WHEN e.genero = 'Mujer' THEN 1 END) AS n_mujeres
FROM galerias g
JOIN empleados e ON e.id_galeria = g.id_galeria
GROUP BY g.id_galeria, g.nombre_galeria
ORDER BY g.id_galeria;

-- 10) Venta más pesada en kilogramos por mes en los últimos 12 meses.

WITH peso_ventas AS (
    SELECT
    EXTRACT(YEAR FROM v.fecha_venta) AS year,
    EXTRACT(MONTH FROM v.fecha_venta) AS mes,
    v.id_venta, 
    v.fecha_venta,  
    SUM(p.peso_kg) AS peso_total
    FROM ventas v
    JOIN productos_ventas pv ON pv.id_venta = v.id_venta
    JOIN productos p ON p.id_producto = pv.id_producto
    WHERE v.fecha_venta >= (SELECT MAX(fecha_venta) FROM ventas) - INTERVAL '12 months'
    GROUP BY v.id_venta, v.fecha_venta
)
SELECT DISTINCT ON (year,mes) year, mes, id_venta, fecha_venta, peso_total
FROM peso_ventas
ORDER BY YEAR ASC, mes ASC, peso_total DESC;