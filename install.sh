#!/usr/local/bin/bash

if [ -z "$BASH_VERSION" ]; then
	echo "Este script debe ejecutarse con bash."
	exit 1
fi

if [ "$(id -u)" = "0" ]; then
	echo "No puedes ejecutar este script como root."
	exit 1
fi

if [ "$(pwd)" != "$HOME/.dotfiles" ]; then
	echo "Este script debe ejecutarse desde el directorio \$HOME/.dotfiles."
	exit 1
fi

# Instalar nuestros paquetes
packageinstall() {
	doas pkg_add -Ix ghostscript-- arandr automake-1.16.5 avahi bash bat cdrtools chafa coreutils cups czkawka-gui dash-- dbus \
	dragon-drop dunst easytag eza feh ffmpeg ffmpegthumbnailer flac fzf gcc%8 gcolor2 gimp%snapshot git gmake \
	gnome-calculator gnome-keyring go gnupg handbrake hplip htop i3lock imagemagick imlib2 jdk%8 jdk%11 jq keepassxc--browser latexmk \
	lf libnotify libopenmpt libreoffice libsamplerate libvorbis lxappearance mediainfo mpg123 mpv neovim nitrogen node \
	nsxiv obsdfreqd odt2txt opusfile p5-File-MimeInfo p7zip pandoc papirus-icon-theme pavucontrol picom playerctl \
	poppler-utils py-gobject py3-pip qt5ct redshift remmina ripgrep sdl2 sdl2-audiolib sdl2-gfx sdl2-image \
	sdl2-mixer sdl2-net sdl2-pango sdl2-ttf stow texlive_texmf-full thunderbird transmission-gtk unrar \
	unzip-- wavpack wget wpa_supplicant xarchiver xclip xcursor-themes xdg-user-dirs xdotool yarn youtube-dl zathura \
	zathura-pdf-mupdf zim zsh neofetch gsed gawk ggrep gnuwatch symbola-ttf meson ninja cmake xcb libconfig libev uthash \
	chromium octave zathura-cb icecast ices--%ices2 curl syncthing xcursor-themes workrave
}

# Instalar las fuentes necesarias
fontdownload() {
	# Definir las URLs de descarga y los nombres de archivo
	AGAVE_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Agave.zip"
	SYMBOLS_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/NerdFontsSymbolsOnly.zip"
	IOSEVKA_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Iosevka.zip"
	AGAVE_ZIP="/tmp/Agave.zip"
	SYMBOLS_ZIP="/tmp/Symbols.zip"
	IOSEVKA_ZIP="/tmp/Iosevka.zip"
	# Definir directorios de destino
	AGAVE_DIR="/usr/local/share/fonts/Agave"
	SYMBOLS_DIR="/usr/local/share/fonts/NerdFontsSymbolsOnly"
	IOSEVKA_DIR="/usr/local/share/fonts/Iosevka"
	# Descargar fuentes
	echo "Descargando fuentes..."
	doas wget -q "$AGAVE_URL" -O "$AGAVE_ZIP"
	doas wget -q "$SYMBOLS_URL" -O "$SYMBOLS_ZIP"
	doas wget -q "$IOSEVKA_URL" -O "$IOSEVKA_ZIP"
	# Extraer fuentes
	echo "Extrayendo fuentes..."
	doas unzip -q "$AGAVE_ZIP" -d "$AGAVE_DIR"
	doas unzip -q "$SYMBOLS_ZIP" -d "$SYMBOLS_DIR"
	doas unzip -q "$IOSEVKA_ZIP" -d "$IOSEVKA_DIR"
}

# Instalar nuestros plugins de zsh
plugindownload(){
repositories=(
	wget https://github.com/zsh-users/zsh-history-substring-search.git "$HOME/.dotfiles/.config/zsh/zsh-history-substring-search"
	wget https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.dotfiles/.config/zsh/zsh-syntax-highlighting"
	wget https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.dotfiles/.config/zsh/zsh-autosuggestions"
)
# Clonar los repositorios
for repo in "${repositories[@]}"; do
	# Separar la URL del destino utilizando espacios
	url_dest=("$repo")
	git clone "${url_dest[0]}" "${url_dest[1]}" >/dev/null 2>&1
done
}

