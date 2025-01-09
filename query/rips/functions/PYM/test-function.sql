SELECT * FROM eliminar_duplicados_ac();
SELECT * FROM actualizar_tipo_identificacion();
SELECT * FROM actualizar_codigo_municipio();
SELECT * FROM actualizar_codigo_departamento();
SELECT * FROM actualizar_causa_externa();
SELECT * FROM actualizar_finalidad_diagnostico_niños();
SELECT * FROM actualizar_codigo_factura('240390');
SELECT * FROM actualizar_diagnostico_vacio();
SELECT * FROM actualizar_codigos_procedimientos_erroneos();
SELECT * FROM actualizar_forma_realizacion_acto_quirurgico();
SELECT * FROM actualizar_finalidad_erronea('1','3');
SELECT * FROM actualizar_tipo_documento_all('1759390','PT');



SELECT * FROM buscar_usuarios_por_codigo_consulta('890703');

SELECT *
FROM buscar_usuarios_por_filtros(
        '890201',                  -- Código de la consulta
        ARRAY['21', '22', '23','24','26','27'],   -- Lista de edades
        '1',           -- Lista de unidades de edad
        ARRAY['06','07'],           -- Lista de finalidades
        ARRAY['Z001', 'C789','Z000']                 -- Diagnóstico principal
);


SELECT * FROM actualizar_finalidades(
               '890201',                    -- Código de la consulta
               ARRAY['21', '22', '23','24','26','27'],     -- Lista de edades
               '1',                         -- Única unidad de edad
               ARRAY['Z000'],       -- Lista de diagnósticos principales
               '06'                          -- Nueva finalidad
);


SELECT * FROM actualizar_diagnosticos(
    '890201',
    ARRAY['21', '22', '23','24','26','27'],
    '1',
    ARRAY['06'],
    'Z000'
);

SELECT * FROM modificar_diagnostico_unico(
        '1003195957',    -- Número de identificación del usuario
        '890201',   -- Código de consulta
        '06',            -- Finalidad
        'Z000'           -- Nuevo diagnóstico
);


SELECT * FROM modificar_finalidad_unico(
        '1002995668',    -- Número de identificación del usuario
        '890201',   -- Código de consulta
        '07',            -- Finalidad
        'Z000'           -- Nuevo diagnóstico
);
