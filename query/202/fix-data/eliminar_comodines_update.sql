-- Active: 1735239549405@@127.0.0.1@5432@202@public

UPDATE datos_variables
SET
    Resultado_de_la_prueba_mini_mental_state = 
        CASE 
            WHEN Resultado_de_la_prueba_mini_mental_state IN ('0', '4', '5', '21') THEN NULL
            ELSE Resultado_de_la_prueba_mini_mental_state
        END,
    Consumo_de_tabaco = 
        CASE 
            WHEN Consumo_de_tabaco ~ '^\d|[1-8]\d|9[0-5]|96|97|98|99$' THEN NULL
            ELSE Consumo_de_tabaco
        END,
    resultado_del_tacto_rectal = 
        CASE 
            WHEN resultado_del_tacto_rectal IN ('0', '4', '5', '21') THEN NULL
            ELSE resultado_del_tacto_rectal
        END,
    acido_folico_preconcepcional = 
        CASE 
            WHEN acido_folico_preconcepcional IN ('0', '1', '2', '21') THEN NULL
            ELSE acido_folico_preconcepcional
        END,
    resultado_de_la_prueba_sangre_oculta_en_materia_fecal =
        CASE 
            WHEN resultado_de_la_prueba_sangre_oculta_en_materia_fecal IN ('0', '4', '5', '6', '21') THEN NULL
            ELSE resultado_de_la_prueba_sangre_oculta_en_materia_fecal
        END,
    agudeza_visual_lejana_ojo_izquierdo = 
        CASE 
            WHEN agudeza_visual_lejana_ojo_izquierdo IN ('0', '3', '4', '5', '6', '7', '8', '9', '21') THEN NULL
            ELSE agudeza_visual_lejana_ojo_izquierdo
        END,
    agudeza_visual_lejana_ojo_derecho = 
        CASE 
            WHEN agudeza_visual_lejana_ojo_derecho IN ('0', '3', '4', '5', '6', '7', '8', '9', '21') THEN NULL
            ELSE agudeza_visual_lejana_ojo_derecho
        END,
    codigo_pais = 
        CASE 
            WHEN codigo_pais ~ '^[0-9]{3}$' THEN NULL
            ELSE codigo_pais
        END,
    clasificacion_del_riesgo_gestacional = 
        CASE 
            WHEN clasificacion_del_riesgo_gestacional IN ('0', '4', '5', '21') THEN NULL
            ELSE clasificacion_del_riesgo_gestacional
        END,
    resultado_de_colonoscopia_tamizaje =
        CASE 
            WHEN resultado_de_colonoscopia_tamizaje IN ('0', '2', '3', '4', '5', '6', '21') THEN NULL
            ELSE resultado_de_colonoscopia_tamizaje
        END,
    resultado_de_tamizaje_auditivo_neonatal =
        CASE 
            WHEN resultado_de_tamizaje_auditivo_neonatal IN ('0', '4', '5', '21') THEN NULL
            ELSE resultado_de_tamizaje_auditivo_neonatal
        END,
    fecha_de_consulta_de_valoracion_integral =
        CASE 
            WHEN fecha_de_consulta_de_valoracion_integral ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_consulta_de_valoracion_integral
        END,
    hipotiroidismo_congenito = 
        CASE 
            WHEN hipotiroidismo_congenito = '0' THEN NULL
            ELSE hipotiroidismo_congenito
        END,
    lepra = 
        CASE 
            WHEN lepra = '21' THEN NULL
            ELSE lepra
        END,
    enfermedad_mental = 
        CASE 
            WHEN enfermedad_mental = '21' THEN NULL
            ELSE enfermedad_mental
        END,
    cancer_de_cervix =
        CASE 
            WHEN cancer_de_cervix = '0' THEN NULL
            ELSE cancer_de_cervix
        END,
    dpt_menores_de_5_anos =
        CASE 
            WHEN dpt_menores_de_5_anos = '0' THEN NULL
            ELSE dpt_menores_de_5_anos
        END,
    neumococo = 
        CASE 
            WHEN neumococo = '0' THEN NULL
            ELSE neumococo
        END,
    resultado_de_glicemia_basal =
        CASE 
            WHEN resultado_de_glicemia_basal ~ '^\d{1,3}$' AND resultado_de_glicemia_basal::INTEGER BETWEEN 0 AND 998 THEN NULL
            ELSE resultado_de_glicemia_basal
        END,
    fecha_de_tamizaje_vale =
        CASE 
            WHEN fecha_de_tamizaje_vale ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_tamizaje_vale
        END,
    fecha_del_tacto_rectal =
        CASE 
            WHEN fecha_del_tacto_rectal ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_del_tacto_rectal
        END,
    fecha_de_tamizaje_con_oximetria_pre_y_post_ductal =
        CASE 
            WHEN fecha_de_tamizaje_con_oximetria_pre_y_post_ductal ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_tamizaje_con_oximetria_pre_y_post_ductal
        END,
    fecha_de_realizacion_colonoscopia_tamizaje =
        CASE 
            WHEN fecha_de_realizacion_colonoscopia_tamizaje ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_realizacion_colonoscopia_tamizaje
        END,
    fecha_de_la_prueba_sangre_oculta_en_materia_fecal = 
        CASE 
            WHEN fecha_de_la_prueba_sangre_oculta_en_materia_fecal ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_la_prueba_sangre_oculta_en_materia_fecal
        END,
    fecha_de_tamizaje_auditivo_neonatal =
        CASE 
            WHEN fecha_de_tamizaje_auditivo_neonatal ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_tamizaje_auditivo_neonatal
        END,
    suministro_de_fortificacion_casera_en_la_primera_infancia =
        CASE 
            WHEN suministro_de_fortificacion_casera_en_la_primera_infancia IN ('0', '1', '16', '17', '18', '20', '21') THEN NULL
            ELSE suministro_de_fortificacion_casera_en_la_primera_infancia
        END,
    fecha_de_toma_psa =
        CASE 
            WHEN fecha_de_toma_psa ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_toma_psa
        END,
    fecha_de_tamizaje_visual_neonatal =
        CASE 
            WHEN fecha_de_tamizaje_visual_neonatal ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_tamizaje_visual_neonatal
        END,
    fecha_de_atencion_en_salud_bucal_por_profesional_en_odontologia =
        CASE 
            WHEN fecha_de_atencion_en_salud_bucal_por_profesional_en_odontologia ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_atencion_en_salud_bucal_por_profesional_en_odontologia
        END,
    resultado_de_ldl =
        CASE 
            WHEN resultado_de_ldl ~ '^\d{1,3}$' AND resultado_de_ldl::INTEGER BETWEEN 0 AND 998 THEN NULL
            ELSE resultado_de_ldl
        END,
    resultado_de_hdl =
        CASE 
            WHEN resultado_de_hdl ~ '^\d{1,3}$' AND resultado_de_hdl::INTEGER BETWEEN 0 AND 998 THEN NULL
            ELSE resultado_de_hdl
        END,
    resultado_de_trigliceridos =
        CASE 
            WHEN resultado_de_trigliceridos ~ '^(\d{1,3}|998|0)$' THEN NULL
            ELSE resultado_de_trigliceridos
        END,
    cop_por_persona =
        CASE 
            WHEN cop_por_persona ~ '^[0-9]{12}$' THEN NULL
            ELSE cop_por_persona
        END,
    resultado_de_psa =
        CASE 
            WHEN resultado_de_psa ~ '^(\d{1,4}|998|0)$' THEN NULL
            ELSE resultado_de_psa
        END,
    fecha_de_toma_de_tamizaje_hepatitis_c = 
        CASE 
            WHEN fecha_de_toma_de_tamizaje_hepatitis_c ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_toma_de_tamizaje_hepatitis_c
        END,
    fecha_de_toma_hdl = 
        CASE 
            WHEN fecha_de_toma_hdl ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_toma_hdl
        END,
    clasificacion_del_riesgo_cardiovascular = 
        CASE 
            WHEN clasificacion_del_riesgo_cardiovascular IN ('21') THEN NULL
            ELSE clasificacion_del_riesgo_cardiovascular
        END,
    clasificacion_del_riesgo_metabolico = 
        CASE 
            WHEN clasificacion_del_riesgo_metabolico IN ('21') THEN NULL
            ELSE clasificacion_del_riesgo_metabolico
        END,
    fecha_de_toma_trigliceridos = 
        CASE 
            WHEN fecha_de_toma_trigliceridos ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_toma_trigliceridos
        END,
    sifilis_gestacional_o_congenita = 
        CASE 
            WHEN sifilis_gestacional_o_congenita = '0' THEN NULL
            ELSE sifilis_gestacional_o_congenita
        END,
    obesidad_o_desnutricion_proteico_calorica = 
        CASE 
            WHEN obesidad_o_desnutricion_proteico_calorica = '21' THEN NULL
            ELSE obesidad_o_desnutricion_proteico_calorica
        END,
    consulta_de_psicologia = 
        CASE 
            WHEN consulta_de_psicologia ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE consulta_de_psicologia
        END,
    preservativos_entregados_a_pacientes_con_its =
        CASE
            WHEN preservativos_entregados_a_pacientes_con_its = '0' THEN NULL
            ELSE preservativos_entregados_a_pacientes_con_its
        END,
    tratamiento_para_sifilis_gestacional = 
        CASE 
            WHEN tratamiento_para_sifilis_gestacional = '0' THEN NULL
            ELSE tratamiento_para_sifilis_gestacional
        END,
    tratamiento_para_sifilis_congenita = 
        CASE 
            WHEN tratamiento_para_sifilis_congenita = '0' THEN NULL
            ELSE tratamiento_para_sifilis_congenita
        END,
    tipo_de_registro = 
        CASE 
            WHEN tipo_de_registro != '0' THEN NULL
            ELSE tipo_de_registro
        END,
    fecha_de_nacimiento = 
        CASE 
            WHEN fecha_de_nacimiento ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_nacimiento
        END,
    fecha_del_peso = 
        CASE 
            WHEN fecha_del_peso ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_del_peso
        END,
    fecha_de_la_talla = 
        CASE 
            WHEN fecha_de_la_talla ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_la_talla
        END,
    fecha_probable_de_parto = 
        CASE 
            WHEN fecha_probable_de_parto ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_probable_de_parto
        END,
    fecha_de_atencion_parto_o_cesarea = 
        CASE 
            WHEN fecha_de_atencion_parto_o_cesarea ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_atencion_parto_o_cesarea
        END,
    fecha_de_atencion_en_salud_para_la_promocion_y_apoyo_de_la_lactancia_materna = 
        CASE 
            WHEN fecha_de_atencion_en_salud_para_la_promocion_y_apoyo_de_la_lactancia_materna ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_atencion_en_salud_para_la_promocion_y_apoyo_de_la_lactancia_materna
        END,
    fecha_de_atencion_en_salud_para_la_asesoria_en_anticoncepcion = 
        CASE 
            WHEN fecha_de_atencion_en_salud_para_la_asesoria_en_anticoncepcion ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_atencion_en_salud_para_la_asesoria_en_anticoncepcion
        END,
    fecha_de_suministro_de_metodo_anticonceptivo = 
        CASE 
            WHEN fecha_de_suministro_de_metodo_anticonceptivo ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_suministro_de_metodo_anticonceptivo
        END,
    fecha_de_primera_consulta_prenatal = 
        CASE 
            WHEN fecha_de_primera_consulta_prenatal ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_primera_consulta_prenatal
        END,
    fecha_de_ultimo_control_prenatal_de_seguimiento = 
        CASE 
            WHEN fecha_de_ultimo_control_prenatal_de_seguimiento ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_ultimo_control_prenatal_de_seguimiento
        END,
    fecha_de_valoracion_agudeza_visual = 
        CASE 
            WHEN fecha_de_valoracion_agudeza_visual ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_valoracion_agudeza_visual
        END,
    fecha_de_toma_ldl = 
        CASE 
            WHEN fecha_de_toma_ldl ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_toma_ldl
        END,
    fecha_de_antigeno_de_superficie_hepatitis_b = 
        CASE 
            WHEN fecha_de_antigeno_de_superficie_hepatitis_b ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_antigeno_de_superficie_hepatitis_b
        END,
    fecha_de_toma_de_prueba_tamizaje_para_sifilis = 
        CASE 
            WHEN fecha_de_toma_de_prueba_tamizaje_para_sifilis ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_toma_de_prueba_tamizaje_para_sifilis
        END,
    fecha_de_toma_de_prueba_para_vih = 
        CASE 
            WHEN fecha_de_toma_de_prueba_para_vih ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_toma_de_prueba_para_vih
        END,
    fecha_de_tsh_neonatal = 
        CASE 
            WHEN fecha_de_tsh_neonatal ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_tsh_neonatal
        END,
    fecha_de_tamizaje_cancer_de_cuello_uterino = 
        CASE 
            WHEN fecha_de_tamizaje_cancer_de_cuello_uterino ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_tamizaje_cancer_de_cuello_uterino
        END,
    fecha_de_colposcopia = 
        CASE 
            WHEN fecha_de_colposcopia ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_colposcopia
        END,
    fecha_de_biopsia_cervicouterina = 
        CASE 
            WHEN fecha_de_biopsia_cervicouterina ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_biopsia_cervicouterina
        END,
    fecha_de_toma_de_mamografia = 
        CASE 
            WHEN fecha_de_toma_de_mamografia ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_toma_de_mamografia
        END,
    fecha_de_resultado_biopsia_de_mama = 
        CASE 
            WHEN fecha_de_resultado_biopsia_de_mama ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_resultado_biopsia_de_mama
        END,
    fecha_de_toma_hemoglobina = 
        CASE 
            WHEN fecha_de_toma_hemoglobina ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_toma_hemoglobina
        END,
    fecha_de_toma_glicemia_basal = 
        CASE 
            WHEN fecha_de_toma_glicemia_basal ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_toma_glicemia_basal
        END,
    fecha_de_toma_creatinina = 
        CASE 
            WHEN fecha_de_toma_creatinina ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_toma_creatinina
        END,
    fecha_de_toma_de_baciloscopia_diagnostico = 
        CASE 
            WHEN fecha_de_toma_de_baciloscopia_diagnostico ~ '^(1800-01-01|1845-01-01)$' THEN NULL
            ELSE fecha_de_toma_de_baciloscopia_diagnostico
        END
