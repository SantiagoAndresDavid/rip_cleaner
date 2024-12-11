BEGIN;

--Paso 2:validar que no existan comodines en las gestantes
SELECT *
FROM resolucion
WHERE gestante = '1'  and  clasificacion_del_riesgo_gestacional = '0';

COMMIT;