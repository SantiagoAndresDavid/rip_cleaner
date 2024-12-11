BEGIN;

--Paso 2:validar que no existan comodines en las gestantes
SELECT *
FROM resolucion
WHERE gestante = '1'  and  fecha_de_primera_consulta_prenatal = '1845-01-01';

COMMIT;