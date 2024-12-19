CREATE OR REPLACE FUNCTION actualizar_diagnostico_vacio()
    RETURNS TABLE(numero_de_identificacion_del_usuario_del_sistema TEXT,codigo_de_la_consulta TEXT) AS $$
BEGIN
    RETURN QUERY
        UPDATE ac
         SET CODIGO_DEL_DIAGNOSTICO_PRINCIPAL = 'R104'
        WHERE CODIGO_DEL_DIAGNOSTICO_PRINCIPAL IS NULL
        RETURNING ac.numero_de_identificacion_del_usuario_en_el_sistema,ac.codigo_de_la_consulta;
END;
$$ LANGUAGE plpgsql;