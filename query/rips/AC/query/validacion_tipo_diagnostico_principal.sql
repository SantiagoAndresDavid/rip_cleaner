BEGIN;


UPDATE AC
SET TIPO_DE_DIAGNOSTICO_PRINCIPAL = '1'
WHERE TIPO_DE_DIAGNOSTICO_PRINCIPAL = '0';

COMMIT;