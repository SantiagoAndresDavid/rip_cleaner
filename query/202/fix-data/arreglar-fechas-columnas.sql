SELECT fecha_de_nacimiento,
       CASE
           WHEN fecha_de_nacimiento ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_nacimiento, '/', 2) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_de_nacimiento, 'DD/MM/YYYY'), 'YYYY-MM-DD')
           WHEN fecha_de_nacimiento ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_nacimiento, '/', 1) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_de_nacimiento, 'MM/DD/YYYY'), 'YYYY-MM-DD')
           ELSE fecha_de_nacimiento
           END AS fecha_convertida
FROM resolucion_manual
WHERE fecha_de_nacimiento ~ '^\d{1,2}/\d{1,2}/\d{4}$';


UPDATE resolucion_manual
SET fecha_de_nacimiento = CASE
                              WHEN fecha_de_nacimiento ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_nacimiento, '/', 2) AS INTEGER) <= 12
                                  THEN TO_CHAR(TO_DATE(fecha_de_nacimiento, 'DD/MM/YYYY'), 'YYYY-MM-DD')
                              WHEN fecha_de_nacimiento ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_nacimiento, '/', 1) AS INTEGER) <= 12
                                  THEN TO_CHAR(TO_DATE(fecha_de_nacimiento, 'MM/DD/YYYY'), 'YYYY-MM-DD')
                              ELSE fecha_de_nacimiento  -- Deja los valores que no coinciden con ninguno de los patrones
    END
WHERE fecha_de_nacimiento ~ '^\d{1,2}/\d{1,2}/\d{4}$';
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT fecha_del_peso,
       CASE
           WHEN fecha_del_peso ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_del_peso, '/', 2) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_del_peso, 'DD/MM/YYYY'), 'YYYY-MM-DD')
           WHEN fecha_del_peso ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_del_peso, '/', 1) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_del_peso, 'MM/DD/YYYY'), 'YYYY-MM-DD')
           ELSE fecha_del_peso
           END AS fecha_convertida
FROM resolucion_manual
WHERE fecha_del_peso ~ '^\d{1,2}/\d{1,2}/\d{4}$';


UPDATE resolucion_manual
SET fecha_del_peso = CASE
                              WHEN fecha_del_peso ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_del_peso, '/', 2) AS INTEGER) <= 12
                                  THEN TO_CHAR(TO_DATE(fecha_del_peso, 'DD/MM/YYYY'), 'YYYY-MM-DD')
                              WHEN fecha_del_peso ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_del_peso, '/', 1) AS INTEGER) <= 12
                                  THEN TO_CHAR(TO_DATE(fecha_del_peso, 'MM/DD/YYYY'), 'YYYY-MM-DD')
                              ELSE fecha_del_peso  -- Deja los valores que no coinciden con ninguno de los patrones
    END
WHERE fecha_del_peso ~ '^\d{1,2}/\d{1,2}/\d{4}$';
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT fecha_de_la_talla,
       CASE
           WHEN fecha_de_la_talla ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_la_talla, '/', 2) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_de_la_talla, 'DD/MM/YYYY'), 'YYYY-MM-DD')
           WHEN fecha_de_la_talla ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_la_talla, '/', 1) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_de_la_talla, 'MM/DD/YYYY'), 'YYYY-MM-DD')
           ELSE fecha_de_la_talla
           END AS fecha_convertida
FROM resolucion_manual
WHERE fecha_de_la_talla ~ '^\d{1,2}/\d{1,2}/\d{4}$';


UPDATE resolucion_manual
SET fecha_de_la_talla = CASE
                              WHEN fecha_de_la_talla ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_la_talla, '/', 2) AS INTEGER) <= 12
                                  THEN TO_CHAR(TO_DATE(fecha_de_la_talla, 'DD/MM/YYYY'), 'YYYY-MM-DD')
                              WHEN fecha_de_la_talla ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_la_talla, '/', 1) AS INTEGER) <= 12
                                  THEN TO_CHAR(TO_DATE(fecha_de_la_talla, 'MM/DD/YYYY'), 'YYYY-MM-DD')
                              ELSE fecha_de_la_talla  -- Deja los valores que no coinciden con ninguno de los patrones
    END
WHERE fecha_de_la_talla ~ '^\d{1,2}/\d{1,2}/\d{4}$';
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT fecha_probable_de_parto,
       CASE
           WHEN fecha_probable_de_parto ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_probable_de_parto, '/', 2) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_probable_de_parto, 'DD/MM/YYYY'), 'YYYY-MM-DD')
           WHEN fecha_probable_de_parto ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_probable_de_parto, '/', 1) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_probable_de_parto, 'MM/DD/YYYY'), 'YYYY-MM-DD')
           ELSE fecha_probable_de_parto
           END AS fecha_convertida
