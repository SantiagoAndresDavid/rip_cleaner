#!/bin/bash

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
    
    local patrones=("US*.csv" "AT*.csv" "AM*.csv" "AP*.csv" "AC*.csv")

    echo "📂 Buscando archivos en: $directorio_csv"
    
    for patron in "${patrones[@]}"; do
        echo "🔍 Buscando archivos con patrón: $patron"
        for archivo in "$directorio_csv"/$patron; do
            if [ -f "$archivo" ]; then
                local nombre_tabla=$(basename "$archivo" | cut -c 1-2)
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
