CREATE OR REPLACE FUNCTION actualizar_acto_quirurgico()
    RETURNS TABLE(numero_de_identificacion_del_usuario_del_sistema TEXT,diagnostico_principal TEXT) AS $$
BEGIN
    RETURN QUERY
UPDATE ap
SET forma_de_realizacion_del_acto_quirurgico = '1'
WHERE ap.forma_de_realizacion_del_acto_quirurgico IS NULL
    RETURNING ap.numero_de_identificacion_del_usuario_en_el_sistema,ap.forma_de_realizacion_del_acto_quirurgico;
END;
$$ LANGUAGE plpgsql;