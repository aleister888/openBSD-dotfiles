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
machdep.allowaperture=2

# Improve networking
net.inet.udp.recvspace=98304
net.inet.udp.sendspace=98304
net.inet.icmp.errppslimit=256' > /etc/sysctl.conf

# These values are meant for my 16GB RAM laptop,
# and usecase, where I run syncthing that needs
# a lot of file descriptors, ymmv.

echo '#!/usr/bin/sh

[ -f xrdb $HOME/.config/Xresources ] && xrdb $HOME/.config/Xresources

xclickroot -r $HOME/.local/scripts/xmenu.sh &

/usr/local/bin/dwm' > /etc/X11/xinit/xinitrc

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

syspatch
