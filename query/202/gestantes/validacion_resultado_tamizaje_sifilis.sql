BEGIN;

SELECT *
FROM resolucion
WHERE gestante = '1' and resultado_de_prueba_tamizaje_para_sifilis = '4';


COMMIT;