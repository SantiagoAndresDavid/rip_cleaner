BEGIN;

SELECT *
FROM resolucion
WHERE gestante = '1'  and  suministro_de_acido_folico_en_el_control_prenatal = '0';

COMMIT;