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
    WHERE m.nombre_generico_del_medicamento = AM.nombre_generico_del_medicamento
);


UPDATE AM
SET codigo_del_medicamento = (
    SELECT m.codigo_del_medicamento
    FROM medicamentos m
    WHERE
        (AM.tipo_de_medicamento IS NULL OR AM.tipo_de_medicamento = m.tipo_de_medicamento)
      AND (AM.nombre_generico_del_medicamento IS NULL OR AM.nombre_generico_del_medicamento = m.nombre_generico_del_medicamento)
      AND (AM.forma_farmaceutica IS NULL OR AM.forma_farmaceutica = m.forma_farmaceutica)
      AND (AM.concentracion_del_medicamento IS NULL OR AM.concentracion_del_medicamento = m.concentracion_del_medicamento)
      AND (AM.unidad_de_medida_del_medicamento IS NULL OR AM.unidad_de_medida_del_medicamento = m.unidad_de_medida_del_medicamento)
        FETCH FIRST 1 ROWS ONLY
)
WHERE codigo_del_medicamento IS NULL
  AND (
    tipo_de_medicamento IS NOT NULL
        OR nombre_generico_del_medicamento IS NOT NULL
        OR forma_farmaceutica IS NOT NULL
        OR concentracion_del_medicamento IS NOT NULL
        OR unidad_de_medida_del_medicamento IS NOT NULL
    )
  AND EXISTS (
    SELECT 1
    FROM medicamentos m
    WHERE
        (AM.tipo_de_medicamento IS NULL OR AM.tipo_de_medicamento = m.tipo_de_medicamento)
      AND (AM.nombre_generico_del_medicamento IS NULL OR AM.nombre_generico_del_medicamento = m.nombre_generico_del_medicamento)
      AND (AM.forma_farmaceutica IS NULL OR AM.forma_farmaceutica = m.forma_farmaceutica)
      AND (AM.concentracion_del_medicamento IS NULL OR AM.concentracion_del_medicamento = m.concentracion_del_medicamento)
      AND (AM.unidad_de_medida_del_medicamento IS NULL OR AM.unidad_de_medida_del_medicamento = m.unidad_de_medida_del_medicamento)
);



DELETE FROM medicamentos
WHERE ctid NOT IN (
    SELECT MIN(ctid)
    FROM medicamentos
    GROUP BY codigo_del_medicamento
);



SELECT codigo_del_medicamento, COUNT(*)
FROM medicamentos
GROUP BY codigo_del_medicamento
HAVING COUNT(*) > 1;


SELECT nombre_generico_del_medicamento, COUNT(*)
FROM medicamentos
GROUP BY nombre_generico_del_medicamento
HAVING COUNT(*) > 1;

