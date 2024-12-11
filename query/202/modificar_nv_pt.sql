BEGIN;

-- Paso 1: Mostrar los registros
SELECT *
FROM "resolucion"
WHERE tipo_de_identificacion_del_usuario = 'NV';

-- Paso 2: Modificar los registros
UPDATE "resolucion"
SET tipo_de_identificacion_del_usuario = 'PT'
WHERE tipo_de_identificacion_del_usuario = 'NV';

COMMIT;
