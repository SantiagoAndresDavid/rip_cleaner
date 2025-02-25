#!/bin/bash

# Cargar módulos externos
source "$(dirname "$0")/utils.sh"
source "$(dirname "$0")/import.sh"
source "$(dirname "$0")/procedures.sh"

# Variables predeterminadas
DB_NAME=""
USER=""
PORT="5432"
HOST=""
PASSWORD=""
IMPORT_DATA=false
CREATE_AND_IMPORT=false
ARCHIVO_CSV=""
SQL_ASSISTANCE="$(cd "$(dirname "$0")/../query/rips/functions" && pwd)"
SQL_PYM="$(cd "$(dirname "$0")/../query/rips/functions/PYM" && pwd)"
SQL_TABLES="$(cd "$(dirname "$0")/../query/rips/functions/tables" && pwd)"

ASSISTANCE_PROCEDURES=(
    "eliminar_decimales"
    "actualizar_codigo_municipio"
    "actualizar_codigo_departamento"
    "actualizar_finalidad_causa_externa"
    "actualizar_causa_externa"
    "actualizar_causa_externa_null"
    "actualizar_diagnostico_vacio"
    "actualizar_diagnostico_vacio_ap"
    "actualizar_acto_quirurgico"
    "actualizar_tipo_diagnostico_principal"
    "actualizar_finalidad_procedimiento"
)
PYM_PROCEDURES=(
    "eliminar_decimales"
    "actualizar_medicamentos"
    "eliminar_duplicados_ac"
    "actualizar_tipo_identificacion"
    "validar_documentos_por_edad"
    "actualizar_codigo_municipio"
    "actualizar_codigo_departamento"
    "actualizar_finalidad_diagnostico_niños"
    "actualizar_finalidad_diagnostico_niños_ap"
    "actualizar_causa_externa"
    "actualizar_finalidad_de_la_causa_externa_consulta"
    "actualizar_diagnostico_vacio"
    "actualizar_diagnostico_vacio_ap"
    "actualizar_tipo_diagnostico_principal"
    "actualizar_finalidad_procedimiento"
    "actualizar_codigos_procedimientos_erroneos"
    "actualizar_forma_realizacion_acto_quirurgico"
)
# Leer argumentos
for arg in "$@"; do
    case $arg in
        --DB_NAME=*) DB_NAME="${arg#*=}" ;;
        --USER=*) USER="${arg#*=}" ;;
        --PORT=*) PORT="${arg#*=}" ;;
        --HOST=*) HOST="${arg#*=}" ;;
        --PASSWORD=*) PASSWORD="${arg#*=}" ;;
        --IMPORT_DATA) IMPORT_DATA=true ;;
        --ARCHIVO_CSV=*) ARCHIVO_CSV="${arg#*=}" ;;
        --CREATE_AND_IMPORT_ASSISTANCE) CREATE_AND_IMPORT_ASSISTANCE=true ;;
        --CREATE_AND_IMPORT_PYM) CREATE_AND_IMPORT_PYM=true ;;
        --CLEAR_DATA_ASSITANCE) CLEAR_DATA_ASSITANCE=true ;; 
        --CLEAR_DATA_PYM) CLEAR_DATA_PYM=true ;;
        --UPDATE_DOCUMENTS) UPDATE_DOCUMENTS=true ;;
        *) 
            echo "❌ Opción desconocida: $arg"
            usage
            exit 1
            ;;
    esac
done

# Validar parámetros obligatorios
validate_params "$DB_NAME" "$USER" "$PORT" "$HOST" "$PASSWORD"
print_spaces_or_lines 1 "lines"  
# Verificar conexión a la base de datos
check_connection "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"

# Modo de importación
if [[ "$IMPORT_DATA" == true ]]; then
    # Validar que el archivo CSV exista antes de importar
    validate_import_params "$ARCHIVO_CSV"
    import_csv "$ARCHIVO_CSV" "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"

elif [[ "$CREATE_AND_IMPORT_ASSISTANCE" == true ]]; then
    print_spaces_or_lines 2 "lines"  
    echo "⚙️ Creando TABLAS"
    # Imprime 3 saltos de línea
    create_structure_and_import "$SQL_TABLES" "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"
    print_spaces_or_lines 2 "lines"
    echo "⚙️ Creando SCRIPTS"
    create_structure_and_import "$SQL_ASSISTANCE" "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"

elif [[ "$CREATE_AND_IMPORT_PYM" == true ]]; then
    print_spaces_or_lines 2 "lines"  
    echo "⚙️ Creando TABLAS"
    # Imprime 3 saltos de línea
    create_structure_and_import "$SQL_TABLES" "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"
    print_spaces_or_lines 2 "lines"
    echo "⚙️ Creando SCRIPTS"
    create_structure_and_import "$SQL_PYM" "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"
elif [[ "$CLEAR_DATA_PYM" == true ]]; then
    print_spaces_or_lines 2 "lines"
    echo "⚙️ Limpiando datos PYM"
    print_spaces_or_lines 2 "lines"
    execute_procedures "${PYM_PROCEDURES[@]}" "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"
elif [[ "$CLEAR_DATA_ASSITANCE" == true ]]; then
    print_spaces_or_lines 2 "lines"
    echo "⚙️ Limpiando datos asistenciales"
    print_spaces_or_lines 2 "lines"
    execute_procedures "${ASSISTANCE_PROCEDURES[@]}" "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"
fi

exit 0
