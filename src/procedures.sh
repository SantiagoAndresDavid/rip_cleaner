#!/bin/bash

# Función para ejecutar procedimientos almacenados
execute_procedure() {
    local nombre_proc="$1"
    local db="$2"
    local user="$3"
    local host="$4"
    local port="$5"
    local password="$6"
    
    echo "🚀 Ejecutando procedimiento: $nombre_proc..."
    RESULT=$(PGPASSWORD="$password" psql -U "$user" -h "$host" -p "$port" -d "$db" \
        --set=client_encoding=UTF8 \
        -P expanded=off \
        -P pager=off \
        -c "SELECT * FROM $nombre_proc();")

    if [[ -z "$RESULT" ]]; then
        echo "⚠️ No se obtuvo ningún resultado de $nombre_proc."
    else
        echo "✅ Resultados de $nombre_proc:"
        echo "$RESULT"
    fi
}

# Función para ejecutar todos los procedimientos en orden
execute_procedures() {
    local procedimientos=("$@")
    local db="${procedimientos[-5]}"
    local user="${procedimientos[-4]}"
    local host="${procedimientos[-3]}"
    local port="${procedimientos[-2]}"
    local password="${procedimientos[-1]}"
    
    unset procedimientos[-5] procedimientos[-4] procedimientos[-3] procedimientos[-2] procedimientos[-1]

    for procedimiento in "${procedimientos[@]}"; do
        echo -e "\n▶️ Presiona **ESPACIO** para continuar con $procedimiento o cualquier otra tecla para salir..."
        IFS= read -rs -n1 key
        if [[ "$key" == " " ]]; then
            execute_procedure "$procedimiento" "$db" "$user" "$host" "$port" "$password"
        else
            echo "⏹️ Proceso cancelado."
            exit 0
        fi
    done
}
