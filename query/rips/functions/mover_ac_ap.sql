CREATE OR REPLACE FUNCTION find_non_890_procedures_with_ap()
    RETURNS TABLE (
                      numero_factura TEXT,
                      codigo_prestador TEXT,
                      tipo_identificacion_usuario TEXT,
                      numero_identificacion_usuario TEXT,
                      fecha_procedimiento TEXT,
                      numero_autorizacion TEXT,
                      codigo_procedimiento TEXT,
                      ambito_realizacion_procedimiento TEXT,
                      finalidad_procedimiento TEXT,
                      personal_que_atiende TEXT,
                      diagnostico_principal TEXT,
                      diagnostico_relacionado TEXT,
                      complicacion TEXT,
                      forma_realizacion_acto_quirurgico TEXT,
                      valor_procedimiento TEXT
                  ) AS $$
BEGIN
    RETURN QUERY
        SELECT
            ac.NUMERO_DE_LA_FACTURA,
            ac.CODIGO_DEL_PRESTADOR_DE_SERVICIOS_DE_SALUD,
            ac.TIPO_DE_IDENTIFICACION_DEL_USUARIO,
            ac.NUMERO_DE_IDENTIFICACION_DEL_USUARIO_EN_EL_SISTEMA,
            ac.FECHA_DE_LA_CONSULTA,
            ac.NUMERO_DE_AUTORIZACION,
            ac.CODIGO_DE_LA_CONSULTA,
            NULL::TEXT AS AMBITO_DE_REALIZACION_DEL_PROCEDIMIENTO,
            NULL::TEXT AS FINALIDAD_DEL_PROCEDIMIENTO,
            NULL::TEXT AS PERSONAL_QUE_ATIENDE,
            ac.CODIGO_DEL_DIAGNOSTICO_PRINCIPAL,
            ac.CODIGO_DEL_DIAGNOSTICO_RELACIONADO_NO_1,
            NULL::TEXT AS COMPLICACION,
            NULL::TEXT AS FORMA_DE_REALIZACION_DEL_ACTO_QUIRURGICO,
            ac.VALOR_DE_LA_CONSULTA
        FROM AC ac
        WHERE ac.CODIGO_DE_LA_CONSULTA NOT LIKE '890%';
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION move_non_890_procedures_to_ap()
    RETURNS VOID AS $$
BEGIN
    -- Insertar datos en la tabla AP
    INSERT INTO AP (
        NUMERO_DE_LA_FACTURA,
        CODIGO_DEL_PRESTADOR_DE_SERVICIOS_DE_SALUD,
        TIPO_DE_IDENTIFICACION_DEL_USUARIO,
        NUMERO_DE_IDENTIFICACION_DEL_USUARIO_EN_EL_SISTEMA,
        FECHA_DEL_PROCEDIMIENTO,
        NUMERO_DE_AUTORIZACION,
        CODIGO_DEL_PROCEDIMIENTO,
        AMBITO_DE_REALIZACION_DEL_PROCEDIMIENTO,
        FINALIDAD_DEL_PROCEDIMIENTO,
        PERSONAL_QUE_ATIENDE,
        DIAGNOSTICO_PRINCIPAL,
        DIAGNOSTICO_RELACIONADO,
        COMPLICACION,
        FORMA_DE_REALIZACION_DEL_ACTO_QUIRURGICO,
        VALOR_DEL_PROCEDIMIENTO
    )
    SELECT
        ac.NUMERO_DE_LA_FACTURA,
        ac.CODIGO_DEL_PRESTADOR_DE_SERVICIOS_DE_SALUD,
        ac.TIPO_DE_IDENTIFICACION_DEL_USUARIO,
        ac.NUMERO_DE_IDENTIFICACION_DEL_USUARIO_EN_EL_SISTEMA,
        ac.FECHA_DE_LA_CONSULTA, -- Asignando como FECHA_DEL_PROCEDIMIENTO
        ac.NUMERO_DE_AUTORIZACION,
        ac.CODIGO_DE_LA_CONSULTA, -- Asignando como CODIGO_DEL_PROCEDIMIENTO
        NULL::TEXT AS AMBITO_DE_REALIZACION_DEL_PROCEDIMIENTO,
        NULL::TEXT AS FINALIDAD_DEL_PROCEDIMIENTO,
        NULL::TEXT AS PERSONAL_QUE_ATIENDE,
        ac.CODIGO_DEL_DIAGNOSTICO_PRINCIPAL,
        ac.CODIGO_DEL_DIAGNOSTICO_RELACIONADO_NO_1,
        NULL::TEXT AS COMPLICACION,
        NULL::TEXT AS FORMA_DE_REALIZACION_DEL_ACTO_QUIRURGICO,
        ac.VALOR_DE_LA_CONSULTA -- Asignando como VALOR_DEL_PROCEDIMIENTO
    FROM AC ac
    WHERE ac.CODIGO_DE_LA_CONSULTA NOT LIKE '890%';

    -- Eliminar los datos de la tabla AC
    DELETE FROM AC
    WHERE CODIGO_DE_LA_CONSULTA NOT LIKE '890%';
END;
$$ LANGUAGE plpgsql;