# Instalar pfetch
pfetch_install() {
	# Clonar el repositorio pfetch y copiar el ejecutable a /usr/local/bin/
	git clone https://github.com/dylanaraps/pfetch.git "$HOME/.dotfiles/bin/pfetch" >/dev/null 2>&1
	doas cp "$HOME/.dotfiles/bin/pfetch/pfetch" /usr/local/bin/ && \
	rm -rf "$HOME/.dotfiles/bin/pfetch"
}

# Instalar los archivos de configuración
dotfiles_install() {
	# Crear directorios si no existen y enlazar archivos
	ensure_directory() {
	    # $1: Directorio a verificar y crear si no existe
	    [ ! -d "$1" ] && mkdir -p "$1"
	}
	# Crear enlaces simbólicos
	create_symlink() {
	    # $1: Origen del archivo
	    # $2: Destino del enlace simbólico
	    ln -s "$1" "$2"
	}
	# Eliminar el archivo ~/.profile si existe y enlazarlo al archivo ~/.dotfiles/.profile
	remove_and_link_profile() {
	    [ -f "$HOME/.profile" ] && rm "$HOME/.profile"
	    ln -s "$HOME/.dotfiles/.profile" "$HOME/.profile"
	}
	# Directorio con los scripts
	ensure_directory "$HOME/.local/bin"
	sh -c "cd $HOME/.dotfiles && stow --target="${HOME}/.local/bin/" bin/" >/dev/null
	# Directorio de configuración
	ensure_directory "$HOME/.config"
	sh -c "cd $HOME/.dotfiles && stow --target="${HOME}/.config/" .config/" >/dev/null
	# Directorio dwm
	ensure_directory "$HOME/.local/share/dwm"
	create_symlink "$HOME/.dotfiles/dwm/autostart.sh" "$HOME/.local/share/dwm/autostart.sh"
	# Enlazar .profile
	remove_and_link_profile
}

# Instalar los temas GTK
gruvbox_install() {
	# Clonar el repositorio gruvbox-dark-icons-gtk en /usr/local/share/icons/
	doas git clone https://github.com/jmattheis/gruvbox-dark-icons-gtk.git /usr/local/share/icons/gruvbox-dark-icons-gtk >/dev/null 2>&1
	# Clonar el repositorio gruvbox-dark-gtk en /usr/local/share/themes/
	doas git clone https://github.com/jmattheis/gruvbox-dark-gtk.git /usr/local/share/themes/gruvbox-dark-gtk >/dev/null 2>&1
	# Clona el tema de gtk4
	git clone https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme.git /tmp/Gruvbox_Theme >/dev/null 2>&1
	# Copia el tema deseado a la carpeta de temas
	doas cp -r /tmp/Gruvbox_Theme/themes/Gruvbox-Dark-B /usr/local/share/themes/Gruvbox-Dark-B
}

# Configurar los temas e iconos usados por GTK4
gtk_config() {
	# Verificar si el directorio ~/.dotfiles/.config/gtk-4.0 no existe y crearlo si es necesario
	[ ! -d "$HOME/.dotfiles/.config/gtk-4.0" ] && mkdir "$HOME/.dotfiles/.config/gtk-4.0"
	# Crear el archivo de configuración de GTK
	echo "[Settings]
	gtk-theme-name=Gruvbox-Dark-B
	gtk-icon-theme-name=gruvbox-dark-icons-gtk" > "$HOME/.dotfiles/.config/gtk-4.0/settings.ini"
	# Aplicar configuraciones utilizando stow
	sh -c "cd $HOME/.dotfiles && stow --target="${HOME}/.config/" .config/" >/dev/null
}

# Instalar nuestro software suckless
suckless_install() {
    # Instalar dwm
    doas gmake install --directory "$HOME/.dotfiles/dwm" >/dev/null 2>&1
    # Instalar dmenu
    doas gmake install --directory "$HOME/.dotfiles/dmenu" >/dev/null 2>&1
    # Instalar dwmblocks
    doas gmake install --directory "$HOME/.dotfiles/dwmblocks" >/dev/null 2>&1
    # Instalar st
    doas gmake clean install --directory "$HOME/.dotfiles/st" >/dev/null 2>&1
}

