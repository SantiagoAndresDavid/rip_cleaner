UPDATE AT
SET valor_unitario_material =
        CASE
            WHEN valor_unitario_material = '0.00' THEN '0' -- Convierte '0.00' en '0'
            ELSE REPLACE(valor_unitario_material, '.00', '') -- Elimina solo el sufijo ".00"
            END
WHERE valor_unitario_material LIKE '%.00'; -- Aplica solo a valores que terminan en ".00"

UPDATE AT
SET valor_total_material =
        CASE
            WHEN valor_total_material = '0.00' THEN '0' -- Convierte '0.00' en '0'
            ELSE REPLACE(valor_total_material, '.00', '') -- Elimina solo el sufijo ".00"
            END
WHERE valor_total_material LIKE '%.00'; -- Aplica solo a valores que terminan en ".00"