


BEGIN;

SELECT *
FROM resolucion
WHERE sexo = 'M'
  AND resultado_del_tacto_rectal = '0'
  AND (EXTRACT(YEAR FROM AGE(CURRENT_DATE, fecha_de_nacimiento)) BETWEEN 40 AND 110);


SELECT *
FROM resolucion
WHERE sexo = 'M'
  AND resultado_del_tacto_rectal = '21'
  AND EXTRACT(YEAR FROM AGE(CURRENT_DATE, TO_DATE(fecha_de_nacimiento, 'YYYY-MM-DD'))) >= 40;



COMMIT;