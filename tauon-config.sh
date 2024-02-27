#!/usr/local/bin/bash

rm $HOME/.local/src/tauon-music-box/user-data/state* ;\
rm $HOME/.local/src/tauon-music-box/user-data/tauon.conf

# Primero vamos a iniciar tauon para que se creen los archivos que queremos editar

tauon >/dev/null & sleep 5; \
	kill $(ps aux | grep 'python3:.*tau' | awk '{print $2}')

sleep 10;

# Script para configurar automaticamente Tauon Music Box

# Vamos a manipular primero el archivo de configuración (Texto)

# Archivo de configuración
CONF="$HOME/.local/src/tauon-music-box/user-data/tauon.conf"

# Aplicar configuraciones usando sed
# Activar Opciones
sed -i 's/auto-dl-artist-data = false/auto-dl-artist-data = true/g' "$CONF"
sed -i 's/auto-update-playlists = false/auto-update-playlists = true/g' "$CONF"
sed -i 's/auto-search-lyrics = false/auto-search-lyrics = true/g' "$CONF"

# Desactivar el recordar la posición para hacer la aplicación mas amigable con DWM
sed -i 's/restore-window-position = true/restore-window-position = false/g' "$CONF"

# Cambiar el tamaño del UI
sed -i 's/ui-scale = .\..*/ui-scale = 1.10/g' "$CONF"
sed -i 's/auto-scale = true/auto-scale = false/g' "$CONF"

# Cambiar el Tema
sed -i 's/theme-name = ".*"/theme-name = "aleister-gruvbox"/g' "$CONF"

# Ccambiar las fuentes usadas
sed -i 's/use-custom-fonts = false/use-custom-fonts = true/g' "$CONF"
sed -i 's/font-main-standard = ".*"/font-main-standard = "Iosevka Nerd Font Mono"/g' "$CONF"
sed -i 's/font-main-medium = ".*"/font-main-medium = "Iosevka Nerd Font Medium"/g' "$CONF"
sed -i 's/font-main-bold = ".*"/font-main-bold = "Iosevka Nerd Font Bold"/g' "$CONF"
sed -i 's/font-main-condensed = ".*"/font-main-condensed = "Iosevka Nerd Font"/g' "$CONF"
sed -i 's/font-main-condensed-bold = ".*"/font-main-condensed-bold = "Iosevka Nerd Font Bold"/g' "$CONF"

# Vamos a activar al búsqueda de artista y la búsqueda de letras.

# Tauon guarda estos ajustes en el archivo binario state.p
# Los bytes que corresponden a los parámetros que queremos ajustar suelen
# estar entorno a las posiciones 250, 460, 480 y 800
# Donde el valor para activado es 210 y 211, desactivado.
#
# Aveces la posición cambia al generarse state.p pero los valores que rodean
# al byte, no. Vamos a buscar en que bytes state.p guarda estos ajustes y modifcarlos.

file="$HOME/.local/src/tauon-music-box/user-data/state.p"

# Definimos los rangos de bytes para buscar
range1=( {200..350} )
range2=( {400..550} )
range3=( {450..600} )
range4=( {750..900} )

# Función para buscar la secuencia deseada en un rango específico
search_sequence() {
    local prev_value1=$1
    local prev_value2=$2
    local next_value=$3
    local range=("${!4}")

    for byte_position in "${range[@]}"; do
        current_byte=$(dd if="$file" bs=1 count=1 skip="$byte_position" 2>/dev/null | od -An -t o1)
        if [ -z "$current_byte" ]; then
            break
        fi

        prev_byte=$(dd if="$file" bs=1 count=1 skip=$(( byte_position - 1 )) 2>/dev/null | od -An -t o1)
        next_byte=$(dd if="$file" bs=1 count=1 skip=$(( byte_position + 1 )) 2>/dev/null | od -An -t o1)

        if [[ ( "$prev_byte" -eq "$prev_value1" || "$prev_byte" -eq "$prev_value2" ) && "$next_byte" -eq "$next_value" ]]; then
            echo "Byte precedido por $prev_value1 o $prev_value2 y seguido por $next_value encontrado en la posición: $byte_position"
            # Cambiamos el valor del byte a 210
            printf '\210' | dd of="$file" bs=1 seek="$byte_position" count=1 conv=notrunc 2>/dev/null
        fi
    done
}

# Buscamos en los rangos especificados y modificamos los bytes encontrados
search_sequence 210 210 116 range1[@]
search_sequence 026 033 211 range2[@]
search_sequence 224 224 135 range3[@]
search_sequence 006 006 116 range4[@]
