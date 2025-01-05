CREATE OR REPLACE FUNCTION actualizar_diagnostico_vacio()
    RETURNS TABLE(numero_de_identificacion_del_usuario_del_sistema TEXT, codigo_de_la_consulta TEXT) AS $$
BEGIN
    RETURN QUERY
        UPDATE ac
        SET CODIGO_DEL_DIAGNOSTICO_PRINCIPAL = CASE
            WHEN us.unidad_de_medida_en_la_edad = '1' THEN
                CASE
                    WHEN CAST(us.edad AS INTEGER) BETWEEN 0 AND 5 THEN 'Z001'
                    WHEN CAST(us.edad AS INTEGER) BETWEEN 6 AND 11 THEN 'Z002'
                    WHEN CAST(us.edad AS INTEGER) BETWEEN 12 AND 17 THEN 'Z003'
                    WHEN CAST(us.edad AS INTEGER) >= 18 THEN 'Z333'
                END
            WHEN us.unidad_de_medida_en_la_edad = '2' AND CAST(us.edad AS INTEGER) BETWEEN 0 AND 12 THEN 'Z001'
            WHEN us.unidad_de_medida_en_la_edad = '3' AND CAST(us.edad AS INTEGER) BETWEEN 0 AND 31 THEN 'Z001'
        END
        FROM us
        WHERE ac.numero_de_identificacion_del_usuario_en_el_sistema = us.numero_de_identificacion_del_usuario_del_sistema
          AND ac.CODIGO_DEL_DIAGNOSTICO_PRINCIPAL IS NULL
        RETURNING ac.numero_de_identificacion_del_usuario_en_el_sistema, ac.codigo_de_la_consulta;
END;
$$ LANGUAGE plpgsql;