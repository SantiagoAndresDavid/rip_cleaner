#!/bin/bash
source "$(dirname "$0")/utils.sh"

# Función para limpiar espacios en el CSV
clean_csv() {
    local archivo="$1"
    echo "🛠️ Limpiando espacios en: $archivo"
    sed -i 's/ *, */,/g' "$archivo"
    sed -i 's/^ *//;s/ *$//' "$archivo"
    echo "✅ Archivo limpio: $archivo"
}

# Función para importar CSV a PostgreSQL
import_csv() {
    local directorio_csv="$1"
    local db="$2"
    local user="$3"
    local host="$4"
    local port="$5"
    local password="$6"
    local patrones=("US*.csv" "AT*.csv" "AM*.csv" "AP*.csv" "AC*.csv" "medicamentos.csv")

    echo "📂 Buscando archivos en: $directorio_csv"
    for patron in "${patrones[@]}"; do
        echo "🔍 Buscando archivos con patrón: $patron"
        for archivo in "$directorio_csv"/$patron; do
            if [ -f "$archivo" ]; then
                case "$(basename "$archivo")" in
                    US*) nombre_tabla="us" ;;
                    AT*) nombre_tabla="at" ;;
                    AM*) nombre_tabla="am" ;;
                    AP*) nombre_tabla="ap" ;;
                    AC*) nombre_tabla="ac" ;;
                    medicamentos.csv) nombre_tabla="medicamentos" ;;  # ¡Aquí está la corrección!
                    *) echo "⚠️ No se reconoce la tabla para $archivo"; continue ;;
                esac

                clean_csv "$archivo"
                echo "📤 Importando $archivo a tabla $nombre_tabla..."
                PGPASSWORD="$password" psql -U "$user" -h "$host" -p "$port" -d "$db" -c \
                    "\copy $nombre_tabla FROM '$archivo' DELIMITER ',' CSV ENCODING 'LATIN1';"
                if [[ $? -ne 0 ]]; then
                    echo "❌ Error al importar $archivo"
                    exit 1
                else
                    echo "✅ $archivo importado correctamente."
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

    # Obtener la lista de archivos .sql en orden inverso
    local sql_files=($(ls -1 "$folder"/*.sql 2>/dev/null | sort -r))

    # Verificar si hay archivos SQL en la carpeta
    if [[ ${#sql_files[@]} -eq 0 ]]; then
        echo "⚠️ No se encontraron archivos .sql en $folder."
        return 1
    fi

    for sql_file in "${sql_files[@]}"; do
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
    echo "✅ ¡Se creó la estructura y los scripts!"
}


