#!/bin/bash

# Función para mostrar ayuda
show_usage() {
    echo -e "\e[1;35m
  ██████╗ ██╗██████╗      ██████╗██╗     ███████╗ █████╗ ███╗   ██╗███████╗██████╗ 
  ██╔══██╗██║██╔══██╗    ██╔════╝██║     ██╔════╝██╔══██╗████╗  ██║██╔════╝██╔══██╗
  ██████╔╝██║██████╔╝    ██║     ██║     █████╗  ███████║██╔██╗ ██║█████╗  ██████╔╝
  ██╔══██╗██║██╔═══╝     ██║     ██║     ██╔══╝  ██╔══██║██║╚██╗██║██╔══╝  ██╔══██╗
  ██║  ██║██║██║         ╚██████╗███████╗███████╗██║  ██║██║ ╚████║███████╗██║  ██║
  ╚═╝  ╚═╝╚═╝╚═╝          ╚═════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝
  ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
   𝙈𝙖𝙜𝙞𝙘 𝙞𝙣 𝙮𝙤𝙪𝙧 𝙧𝙞𝙥𝙨 ✨ 𝙎𝙚𝙖𝙢𝙡𝙚𝙨𝙨 𝙙𝙖𝙩𝙖𝙗𝙖𝙨𝙚 𝙢𝙖𝙞𝙣𝙩𝙚𝙣𝙖𝙣𝙘𝙚 𝙖𝙪𝙩𝙤𝙢𝙖𝙜𝙞𝙘
  clear-rips: $0 --DB_NAME=<nombre_bd> --USER=<usuario> --PORT=<puerto> 
       --HOST=<host> --PASSWORD=<contraseña> 
       [--import_data --ARCHIVO_CSV=<ruta>]
\e[0m"
    exit 0
}

# Función para validar parámetros requeridos
validate_params() {
    if [[ -z "$1" || -z "$2" || -z "$3" || -z "$4" || -z "$5" ]]; then
        echo "❌ Error: Faltan parámetros de conexión."
        show_usage
    fi
}

# Validar parámetros de importación
validate_import_params() {
    if [[ -z "$1" ]]; then
        echo "❌ Error: Falta --ARCHIVO_CSV en modo importación."
        show_usage
    fi
}

# Verificar conexión a PostgreSQL
check_connection() {
    PGPASSWORD="$5" psql -U "$2" -h "$3" -p "$4" -d "$1" -c "SELECT 1;" &>/dev/null
    if [[ $? -ne 0 ]]; then
        echo "❌ Error: No se pudo conectar a la base de datos."
        exit 1
    fi
    echo "✅ Conexión exitosa."
}
