BEGIN;

SELECT *
FROM resolucion
WHERE gestante = '1' and fecha_de_toma_hemoglobina = '1800-01-01';

COMMIT;