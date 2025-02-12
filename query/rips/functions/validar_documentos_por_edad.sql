CREATE OR REPLACE FUNCTION validar_documentos_por_edad(ignore_list TEXT[] DEFAULT '{}')
    RETURNS TABLE (
                      tipo_identificacion TEXT,
                      numero_identificacion TEXT,
                      edad TEXT,
                      unidad_medida_edad TEXT,
                      primer_nombre TEXT,
                      segundo_nombre TEXT,
                      primer_apellido TEXT,
                      segundo_apellido TEXT
                  ) AS $$
BEGIN
    RETURN QUERY
        SELECT
            u.TIPO_DE_IDENTIFICACION_DEL_USUARIO,
            u.NUMERO_DE_IDENTIFICACION_DEL_USUARIO_DEL_SISTEMA,
            u.EDAD,
            u.UNIDAD_DE_MEDIDA_EN_LA_EDAD,
            u.primer_nombre_del_usuario,
            u.segundo_nombre_del_usuario,
            u.primer_apellido_del_usuario,
            u.segundo_apellido_del_usuario
        FROM US u
        WHERE
          -- Convertir la edad a días para estandarizar
            CASE
                WHEN u.UNIDAD_DE_MEDIDA_EN_LA_EDAD = '1' THEN u.EDAD::INTEGER * 365  -- Años a días
                WHEN u.UNIDAD_DE_MEDIDA_EN_LA_EDAD = '2' THEN u.EDAD::INTEGER * 30   -- Meses a días
                WHEN u.UNIDAD_DE_MEDIDA_EN_LA_EDAD = '3' THEN u.EDAD::INTEGER        -- Días
                END < 18 * 365  -- Solo menores de 18 años (6570 días)
          AND (
            -- Caso 1: Menores de 3 meses (90 días)
            (
                CASE
                    WHEN u.UNIDAD_DE_MEDIDA_EN_LA_EDAD = '1' THEN u.EDAD::INTEGER * 365
                    WHEN u.UNIDAD_DE_MEDIDA_EN_LA_EDAD = '2' THEN u.EDAD::INTEGER * 30
                    ELSE u.EDAD::INTEGER
                    END < 90  -- 3 meses = 90 días
                    AND u.TIPO_DE_IDENTIFICACION_DEL_USUARIO != 'CN'
                )
                OR
                -- Caso 2: Entre 3 meses y 7 años (90 a 2555 días)
            (
                CASE
                    WHEN u.UNIDAD_DE_MEDIDA_EN_LA_EDAD = '1' THEN u.EDAD::INTEGER * 365
                    WHEN u.UNIDAD_DE_MEDIDA_EN_LA_EDAD = '2' THEN u.EDAD::INTEGER * 30
                    ELSE u.EDAD::INTEGER
                    END BETWEEN 90 AND 2555  -- Entre 3 meses y 7 años
                    AND u.TIPO_DE_IDENTIFICACION_DEL_USUARIO != 'RC'
                )
                OR
                -- Caso 3: Entre 7 y 17 años (2556 a 6570 días)
            (
                CASE
                    WHEN u.UNIDAD_DE_MEDIDA_EN_LA_EDAD = '1' THEN u.EDAD::INTEGER * 365
                    WHEN u.UNIDAD_DE_MEDIDA_EN_LA_EDAD = '2' THEN u.EDAD::INTEGER * 30
                    ELSE u.EDAD::INTEGER
                    END BETWEEN 2556 AND 6570  -- Entre 7 y 17 años
                    AND u.TIPO_DE_IDENTIFICACION_DEL_USUARIO != 'TI'
                )
                OR
                -- Caso 4: Mayores de 18 años (>= 6570 días)
            (
                CASE
                    WHEN u.UNIDAD_DE_MEDIDA_EN_LA_EDAD = '1' THEN u.EDAD::INTEGER * 365
                    WHEN u.UNIDAD_DE_MEDIDA_EN_LA_EDAD = '2' THEN u.EDAD::INTEGER * 30
                    ELSE u.EDAD::INTEGER
                    END >= 6570  -- 18 años o más
                    AND u.TIPO_DE_IDENTIFICACION_DEL_USUARIO != 'CC'
                )
            )
          -- Excluir los números de identificación en la lista ignore_list
          AND u.NUMERO_DE_IDENTIFICACION_DEL_USUARIO_DEL_SISTEMA NOT IN (SELECT UNNEST(ignore_list))
          -- Ignorar documentos con TIPO_DE_IDENTIFICACION_DEL_USUARIO = 'PT'
          AND u.TIPO_DE_IDENTIFICACION_DEL_USUARIO != 'PT';
END;
$$ LANGUAGE plpgsql;