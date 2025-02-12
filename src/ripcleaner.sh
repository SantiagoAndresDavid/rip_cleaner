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
ARCHIVO_CSV=""
PROCEDIMIENTOS=("eliminar_decimales" "actualizar_tipo_identificacion" "actualizar_finalidad_causa_externa" "actualizar_codigo_municipio")

# Leer argumentos
for arg in "$@"; do
  case $arg in
    --DB_NAME=*) DB_NAME="${arg#*=}" ;;
    --USER=*) USER="${arg#*=}" ;;
    --PORT=*) PORT="${arg#*=}" ;;
    --HOST=*) HOST="${arg#*=}" ;;
    --PASSWORD=*) PASSWORD="${arg#*=}" ;;
    --import_data) IMPORT_DATA=true ;;
    --ARCHIVO_CSV=*) ARCHIVO_CSV="${arg#*=}" ;;
    *) show_usage ;;
  esac
done

# Validar parámetros
validate_params "$DB_NAME" "$USER" "$PORT" "$HOST" "$PASSWORD"

# Verificar conexión
check_connection "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"

# Modo de importación
if [[ "$IMPORT_DATA" == true ]]; then
    validate_import_params "$ARCHIVO_CSV"
    import_csv "$ARCHIVO_CSV" "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"
else
    execute_procedures "${PROCEDIMIENTOS[@]}" "$DB_NAME" "$USER" "$HOST" "$PORT" "$PASSWORD"
fi

exit 0
