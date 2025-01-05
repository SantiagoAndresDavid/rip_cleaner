CREATE OR REPLACE FUNCTION actualizar_codigo_municipio()
    RETURNS TABLE(numero_de_identificacion_del_usuario_del_sistema TEXT) AS $$
BEGIN
    RETURN QUERY
UPDATE us
SET CODIGO_DEL_MUNICIPIO_DE_RESIDENCIA_HABITUAL = '621'
WHERE CODIGO_DEL_MUNICIPIO_DE_RESIDENCIA_HABITUAL != '621'
    RETURNING us.numero_de_identificacion_del_usuario_del_sistema;
END;
$$ LANGUAGE plpgsql;