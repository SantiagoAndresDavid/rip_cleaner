#!/bin/bash

#
execute_create(){
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

# Función para ejecutar procedimientos almacenados
execute_procedure() {
    local nombre_proc="$1"
    local db="$2"
    local user="$3"
    local host="$4"
    local port="$5"
    local password="$6"
    local id_person="$7"
    local document_type="$8"
    local code_dian="$9"

    echo "🚀 Ejecutando procedimiento: $nombre_proc..."

    local query="SELECT * FROM $nombre_proc("
    local params=()

    # Agregar parámetros si están presentes
    [[ -n "$id_person" ]] && params+=("'$id_person'")
    [[ -n "$document_type" ]] && params+=("'$document_type'")
    [[ -n "$code_dian" ]] && params+=("'$code_dian'")

    # Unir parámetros con comas
    query+=$(IFS=,; echo "${params[*]}")");"

    echo "🛠️ Query final: $query"

    RESULT=$(PGPASSWORD="$password" psql -U "$user" -h "$host" -p "$port" -d "$db" \
        --set=client_encoding=UTF8 -P expanded=off -P pager=off -c "$query")

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

search_error_documents(){
    local db="$1"
    local user="$2"
    local host="$3"
    local port="$4"
    local password="$5"

    while true; do
        echo -e "\n▶️ Presiona **ESPACIO** para continuar con $procedimiento o cualquier otra tecla para salir..."
        IFS= read -rs -n1 key
        if [[ "$key" == " " ]]; then
            execute_procedure "validar_documentos_por_edad" "$db" "$user" "$host" "$port" "$password"
            fix_error_documents "$db" "$user" "$host" "$port" "$password"
        else
            echo "⏹️ Proceso cancelado."
            break  # Usamos break en lugar de exit 0 para no detener todo el script
        fi
    done
}

fix_error_documents() {
    local db="$1"
    local user="$2"
    local host="$3"
    local port="$4"
    local password="$5"

    echo -e "\n▶️ Presiona **ESPACIO** para continuar con actualizar_tipo_documento_all o cualquier otra tecla para salir..."
    IFS= read -rs -n1 key

    if [[ "$key" == " " ]]; then
        read -p "🆔 Ingresa el ID de la persona (dejar vacío si no aplica): " id_person
        read -p "📄 Ingresa el tipo de documento (dejar vacío si no aplica): " document_type

        execute_procedure "actualizar_tipo_documento_all" "$db" "$user" "$host" "$port" "$password" "$id_person" "$document_type"
    else
        echo "⏹️ Proceso cancelado."
        exit 0
    fi
}


update_code_dian(){
    local db="$1"
    local user="$2"
    local host="$3"
    local port="$4"
    local password="$5" 

    echo -e "\n▶️ Presiona **ESPACIO** para continuar con actualizar_tipo_documento_all o cualquier otra tecla para salir..."
    IFS= read -rs -n1 key

    if [[ "$key" == " " ]]; then
        read -p "🆔 Ingresa el ID de la persona (dejar vacío si no aplica): " code_dian
        echo "🔍 Código DIAN capturado: '$code_dian'"
        execute_procedure "actualizar_codigo_factura" "$db" "$user" "$host" "$port" "$password" "$code_dian"
    else
        echo "⏹️ Proceso cancelado."
        exit 0
    fi
}