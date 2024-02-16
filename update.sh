#!/usr/local/bin/bash

rm ~/.config/mimeapps.list 2>/dev/null

# Stow dotfiles
sh -c "cd $HOME/.dotfiles && stow --target="${HOME}/.local/bin/" bin/" >/dev/null
sh -c "cd $HOME/.dotfiles && stow --target="${HOME}/.config/" .config/" >/dev/null

# Symlink DWM autostart script
ln -s ~/.dotfiles/dwm/autostart.sh ~/.local/share/dwm 2>/dev/null

# Symlink shell profile into home directory
ln -s ~/.dotfiles/.profile ~ 2>/dev/null

# Directorio de respaldo
backup_dir="$HOME/.dotfiles/bckp"
# Archivos a respaldar
files="/etc/X11/xinit/xinitrc /etc/sysctl.conf /etc/crontab /etc/mixerctl.conf"
# Iterar sobre cada archivo y realizar una copia de seguridad si existe
for file in $files; do
    if [ -e "$file" ]; then
        filename=$(basename "$file")
        cp "$file" "$backup_dir/$filename"
        echo "Se ha creado una copia de seguridad de $filename en $backup_dir."
    fi
done

# Make some configuration user-agnostic

echo "file:///home/$(whoami)/Downloads" > ~/.dotfiles/.config/gtk-3.0/bookmarks
sed -i "s|$(cat ~/.config/qt5ct/qt5ct.conf | grep color_scheme)|color_scheme_path=/home/`whoami`/.config/qt5ct/colors/Gruvbox.conf|g" ~/.config/qt5ct/qt5ct.conf

# Función para realizar la copia de /etc/login.conf
perform_backup() {
	local user="$1"
	local cap="$2"
	local file="$3"

	echo "$user" > "$file"
	getcap -f /etc/login.conf "$user" | sed 's/	/\\n/g' | grep "$cap" | head -n2 >> "$file"
}

# Realizar la copia para el grupo "staff"
perform_backup "staff" "datasize" ~/.dotfiles/bckp/staff
perform_backup "staff" "maxproc" ~/.dotfiles/bckp/staff
perform_backup "staff" "openfiles" ~/.dotfiles/bckp/staff

# Realizar la copia para el grupo "default"
perform_backup "default" "datasize" ~/.dotfiles/bckp/default
perform_backup "default" "maxproc" ~/.dotfiles/bckp/default
perform_backup "default" "openfiles" ~/.dotfiles/bckp/default

# Set Wallpaper
mkdir -p ~/.config/nitrogen
echo "[xin_-1]
file=/home/`whoami`/.dotfiles/img/wallpaper.jpg
mode=4
bgcolor=#000000" > ~/.config/nitrogen/bg-saved.cfg

# Borrar links symbolicos rotos
find ~/.local/bin -type l ! -exec test -e {} \; -delete
find ~/.config -type l ! -exec test -e {} \; -delete
