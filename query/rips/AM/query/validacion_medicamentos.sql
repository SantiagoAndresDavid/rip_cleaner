UPDATE AM
SET nombre_generico_del_medicamento = (
    SELECT m.nombre_generico_del_medicamento
    FROM medicamentos m
    WHERE m.codigo_del_medicamento = AM.codigo_del_medicamento
)
WHERE EXISTS (
    SELECT 1
    FROM medicamentos m
    WHERE m.codigo_del_medicamento = AM.codigo_del_medicamento
);


SELECT codigo_del_medicamento, COUNT(*)
FROM medicamentos
GROUP BY codigo_del_medicamento
HAVING COUNT(*) > 1;


SELECT nombre_generico_del_medicamento, COUNT(*)
FROM medicamentos
GROUP BY nombre_generico_del_medicamento
HAVING COUNT(*) > 1;

