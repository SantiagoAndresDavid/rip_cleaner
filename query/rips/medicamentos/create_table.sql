create table medicamentos
(
    codigo_del_medicamento           text,
    tipo_de_medicamento              text,
    nombre_generico_del_medicamento  text,
    forma_farmaceutica               text,
    concentracion_del_medicamento    text,
    unidad_de_medida_del_medicamento text,
    numero_de_unidades               text,
    valor_unitario_del_medicamento   text,
    valor_total_del_medicamento      text
);

DELETE FROM medicamentos;
