#!/usr/local/bin/bash

# Modificar la configuración del kernel
mod_sysctl(){
cp /etc/sysctl.conf /etc/sysctl.conf.bak
echo '# Enable hyper-threading
hw.smt=1
# Maximum file descriptors
kern.maxfiles=16384
# Memory freeing
kern.bufcachepercent=90
# Shared Memory
kern.shminfo.shmall=131072
kern.shminfo.shmmni=1024
# Maximum number of threads
kern.maxthread=4096

# Smophores
kern.shminfo.shmseg=2048
kern.seminfo.semmns=4096
kern.seminfo.semmni=1024

kern.maxvnodes=8192
kern.somaxconn=2048
machdep.allowaperture=1

# Improve networking
net.inet.udp.recvspace=262144
net.inet.udp.sendspace=262144
net.inet.icmp.errppslimit=256' > /etc/sysctl.conf
}

lfdesktop(){
echo "[Desktop Entry]
Type=Application
Name=lf
Comment=Launches the lf file manager
Icon=utilities-terminal
Terminal=false
Exec=st lf
Categories=ConsoleOnly;System;FileTools;FileManager
MimeType=inode/directory;" > /usr/local/share/applications/lf.desktop && \
chmod 644 /usr/local/share/applications/lf.desktop
}

# Activar la webcam y el micrófono
multimedia_enable(){
if ! grep -q "record" /etc/sysctl.conf; then
# Si no esta ya activado, permitir acceder al micrófono y webcam
echo "kern.audio.record=1
kern.video.record=1" >> /etc/sysctl.conf
install -m 777 /dev/null /tmp/multimedia
fi
# Establecer permisos para /dev/video0
chmod 640 /dev/video0
}

# Instalar script para iniciar X11
xinit_make(){
echo '#!/bin/sh

[ -f xrdb $HOME/.config/Xresources ] && xrdb $HOME/.config/Xresources

while true; do
	/usr/local/bin/dwm >/dev/null 2>&1
done' > /etc/X11/xinit/xinitrc
}

# Instalar script para ejecutar el reproductor de música
tauon_script(){
echo '#!/bin/sh
python3 $HOME/.local/src/tauon-music-box/tauon.py' > /usr/local/bin/tauon
chmod 0755 /usr/local/bin/tauon
}

# Instalar servicio de automontado de discos duros
hotplugd_install(){
cp ./attach /etc/hotplug/attach
chmod 0755 /etc/hotplug/attach
if ! grep -q hotplugd /etc/rc.conf.local; then
    echo 'hotplugd_flags=""' >> /etc/rc.conf.local
fi
}

# Configurar ZSH
zsh_config(){
mkdir -p /etc/zsh
echo 'ZDOTDIR="$HOME"/.config/zsh' > /etc/zshenv
echo 'ZDOTDIR="$HOME"/.config/zsh' > /etc/zsh/zshenv
}

# Configurar unveil.main para ungoogled-chromium si no está configurado
chrome_unveil(){
if ! grep -q proxy /etc/chromium/unveil.main; then
    echo "
# Needed for keepassxc-browser integration
/usr/local/bin r
/usr/local/bin/keepassxc-proxy rx" >> /etc/chromium/unveil.main
fi
}

ports_setup(){
	if [ ! -d /usr/ports ]; then
		cd /usr && cvs -qd anoncvs@anoncvs.fr.openbsd.org:/cvs checkout -P ports
	fi
}

staff-changes(){
# Si el número máximo de archivos no esta definido para staff, definelo
grep "openfiles-cur=16384" /etc/login.conf || \
	sed -i 's/staff:\\$/staff:\\\
	:openfiles-cur=16384:\\/g' /etc/login.conf
}

# Crear enlace simbólico para exa
ln -s /usr/local/bin/eza /usr/local/bin/exa 2>/dev/null

# Copiar archivos necesarios a /var/icecast/etc
cp -p /etc/{hosts,localtime,resolv.conf} /var/icecast/etc
cp -p /usr/share/misc/mime.types /var/icecast/etc

# Instalar parches de seguridad
syspatch 2>/dev/null

# Ejecutar funciones

if mod_sysctl; then
	echo "Se modifico correctamente /etc/sysctl.conf"
else
	echo "Hubo un error al modificar /etc/sysctl.conf"
fi

if xinit_make; then
	echo "/etc/X11/xinit/xinirc se creo correctamente"
else
	echo "/etc/X11/xinit/xinirc no se pudo crear"
fi

if tauon_script; then
	echo "El script para iniciar el reproductor de música se creo correctamente"
else
	echo "Hubo un error al crear el script para iniciar el reproductor de música"
fi

if hotplugd_install; then
	echo "El servicio de automontado se activo correctamente"
else
	echo "Hubo un error al instalar el servicio de automontado"
fi

if zsh_config; then
	echo "Se definio el archivo de configuración de ZSH correctamente"
else
	echo "Hubo un fallo al definir la localización del archivo de configuración de ZSH"
fi

if chrome_unveil; then
	echo "Chrome se configuró correctamente"
else
	echo "Hubo un error al configurar Chrome"
fi

if lfdesktop; then
	echo "Acceso directo de lf creado exitosamente"
else
	echo "No se pudo crear el acceso directo de lf"
fi

# Respuesta por defecto
default_answer="s"

# Preguntar si activar la webcam y el micrófono
read -rp "¿Desea permitir el uso de webcam/micrófono? (S/n): " answer1
answer1=${answer1:-$default_answer}  # Si la respuesta está vacía, establece la respuesta predeterminada

if [ "${answer1,,}" = "s" ]; then
	multimedia_enable
fi

# Pregunta si cambiar los limites del grupo staff
read -rp "¿Desea establecer los limites recomendados para el grupo staff? (S/n): " answer2
answer2=${answer2:-$default_answer}  # Si la respuesta está vacía, establece la respuesta predeterminada

# Verifica la respuesta del usuario
if [ "${answer2,,}" = "s" ]; then
	staff-changes
fi

# Preguntar si se desea descargar el código de los ports
read -rp "¿Desea descargar los ports? (S/n): " answer3
answer3=${answer3:-$default_answer}

if [ "${answer3,,}" = "s" ]; then
	ports_setup
fi
