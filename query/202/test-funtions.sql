SELECT consecutivo_de_registro from resolucion_manual where resultado_de_biopsia_de_mama != '0' and fecha_de_resultado_biopsia_de_mama = '1845-01-01';

UPDATE resolucion_manual
SET fecha_de_resultado_biopsia_de_mama = '1845-01-01'
WHERE resultado_de_biopsia_de_mama != '0'
  AND fecha_de_resultado_biopsia_de_mama = '1800-01-01';

SELECT consecutivo_de_registro,fecha_de_antigeno_de_superficie_hepatitis_b from resolucion_manual where resultado_de_antigeno_de_superficie_hepatitis_b = '21';

SELECT consecutivo_de_registro,fecha_de_toma_de_prueba_tamizaje_para_sifilis from resolucion_manual where resultado_de_prueba_tamizaje_para_sifilis = '21';
SELECT consecutivo_de_registro, fecha_de_toma_creatinina, resultado_de_creatinina
FROM resolucion_manual
WHERE EXTRACT(YEAR FROM AGE(TO_DATE(fecha_de_nacimiento, 'YYYY-MM-DD'))) < 29 and clasificacion_del_riesgo_cardiovascular = '0' or clasificacion_del_riesgo_cardiovascular='21';



SELECT 
  COALESCE(rm.consecutivo_de_registro, ra.consecutivo_de_registro) as consecutivo_de_registro,
  rm.codigo_de_habilitacion_ips_primaria as rm_ips,
  ra.codigo_de_habilitacion_ips_primaria as ra_ips
FROM resolucion_manual rm
FULL OUTER JOIN resolucion_automatica ra
  ON rm.consecutivo_de_registro = ra.consecutivo_de_registro
WHERE rm.codigo_de_habilitacion_ips_primaria IS DISTINCT FROM ra.codigo_de_habilitacion_ips_primaria;


