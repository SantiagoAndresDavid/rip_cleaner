CREATE OR REPLACE FUNCTION actualizar_causa_externa()
    RETURNS TABLE(numero_de_identificacion_del_usuario_del_sistema TEXT, codigo_de_la_consulta TEXT) AS $$
BEGIN
    RETURN QUERY
        UPDATE AC
        SET CAUSA_EXTERNA = CASE
            WHEN CAUSA_EXTERNA IS NULL THEN
                CASE
                    WHEN US.edad::INTEGER BETWEEN 0 AND 10 THEN '04'
                    WHEN US.edad::INTEGER BETWEEN 12 AND 28 THEN '05'
                    WHEN US.edad::INTEGER >= 29 THEN '07'
                    ELSE CAUSA_EXTERNA
                END
            WHEN CAUSA_EXTERNA = '13' THEN '15'
            ELSE CAUSA_EXTERNA
        END
        FROM US
        WHERE AC.numero_de_identificacion_del_usuario_en_el_sistema = US.numero_de_identificacion_del_usuario_del_sistema
        RETURNING AC.numero_de_identificacion_del_usuario_en_el_sistema, AC.codigo_de_la_consulta;
END;
$$ LANGUAGE plpgsql;