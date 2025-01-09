UPDATE AM
SET
    nombre_generico_del_medicamento = (
        SELECT m.nombre_generico_del_medicamento
        FROM medicamentos m
        WHERE m.codigo_del_medicamento = AM.codigo_del_medicamento
    ),
    forma_farmaceutica = (
        SELECT m.forma_farmaceutica
        FROM medicamentos m
        WHERE m.codigo_del_medicamento = AM.codigo_del_medicamento
    ),
    concentracion_del_medicamento = (
        SELECT m.concentracion_del_medicamento
        FROM medicamentos m
        WHERE m.codigo_del_medicamento = AM.codigo_del_medicamento
    ),
    unidad_de_medida_del_medicamento = (
        SELECT m.unidad_de_medida_del_medicamento
        FROM medicamentos m
        WHERE m.codigo_del_medicamento = AM.codigo_del_medicamento
    )
WHERE
    codigo_del_medicamento IS NOT NULL
  AND (
    nombre_generico_del_medicamento IS NULL
        OR forma_farmaceutica IS NULL
        OR concentracion_del_medicamento IS NULL
        OR unidad_de_medida_del_medicamento IS NULL
    )
  AND EXISTS (
    SELECT 1
    FROM medicamentos m
    WHERE m.codigo_del_medicamento = AM.codigo_del_medicamento
);



-- Actualizar codigo_del_medicamento cuando sea NULL basado en el nombre del medicamento
UPDATE AM
SET codigo_del_medicamento = (
  SELECT m.codigo_del_medicamento
  FROM medicamentos m
  WHERE m.nombre_generico_del_medicamento = AM.nombre_generico_del_medicamento
)
WHERE codigo_del_medicamento IS NULL
  AND nombre_generico_del_medicamento IS NOT NULL
  AND EXISTS (
  SELECT 1
  FROM medicamentos m
  WHERE 
    m.tipo_de_medicamento = AM.tipo_de_medicamento
    AND m.nombre_generico_del_medicamento = AM.nombre_generico_del_medicamento
    AND m.forma_farmaceutica = AM.forma_farmaceutica
    AND m.concentracion_del_medicamento = AM.concentracion_del_medicamento
    AND m.unidad_de_medida_del_medicamento = AM.unidad_de_medida_del_medicamento
);



UPDATE am
SET nombre_generico_del_medicamento = 'SOLUCION SALINA AL 0.9 POR 500' WHERE am.nombre_generico_del_medicamento ='SOLUCION SALINA  AL 0.9 POR 50';

SELECT codigo_del_medicamento, COUNT(*)
FROM medicamentos
GROUP BY codigo_del_medicamento
HAVING COUNT(*) > 1;


SELECT nombre_generico_del_medicamento, COUNT(*)
FROM medicamentos
GROUP BY nombre_generico_del_medicamento
HAVING COUNT(*) > 1;