FROM resolucion_manual
WHERE fecha_probable_de_parto ~ '^\d{1,2}/\d{1,2}/\d{4}$';


UPDATE resolucion_manual
SET fecha_probable_de_parto = CASE
                                  WHEN fecha_probable_de_parto ~ '^\s*\d{1,2}/\d{1,2}/\d{4}\s*$' AND CAST(SPLIT_PART(TRIM(fecha_probable_de_parto), '/', 2) AS INTEGER) <= 12
                                      THEN TO_CHAR(TO_DATE(TRIM(fecha_probable_de_parto), 'DD/MM/YYYY'), 'YYYY-MM-DD')
                                  WHEN fecha_probable_de_parto ~ '^\s*\d{1,2}/\d{1,2}/\d{4}\s*$' AND CAST(SPLIT_PART(TRIM(fecha_probable_de_parto), '/', 1) AS INTEGER) <= 12
                                      THEN TO_CHAR(TO_DATE(TRIM(fecha_probable_de_parto), 'MM/DD/YYYY'), 'YYYY-MM-DD')
                                  ELSE fecha_probable_de_parto  -- Deja los valores que no coinciden con ninguno de los patrones
    END
WHERE fecha_probable_de_parto ~ '^\s*\d{1,2}/\d{1,2}/\d{4}\s*$';

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT fecha_de_atencion_en_salud_para_la_promocion_y_apoyo_de_la_lact,
       CASE
           WHEN fecha_de_atencion_en_salud_para_la_promocion_y_apoyo_de_la_lact ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_atencion_en_salud_para_la_promocion_y_apoyo_de_la_lact, '/', 2) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_de_atencion_en_salud_para_la_promocion_y_apoyo_de_la_lact, 'DD/MM/YYYY'), 'YYYY-MM-DD')
           WHEN fecha_de_atencion_en_salud_para_la_promocion_y_apoyo_de_la_lact ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_atencion_en_salud_para_la_promocion_y_apoyo_de_la_lact, '/', 1) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_de_atencion_en_salud_para_la_promocion_y_apoyo_de_la_lact, 'MM/DD/YYYY'), 'YYYY-MM-DD')
           ELSE fecha_de_atencion_en_salud_para_la_promocion_y_apoyo_de_la_lact
           END AS fecha_convertida
FROM resolucion_manual
WHERE fecha_de_atencion_en_salud_para_la_promocion_y_apoyo_de_la_lact ~ '^\d{1,2}/\d{1,2}/\d{4}$';


UPDATE resolucion_manual
SET fecha_de_atencion_en_salud_para_la_promocion_y_apoyo_de_la_lact = CASE
              WHEN fecha_de_atencion_en_salud_para_la_promocion_y_apoyo_de_la_lact ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_atencion_en_salud_para_la_promocion_y_apoyo_de_la_lact, '/', 2) AS INTEGER) <= 12
                  THEN TO_CHAR(TO_DATE(fecha_de_atencion_en_salud_para_la_promocion_y_apoyo_de_la_lact, 'DD/MM/YYYY'), 'YYYY-MM-DD')
              WHEN fecha_de_atencion_en_salud_para_la_promocion_y_apoyo_de_la_lact ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_atencion_en_salud_para_la_promocion_y_apoyo_de_la_lact, '/', 1) AS INTEGER) <= 12
                  THEN TO_CHAR(TO_DATE(fecha_de_atencion_en_salud_para_la_promocion_y_apoyo_de_la_lact, 'MM/DD/YYYY'), 'YYYY-MM-DD')
              ELSE fecha_de_atencion_en_salud_para_la_promocion_y_apoyo_de_la_lact  -- Deja los valores que no coinciden con ninguno de los patrones
    END
WHERE fecha_de_atencion_en_salud_para_la_promocion_y_apoyo_de_la_lact ~ '^\d{1,2}/\d{1,2}/\d{4}$';
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT fecha_de_consulta_de_valoracion_integral,
       CASE
           WHEN fecha_de_consulta_de_valoracion_integral ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_consulta_de_valoracion_integral, '/', 2) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_de_consulta_de_valoracion_integral, 'DD/MM/YYYY'), 'YYYY-MM-DD')
           WHEN fecha_de_consulta_de_valoracion_integral ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_consulta_de_valoracion_integral, '/', 1) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_de_consulta_de_valoracion_integral, 'MM/DD/YYYY'), 'YYYY-MM-DD')
           ELSE fecha_de_consulta_de_valoracion_integral
           END AS fecha_convertida
