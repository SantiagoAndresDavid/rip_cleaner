BEGIN;

SELECT *
FROM resolucion_manual
WHERE gestante = '1'  and  suministro_de_sulfato_ferroso_en_el_control_prenatal = '0';

COMMIT;