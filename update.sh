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
# Make a backup of my mixerctl config
cat /etc/mixerctl.conf > ~/.dotfiles/bckp/mixerctl.conf

# Make some configuration user-agnostic

echo "file:///home/`whoami`/Downloads" > ~/.dotfiles/.config/gtk-3.0/bookmarks
sed -i "s|$(cat ~/.config/qt5ct/qt5ct.conf | grep color_scheme)|color_scheme_path=/home/`whoami`/.config/qt5ct/colors/Gruvbox.conf|g" ~/.config/qt5ct/qt5ct.conf

# Make a backup of login.conf values for staff and default
echo "staff" > ~/.dotfiles/bckp/staff
echo "$(getcap -f /etc/login.conf staff | sed 's/	/\\n/g')" | grep datasize | head -n2 >>		~/.dotfiles/bckp/staff
echo "$(getcap -f /etc/login.conf staff | sed 's/	/\\n/g')" | grep maxproc | head -n2 >>		~/.dotfiles/bckp/staff
echo "$(getcap -f /etc/login.conf staff | sed 's/	/\\n/g')" | grep openfiles | head -n2 >>	~/.dotfiles/bckp/staff
echo "default" > ~/.dotfiles/bckp/default
echo "$(getcap -f /etc/login.conf default | sed 's/	/\\n/g')" | grep datasize | head -n2 >>		~/.dotfiles/bckp/default
echo "$(getcap -f /etc/login.conf default | sed 's/	/\\n/g')" | grep maxproc | head -n2 >>		~/.dotfiles/bckp/default
echo "$(getcap -f /etc/login.conf default | sed 's/	/\\n/g')" | grep openfiles | head -n2 >>	~/.dotfiles/bckp/default

# Set Wallpaper
mkdir -p ~/.config/nitrogen
echo "[xin_-1]
file=/home/`whoami`/.dotfiles/img/wallpaper.jpg
mode=4
bgcolor=#000000" > ~/.config/nitrogen/bg-saved.cfg

# Add ncspot bindings

mkdir -p ~/.config/ncspot
ln -s ~/.dotfiles/no-stow/ncspot ~/.config/ncspot/config.toml