# Instalar nuestro reproductor de música
tauon_music_box() {
	# Clonar el repositorio TauonMusicBox
	git clone https://github.com/Taiko2k/TauonMusicBox.git "$HOME/.local/src/tauon-music-box" --branch v7.5.0 >/dev/null 2>&1
	# Patch Tauon Compile Script
	sed -i 's/gcc/egcc/g' "$HOME/.local/src/tauon-music-box/compile-phazor.sh"
	# Actualizar submódulos
	git -C "$HOME/.local/src/tauon-music-box" submodule update --init --recursive >/dev/null 2>&1
	# Instalar urllib3==1.26.6 (La última vez que probe versiones mas recientes no se podian instalar o generaban conflictos)
	pip install --user urllib3==1.26.6 >/dev/null 2>&1
	# Instalar los requisitos de TauonMusicBox
	pip install --user -r "$HOME/.local/src/tauon-music-box/requirements.txt" >/dev/null 2>&1
	# Compilar TauonMusicBox
	sh -c "cd $HOME/.local/src/tauon-music-box && git submodule update --init --recursive && bash compile-phazor.sh" >/dev/null 2>&1
	rm "$HOME/.local/src/tauon-music-box/.gitignore"
}

# Instalar atool (Programa para descomprimir ficheros)
atool2_install() {
	# Clonar el repositorio atool2
	git clone https://github.com/solsticedhiver/atool2.git "$HOME/.local/src/atool2" >/dev/null 2>&1
	# Modificar el script de configuración para usar /usr/local/bin/bash
	sed -i 's|/bin/bash|/usr/local/bin/bash|g' "$HOME/.local/src/atool2/configure"
	# Hacer enlaces simbólicos para compilar atool en OpenBSD
	rm "$HOME/.local/src/atool2/build-aux/missing" "$HOME/.local/src/atool2/build-aux/install-sh"
	ln -s /usr/local/share/automake-1.16/missing "$HOME/.local/src/atool2/build-aux/missing"
	ln -s /usr/local/share/automake-1.16/install-sh "$HOME/.local/src/atool2/build-aux/install-sh"
	# Compilar
	sh -c "cd $HOME/.local/src/atool2 && ./configure" >/dev/null
	gmake --directory "$HOME/.local/src/atool2" >/dev/null 2>&1
	# Copiar binarios a ~/.local/bin
	sh -c "cd $HOME/.local/src/atool2 && cp -f acat adiff als apack arepack atool aunpack $HOME/.local/bin/"
}

# Configurar neovim e instalar los plugins
vim_configure() {
	# Instalar VimPlug
	sh -c "curl -fLo ${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim --create-dirs \
		   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" >/dev/null 2>&1
	# Crear enlace simbólico de neovim a vim
	doas ln -s /usr/local/bin/nvim /usr/local/bin/vim 2>/dev/null
	# Instalar los plugins
	nvim +'PlugInstall --sync' +qa >/dev/null 2>&1
}

# Configurar cronie
crontab_install() {
# Verificar si /etc/crontab no existe y configurar cronjobs
if [ ! -f /etc/crontab ]; then
echo "SHELL=/bin/sh
MAILTO=$(whoami)

# Auto suspend laptop
* * * * *	$(whoami)	$HOME/.local/bin/bat
* * * * *	root		rm /var/log/Xorg.*
* * * * *	root		rm /var/log/daemon.*
* * * * *	root		rm /var/log/maillog.*" > /tmp/crontab
doas mv /tmp/crontab /etc/crontab
fi
}

# Configurar nitrogen
nitrogen_configure() {
# Crear el directorio ~/.config/nitrogen si no existe
mkdir -p "$HOME/.config/nitrogen"
# Crear el archivo de configuración bg-saved.cfg
echo "[xin_-1]
file=$HOME/.dotfiles/img/wallpaper.png
mode=5
bgcolor=#000000" > "$HOME/.config/nitrogen/bg-saved.cfg"
}

# Añadir el usuario a los grupos deseados
groups_add() {
	# Añadir el usuario actual a los grupos especificados
	doas usermod -G operator,users,wheel "$(whoami)"
}

# Instalar app de cli para manejar la basura
trash_dir() {
	# Crear el directorio /.Trash con permisos adecuados
	doas gmkdir --parent /.Trash
	doas chmod a+rw /.Trash
	doas chmod +t /.Trash
	# Instalar trash-cli
	pip install --user trash-cli >/dev/null 2>&1
}

