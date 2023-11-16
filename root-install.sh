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

echo '#!/bin/sh

DEVCLASS=$1
DEVNAME=$2
MOUNTROOT="/mnt"
DEBUG=1
mount_helper=/sbin/mount
group_prem=1000
user_perm=1000
export DISPLAY=:0.0
export HOME=/home/aleister

case $DEVCLASS in
2)
    # disk devices
        /sbin/disklabel $DEVNAME 2>&1 | awk -F '[ ]*' '/^  [abd-z]:/' | while read line;
        do
        mount_flags="-o noexec,noatime,nodev"
                slice=`echo $line | awk -F ':' '{print $1}'`
                type=`echo $line | awk -F '[ ]*' '{print $4}'`
                case $type in
        ISO9660 | 4.2BSD)
                        ;;
        ext2fs)
            mount_flags="$mount_flags -r"
            ;;
        NTFS)
            mount_helper=/sbin/mount_ntfs
            mount_flags="$mount_flags -g $group_prem -u $user_perm"
            ;;
        MSDOS)
            mount_helper=/sbin/mount_msdos
            mount_flags="$mount_flags -g $group_prem -u $user_perm"
            ;;
        *)
            continue
            ;;
                esac

                [ $DEBUG == 1 ] && logger -i "hotplugd attaching SLICE $slice of DEVICE $DEVNAME"
        [ ! -d $MOUNTROOT/$DEVNAME$slice ] && mkdir -p -m 1777 $MOUNTROOT/$DEVNAME$slice
        $mount_helper $mount_flags /dev/$DEVNAME$slice $MOUNTROOT/$DEVNAME$slice
        /usr/local/bin/notify-send "Mounted $DEVNAME$slice ($type)"
        done
        ;;
3)
    # network devices; requires hostname.$DEVNAME
    sh /etc/netstart $DEVNAME
    ;;
esac' > /etc/hotplug/attach

chmod 0755 /etc/hotplug/attach

if [ "$(grep hotplugd /etc/rc.conf.local 2>&1)" = "" ]; then
	echo 'hotplugd_flags=""' >> /etc/rc.conf.local
fi

mkdir /etc/zsh

echo 'ZDOTDIR="$HOME"/.config/zsh' > /etc/zshenv
echo 'ZDOTDIR="$HOME"/.config/zsh' > /etc/zsh/zshenv

ln -s /usr/local/bin/eza /usr/local/bin/exa

syspatch
