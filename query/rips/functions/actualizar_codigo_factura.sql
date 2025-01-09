CREATE OR REPLACE FUNCTION actualizar_codigo_factura(codigo_factura TEXT)
    RETURNS TABLE(NUMERO_DE_LA_FACTURA TEXT, NUMERO_DE_IDENTIFICACION TEXT) AS $$
BEGIN
    -- Actualizar los valores en la tabla 'ap' y devolver los resultados
    RETURN QUERY
UPDATE ap
SET NUMERO_DE_LA_FACTURA = 'FEHM' || codigo_factura::TEXT
            RETURNING ap.NUMERO_DE_LA_FACTURA, ap.numero_de_identificacion_del_usuario_en_el_sistema;

-- Actualizar los valores en la tabla 'ac' y devolver los resultados
RETURN QUERY
UPDATE ac
SET NUMERO_DE_LA_FACTURA = 'FEHM' || codigo_factura::TEXT
            RETURNING ac.NUMERO_DE_LA_FACTURA, ac.numero_de_identificacion_del_usuario_en_el_sistema;

RETURN QUERY
    UPDATE am
        SET NUMERO_DE_LA_FACTURA = 'FEHM' || codigo_factura::TEXT
        RETURNING am.NUMERO_DE_LA_FACTURA, am.numero_de_identificacion_del_usuario_en_el_sistema;

RETURN QUERY
    UPDATE at
        SET NUMERO_DE_LA_FACTURA = 'FEHM' || codigo_factura::TEXT
        RETURNING at.NUMERO_DE_LA_FACTURA, at.numero_de_identificacion_del_usuario_en_el_sistema;
END;
$$ LANGUAGE plpgsql;