FROM resolucion_manual
WHERE fecha_de_consulta_de_valoracion_integral ~ '^\d{1,2}/\d{1,2}/\d{4}$';


UPDATE resolucion_manual
SET fecha_de_consulta_de_valoracion_integral = CASE
      WHEN fecha_de_consulta_de_valoracion_integral ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_consulta_de_valoracion_integral, '/', 2) AS INTEGER) <= 12
          THEN TO_CHAR(TO_DATE(fecha_de_consulta_de_valoracion_integral, 'DD/MM/YYYY'), 'YYYY-MM-DD')
      WHEN fecha_de_consulta_de_valoracion_integral ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_consulta_de_valoracion_integral, '/', 1) AS INTEGER) <= 12
          THEN TO_CHAR(TO_DATE(fecha_de_consulta_de_valoracion_integral, 'MM/DD/YYYY'), 'YYYY-MM-DD')
      ELSE fecha_de_consulta_de_valoracion_integral  -- Deja los valores que no coinciden con ninguno de los patrones
    END
WHERE fecha_de_consulta_de_valoracion_integral ~ '^\d{1,2}/\d{1,2}/\d{4}$';
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT fecha_de_suministro_de_metodo_anticonceptivo,
       CASE
           WHEN fecha_de_suministro_de_metodo_anticonceptivo ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_suministro_de_metodo_anticonceptivo, '/', 2) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_de_suministro_de_metodo_anticonceptivo, 'DD/MM/YYYY'), 'YYYY-MM-DD')
           WHEN fecha_de_suministro_de_metodo_anticonceptivo ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_suministro_de_metodo_anticonceptivo, '/', 1) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_de_suministro_de_metodo_anticonceptivo, 'MM/DD/YYYY'), 'YYYY-MM-DD')
           ELSE fecha_de_suministro_de_metodo_anticonceptivo
           END AS fecha_convertida
FROM resolucion_manual
WHERE fecha_de_suministro_de_metodo_anticonceptivo ~ '^\d{1,2}/\d{1,2}/\d{4}$';


UPDATE resolucion_manual
SET fecha_de_suministro_de_metodo_anticonceptivo = CASE
                                                   WHEN fecha_de_suministro_de_metodo_anticonceptivo ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_suministro_de_metodo_anticonceptivo, '/', 2) AS INTEGER) <= 12
                                                       THEN TO_CHAR(TO_DATE(fecha_de_suministro_de_metodo_anticonceptivo, 'DD/MM/YYYY'), 'YYYY-MM-DD')
                                                   WHEN fecha_de_suministro_de_metodo_anticonceptivo ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_suministro_de_metodo_anticonceptivo, '/', 1) AS INTEGER) <= 12
                                                       THEN TO_CHAR(TO_DATE(fecha_de_suministro_de_metodo_anticonceptivo, 'MM/DD/YYYY'), 'YYYY-MM-DD')
                                                   ELSE fecha_de_suministro_de_metodo_anticonceptivo  -- Deja los valores que no coinciden con ninguno de los patrones
    END
WHERE fecha_de_suministro_de_metodo_anticonceptivo ~ '^\d{1,2}/\d{1,2}/\d{4}$';
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT fecha_de_primera_consulta_prenatal,
       CASE
           WHEN fecha_de_primera_consulta_prenatal ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_primera_consulta_prenatal, '/', 2) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_de_primera_consulta_prenatal, 'DD/MM/YYYY'), 'YYYY-MM-DD')
           WHEN fecha_de_primera_consulta_prenatal ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_primera_consulta_prenatal, '/', 1) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_de_primera_consulta_prenatal, 'MM/DD/YYYY'), 'YYYY-MM-DD')
           ELSE fecha_de_primera_consulta_prenatal
           END AS fecha_convertida
FROM resolucion_manual
WHERE fecha_de_suministro_de_metodo_anticonceptivo ~ '^\d{1,2}/\d{1,2}/\d{4}$';


UPDATE resolucion_manual
SET fecha_de_primera_consulta_prenatal = CASE
                                                       WHEN fecha_de_primera_consulta_prenatal ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_primera_consulta_prenatal, '/', 2) AS INTEGER) <= 12
                                                           THEN TO_CHAR(TO_DATE(fecha_de_primera_consulta_prenatal, 'DD/MM/YYYY'), 'YYYY-MM-DD')
                                                       WHEN fecha_de_primera_consulta_prenatal ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_primera_consulta_prenatal, '/', 1) AS INTEGER) <= 12
                                                           THEN TO_CHAR(TO_DATE(fecha_de_primera_consulta_prenatal, 'MM/DD/YYYY'), 'YYYY-MM-DD')
                                                       ELSE fecha_de_primera_consulta_prenatal  -- Deja los valores que no coinciden con ninguno de los patrones
    END
