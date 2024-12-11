BEGIN;

SELECT *
FROM resolucion
WHERE gestante = '1' and resultado_de_prueba_para_vih = '4';

COMMIT;