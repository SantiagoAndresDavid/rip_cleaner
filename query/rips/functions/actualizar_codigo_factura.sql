CREATE OR REPLACE FUNCTION actualizar_codigo_factura(codigo_factura INTEGER)
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
END;
$$ LANGUAGE plpgsql;