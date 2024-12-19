CREATE OR REPLACE FUNCTION actualizar_finalidades(
    codigo_consulta TEXT,
    edades_usuario TEXT[],           -- Lista de edades
    unidad_edad TEXT,                -- Única unidad de edad
    diagnosticos_principales TEXT[], -- Lista de diagnósticos principales
    nueva_finalidad TEXT             -- Nueva finalidad a asignar
)
    RETURNS TABLE (
                      tipo_de_identificacion_del_usuario TEXT,
                      numero_de_identificacion_del_usuario_del_sistema TEXT,
                      edad TEXT,
                      unidad_de_medida_en_la_edad TEXT,
                      codigo_de_la_consulta TEXT,
                      finalidad_anterior TEXT,
                      finalidad_actual TEXT
                  ) AS $$
BEGIN
    RETURN QUERY
        WITH filas_actualizadas AS (
            UPDATE AC
                SET
                    finalidad_de_la_causa_externa_consulta = nueva_finalidad
                FROM
                    US
                WHERE
                    AC.numero_de_identificacion_del_usuario_en_el_sistema = US.numero_de_identificacion_del_usuario_del_sistema
                        AND AC.codigo_de_la_consulta = codigo_consulta
                        AND US.edad = ANY(edades_usuario)
                        AND US.unidad_de_medida_en_la_edad = unidad_edad
                        AND AC.codigo_del_diagnostico_principal = ANY(diagnosticos_principales)
                RETURNING
                    US.tipo_de_identificacion_del_usuario AS tipo_de_identificacion_del_usuario,
                    US.numero_de_identificacion_del_usuario_del_sistema AS numero_de_identificacion_del_usuario_del_sistema,
                    US.edad AS edad,
                    US.unidad_de_medida_en_la_edad AS unidad_de_medida_en_la_edad,
                    AC.codigo_de_la_consulta AS codigo_de_la_consulta,
                    AC.finalidad_de_la_causa_externa_consulta AS finalidad_anterior,
                    nueva_finalidad AS finalidad_actual
        )
        SELECT *
        FROM filas_actualizadas;
END;
$$ LANGUAGE plpgsql;
