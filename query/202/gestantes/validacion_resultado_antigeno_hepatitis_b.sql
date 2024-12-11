BEGIN;

SELECT *
FROM resolucion
WHERE gestante = '1'  and  resultado_de_antigeno_de_superficie_hepatitis_b = '4';

COMMIT;