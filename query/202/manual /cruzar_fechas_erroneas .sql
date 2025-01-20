CREATE OR REPLACE FUNCTION actualizar_fechas_erroneas()
    RETURNS TABLE(
        numero_de_identificacion_del_usuario VARCHAR(255),
        columna VARCHAR(255),
        valor_anterior VARCHAR(255),
        valor_nuevo VARCHAR(255)
    )
    LANGUAGE plpgsql
AS
$$
DECLARE
    col_name TEXT;
    update_query TEXT;
BEGIN
    FOR col_name IN
        SELECT column_name
        FROM information_schema.columns
        WHERE table_name = 'resolucion_manual'
          AND column_name ILIKE 'Fecha%'
    LOOP
        RETURN QUERY EXECUTE FORMAT(
            'UPDATE resolucion_automatica ra
             SET %I = rm.%I
             FROM resolucion_manual rm
             WHERE ra.Numero_de_identificacion_del_usuario = rm.Numero_de_identificacion_del_usuario
             AND ra.%I IN (''1800-01-01'', ''1845-01-01'')
             AND rm.%I NOT IN (''1800-01-01'', ''1845-01-01'')
             RETURNING 
                ra.Numero_de_identificacion_del_usuario::VARCHAR(255),
                %L::VARCHAR(255),
                ra.%I::VARCHAR(255) AS valor_anterior,
                rm.%I::VARCHAR(255) AS valor_nuevo',
            col_name, col_name, col_name, col_name, col_name, col_name, col_name
        );
    END LOOP;
END;
$$;