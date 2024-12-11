BEGIN;

--Paso 2:validar que no existan comodines en las gestantes
SELECT *
FROM resolucion
WHERE gestante = '1'  and  acido_folico_preconcepcional = '0';

SELECT *
FROM resolucion
WHERE gestante = '1'  and  acido_folico_preconcepcional = '21';

COMMIT;