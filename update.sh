#!/usr/local/bin/bash

rm ~/.config/mimeapps.list 2>/dev/null

# Stow archivos de configuración y scripts
sh -c "cd $HOME/.dotfiles && stow --target="${HOME}/.local/bin/" bin/" >/dev/null
sh -c "cd $HOME/.dotfiles && stow --target="${HOME}/.config/" .config/" >/dev/null
# Borrar enlaces rotos
find "$HOME/.local/bin" -type l ! -exec test -e {} \; -delete
find "$HOME/.config"    -type l ! -exec test -e {} \; -delete

# Enlazar nuestro script de inicio
ln -s ~/.dotfiles/dwm/autostart.sh ~/.local/share/dwm 2>/dev/null

# Enlazar nuestro perfil al directorio home
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

# Hacer ciertas configuraciones independientes del nombre de usuario

echo "file:///home/$(whoami)
file:///home/$(whoami)/Downloads
file:///home/$(whoami)/Documents
file:///home/$(whoami)/Pictures
file:///home/$(whoami)/Videos
file:///home/$(whoami)/Music" > ~/.dotfiles/.config/gtk-3.0/bookmarks
sed -i "s|$(cat ~/.config/qt5ct/qt5ct.conf | grep color_scheme)|color_scheme_path=/home/`whoami`/.config/qt5ct/colors/Gruvbox.conf|g" ~/.config/qt5ct/qt5ct.conf

# Hacer una copia de seguridad de /etc/login.conf
perform_backup() {
	local user="$1"
	local cap="$2"
	local file="$3"

	getcap -f /etc/login.conf "$user" | sed 's/:/:\
/g' | grep "$cap" >> "$file"
}

echo "staff" > "$HOME/.dotfiles/bckp/staff"
# Realizar la copia para el grupo staff
perform_backup "staff" "datasize"  "$HOME/.dotfiles/bckp/staff"
perform_backup "staff" "maxproc"   "$HOME/.dotfiles/bckp/staff"
perform_backup "staff" "openfiles" "$HOME/.dotfiles/bckp/staff"

echo "default" > "$HOME/.dotfiles/bckp/default"
# Realizar la copia para el grupo default
perform_backup "default" "datasize"  "$HOME/.dotfiles/bckp/default"
perform_backup "default" "maxproc"   "$HOME/.dotfiles/bckp/default"
perform_backup "default" "openfiles" "$HOME/.dotfiles/bckp/default"

# Establacer fondo de pantalla
mkdir -p ~/.config/nitrogen
echo "[xin_-1]
file=/home/$(whoami)/.dotfiles/img/wallpaper.jpg
mode=5
bgcolor=#000000" > ~/.config/nitrogen/bg-saved.cfg

# Arreglar los permisos de la webcam
if [ ! "$(gstat -c "%a" /dev/video0)" = "640" ]; then
	doas chmod 640 /dev/video0
fi

# Actualizar plugins de zsh
sh -c "cd $HOME/.config/zsh/zsh-autosuggestions && git pull"
sh -c "cd $HOME/.config/zsh/zsh-history-substring-search && git pull"
sh -c "cd $HOME/.config/zsh/zsh-syntax-highlighting && git pull"
