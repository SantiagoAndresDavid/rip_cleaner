CREATE OR REPLACE FUNCTION actualizar_causa_externa_null()
    RETURNS TABLE(numero_de_identificacion_del_usuario_del_sistema TEXT, codigo_de_la_consulta TEXT) AS $$
BEGIN
    RETURN QUERY
        UPDATE AC
            SET CAUSA_EXTERNA = '13'
            WHERE CAUSA_EXTERNA IS NULL
            RETURNING ac.numero_de_identificacion_del_usuario_en_el_sistema, ac.codigo_de_la_consulta;
END;
$$ LANGUAGE plpgsql;