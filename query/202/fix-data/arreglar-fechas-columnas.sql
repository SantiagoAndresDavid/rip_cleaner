SELECT fecha_del_peso,
       CASE
           WHEN fecha_del_peso ~ '^\d{2}/\d{2}/\d{4}$' AND CAST(SUBSTRING(fecha_del_peso FROM 4 FOR 2) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_del_peso, 'DD/MM/YYYY'), 'YYYY-MM-DD')
           WHEN fecha_del_peso ~ '^\d{2}/\d{2}/\d{4}$' AND CAST(SUBSTRING(fecha_del_peso FROM 1 FOR 2) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_del_peso, 'MM/DD/YYYY'), 'YYYY-MM-DD')
           ELSE fecha_del_peso
           END AS fecha_convertida
FROM resolucion_manual
WHERE fecha_del_peso ~ '^\d{2}/\d{2}/\d{4}$';



UPDATE resolucion_manual
SET fecha_del_peso = CASE
                         WHEN fecha_del_peso ~ '^\d{2}/\d{2}/\d{4}$' AND CAST(SUBSTRING(fecha_del_peso FROM 4 FOR 2) AS INTEGER) <= 12
                             THEN TO_CHAR(TO_DATE(fecha_del_peso, 'DD/MM/YYYY'), 'YYYY-MM-DD')
                         WHEN fecha_del_peso ~ '^\d{2}/\d{2}/\d{4}$' AND CAST(SUBSTRING(fecha_del_peso FROM 1 FOR 2) AS INTEGER) <= 12
                             THEN TO_CHAR(TO_DATE(fecha_del_peso, 'MM/DD/YYYY'), 'YYYY-MM-DD')
                         ELSE fecha_del_peso  -- Deja los valores que no coinciden con ninguno de los patrones
    END
WHERE fecha_del_peso ~ '^\d{2}/\d{2}/\d{4}$';


