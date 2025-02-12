-- paso 1 eliminar los decimales
SELECT eliminar_decimales();
-- paso 2 eliminar duplicados del AC
SELECT * FROM eliminar_duplicados_ac();
-- paso 2 cambiar de CE Y NU POR PT
SELECT * FROM actualizar_tipo_identificacion();
-- paso 3 verificar los documentos por edad
SELECT * FROM validar_documentos_por_edad();
SELECT * FROM validar_documentos_por_edad(ARRAY['1067822452', '1137734773','1067819256']);
SELECT * FROM actualizar_tipo_documento_all('1067819206','TI');
SELECT * FROM actualizar_tipo_documento_all('1137734435','RC');
-- paso 4 cambiar el departamento y el municipio
SELECT * FROM actualizar_codigo_municipio();
SELECT * FROM actualizar_codigo_departamento();
-- paso 5 actualizar el código de la factura
SELECT * FROM actualizar_codigo_factura('246673');
-- paso 6 actualizar la finalidad de la causa externa
SELECT * FROM actualizar_finalidad_diagnostico_niños();
SELECT * FROM actualizar_finalidad_diagnostico_niños_ap();
-- paso 7 actualizar casua externa
SELECT * FROM actualizar_causa_externa();
SELECT * FROM actualizar_finalidad_de_la_causa_externa_consulta();
-- paso 8 actualizar diagnosticos vacios
SELECT * FROM actualizar_diagnostico_vacio();
SELECT * FROM actualizar_diagnostico_vacio_ap();
SELECT * FROM actualizar_tipo_diagnostico_principal();
-- paso 8 arreglar procedimientos
SELECT * FROM actualizar_finalidad_procedimiento();
SELECT * FROM actualizar_codigos_procedimientos_erroneos();
SELECT * FROM actualizar_forma_realizacion_acto_quirurgico();
SELECT * FROM actualizar_finalidad_erronea('1','3');
-- herramientas para corregir
SELECT * FROM actualizar_tipo_documento_all('6216526','PT');
SELECT * FROM actualizar_tipo_documento_all('1064112017','TI');
SELECT * FROM actualizar_tipo_documento_all('1067808836','CC');

UPDATE ap
SET ambito_de_realizacion_del_procedimiento = '1'
WHERE ambito_de_realizacion_del_procedimiento ='7' or  ambito_de_realizacion_del_procedimiento ='5' or  ambito_de_realizacion_del_procedimiento ='6' or  ambito_de_realizacion_del_procedimiento ='4'
RETURNING ap.ambito_de_realizacion_del_procedimiento,ap.ambito_de_realizacion_del_procedimiento;

UPDATE ap
SET finalidad_del_procedimiento = LTRIM(finalidad_del_procedimiento, '0')
WHERE finalidad_del_procedimiento LIKE '0%';



SELECT *
FROM AC
WHERE CODIGO_DE_LA_CONSULTA NOT LIKE '890%'
LIMIT 10;


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
