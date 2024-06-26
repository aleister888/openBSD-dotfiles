#!/bin/sh

# Establecer fondo de pantalla
nitrogen --restore &

# Definir localización para ajustar el filtro de luz azul
LOCATION="$(curl -s "https://location.services.mozilla.com/v1/geolocate?key=geoclue" | jq -r '"\(.location.lat):\(.location.lng)"' &)"

# Cerrar instancias de dbus no usadas o reiniciar dbus
# OpenBSD es muy flexible con dbus, en Linux hacer esto daría más problemas
dbus-cleanup-sockets
if [ "$(pgrep dbus | wc -l)" -gt 3]; then
	pkill dbus
fi

# Ajustar DPI de la pantall
xrandr --dpi 96

doas /usr/bin/mixerctl outputs.hp_boost=on >/dev/null

# Establecer distribucción de teclado
setxkbmap -model pc104 -layout es,us  -option grp:win_space_toggle -option caps:none &

# Activar el click de la rueda del ratón
xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation" 1 &
xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Button" 2 &
xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Axes" 6 7 4 5 &

xset -dpms; xset s off &
# Actualizar archivo de recursos
xrdb ~/.config/Xresources &

# Lanzar nuestras aplicaciones is no lo estan ya
pgrep dbus || sh -c 'dbus-update-activation-environment --all & dbus-launch' &
pgrep picom		|| picom &
pgrep dunst		|| dunst &
pkill dwmblocks		;  dwmblocks &
pgrep redshift		|| redshift -l $LOCATION &

# Borrar archivos basura
while true; do
	rm ~/.serverauth* ~/*.core ~/.pki
	sleep 120;
done &
