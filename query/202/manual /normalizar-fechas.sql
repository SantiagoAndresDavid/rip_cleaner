CREATE OR REPLACE FUNCTION normalize_all_date_columns() 
RETURNS TABLE (column_name text, rows_updated bigint) AS $$
DECLARE
    col_name text;
    affected_rows bigint;
BEGIN
    CREATE TEMP TABLE IF NOT EXISTS temp_results (
        col text,
        rows bigint
    );

    FOR col_name IN 
        SELECT c.column_name 
        FROM information_schema.columns c
        WHERE c.table_name = 'resolucion_manual' 
        AND c.column_name LIKE 'fecha%'
    LOOP
        EXECUTE format('
            WITH updated AS (
                UPDATE resolucion_manual
                SET %I = CASE
                    WHEN %I ~ ''^\d{1,2}/\d{1,2}/\d{4}$'' AND 
                        CAST(SPLIT_PART(%I, ''/'', 2) AS INTEGER) <= 12
                        THEN TO_CHAR(TO_DATE(%I, ''DD/MM/YYYY''), ''YYYY-MM-DD'')
                    WHEN %I ~ ''^\d{1,2}/\d{1,2}/\d{4}$'' AND 
                        CAST(SPLIT_PART(%I, ''/'', 1) AS INTEGER) <= 12
                        THEN TO_CHAR(TO_DATE(%I, ''MM/DD/YYYY''), ''YYYY-MM-DD'')
                    ELSE %I
                END
                WHERE %I ~ ''^\d{1,2}/\d{1,2}/\d{4}$''
                RETURNING 1
            ) SELECT COUNT(*) FROM updated',
            col_name, col_name, col_name, col_name,
            col_name, col_name, col_name, col_name,
            col_name
        ) INTO affected_rows;

        INSERT INTO temp_results VALUES (col_name, affected_rows);
    END LOOP;

    RETURN QUERY SELECT * FROM temp_results;
    DROP TABLE temp_results;
END;
$$ LANGUAGE plpgsql;

-- Execute and show results
