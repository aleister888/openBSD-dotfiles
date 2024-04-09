#!/usr/local/bin/bash

ensure_directory() { # Crear directorio si no existe
    [ ! -d "$1" ] && mkdir -p "$1"
}
create_symlink() { # Crear enlaces simbólicos
    # $1: Origen, $2: Destino
    ln -s "$1" "$2"
}
# Eliminar el archivo ~/.profile si existe y enlazarlo al archivo ~/.dotfiles/.profile
remove_and_link_profile() {
    [ -f "$HOME/.profile" ] && rm "$HOME/.profile"
    ln -s "$HOME/.dotfiles/.profile" "$HOME/.profile"
}

# Arreglar los permisos de la webcam
if [ ! "$(gstat -c "%a" /dev/video0)" = "640" ]; then
	doas chmod 640 /dev/video0
fi

#######################################
# Archivos de configuración y scripts #
#######################################

# Stow archivos de configuración y scripts

# Directorio con los scripts
ensure_directory "$HOME/.local/bin"
sh -c "cd $HOME/.dotfiles && stow --target="${HOME}/.local/bin/" bin/" >/dev/null

# Directorio de configuración
ensure_directory "$HOME/.config"
sh -c "cd $HOME/.dotfiles && stow --target="${HOME}/.config/" .config/" >/dev/null

# Directorio dwm
ensure_directory "$HOME/.local/share/dwm"
create_symlink "$HOME/.dotfiles/dwm/autostart.sh" "$HOME/.local/share/dwm/autostart.sh"

remove_and_link_profile

# Borrar enlaces rotos
find "$HOME/.local/bin" -type l ! -exec test -e {} \; -delete
find "$HOME/.config"    -type l ! -exec test -e {} \; -delete

# Enlazar nuestro script de inicio
ln -s ~/.dotfiles/dwm/autostart.sh ~/.local/share/dwm 2>/dev/null

# Enlazar nuestro perfil al directorio home
ln -s ~/.dotfiles/.profile ~ 2>/dev/null

# Hacer ciertas configuraciones independientes del nombre de usuario
echo "file:///home/$(whoami)
file:///home/$(whoami)/Downloads
file:///home/$(whoami)/Documents
file:///home/$(whoami)/Pictures
file:///home/$(whoami)/Videos
file:///home/$(whoami)/Music" > ~/.dotfiles/.config/gtk-3.0/bookmarks

# Establacer fondo de pantalla
mkdir -p ~/.config/nitrogen
echo "[xin_-1]
file=/home/$(whoami)/.dotfiles/img/wallpaper.png
mode=5
bgcolor=#000000" > ~/.config/nitrogen/bg-saved.cfg

# Configurar QT5
mkdir -p $HOME/.config/qt5ct
echo "[Appearance]
color_scheme_path=$HOME/.config/qt5ct/colors/Gruvbox.conf
custom_palette=true
icon_theme=gruvbox-dark-icons-gtk
standard_dialogs=default
style=Fusion

[Fonts]
fixed=\"Iosevka Nerd Font Mono,12,-1,5,50,0,0,0,0,0,Bold\"
general=\"Iosevka Nerd Font,12,-1,5,63,0,0,0,0,0,SemiBold\"" > "$HOME/.dotfiles/.config/qt5ct/qt5ct.conf"

###############
# Plugins ZSH #
###############

plugin_install(){
	git clone "https://github.com/$1" "$HOME/.dotfiles/.config/zsh/$(basename "$1")"
}

[ ! -e $HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
     plugin_install zsh-users/zsh-autosuggestions
[ ! -e $HOME/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh ] && \
     plugin_install zsh-users/zsh-history-substring-search
[ ! -e $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
     plugin_install zsh-users/zsh-syntax-highlighting
[ ! -e $HOME/.config/zsh/zsh-you-should-use/you-should-use.plugin.zsh ] && \
	plugin_install MichaelAquilina/zsh-you-should-use

# Actualizar plugins de zsh
sh -c "cd $HOME/.config/zsh/zsh-autosuggestions && git pull"
sh -c "cd $HOME/.config/zsh/zsh-history-substring-search && git pull"
sh -c "cd $HOME/.config/zsh/zsh-syntax-highlighting && git pull"
sh -c "cd $HOME/.config/zsh/zsh-you-should-use && git pull"

#######################
# Copias de seguridad #
#######################

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

################################
# Aplicaciones predeterminadas #
################################

# Borramos ajustes ya guardados
rm -f $HOME/.config/mimeapps.list
rm -f $HOME/.local/share/applications/defaults.list
doas rm -f /usr/local/share/applications/mimeinfo.cache
update-mime-database ~/.local/share/mime

[ ! -d "$HOME/.local/share/applications" ] && mkdir -p "$HOME/.local/share/applications"
# Creamos el archivo .desktop para lf
[ ! -e "$HOME/.local/share/applications/lft.desktop" ] && \
echo '[Desktop Entry]
Type=Application
Name=lf File Manager (St)
Comment=Simple terminal-based file manager
Exec=st -e lf %u
Terminal=false
Icon=utilities-terminal
Categories=System;FileTools;FileManager
GenericName=File Manager
MimeType=inode/directory;' > "$HOME/.local/share/applications/lft.desktop"

# Creamos el archivo .desktop para nvim
[ ! -e "$HOME/.local/share/applications/nvimt.desktop" ] && \
echo '[Desktop Entry]
Type=Application
Name=Neovim (St)
Comment=Simple terminal-based text editor
Exec=st -e nvim %F
Terminal=false
Icon=nvim
Categories=Utility;TextEditor;
MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;' > "$HOME/.local/share/applications/nvimt.desktop"

# Establecemos por defecto el administrador de archivos
xdg-mime default lfst.desktop inode/directory
xdg-mime default lfst.desktop x-directory/normal
update-desktop-database "$HOME/.local/share/applications"

# Nuestra función para establecer nuestro visor de imagenes, video, audio y editor de texto
set_default_mime_types(){
	local pattern="$1"
	local desktop_file="$2"
	awk -v pattern="$pattern" '$0 ~ pattern {print $1}' /usr/share/misc/mime.types | while read -r line; do
		xdg-mime default "$desktop_file" "$line"
	done
}

set_default_mime_types "^image" "nsxiv.desktop"
set_default_mime_types "^video" "mpv.desktop"
set_default_mime_types "^audio" "mpv.desktop"
set_default_mime_types "^text" "nvimt.desktop"

xdg-settings set default-web-browser chromium-browser.desktop 2>/dev/null
