#!/bin/sh
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
net.inet.icmp.errppslimit=256

# Enable Microphone/Webcam Access
kern.audio.record=1
kern.video.record=1' > /etc/sysctl.conf

# These values are meant for my 16GB RAM laptop,
# and usecase, where I run syncthing that needs
# a lot of file descriptors, ymmv.

echo '#!/usr/bin/sh

[ -f xrdb $HOME/.config/Xresources ] && xrdb $HOME/.config/Xresources

xclickroot -r $HOME/.local/scripts/xmenu.sh &

while true; do
	ck-launch-session /usr/local/bin/dwm >/dev/null 2>&1
done' > /etc/X11/xinit/xinitrc

echo '#!/bin/sh
python3 ~/.local/src/tauon-music-box/tauon.py' > /usr/local/bin/tauon

chmod +x /usr/local/bin/tauon

doas cp ~/.dotfiles/attach /etc/hotplug/attach

chmod 0755 /etc/hotplug/attach

if [ "$(grep hotplugd /etc/rc.conf.local 2>&1)" = "" ]; then
	echo 'hotplugd_flags=""' >> /etc/rc.conf.local
fi

mkdir /etc/zsh

echo 'ZDOTDIR="$HOME"/.config/zsh' > /etc/zshenv
echo 'ZDOTDIR="$HOME"/.config/zsh' > /etc/zsh/zshenv

ln -s /usr/local/bin/eza /usr/local/bin/exa

grep "proxy" /etc/ungoogled-chromium/unveil.main || \
echo "
# needed for keepassxc integration
/usr/local/bin r
/usr/local/bin/keepassxc-proxy rx" >> /etc/ungoogled-chromium/unveil.main

cp -p /etc/{hosts,localtime,resolv.conf} /var/icecast/etc
cp -p /usr/share/misc/mime.types /var/icecast/etc

chmod 640 /dev/video0

syspatch
