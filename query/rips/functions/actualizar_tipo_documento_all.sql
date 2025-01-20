CREATE OR REPLACE FUNCTION actualizar_tipo_documento_all(
    p_numero_documento TEXT,
    p_nuevo_tipo_documento TEXT
) RETURNS TABLE(tabla_modificada TEXT, columna_modificada TEXT) AS $$
BEGIN
    -- Update AC table
        UPDATE AC
        SET TIPO_DE_IDENTIFICACION_DEL_USUARIO = p_nuevo_tipo_documento
        WHERE NUMERO_DE_IDENTIFICACION_DEL_USUARIO_EN_EL_SISTEMA = p_numero_documento;
        IF FOUND THEN
            RETURN QUERY SELECT 'AC', 'TIPO_DE_IDENTIFICACION_DEL_USUARIO';
        END IF;

        -- Update AP table
        UPDATE AP
        SET TIPO_DE_IDENTIFICACION_DEL_USUARIO = p_nuevo_tipo_documento
        WHERE NUMERO_DE_IDENTIFICACION_DEL_USUARIO_EN_EL_SISTEMA = p_numero_documento;
        IF FOUND THEN
            RETURN QUERY SELECT 'AP', 'TIPO_DE_IDENTIFICACION_DEL_USUARIO';
        END IF;

        -- Update AM table
        UPDATE AM
        SET TIPO_DE_IDENTIFICACION_DEL_USUARIO = p_nuevo_tipo_documento
        WHERE NUMERO_DE_IDENTIFICACION_DEL_USUARIO_EN_EL_SISTEMA = p_numero_documento;
        IF FOUND THEN
            RETURN QUERY SELECT 'AM', 'TIPO_DE_IDENTIFICACION_DEL_USUARIO';
        END IF;

        -- Update US table
        UPDATE US
        SET TIPO_DE_IDENTIFICACION_DEL_USUARIO = p_nuevo_tipo_documento
        WHERE NUMERO_DE_IDENTIFICACION_DEL_USUARIO_DEL_SISTEMA = p_numero_documento;
        IF FOUND THEN
            RETURN QUERY SELECT 'US', 'TIPO_DE_IDENTIFICACION_DEL_USUARIO';
        END IF;

        -- Update AT table if it exists
        UPDATE AT
        SET TIPO_DE_IDENTIFICACION_DEL_USUARIO = p_nuevo_tipo_documento
        WHERE NUMERO_DE_IDENTIFICACION_DEL_USUARIO_EN_EL_SISTEMA = p_numero_documento;
        IF FOUND THEN
            RETURN QUERY SELECT 'AT', 'TIPO_DE_IDENTIFICACION_DEL_USUARIO';
        END IF;

END;
$$ LANGUAGE plpgsql;
