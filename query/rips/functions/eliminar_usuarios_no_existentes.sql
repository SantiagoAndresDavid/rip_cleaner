CREATE OR REPLACE FUNCTION eliminar_usuario_y_registros_relacionados(p_numero_identificacion TEXT)
RETURNS TABLE (
    tabla_ac INTEGER,
    tabla_ap INTEGER,
    tabla_at INTEGER,
    tabla_am INTEGER,
    tabla_us INTEGER
) AS $$
DECLARE
    v_ac_count INTEGER;
    v_ap_count INTEGER;
    v_at_count INTEGER;
    v_am_count INTEGER;
    v_us_count INTEGER;
BEGIN
    -- Delete and get count from dependent tables
    WITH deleted_ac AS (
        DELETE FROM AC 
        WHERE NUMERO_DE_IDENTIFICACION_DEL_USUARIO_EN_EL_SISTEMA = p_numero_identificacion
        RETURNING *
    )
    SELECT COUNT(*) INTO v_ac_count FROM deleted_ac;

    WITH deleted_ap AS (
        DELETE FROM AP 
        WHERE NUMERO_DE_IDENTIFICACION_DEL_USUARIO_EN_EL_SISTEMA = p_numero_identificacion
        RETURNING *
    )
    SELECT COUNT(*) INTO v_ap_count FROM deleted_ap;

    WITH deleted_at AS (
        DELETE FROM AT 
        WHERE NUMERO_DE_IDENTIFICACION_DEL_USUARIO_EN_EL_SISTEMA = p_numero_identificacion
        RETURNING *
    )
    SELECT COUNT(*) INTO v_at_count FROM deleted_at;

    WITH deleted_am AS (
        DELETE FROM AM 
        WHERE NUMERO_DE_IDENTIFICACION_DEL_USUARIO_EN_EL_SISTEMA = p_numero_identificacion
        RETURNING *
    )
    SELECT COUNT(*) INTO v_am_count FROM deleted_am;

    WITH deleted_us AS (
        DELETE FROM US 
        WHERE NUMERO_DE_IDENTIFICACION_DEL_USUARIO_DEL_SISTEMA = p_numero_identificacion
        RETURNING *
    )
    SELECT COUNT(*) INTO v_us_count FROM deleted_us;

    RETURN QUERY SELECT v_ac_count, v_ap_count, v_at_count, v_am_count, v_us_count;
END;
$$ LANGUAGE plpgsql;