BEGIN;

UPDATE ac
SET finalidad_de_la_causa_externa_consulta = '10'
RETURNING finalidad_de_la_causa_externa_consulta;

COMMIT;
