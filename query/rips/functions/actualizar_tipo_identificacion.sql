CREATE OR REPLACE FUNCTION actualizar_tipo_identificacion()
    RETURNS TABLE(
                     tabla_origen TEXT,
                     numero_de_identificacion TEXT
                 ) AS $$
BEGIN
    -- Actualizar en la tabla us y devolver resultados
    RETURN QUERY
        UPDATE us
            SET tipo_de_identificacion_del_usuario = 'PT'
            WHERE tipo_de_identificacion_del_usuario IN ('CE', 'NU','PA')
                AND tipo_de_identificacion_del_usuario != 'PT'
            RETURNING 'us' AS tabla_origen, numero_de_identificacion_del_usuario_del_sistema;

    -- Actualizar en la tabla ac y devolver resultados
    RETURN QUERY
        UPDATE ac
            SET tipo_de_identificacion_del_usuario = (
                SELECT tipo_de_identificacion_del_usuario
                FROM us
                WHERE us.numero_de_identificacion_del_usuario_del_sistema = ac.numero_de_identificacion_del_usuario_en_el_sistema
            )
            WHERE EXISTS (
                SELECT 1
                FROM us
                WHERE us.numero_de_identificacion_del_usuario_del_sistema = ac.numero_de_identificacion_del_usuario_en_el_sistema
                  AND ac.tipo_de_identificacion_del_usuario != us.tipo_de_identificacion_del_usuario
            )
            RETURNING 'ac' AS tabla_origen, numero_de_identificacion_del_usuario_en_el_sistema;

    -- Actualizar en la tabla am y devolver resultados
    RETURN QUERY
        UPDATE am
            SET tipo_de_identificacion_del_usuario = (
                SELECT tipo_de_identificacion_del_usuario
                FROM us
                WHERE us.numero_de_identificacion_del_usuario_del_sistema = am.numero_de_identificacion_del_usuario_en_el_sistema
            )
            WHERE EXISTS (
                SELECT 1
                FROM us
                WHERE us.numero_de_identificacion_del_usuario_del_sistema = am.numero_de_identificacion_del_usuario_en_el_sistema
                  AND am.tipo_de_identificacion_del_usuario != us.tipo_de_identificacion_del_usuario
            )
            RETURNING 'am' AS tabla_origen, numero_de_identificacion_del_usuario_en_el_sistema;

    -- Actualizar en la tabla ap y devolver resultados
    RETURN QUERY
        UPDATE ap
            SET tipo_de_identificacion_del_usuario = (
                SELECT tipo_de_identificacion_del_usuario
                FROM us
                WHERE us.numero_de_identificacion_del_usuario_del_sistema = ap.numero_de_identificacion_del_usuario_en_el_sistema
            )
            WHERE EXISTS (
                SELECT 1
                FROM us
                WHERE us.numero_de_identificacion_del_usuario_del_sistema = ap.numero_de_identificacion_del_usuario_en_el_sistema
                  AND ap.tipo_de_identificacion_del_usuario != us.tipo_de_identificacion_del_usuario
            )
            RETURNING 'ap' AS tabla_origen, numero_de_identificacion_del_usuario_en_el_sistema;

    RETURN QUERY
        UPDATE at
            SET tipo_de_identificacion_del_usuario = (
                SELECT tipo_de_identificacion_del_usuario
                FROM us
                WHERE us.numero_de_identificacion_del_usuario_del_sistema = at.numero_de_identificacion_del_usuario_en_el_sistema
            )
            WHERE EXISTS (
                SELECT 1
                FROM us
                WHERE us.numero_de_identificacion_del_usuario_del_sistema = at.numero_de_identificacion_del_usuario_en_el_sistema
                  AND at.tipo_de_identificacion_del_usuario != us.tipo_de_identificacion_del_usuario
            )
            RETURNING 'at' AS tabla_origen, numero_de_identificacion_del_usuario_en_el_sistema;

END;
$$ LANGUAGE plpgsql;
