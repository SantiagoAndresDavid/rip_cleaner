CREATE OR REPLACE FUNCTION actualizar_finalidad_ap()
    RETURNS TABLE(numero_de_identificacion_del_usuario_del_sistema TEXT,finalidad TEXT) AS $$
BEGIN
    RETURN QUERY
UPDATE ap
SET finalidad_del_procedimiento = '1'
WHERE finalidad_del_procedimiento IS DISTINCT FROM '1'
    RETURNING ap.numero_de_identificacion_del_usuario_en_el_sistema,ap.finalidad_del_procedimiento;
END;
$$ LANGUAGE plpgsql;