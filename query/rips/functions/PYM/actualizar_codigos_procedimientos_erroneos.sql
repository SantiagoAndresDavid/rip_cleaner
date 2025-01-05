CREATE OR REPLACE FUNCTION actualizar_codigos_procedimientos_erroneos()
RETURNS TABLE (old_codigo TEXT, new_codigo TEXT) AS $$
BEGIN
    -- Actualizar el código de procedimiento 997102 a 997107
    RETURN QUERY
    UPDATE AP
    SET CODIGO_DEL_PROCEDIMIENTO = '997107'
    WHERE CODIGO_DEL_PROCEDIMIENTO = '997102'
    RETURNING '997102' AS old_codigo, '997107' AS new_codigo;

    -- Actualizar el código de procedimiento 997310 a 997002
    RETURN QUERY
    UPDATE AP
    SET CODIGO_DEL_PROCEDIMIENTO = '997002'
    WHERE CODIGO_DEL_PROCEDIMIENTO = '997310'
    RETURNING '997310' AS old_codigo, '997002' AS new_codigo;
END;
$$ LANGUAGE plpgsql;