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
CSV_MED="$(cd "$(dirname "$0")/../documentos/medicamentos/" && pwd)"

ASSISTANCE_PROCEDURES=(
    "eliminar_decimales"
    "actualizar_codigo_municipio"
    "actualizar_tipo_identificacion"
    "actualizar_codigo_departamento"
    "actualizar_finalidad_causa_externa"
    "actualizar_causa_externa"
    "actualizar_causa_externa_null"
    "actualizar_diagnostico_vacio"
    "actualizar_diagnostico_vacio_ap"
    "actualizar_acto_quirurgico"
    "actualizar_tipo_diagnostico_principal"
    "actualizar_finalidad_procedimiento"
    "actualizar_medicamentos"
)

PYM_PROCEDURES=(
    "eliminar_decimales"
    "actualizar_medicamentos"
    "actualizar_tipo_identificacion"
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
        --import_data) import_data=true ;;
        --ARCHIVO_CSV=*) ARCHIVO_CSV="${arg#*=}" ;;
        --create_and_import_assistance) create_and_import_assistance=true ;;
        --create_and_import_pym) create_and_import_pym=true ;;
        --clear_data_assitance) clear_data_assitance=true ;; 
        --clear_data_pym) clear_data_pym=true ;;
        --update_documents) update_documents=true ;;
        --update_code_dian) update_code_dian=true ;;
        --code_dian=*) code_dian="${arg#*=}" ;;
        --help) help=true ;;
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

case true in
    "$create_and_import_assistance")
        print_spaces_or_lines 2 "lines"  
        echo "⚙️ Creando TABLAS"
        create_structure_and_import "$SQL_TABLES" "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"
        print_spaces_or_lines 2 "lines"
        echo "⚙️ Creando SCRIPTS"
        create_structure_and_import "$SQL_ASSISTANCE" "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"
        print_spaces_or_lines 2 "lines"
        echo "📥 Iniciando importación de archivos CSV..." 
        print_spaces_or_lines 2 "lines" 
        if [[ -n "$ARCHIVO_CSV" ]]; then
            validate_import_params "$ARCHIVO_CSV"
            import_csv "$ARCHIVO_CSV" "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"
            #imported med 
            echo "⚙️ importando medicamentos"
            import_csv "$CSV_MED" "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"
        else
            echo "⚠️ No se ha especificado un directorio CSV. Usa --ARCHIVO_CSV=/ruta/al/directorio"
            exit 1
        fi
            ;;
    
    "$create_and_import_pym")
        print_spaces_or_lines 2 "lines"  
        echo "⚙️ Creando TABLAS"
        create_structure_and_import "$SQL_TABLES" "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"
        print_spaces_or_lines 2 "lines"
        echo "⚙️ Creando SCRIPTS"
        create_structure_and_import "$SQL_PYM" "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"
                print_spaces_or_lines 2 "lines" 
        if [[ -n "$ARCHIVO_CSV" ]]; then
            validate_import_params "$ARCHIVO_CSV"
            import_csv "$ARCHIVO_CSV" "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"
            #imported med 
            echo "⚙️ importando medicamentos"
            import_csv "$CSV_MED" "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"
        else
            echo "⚠️ No se ha especificado un directorio CSV. Usa --ARCHIVO_CSV=/ruta/al/directorio"
            exit 1
        fi
        ;;

    "$clear_data_pym")
        print_spaces_or_lines 2 "lines"
        echo "⚙️ Limpiando datos PYM"
        print_spaces_or_lines 2 "lines"
        execute_procedures "${PYM_PROCEDURES[@]}" "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"
        ;;

    "$clear_data_assitance")
        print_spaces_or_lines 2 "lines"
        echo "⚙️ Limpiando datos asistenciales"
        print_spaces_or_lines 2 "lines"
        execute_procedures "${ASSISTANCE_PROCEDURES[@]}" "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"
        ;;

    "$update_documents")
        print_spaces_or_lines 2 "lines"
        echo "⚙️ BUscando documentos probables para actualizar"
        print_spaces_or_lines 2 "lines"
        search_error_documents "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"
    ;;
    "$update_code_dian")
        print_spaces_or_lines 2 "lines"
        echo "⚙️ Actualizando código DIAN"
        print_spaces_or_lines 2 "lines"
        update_code_dian "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"
    ;;
    "$HELP")
        show_usage
        ;;
esac
exit 0
