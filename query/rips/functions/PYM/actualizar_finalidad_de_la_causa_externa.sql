CREATE OR REPLACE FUNCTION actualizar_finalidad_de_la_causa_externa_consulta()
    RETURNS TABLE(numero_de_identificacion_del_usuario_del_sistema TEXT, codigo_de_la_consulta TEXT) AS $$
BEGIN
    RETURN QUERY
        UPDATE ac
            SET finalidad_de_la_causa_externa_consulta = CASE
               WHEN us.unidad_de_medida_en_la_edad = '1' THEN
                   CASE
                       WHEN CAST(us.edad AS INTEGER) BETWEEN 0 AND 10 THEN '04'
                       WHEN CAST(us.edad AS INTEGER) BETWEEN 12 AND 28 THEN '05'
                       WHEN CAST(us.edad AS INTEGER) >= 19 THEN '07'
                       END
               WHEN us.unidad_de_medida_en_la_edad = '2' AND CAST(us.edad AS INTEGER) BETWEEN 0 AND 12 THEN '04'
               WHEN us.unidad_de_medida_en_la_edad = '3' AND CAST(us.edad AS INTEGER) BETWEEN 0 AND 31 THEN '04'
                END
            FROM us
            WHERE ac.numero_de_identificacion_del_usuario_en_el_sistema = us.numero_de_identificacion_del_usuario_del_sistema
                AND ac.finalidad_de_la_causa_externa_consulta IS NULL or ac.finalidad_de_la_causa_externa_consulta = '10'
            RETURNING ac.numero_de_identificacion_del_usuario_en_el_sistema, ac.codigo_de_la_consulta;
END;
$$ LANGUAGE plpgsql;