WHERE fecha_de_primera_consulta_prenatal ~ '^\d{1,2}/\d{1,2}/\d{4}$';
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT fecha_de_ultimo_control_prenatal_de_seguimiento,
       CASE
           WHEN fecha_de_ultimo_control_prenatal_de_seguimiento ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_ultimo_control_prenatal_de_seguimiento, '/', 2) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_de_ultimo_control_prenatal_de_seguimiento, 'DD/MM/YYYY'), 'YYYY-MM-DD')
           WHEN fecha_de_ultimo_control_prenatal_de_seguimiento ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_ultimo_control_prenatal_de_seguimiento, '/', 1) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_de_ultimo_control_prenatal_de_seguimiento, 'MM/DD/YYYY'), 'YYYY-MM-DD')
           ELSE fecha_de_ultimo_control_prenatal_de_seguimiento
           END AS fecha_convertida
FROM resolucion_manual
WHERE fecha_de_ultimo_control_prenatal_de_seguimiento ~ '^\d{1,2}/\d{1,2}/\d{4}$';


UPDATE resolucion_manual
SET fecha_de_ultimo_control_prenatal_de_seguimiento = CASE
                                             WHEN fecha_de_ultimo_control_prenatal_de_seguimiento ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_ultimo_control_prenatal_de_seguimiento, '/', 2) AS INTEGER) <= 12
                                                 THEN TO_CHAR(TO_DATE(fecha_de_ultimo_control_prenatal_de_seguimiento, 'DD/MM/YYYY'), 'YYYY-MM-DD')
                                             WHEN fecha_de_ultimo_control_prenatal_de_seguimiento ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_ultimo_control_prenatal_de_seguimiento, '/', 1) AS INTEGER) <= 12
                                                 THEN TO_CHAR(TO_DATE(fecha_de_ultimo_control_prenatal_de_seguimiento, 'MM/DD/YYYY'), 'YYYY-MM-DD')
                                             ELSE fecha_de_ultimo_control_prenatal_de_seguimiento  -- Deja los valores que no coinciden con ninguno de los patrones
    END
WHERE fecha_de_ultimo_control_prenatal_de_seguimiento ~ '^\d{1,2}/\d{1,2}/\d{4}$';
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT fecha_de_toma_hemoglobina,
       CASE
           WHEN fecha_de_toma_hemoglobina ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_toma_hemoglobina, '/', 2) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_de_toma_hemoglobina, 'DD/MM/YYYY'), 'YYYY-MM-DD')
           WHEN fecha_de_toma_hemoglobina ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_toma_hemoglobina, '/', 1) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_de_toma_hemoglobina, 'MM/DD/YYYY'), 'YYYY-MM-DD')
           ELSE fecha_de_toma_hemoglobina
           END AS fecha_convertida
FROM resolucion_manual
WHERE fecha_de_toma_hemoglobina ~ '^\d{1,2}/\d{1,2}/\d{4}$';


UPDATE resolucion_manual
SET fecha_de_toma_hemoglobina = CASE
                                                          WHEN fecha_de_toma_hemoglobina ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_toma_hemoglobina, '/', 2) AS INTEGER) <= 12
                                                              THEN TO_CHAR(TO_DATE(fecha_de_toma_hemoglobina, 'DD/MM/YYYY'), 'YYYY-MM-DD')
                                                          WHEN fecha_de_toma_hemoglobina ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_toma_hemoglobina, '/', 1) AS INTEGER) <= 12
                                                              THEN TO_CHAR(TO_DATE(fecha_de_toma_hemoglobina, 'MM/DD/YYYY'), 'YYYY-MM-DD')
                                                          ELSE fecha_de_toma_hemoglobina  -- Deja los valores que no coinciden con ninguno de los patrones
    END
WHERE fecha_de_toma_hemoglobina ~ '^\d{1,2}/\d{1,2}/\d{4}$';
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT fecha_de_toma_glicemia_basal,
       CASE
           WHEN fecha_de_toma_glicemia_basal ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_toma_glicemia_basal, '/', 2) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_de_toma_glicemia_basal, 'DD/MM/YYYY'), 'YYYY-MM-DD')
           WHEN fecha_de_toma_glicemia_basal ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_toma_glicemia_basal, '/', 1) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_de_toma_glicemia_basal, 'MM/DD/YYYY'), 'YYYY-MM-DD')
           ELSE fecha_de_toma_glicemia_basal
           END AS fecha_convertida
