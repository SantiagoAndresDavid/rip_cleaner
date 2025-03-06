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
import_data=false
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
    ""
)
# Leer argumentos
for arg in "$@"; do
    case $arg in
        --DB_NAME=*) DB_NAME="${arg#*=}" ;;
        --USER=*) USER="${arg#*=}" ;;
        --PORT=*) PORT="${arg#*=}" ;;
        --HOST=*) HOST="${arg#*=}" ;;
        --PASSWORD=*) PASSWORD="${arg#*=}" ;;
        --import_data) import_data=true ;;
        --ARCHIVO_CSV=*) ARCHIVO_CSV="${arg#*=}" ;;
        --create_and_import_assistance) create_and_import_assistance=true ;;
        --clear_data_assitance) clear_data_assitance=true ;; 
        --CLEAR_DATA_RIPS) CLEAR_DATA_RIPS=true ;;
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
if [[ "$import_data" == true ]]; then
    # Validar que el archivo CSV exista antes de importar
    validate_import_params "$ARCHIVO_CSV"
    import_csv "$ARCHIVO_CSV" "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"

elif [[ "$create_and_import_assistance" == true ]]; then
    print_spaces_or_lines 2 "lines"  
    echo "⚙️ Creando TABLAS"
    # Imprime 3 saltos de línea
    create_structure_and_import "$SQL_TABLES" "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"
    print_spaces_or_lines 2 "lines"
    echo "⚙️ Creando SCRIPTS"
    create_structure_and_import "$SQL_ASSISTANCE" "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"
elif [[ "$CLEAR_DATA_RIPS" == true ]]; then
    print_spaces_or_lines 2 "lines"
    echo "⚙️ Limpiando datos PYM"


elif [[ "$clear_data_assitance" == true ]]; then
    print_spaces_or_lines 2 "lines"
    echo "⚙️ Limpiando datos asistenciales"
    print_spaces_or_lines 2 "lines"
    execute_procedures "${ASSISTANCE_PROCEDURES[@]}" "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"
fi

exit 0
