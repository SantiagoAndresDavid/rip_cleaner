DROP TABLE US CASCADE;
CREATE TABLE US (
                    TIPO_DE_IDENTIFICACION_DEL_USUARIO TEXT,
                    NUMERO_DE_IDENTIFICACION_DEL_USUARIO_DEL_SISTEMA TEXT PRIMARY KEY,
                    CODIGO_ENTIDAD_ADMINISTRADORA TEXT,
                    TIPO_DE_USUARIO TEXT,
                    PRIMER_APELLIDO_DEL_USUARIO TEXT,
                    SEGUNDO_APELLIDO_DEL_USUARIO TEXT,
                    PRIMER_NOMBRE_DEL_USUARIO TEXT,
                    SEGUNDO_NOMBRE_DEL_USUARIO TEXT,
                    EDAD TEXT,
                    UNIDAD_DE_MEDIDA_EN_LA_EDAD TEXT,
                    SEXO TEXT,
                    CODIGO_DEL_DEPARTAMENTO_DE_RESIDENCIA_HABITUAL TEXT,
                    CODIGO_DEL_MUNICIPIO_DE_RESIDENCIA_HABITUAL TEXT,
                    ZONA_DE_RESIDENCIA_HABITUAL TEXT
);

COMMENT ON COLUMN US.UNIDAD_DE_MEDIDA_EN_LA_EDAD IS '1 = Años, 2 = Meses, 3 = Días';


