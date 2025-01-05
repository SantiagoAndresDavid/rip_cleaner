UPDATE AM
SET valor_unitario_del_medicamento =
        CASE
            WHEN valor_unitario_del_medicamento = '0.00' THEN '0' -- Convierte '0.00' en '0'
            ELSE REPLACE(valor_unitario_del_medicamento, '.00', '') -- Elimina solo el sufijo ".00"
            END
WHERE valor_unitario_del_medicamento LIKE '%.00'; -- Aplica solo a valores que terminan en ".00"

UPDATE AM
SET valor_total_del_medicamento =
        CASE
            WHEN valor_total_del_medicamento = '0.00' THEN '0' -- Convierte '0.00' en '0'
            ELSE REPLACE(valor_total_del_medicamento, '.00', '') -- Elimina solo el sufijo ".00"
            END
WHERE valor_total_del_medicamento LIKE '%.00'; -- Aplica solo a valores que terminan en ".00"