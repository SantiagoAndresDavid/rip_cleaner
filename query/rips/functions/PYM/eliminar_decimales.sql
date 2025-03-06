CREATE OR REPLACE FUNCTION eliminar_decimales()
RETURNS text AS $$
BEGIN
-- Actualizaciones para la tabla ac
UPDATE ac
SET valor_de_la_consulta =
        CASE
            WHEN valor_de_la_consulta = '0.00' THEN '0'
            ELSE REPLACE(valor_de_la_consulta, '.00', '')
            END
WHERE valor_de_la_consulta LIKE '%.00';

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

-- Actualizaciones para la tabla AM
UPDATE AM
SET valor_unitario_del_medicamento =
        CASE
            WHEN valor_unitario_del_medicamento = '0.00' THEN '0'
            ELSE REPLACE(valor_unitario_del_medicamento, '.00', '')
            END
WHERE valor_unitario_del_medicamento LIKE '%.00';

UPDATE AM
SET valor_total_del_medicamento =
        CASE
            WHEN valor_total_del_medicamento = '0.00' THEN '0'
            ELSE REPLACE(valor_total_del_medicamento, '.00', '')
            END
WHERE valor_total_del_medicamento LIKE '%.00';

-- Actualizaciones para la tabla ap (duplicada según código original)
UPDATE ap
SET valor_del_procedimiento =
        CASE
            WHEN valor_del_procedimiento = '0.00' THEN '0'
            ELSE REPLACE(valor_del_procedimiento, '.00', '')
            END
WHERE valor_del_procedimiento LIKE '%.00';

-- Actualizaciones para la tabla AT
UPDATE AT
SET valor_unitario_material =
        CASE
            WHEN valor_unitario_material = '0.00' THEN '0'
            ELSE REPLACE(valor_unitario_material, '.00', '')
            END
WHERE valor_unitario_material LIKE '%.00';

UPDATE AT
SET valor_total_material =
        CASE
            WHEN valor_total_material = '0.00' THEN '0'
            ELSE REPLACE(valor_total_material, '.00', '')
            END
WHERE valor_total_material LIKE '%.00';
    RETURN '✅ FUNCION REALIZADA CON EXITO';
END;
$$ LANGUAGE plpgsql;