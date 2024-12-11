BEGIN;

--para validar esto hay que compararlo con el dato hecho a mano de la resolucion manual
SELECT *
FROM resolucion
WHERE gestante = '1'  and  fecha_de_ultimo_control_prenatal_de_seguimiento = '1845-01-01';

COMMIT;