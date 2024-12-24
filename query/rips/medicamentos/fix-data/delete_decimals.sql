-- Actualizar valor_neto_a_pagar para convertir el formato 0.0
UPDATE medicamentos
SET tipo_de_medicamento =
        CASE
            WHEN tipo_de_medicamento = '0.0' THEN '0'
            ELSE REPLACE(tipo_de_medicamento, '.0', '')
            END
WHERE tipo_de_medicamento LIKE '%.0';
