#!/bin/bash
source "$(dirname "$0")/utils.sh"

# Función para limpiar espacios en el CSV
clean_csv() {
    local file="$1"
    echo "🛠️ Limpiando espacios en: $file"
    sed -i 's/ *, */,/g' "$file"
    sed -i 's/^ *//;s/ *$//' "$file"
    echo "✅ file limpio: $file"
}

# Función para importar CSV a PostgreSQL
import_csv() {
    local directory_csv="$1"
    local db="$2"
    local user="$3"
    local host="$4"
    local port="$5"
    local password="$6"
    
    local file_type=("US*.csv" "AT*.csv" "AM*.csv" "AP*.csv" "AC*.csv")

    echo "📂 Buscando archivos en: $directory_csv"
    
    for pattern in "${file_type[@]}"; do
        echo "🔍 Buscando archivos con patrón: $pattern"
        for file in "$directory_csv"/$pattern; do
            if [ -f "$file" ]; then
                local table_name=$(basename "$file" | cut -c 1-2)
                clean_csv "$file"
                echo "📤 Importando $file a tabla $table_name..."
                
                PGPASSWORD="$password" psql -U "$user" -h "$host" -p "$port" -d "$db" -c \
                    "\copy $table_name FROM '$file' DELIMITER ',' CSV ENCODING 'LATIN1';"

                if [[ $? -ne 0 ]]; then
                    echo "❌ Error al importar $file"
                    exit 1
                else
                    echo "✅ $file importado correctamente."
                    sleep 1
                fi
            fi
        done
    done
    echo "✅ ¡Importación completada!"
}

create_structure_and_import(){
    local folder="$1"
    local db="$2"
    local user="$3"
    local host="$4"
    local port="$5"
    local password="$6"


    for sql_file in "$folder"/*.sql; do
        # Verificar si hay archivos SQL en la carpeta
        if [[ ! -f "$sql_file" ]]; then
            echo "⚠️ No se encontraron archivos .sql en $folder."
            return 1
        fi

        echo "🚀 Ejecutando archivo SQL: $sql_file..."
        RESULT=$(PGPASSWORD="$password" psql -U "$user" -h "$host" -p "$port" -d "$db" \
            --set=client_encoding=UTF8 \
            -P expanded=off \
            -P pager=off \
            -f "$sql_file" 2>&1)

        # Verificar si la ejecución fue exitosa
        if [[ $? -ne 0 ]]; then
            echo "❌ Error al ejecutar $sql_file:"
            echo "$RESULT"
        else
            echo "✅ Archivo $sql_file ejecutado correctamente."
        fi
    done
    print_line 200
    echo "✅ ¡Se creo la estructura y los scripts!"
}