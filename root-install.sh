#!/usr/local/bin/bash
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

multimedia_enable(){

if ! grep -q "record" /etc/sysctl.conf; then
# Si no esta ya activado, permitir acceder al micrófono y webcam
echo "kern.audio.record=1
kern.video.record=1" >> /etc/sysctl.conf
fi
# Establecer permisos para /dev/video0
chmod 640 /dev/video0

}

# Estos valores estan elegidos para mi portátil con 16GB RAM y mi uso específico.
# Deberias ajustarlos en función de tu necesidad más tarde

echo '#!/bin/sh

[ -f xrdb $HOME/.config/Xresources ] && xrdb $HOME/.config/Xresources

while true; do
	ck-launch-session /usr/local/bin/dwm >/dev/null 2>&1
done' > /etc/X11/xinit/xinitrc

echo '#!/bin/sh
python3 $HOME/.local/src/tauon-music-box/tauon.py' > /usr/local/bin/tauon

# Copiar attach a /etc/hotplug
doas cp ~/.dotfiles/attach /etc/hotplug/attach
chmod 0755 /etc/hotplug/attach

# Verificar hotplugd en /etc/rc.conf.local y agregar si no existe
if ! grep -q hotplugd /etc/rc.conf.local; then
    echo 'hotplugd_flags=""' >> /etc/rc.conf.local
fi

# Configurar ZSH
mkdir -p /etc/zsh
echo 'ZDOTDIR="$HOME"/.config/zsh' > /etc/zshenv
echo 'ZDOTDIR="$HOME"/.config/zsh' > /etc/zsh/zshenv

# Crear enlace simbólico para exa
ln -s /usr/local/bin/eza /usr/local/bin/exa 2>/dev/null

# Configurar unveil.main para ungoogled-chromium si no está configurado
if ! grep -q proxy /etc/ungoogled-chromium/unveil.main; then
    echo "
# Let's save us some trouble and provide access to everything
~/ rwc

# Needed for keepassxc-browser integration
/usr/local/bin r
/usr/local/bin/keepassxc-proxy rx" >> /etc/ungoogled-chromium/unveil.main
fi

# Copiar archivos necesarios a /var/icecast/etc
cp -p /etc/{hosts,localtime,resolv.conf} /var/icecast/etc
cp -p /usr/share/misc/mime.types /var/icecast/etc

# Instalar parches de seguridad
syspatch 2>/dev/null

read -rp "¿Desea permitir el uso de webcam/micrófono? (s/n): " answer

# Verifica la respuesta del usuario
if [ "$answer" = "s" ]; then
	multimedia_enable
fi
