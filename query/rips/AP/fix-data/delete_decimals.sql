UPDATE ap
SET valor_del_procedimiento =
        CASE
            WHEN valor_del_procedimiento = '0.00' THEN '0' -- Convierte '0.00' en '0'
            ELSE REPLACE(valor_del_procedimiento, '.00', '') -- Elimina solo el sufijo ".00"
            END
WHERE valor_del_procedimiento LIKE '%.00'; -- Aplica solo a valores que terminan en ".00"





