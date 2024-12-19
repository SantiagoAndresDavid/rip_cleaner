CREATE OR REPLACE FUNCTION buscar_usuarios_por_filtros(
    codigo_consulta TEXT,
    edad_usuario TEXT,
    unidad_edad TEXT,
    finalidad TEXT,
    codigo_del_diagnostico_principal TEXT
)
RETURNS TABLE (
    tipo_de_identificacion_del_usuario TEXT,
    numero_de_identificacion_del_usuario_del_sistema TEXT,
    edad TEXT,
    unidad_de_medida_en_la_edad TEXT,
    codigo_de_la_consulta TEXT,
    finalidad_de_la_causa_externa_consulta TEXT,
    codigo_del_diagnostico_principal TEXT
) AS $$
BEGIN
    RETURN QUERY
SELECT
    us.tipo_de_identificacion_del_usuario,
    us.numero_de_identificacion_del_usuario_del_sistema,
    us.edad,
    us.unidad_de_medida_en_la_edad,
    ac.codigo_de_la_consulta,
    ac.finalidad_de_la_causa_externa_consulta,
    ac.codigo_del_diagnostico_principal
FROM
    AC ac
        INNER JOIN
    US us
    ON
        ac.numero_de_identificacion_del_usuario_en_el_sistema = us.numero_de_identificacion_del_usuario_del_sistema
WHERE
    ac.codigo_de_la_consulta = codigo_consulta
  AND us.edad = edad_usuario
  AND us.unidad_de_medida_en_la_edad = unidad_edad
  AND ac.finalidad_de_la_causa_externa_consulta = finalidad;
END;
$$ LANGUAGE plpgsql;
