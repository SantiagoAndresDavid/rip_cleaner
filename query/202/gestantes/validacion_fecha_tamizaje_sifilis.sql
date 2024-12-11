BEGIN;

SELECT *
FROM resolucion
WHERE gestante = '1' and fecha_de_toma_de_prueba_tamizaje_para_sifilis = '1800-01-01';

COMMIT;