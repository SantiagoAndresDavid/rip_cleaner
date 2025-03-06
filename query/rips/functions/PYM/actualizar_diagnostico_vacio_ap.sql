CREATE OR REPLACE FUNCTION actualizar_diagnostico_vacio_ap()
    RETURNS TABLE(numero_de_identificacion_del_usuario_del_sistema TEXT,diagnostico_principal TEXT) AS $$
BEGIN
    RETURN QUERY
UPDATE ap
SET diagnostico_principal = 'Z719'
WHERE ap.diagnostico_principal IS NULL
    RETURNING ap.numero_de_identificacion_del_usuario_en_el_sistema,ap.diagnostico_principal;
END;
$$ LANGUAGE plpgsql;