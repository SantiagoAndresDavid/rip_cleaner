-- paso 1 eliminar los decimales
SELECT eliminar_decimales();
-- paso 2 cambiar de CE Y NU POR PT
SELECT * FROM actualizar_tipo_identificacion();
-- paso 3 verificar los documentos por edad
SELECT * FROM validar_documentos_por_edad();
SELECT * FROM validar_documentos_por_edad(ARRAY['1067822461','1067822467','1067822479','1067822480']);
SELECT * FROM actualizar_tipo_documento_all('1067808836','CC');
SELECT * FROM actualizar_tipo_documento_all('1137733764','RC');
SELECT * FROM actualizar_tipo_documento_all('8010378','PT');
SELECT * FROM actualizar_tipo_documento_all('1067818914','TI');
-- paso 4 cambiar el departamento y el municipio
SELECT * FROM actualizar_codigo_municipio();
SELECT * FROM actualizar_codigo_departamento();
-- paso 5 actualizar el código de la factura
SELECT * FROM actualizar_codigo_factura('246671');
-- paso 6 actualizar la finalidad de la causa externa
SELECT * FROM actualizar_finalidad_causa_externa();
-- paso 7 actualizar la causa externa
SELECT * FROM actualizar_causa_externa();
SELECT * FROM actualizar_causa_externa_null();
--paso 8 actualizar vacíos
SELECT * FROM actualizar_diagnostico_vacio();
SELECT * FROM actualizar_diagnostico_vacio_ap();
SELECT * FROM actualizar_acto_quirurgico();
SELECT * FROM actualizar_tipo_diagnostico_principal();
SELECT * FROM actualizar_finalidad_procedimiento();

-- SOLUCIONES
        SELECT * FROM eliminar_usuario_y_registros_relacionados('6402357');
SELECT * FROM actualizar_finalidad_ap();


