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