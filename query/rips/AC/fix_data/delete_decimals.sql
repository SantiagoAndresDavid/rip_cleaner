UPDATE ac
SET valor_de_la_consulta =
        CASE
            WHEN valor_de_la_consulta = '0.00' THEN '0' -- Convierte '0.00' en '0'
            ELSE REPLACE(valor_de_la_consulta, '.00', '') -- Elimina solo el sufijo ".00"
            END
WHERE valor_de_la_consulta LIKE '%.00'; -- Aplica solo a valores que terminan en ".00"

UPDATE ac
SET valor_de_la_cuota_moderadora =
        CASE
            WHEN valor_de_la_cuota_moderadora = '0.00' THEN '0'
            ELSE REPLACE(valor_de_la_cuota_moderadora, '.00', '')
            END
WHERE valor_de_la_cuota_moderadora LIKE '%.00';

UPDATE ac
SET valor_neto_a_pagar =
        CASE
            WHEN valor_neto_a_pagar = '0.00' THEN '0'
            ELSE REPLACE(valor_neto_a_pagar, '.00', '')
            END
WHERE valor_neto_a_pagar LIKE '%.00';




