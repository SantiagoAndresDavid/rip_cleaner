

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BEGIN;

-- Paso 1: Consultar el si existen errores en ac
SELECT *
FROM ac
WHERE tipo_de_identificacion_del_usuario = 'CE' OR tipo_de_identificacion_del_usuario = 'NU';

-- Paso 2: Consultar el si existen errores en us
SELECT *
FROM us
WHERE tipo_de_identificacion_del_usuario = 'CE' OR tipo_de_identificacion_del_usuario = 'NU';

SELECT *
FROM am
WHERE tipo_de_identificacion_del_usuario = 'CE' OR tipo_de_identificacion_del_usuario = 'NU';

SELECT *
FROM ap
WHERE tipo_de_identificacion_del_usuario = 'CE' OR tipo_de_identificacion_del_usuario = 'NU';

-- Paso 3: Modificar en la tabla us los errores
UPDATE us
SET tipo_de_identificacion_del_usuario = 'PT'
WHERE tipo_de_identificacion_del_usuario = 'CE' OR tipo_de_identificacion_del_usuario = 'NU';

-- Paso 4: Modificar segun el archivo us los tipos de documentos en ac
UPDATE AC
SET TIPO_DE_IDENTIFICACION_DEL_USUARIO = (
    SELECT TIPO_DE_IDENTIFICACION_DEL_USUARIO
    FROM US
    WHERE US.NUMERO_DE_IDENTIFICACION_DEL_USUARIO_DEL_SISTEMA = AC.NUMERO_DE_IDENTIFICACION_DEL_USUARIO_EN_EL_SISTEMA
)
WHERE EXISTS (
    SELECT 1
    FROM US
    WHERE US.NUMERO_DE_IDENTIFICACION_DEL_USUARIO_DEL_SISTEMA = AC.NUMERO_DE_IDENTIFICACION_DEL_USUARIO_EN_EL_SISTEMA
);


UPDATE am
SET TIPO_DE_IDENTIFICACION_DEL_USUARIO = (
    SELECT TIPO_DE_IDENTIFICACION_DEL_USUARIO
    FROM US
    WHERE US.NUMERO_DE_IDENTIFICACION_DEL_USUARIO_DEL_SISTEMA = am.NUMERO_DE_IDENTIFICACION_DEL_USUARIO_EN_EL_SISTEMA
)
WHERE EXISTS (
    SELECT 1
    FROM US
    WHERE US.NUMERO_DE_IDENTIFICACION_DEL_USUARIO_DEL_SISTEMA = am.NUMERO_DE_IDENTIFICACION_DEL_USUARIO_EN_EL_SISTEMA
);


UPDATE ap
SET TIPO_DE_IDENTIFICACION_DEL_USUARIO = (
    SELECT TIPO_DE_IDENTIFICACION_DEL_USUARIO
    FROM US
    WHERE US.NUMERO_DE_IDENTIFICACION_DEL_USUARIO_DEL_SISTEMA = ap.NUMERO_DE_IDENTIFICACION_DEL_USUARIO_EN_EL_SISTEMA
)
WHERE EXISTS (
    SELECT 1
    FROM US
    WHERE US.NUMERO_DE_IDENTIFICACION_DEL_USUARIO_DEL_SISTEMA = ap.NUMERO_DE_IDENTIFICACION_DEL_USUARIO_EN_EL_SISTEMA
);


COMMIT;
