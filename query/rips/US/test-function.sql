--SELECT * FROM actualizar_tipo_identificacion();
--SELECT * FROM actualizar_codigo_factura(234457);
--SELECT * FROM actualizar_codigo_municipio();
--SELECT * FROM actualizar_causa_externa();
--SELECT * FROM actualizar_diagnostico_vacio();
SELECT * FROM buscar_usuarios_por_codigo_consulta('890205');

SELECT *
FROM buscar_usuarios_por_filtros(
        '890201',                  -- Código de la consulta
        ARRAY['21', '22', '23','24','26','27'],   -- Lista de edades
        '1',           -- Lista de unidades de edad
        ARRAY['05', '04','06'],           -- Lista de finalidades
        ARRAY['Z001', 'Z003','Z000']                 -- Diagnóstico principal
);


SELECT * FROM actualizar_finalidad(
               '890201',                    -- Código de la consulta
               ARRAY['21', '22', '23','24','26','27'],     -- Lista de edades
               '1',                         -- Única unidad de edad
               ARRAY['Z000'],       -- Lista de diagnósticos principales
               '06'                          -- Nueva finalidad
       );
