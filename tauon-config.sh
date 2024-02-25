#!/usr/local/bin/bash

rm "$HOME/.local/src/tauon-music-box/user-data/state*" "$HOME/.local/src/tauon-music-box/user-data/tauon.conf"

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
sed -i 's/font-main-standard = ".*"/font-main-standard = "agave Nerd Font Mono"/g' "$CONF"
sed -i 's/font-main-medium = ".*"/font-main-medium = "Iosevka Nerd Font Medium"/g' "$CONF"
sed -i 's/font-main-bold = ".*"/font-main-bold = "Iosevka Nerd Font Bold"/g' "$CONF"
sed -i 's/font-main-condensed = ".*"/font-main-condensed = "Iosevka Nerd Font"/g' "$CONF"
sed -i 's/font-main-condensed-bold = ".*"/font-main-condensed-bold = "Iosevka Nerd Font Bold"/g' "$CONF"

# Vamos a activar al búsqueda de artista y la búsqueda de letras.

# Tauon guarda estos ajustes en el archivo binario state.p
# Los bytes que corresponden a los parámetros que queremos ajustar son:
# 251, 463, 483, 793
# Donde el valor para activado es 210 (Por defecto es 211, desactivado).

# Vamos a cambiar los bytes para este archivo
archivo="$HOME/.local/src/tauon-music-box/user-data/state.p"

# Definimos las posiciones-1 de los bytes y el nuevo valor
posiciones_bytes=(250 462 482 792)
nuevo_valor_byte="\210"

# Iteramos sobre cada posición de byte y modificamos el valor del byte
for pos in "${posiciones_bytes[@]}"; do
    printf "$nuevo_valor_byte" | dd of="$archivo" bs=1 seek="$pos" count=1 conv=notrunc status=none
done
