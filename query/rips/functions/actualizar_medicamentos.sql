CREATE OR REPLACE FUNCTION actualizar_medicamentos()
RETURNS VOID AS $$
BEGIN

-- Corrección específica del nombre del medicamento
UPDATE AM
SET nombre_generico_del_medicamento = 'SOLUCION SALINA AL 0.9 POR 500'
WHERE nombre_generico_del_medicamento = 'SOLUCION SALINA  AL 0.9 POR 50';

UPDATE AM
SET concentracion_del_medicamento = 'AMPOLLA'
WHERE nombre_generico_del_medicamento = 'DEPOTRIM AMPOLLA';
-- Actualizar información del medicamento si existen valores faltantes
UPDATE AM
SET
    nombre_generico_del_medicamento = m.nombre_generico_del_medicamento,
    forma_farmaceutica = m.forma_farmaceutica,
    concentracion_del_medicamento = m.concentracion_del_medicamento,
    unidad_de_medida_del_medicamento = m.unidad_de_medida_del_medicamento
    FROM medicamentos m
WHERE m.codigo_del_medicamento = AM.codigo_del_medicamento
  AND AM.codigo_del_medicamento IS NOT NULL
  AND (AM.nombre_generico_del_medicamento IS NULL
   OR AM.forma_farmaceutica IS NULL
   OR AM.concentracion_del_medicamento IS NULL
   OR AM.unidad_de_medida_del_medicamento IS NULL)
  AND EXISTS (
    SELECT 1 FROM medicamentos m2
    WHERE m2.codigo_del_medicamento = AM.codigo_del_medicamento
    );

-- Actualizar codigo_del_medicamento cuando sea NULL basado en el nombre del medicamento
UPDATE AM
SET codigo_del_medicamento = m.codigo_del_medicamento
    FROM medicamentos m
WHERE AM.codigo_del_medicamento IS NULL
  AND AM.nombre_generico_del_medicamento IS NOT NULL
  AND m.tipo_de_medicamento = AM.tipo_de_medicamento
  AND m.nombre_generico_del_medicamento = AM.nombre_generico_del_medicamento
  AND m.forma_farmaceutica = AM.forma_farmaceutica
  AND m.concentracion_del_medicamento = AM.concentracion_del_medicamento
  AND m.unidad_de_medida_del_medicamento = AM.unidad_de_medida_del_medicamento;


END;
$$ LANGUAGE plpgsql;