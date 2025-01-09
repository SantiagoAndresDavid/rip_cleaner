CREATE OR REPLACE FUNCTION eliminar_duplicados_ac()
    RETURNS TABLE (
                      usuario_id TEXT,
                      consulta_fecha TEXT,
                      consulta_codigo TEXT,
                      consulta_finalidad TEXT
                  ) AS $$
BEGIN
    -- Eliminar los duplicados y devolver los registros eliminados
    RETURN QUERY
        WITH CTE AS (
            SELECT
                ac.NUMERO_DE_IDENTIFICACION_DEL_USUARIO_EN_EL_SISTEMA AS usuario_id,
                ac.FECHA_DE_LA_CONSULTA AS consulta_fecha,
                ac.CODIGO_DE_LA_CONSULTA AS consulta_codigo,
                ac.FINALIDAD_DE_LA_CAUSA_EXTERNA_CONSULTA AS consulta_finalidad,
                ROW_NUMBER() OVER (
                    PARTITION BY
                        ac.NUMERO_DE_IDENTIFICACION_DEL_USUARIO_EN_EL_SISTEMA,
                        ac.FECHA_DE_LA_CONSULTA,
                        ac.CODIGO_DE_LA_CONSULTA,
                        ac.FINALIDAD_DE_LA_CAUSA_EXTERNA_CONSULTA
                    ORDER BY
                        ac.NUMERO_DE_IDENTIFICACION_DEL_USUARIO_EN_EL_SISTEMA -- Ajustar el criterio de orden si es necesario
                    ) AS fila,
                ac.NUMERO_DE_IDENTIFICACION_DEL_USUARIO_EN_EL_SISTEMA
            FROM AC ac
            )
            -- Aquí vamos a eliminar solo los registros duplicados
            DELETE FROM AC
                WHERE NUMERO_DE_IDENTIFICACION_DEL_USUARIO_EN_EL_SISTEMA IN (
                    SELECT cte.NUMERO_DE_IDENTIFICACION_DEL_USUARIO_EN_EL_SISTEMA
                    FROM CTE cte
                    WHERE cte.fila > 1
                )
                -- Después de eliminar, devolvemos los registros eliminados
                RETURNING
                    NUMERO_DE_IDENTIFICACION_DEL_USUARIO_EN_EL_SISTEMA AS usuario_id,
                    FECHA_DE_LA_CONSULTA AS consulta_fecha,
                    CODIGO_DE_LA_CONSULTA AS consulta_codigo,
                    FINALIDAD_DE_LA_CAUSA_EXTERNA_CONSULTA AS consulta_finalidad;
END;
$$ LANGUAGE plpgsql;
