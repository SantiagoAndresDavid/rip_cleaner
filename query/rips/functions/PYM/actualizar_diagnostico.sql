CREATE OR REPLACE FUNCTION modificar_diagnostico_unico(
    p_numero_de_identificacion_del_usuario TEXT, -- Número de identificación del usuario
    p_codigo_consulta TEXT,                     -- Código de la consulta
    p_finalidad TEXT,                           -- Finalidad de la consulta
    p_nuevo_diagnostico TEXT                    -- Nuevo diagnóstico a asignar
)
    RETURNS TABLE (
                      tipo_de_identificacion_del_usuario TEXT,
                      numero_de_identificacion_del_usuario_del_sistema TEXT,
                      edad TEXT,
                      unidad_de_medida_en_la_edad TEXT,
                      codigo_de_la_consulta TEXT,
                      finalidad TEXT,
                      diagnostico_anterior TEXT,
                      diagnostico_actual TEXT
                  ) AS $$
BEGIN
    RETURN QUERY
        WITH registro_actualizado AS (
            UPDATE AC
                SET
                    codigo_del_diagnostico_principal = p_nuevo_diagnostico
                FROM
                    US
                WHERE
                    AC.numero_de_identificacion_del_usuario_en_el_sistema = US.numero_de_identificacion_del_usuario_del_sistema
                        AND US.numero_de_identificacion_del_usuario_del_sistema = p_numero_de_identificacion_del_usuario
                        AND AC.codigo_de_la_consulta = p_codigo_consulta
                        AND AC.finalidad_de_la_causa_externa_consulta = p_finalidad
                RETURNING
                    US.tipo_de_identificacion_del_usuario AS tipo_de_identificacion_del_usuario,
                    US.numero_de_identificacion_del_usuario_del_sistema AS numero_de_identificacion_del_usuario_del_sistema,
                    US.edad AS edad,
                    US.unidad_de_medida_en_la_edad AS unidad_de_medida_en_la_edad,
                    AC.codigo_de_la_consulta AS codigo_de_la_consulta,
                    AC.finalidad_de_la_causa_externa_consulta AS finalidad,
                    AC.codigo_del_diagnostico_principal AS diagnostico_anterior,
                    p_nuevo_diagnostico AS diagnostico_actual
        )
        SELECT *
        FROM registro_actualizado;
END;
$$ LANGUAGE plpgsql;
