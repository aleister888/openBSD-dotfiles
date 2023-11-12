#!/bin/sh

rm ~/.config/mimeapps.list

# Stow dotfiles
stow --target=${HOME}/.local/scripts/ scripts/
stow --target=${HOME}/.config/ .config/

# Symlink DWM autostart script
ln -s ~/.dotfiles/dwm/autostart.sh ~/.local/share/dwm/

# Symlink shell profile into home directory
ln -s ~/.dotfiles/.profile ~/

# Make a backup of my xinit script
cat /etc/X11/xinit/xinitrc > ~/.dotfiles/bckp/xinitrc
# Make a backup of my sysctl config
cat /etc/sysctl.conf > ~/.dotfiles/bckp/sysctl.conf
# Make a backup of my crontab
cat /etc/crontab > ~/.dotfiles/bckp/crontab

# Make a backup of login.conf values for staff and default
echo "staff" > ~/.dotfiles/bckp/staff
echo "$(getcap -f /etc/login.conf staff | sed 's/	/\\n/g')" | grep datasize | head -n2 >>		~/.dotfiles/bckp/staff
echo "$(getcap -f /etc/login.conf staff | sed 's/	/\\n/g')" | grep maxproc | head -n2 >>		~/.dotfiles/bckp/staff
echo "$(getcap -f /etc/login.conf staff | sed 's/	/\\n/g')" | grep openfiles | head -n2 >>	~/.dotfiles/bckp/staff
echo "default" > ~/.dotfiles/bckp/default
echo "$(getcap -f /etc/login.conf default | sed 's/	/\\n/g')" | grep datasize | head -n2 >>		~/.dotfiles/bckp/default
echo "$(getcap -f /etc/login.conf default | sed 's/	/\\n/g')" | grep maxproc | head -n2 >>		~/.dotfiles/bckp/default
echo "$(getcap -f /etc/login.conf default | sed 's/	/\\n/g')" | grep openfiles | head -n2 >>	~/.dotfiles/bckp/default
