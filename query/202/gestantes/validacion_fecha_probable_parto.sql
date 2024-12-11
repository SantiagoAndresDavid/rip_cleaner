BEGIN;

SELECT *
FROM resolucion
WHERE gestante = '1'  and  fecha_probable_de_parto = '1845-01-01';


    SELECT column_name
    FROM information_schema.columns
    WHERE table_name = 'resolucion';

    SELECT r.numero_de_identificacion_del_usuario,
           r.fecha_probable_de_parto AS fecha_actual,
           rm.fecha_probable_de_parto AS fecha_nueva
    FROM resolucion r
             JOIN resolucion_manual rm
                  ON r.numero_de_identificacion_del_usuario = rm.numero_de_identificacion_del_usuario
    WHERE r.fecha_probable_de_parto = '1845-01-01';


COMMIT;