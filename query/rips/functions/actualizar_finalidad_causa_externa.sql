CREATE OR REPLACE FUNCTION actualizar_finalidad_causa_externa()
    RETURNS TABLE(numero_de_identificacion_del_usuario_del_sistema TEXT,codigo_de_la_consulta TEXT) AS $$
BEGIN
    RETURN QUERY
        UPDATE ac
            SET finalidad_de_la_causa_externa_consulta = '10'
            RETURNING ac.numero_de_identificacion_del_usuario_en_el_sistema, ac.codigo_de_la_consulta;
END;
$$ LANGUAGE plpgsql;

