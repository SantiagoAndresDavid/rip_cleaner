CREATE OR REPLACE FUNCTION actualizar_codigo_departamento()
    RETURNS TABLE(numero_de_identificacion_del_usuario_del_sistema TEXT) AS $$
BEGIN
    RETURN QUERY
UPDATE us
SET CODIGO_DEL_DEPARTAMENTO_DE_RESIDENCIA_HABITUAL = '20'
WHERE CODIGO_DEL_DEPARTAMENTO_DE_RESIDENCIA_HABITUAL != '20'
    RETURNING us.numero_de_identificacion_del_usuario_del_sistema;
END;
$$ LANGUAGE plpgsql;