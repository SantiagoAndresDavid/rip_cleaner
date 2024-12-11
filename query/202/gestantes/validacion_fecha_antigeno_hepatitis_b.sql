BEGIN;

SELECT *
FROM resolucion
WHERE gestante = '1'  and  fecha_de_antigeno_de_superficie_hepatitis_b = '1800-01-01';

COMMIT;