rcctl_enable() {
	# Lista de servicios a habilitar
	servicios="multicast messagebus avahi_daemon cupsd wpa_supplicant cron apmd obsdfreqd icecast"
	# Habilitar servicios con rcctl
	for servicio in $servicios; do
		doas rcctl enable "$servicio"
	done
	# Configurar opciones específicas para algunos servicios
	doas rcctl set apmd flags -L
	doas rcctl set obsdfreqd flags -T 90,55
}

# Ahora llamamos a nuestras funciones y otros
# comandos que no merecen su propia función

if packageinstall; then
	echo "Los paquetes se instalaron correctamente"
else
	echo "Hubo un error al instalar los paquetes"
fi

if fontdownload; then
	echo "Las fuentes se descargaron y extrajeron correctamente"
else
	echo "Hubo un error al descargar o extraer las fuentes"
fi

if plugindownload; then
	echo "Los plugins de zsh se descargaron correctamente"
else
	echo "Hubo un error al descargar los plugins de zsh"
fi

if pfetch_install; then
	echo "pfetch se instaló correctamente"
else
	echo "Hubo un error al instalar pfetch"
fi

if dotfiles_install; then
	echo "Los archivos de configuración se instalaron correctamente"
else
	echo "Hubo un error al instalar los archivos de configuración"
fi

[ ! -d "$HOME/Pictures/Screenshots" ] && mkdir -p "$HOME/Pictures/Screenshots"

if gruvbox_install; then
	echo "Los temas de aplicación e iconos se instalaron correctamente"
else
	echo "Hubo un error al instalar los temas de aplicación e iconos"
fi

if gtk_config; then
	echo "GTK4 se configuró correctamente"
else
	echo "Hubo un error al configurar GTK4"
fi

# Instalamos xdg-ninja
NINJA_DIR="$HOME/.dotfiles/bin/xdg-ninja"
git clone https://github.com/b3nj5m1n/xdg-ninja.git "$NINJA_DIR" >/dev/null 2>&1
if [ -d "$NINJA_DIR" ]; then
    echo "xdg-ninja se instaló correctamente en $NINJA_DIR"
else
    echo "Hubo un error al instalar xdg-ninja"
fi

# Creamos una carpeta para descargar el código del software que queremos instalar
[ ! -d "$HOME/.local/src" ] && mkdir -p "$HOME/.local/src"

if suckless_install; then
	echo "El software suckless se instaló correctamente"
else
	echo "Hubo un error al instalar el sotware suckless"
fi

if tauon_music_box; then
	echo "Tauon Music Box se instaló correctamente"
else
	echo "Hubo un error al instalar Tauon Music Box"
fi

if atool2_install; then
	echo "atool2 se instaló correctamente"
else
	echo "Hubo un error al instalar atool2"
fi

if vim_configure; then
	echo "Neovim se configuró correctamente"
else
	echo "Hubo un error al configurar Neovim"
fi

# Change login shell to zsh
chsh -s /usr/local/bin/zsh "$(whoami)"

if crontab_install; then
	echo "Cronie se configuró correctamente"
else
	echo "Hubo un error al configurar Cronie"
fi

if nitrogen_configure; then
	echo "Nitrogen se configuró correctamente"
else
	echo "Hubo un error al configurar nitrogen"
fi

# configures startx and runs syspatch
doas "$HOME/.dotfiles/root-install.sh"

if groups_add; then
	echo "Usuario añadido correctamente a los grupos operator,users,wheel"
else
	echo "Hubo un error al añadir el usuario a los grupos operator,users,wheel"
fi

if trash_dir; then
	echo "Se instaló software para manejar la papelera"
else
	echo "Hubo un error al instalar el software para manejar la papelera"
fi

if rcctl_enable; then
	echo "Se activaron los servicios exitosamente"
else
	echo "Hubo un error al activar los servicios"
fi

mkdir -p "$HOME/.local/share/npm"
mkdir -p "$HOME/.local/share/npm/lib"

ln -s "$HOME/.config/Xauthority" "$HOME/.Xauthority" 2>/dev/null
mkdir -p "$HOME/.local/share/icons" >/dev/null
ln -s /usr/local/lib/X11/icons/whiteglass "$HOME/.local/share/icons/whiteglass" >/dev/null

# Cambia los permisos de la webcam si se decidio
# permitir el uso de webcam en root-install.sh
if [ -f /tmp/multimedia ]; then
	doas chown $(whoami) /dev/video0
fi

echo "Instalación terminada"
