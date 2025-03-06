CREATE OR REPLACE FUNCTION actualizar_tipo_diagnostico_principal()
    RETURNS TABLE(numero_de_identificacion_del_usuario_del_sistema TEXT,codigo_de_la_consulta TEXT) AS $$
BEGIN
    UPDATE AC
    SET TIPO_DE_DIAGNOSTICO_PRINCIPAL = '1'
    WHERE TIPO_DE_DIAGNOSTICO_PRINCIPAL = '0';
END;
$$ LANGUAGE plpgsql;