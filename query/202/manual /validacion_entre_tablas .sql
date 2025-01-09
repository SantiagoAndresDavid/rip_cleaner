CREATE OR REPLACE FUNCTION comparar_fechas()
    RETURNS TABLE(
                     Numero_de_identificacion_del_usuario VARCHAR(255),
                     columna VARCHAR(255),
                     valor_manual VARCHAR(255),
                     valor_automatica VARCHAR(255)
                 ) AS $$
DECLARE
    col_name TEXT;
    query TEXT;
BEGIN
    FOR col_name IN
        SELECT column_name
        FROM information_schema.columns
        WHERE table_name = 'resolucion_manual'
          AND column_name ILIKE 'Fecha%'
        LOOP
            query := FORMAT(
                    'SELECT rm.Numero_de_identificacion_del_usuario::VARCHAR(255), ''%s''::VARCHAR(255) AS columna,
                            rm.%s::VARCHAR(255) AS valor_manual, ra.%s::VARCHAR(255) AS valor_automatica
                     FROM resolucion_manual rm
                     JOIN resolucion_automatica ra ON rm.Numero_de_identificacion_del_usuario = ra.Numero_de_identificacion_del_usuario
                     WHERE rm.%s IS DISTINCT FROM ra.%s',
                    col_name, col_name, col_name, col_name, col_name
                     );
            RETURN QUERY EXECUTE query;
        END LOOP;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_fechas_condicional()
    RETURNS VOID AS $$
DECLARE
    col_name TEXT;
    query TEXT;
BEGIN
    FOR col_name IN
        SELECT column_name
        FROM information_schema.columns
        WHERE table_name = 'resolucion_manual'
          AND column_name ILIKE 'Fecha%'
        LOOP
            query := FORMAT(
                    'UPDATE resolucion_automatica ra
                     SET %s = rm.%s
                     FROM resolucion_manual rm
                     WHERE ra.Numero_de_identificacion_del_usuario = rm.Numero_de_identificacion_del_usuario
                       AND ((ra.%s IN (''1800-01-01'', ''1845-01-01'') AND rm.%s NOT IN (''1800-01-01'', ''1845-01-01''))
                       OR (ra.%s IS DISTINCT FROM rm.%s AND rm.%s NOT IN (''1800-01-01'', ''1845-01-01'')))',
                    col_name, col_name, col_name, col_name, col_name, col_name, col_name
                     );
            EXECUTE query;
        END LOOP;
END;
$$ LANGUAGE plpgsql;