FROM resolucion_manual
WHERE fecha_de_toma_glicemia_basal ~ '^\d{1,2}/\d{1,2}/\d{4}$';


UPDATE resolucion_manual
SET fecha_de_toma_glicemia_basal = CASE
                                    WHEN fecha_de_toma_glicemia_basal ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_toma_glicemia_basal, '/', 2) AS INTEGER) <= 12
                                        THEN TO_CHAR(TO_DATE(fecha_de_toma_glicemia_basal, 'DD/MM/YYYY'), 'YYYY-MM-DD')
                                    WHEN fecha_de_toma_glicemia_basal ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_toma_glicemia_basal, '/', 1) AS INTEGER) <= 12
                                        THEN TO_CHAR(TO_DATE(fecha_de_toma_glicemia_basal, 'MM/DD/YYYY'), 'YYYY-MM-DD')
                                    ELSE fecha_de_toma_glicemia_basal  -- Deja los valores que no coinciden con ninguno de los patrones
    END
WHERE fecha_de_toma_glicemia_basal ~ '^\d{1,2}/\d{1,2}/\d{4}$';
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT fecha_de_toma_creatinina,
       CASE
           WHEN fecha_de_toma_creatinina ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_toma_creatinina, '/', 2) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_de_toma_creatinina, 'DD/MM/YYYY'), 'YYYY-MM-DD')
           WHEN fecha_de_toma_creatinina ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_toma_creatinina, '/', 1) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_de_toma_creatinina, 'MM/DD/YYYY'), 'YYYY-MM-DD')
           ELSE fecha_de_toma_creatinina
           END AS fecha_convertida
FROM resolucion_manual
WHERE fecha_de_toma_creatinina ~ '^\d{1,2}/\d{1,2}/\d{4}$';


UPDATE resolucion_manual
SET fecha_de_toma_creatinina = CASE
                                       WHEN fecha_de_toma_creatinina ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_toma_creatinina, '/', 2) AS INTEGER) <= 12
                                           THEN TO_CHAR(TO_DATE(fecha_de_toma_creatinina, 'DD/MM/YYYY'), 'YYYY-MM-DD')
                                       WHEN fecha_de_toma_creatinina ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_toma_creatinina, '/', 1) AS INTEGER) <= 12
                                           THEN TO_CHAR(TO_DATE(fecha_de_toma_creatinina, 'MM/DD/YYYY'), 'YYYY-MM-DD')
                                       ELSE fecha_de_toma_creatinina  -- Deja los valores que no coinciden con ninguno de los patrones
    END
WHERE fecha_de_toma_creatinina ~ '^\d{1,2}/\d{1,2}/\d{4}$';
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT fecha_de_toma_trigliceridos,
       CASE
           WHEN fecha_de_toma_trigliceridos ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_toma_trigliceridos, '/', 2) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_de_toma_trigliceridos, 'DD/MM/YYYY'), 'YYYY-MM-DD')
           WHEN fecha_de_toma_trigliceridos ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_toma_trigliceridos, '/', 1) AS INTEGER) <= 12
               THEN TO_CHAR(TO_DATE(fecha_de_toma_trigliceridos, 'MM/DD/YYYY'), 'YYYY-MM-DD')
           ELSE fecha_de_toma_trigliceridos
           END AS fecha_convertida
FROM resolucion_manual
WHERE fecha_de_toma_trigliceridos ~ '^\d{1,2}/\d{1,2}/\d{4}$';


UPDATE resolucion_manual
SET fecha_de_toma_trigliceridos = CASE
                                   WHEN fecha_de_toma_trigliceridos ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_toma_trigliceridos, '/', 2) AS INTEGER) <= 12
                                       THEN TO_CHAR(TO_DATE(fecha_de_toma_trigliceridos, 'DD/MM/YYYY'), 'YYYY-MM-DD')
                                   WHEN fecha_de_toma_trigliceridos ~ '^\d{1,2}/\d{1,2}/\d{4}$' AND CAST(SPLIT_PART(fecha_de_toma_trigliceridos, '/', 1) AS INTEGER) <= 12
                                       THEN TO_CHAR(TO_DATE(fecha_de_toma_trigliceridos, 'MM/DD/YYYY'), 'YYYY-MM-DD')
                                   ELSE fecha_de_toma_trigliceridos  -- Deja los valores que no coinciden con ninguno de los patrones
    END
WHERE fecha_de_toma_trigliceridos ~ '^\d{1,2}/\d{1,2}/\d{4}$';