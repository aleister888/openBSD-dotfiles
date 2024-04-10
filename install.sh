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

# Funciones para mostrar errores o éxitos
success(){
	clear; echo "$1 $(tput setaf 7)$(tput setab 2)OK$(tput sgr0)"; sleep 1
}

error(){
	clear; echo "$1 $(tput setaf 7)$(tput setab 1)ERROR$(tput sgr0)"; sleep 1
}

# Dependencias para compilar Tauon Music Box, libappindicator no esta disponible
tauon_packages='py3-dbus py-gobject py3-pip ffmpeg libnotify sdl2 sdl2-audiolib sdl2-gfx sdl2-image sdl2-mixer sdl2-net sdl2-pango sdl2-ttf wavpack flac libvorbis opusfile libopenmpt libsamplerate mpg123 coreutils'
# GUI
packages='arandr czkawka-gui dragon-drop easytag gimp%snapshot gcolor2 mate-calc libreoffice lxappearance mpv nsxiv pavucontrol zathura zathura-pdf-mupdf chromium zathura-cb workrave gsimplecal'
# Otros paquetes
packages+=' ghostscript-- automake-1.16.5 avahi bash bat cdrtools chafa cups dash-- dbus dunst eza feh ffmpegthumbnailer fzf gcc%8 git gmake gnome-keyring go gnupg hplip htop i3lock imagemagick imlib2 jdk%8 jdk%11 jq keepassxc--browser latexmk lf mediainfo neovim nitrogen node obsdfreqd odt2txt p5-File-MimeInfo p7zip pandoc papirus-icon-theme picom playerctl poppler-utils qt5ct redshift remmina ripgrep stow texlive_texmf-full thunderbird transmission-gtk unrar unzip-- wget wpa_supplicant xarchiver xclip xcursor-themes xdg-user-dirs xdotool yarn youtube-dl zsh neofetch gsed gawk ggrep gnuwatch symbola-ttf meson ninja cmake xcb libconfig libev uthash curl syncthing xcursor-themes polkit findutils'

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
	#
	if [ ! -d "$HOME/.local/share/fonts" ]; then
		mkdir -p "$HOME/.local/share/fonts"
		ln -s /usr/local/share/fonts/Iosevka "$HOME/.local/share/fonts/Iosevka"
		ln -s /usr/local/share/fonts/Agave "$HOME/.local/share/fonts/Agave"
	fi
}

# Instalar pfetch
pfetch_install() {
	# Clonar el repositorio pfetch y copiar el script a /usr/local/bin/
	git clone https://github.com/dylanaraps/pfetch.git "$HOME/.dotfiles/bin/pfetch"
	doas cp "$HOME/.dotfiles/bin/pfetch/pfetch" /usr/local/bin/ && \
	rm -rf "$HOME/.dotfiles/bin/pfetch"
}

# Instalar los temas GTK
gruvbox_install() {
	# Clonar el repositorio gruvbox-dark-icons-gtk en /usr/local/share/icons/
	doas git clone https://github.com/jmattheis/gruvbox-dark-icons-gtk.git \
	/usr/local/share/icons/gruvbox-dark-icons-gtk >/dev/null
	# Clonar el repositorio gruvbox-dark-gtk en /usr/local/share/themes/
	doas git clone https://github.com/jmattheis/gruvbox-dark-gtk.git \
	/usr/local/share/themes/gruvbox-dark-gtk >/dev/null
	# Clona el tema de gtk4
	git clone https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme.git \
	/tmp/Gruvbox_Theme >/dev/null
	# Copia el tema deseado a la carpeta de temas
	doas cp -r /tmp/Gruvbox_Theme/themes/Gruvbox-Dark-B \
	/usr/local/share/themes/Gruvbox-Dark-B
}

# Configurar los temas e iconos usados por GTK4
gtk_config() {
	# Verificar si el directorio ~/.dotfiles/.config/gtk-4.0 no existe y crearlo si es necesario
	[ ! -d "$HOME/.dotfiles/.config/gtk-4.0" ] && mkdir "$HOME/.dotfiles/.config/gtk-4.0"
	# Crear el archivo de configuración de GTK
	echo "[Settings]
	gtk-theme-name=Gruvbox-Dark-B
	gtk-icon-theme-name=gruvbox-dark-icons-gtk" | tee "$HOME/.dotfiles/.config/gtk-4.0/settings.ini"
	# Aplicar configuraciones utilizando stow
	sh -c "cd $HOME/.dotfiles && stow --target=${HOME}/.config/ .config/" >/dev/null
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
	local THEME_FILE="/tmp/themes.tar.gz"
	# Clonar el repositorio TauonMusicBox
	git clone https://github.com/Taiko2k/TauonMusicBox.git "$HOME/.local/src/tauon-music-box" --branch v7.7.1 >/dev/null
	# Cambiamos el compilador a egcc
	sed -i 's/gcc/egcc/g' "$HOME/.local/src/tauon-music-box/compile-phazor.sh"
	# Quitamos dbus-python de la lista de depedencias (Ya lo instalamos con pkg_add py3-dbus)
	sed -i '/dbus-python/d' "$HOME/.local/src/tauon-music-box/requirements.txt"
	# Actualizar submódulos
	git -C "$HOME/.local/src/tauon-music-box" submodule update --init --recursive >/dev/null
	# Instalar urllib3==1.26.6 (La última vez que probe versiones mas recientes no se podian instalar o generaban conflictos)
	pip install --user urllib3==1.26.6 >/dev/null
	# Instalar los requisitos de TauonMusicBox
	pip install --user -r "$HOME/.local/src/tauon-music-box/requirements.txt" >/dev/null
	# Compilar TauonMusicBox
	sh -c "cd $HOME/.local/src/tauon-music-box && bash compile-phazor.sh" >/dev/null
	# Borrar .gitignore para desactivar el modo desarollador
	rm "$HOME/.local/src/tauon-music-box/.gitignore"
	# Descargar y extraer mis temas
	wget https://github.com/Taiko2k/TauonMusicBox/files/14394169/themes.tar.gz --output-file="$THEME_FILE"
	tar -xzvf "$THEME_FILE" -C "$HOME/.local/src/tauon-music-box/theme/"
}

# Instalar atool (Programa para descomprimir ficheros)
atool2_install() {
	# Clonar el repositorio atool2
	git clone https://github.com/solsticedhiver/atool2.git "$HOME/.local/src/atool2" >/dev/null
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

# Hacemos la configuración de QT5 independiente del nombre de usuario
qt_config(){
	mkdir -p "$HOME/.config/qt5ct"
	echo "[Appearance]
color_scheme_path=$HOME/.config/qt5ct/colors/Gruvbox.conf
custom_palette=true
icon_theme=gruvbox-dark-icons-gtk
standard_dialogs=default
style=Fusion" | tee "$HOME/.config/qt5ct/qt5ct.conf"
}

# Configurar cronie
crontab_install() {
# Verificar si /etc/crontab no existe y configurar cronjobs
	[ ! -f /etc/crontab ] && echo "SHELL=/bin/sh
MAILTO=$USER

# Auto suspend laptop
* * * * *	$USER	$HOME/.local/bin/bat
@reboot		$USER	syncthing --no-browser --no-default-folder

* * * * *	root		rm /var/log/Xorg.*
* * * * *	root		rm /var/log/daemon.*
* * * * *	root		rm /var/log/maillog.*
30 10 * * *	root		cd /usr/ports && cvs -q up -Pd -A" | doas tee /tmp/crontab
}

# Comandos que deben ejecutarse solo como root
root_install(){
# Configurar el kernel
	cp /etc/sysctl.conf /etc/sysctl.conf.bak
	doas cp -f "$HOME/.dotfiles/assets/sysctl.conf" /etc/sysctl.conf

# Configurar xinit para iniciar X11
	doas install -m 755 "$HOME/.dotfiles/assets" /etc/X11/xinit/xinitrc

# Crear un script para ejecutar tauon
	doas install -m 755 "$HOME/.dotfiles/assets/tauon" /usr/local/bin/tauon

# Auto-montar discos externos automáticamente
doas cp "$HOME/.dotfiles/attach" /etc/hotplug/attach
doas chmod 0755 /etc/hotplug/attach
if ! grep -q hotplugd /etc/rc.conf.local; then
    echo 'hotplugd_flags=""' | doas tee -a /etc/rc.conf.local
fi

# Configurar la ubicación de la configuración de zsh
doas mkdir -p /etc/zsh
echo 'ZDOTDIR="$HOME"/.config/zsh' | doas tee /etc/zshenv
echo 'ZDOTDIR="$HOME"/.config/zsh' | doas tee /etc/zsh/zshenv

# Configurar chromium para poder conectarse a KeepassXC
if ! grep -q proxy /etc/chromium/unveil.main; then
echo "
# Needed for keepassxc-browser integration
/usr/local/bin r
/usr/local/bin/keepassxc-proxy rx" | doas tee -a /etc/chromium/unveil.main
fi

# Crear enlace simbólico para exa
doas ln -s /usr/local/bin/eza /usr/local/bin/exa 2>/dev/null

# Copiar archivos necesarios a /var/icecast/etc
doas cp -p /etc/{hosts,localtime,resolv.conf} /var/icecast/etc
doas cp -p /usr/share/misc/mime.types /var/icecast/etc

# Instalar parches de seguridad
doas syspatch 2>/dev/null
}

multimedia_enable(){
# Si no esta ya activado, permitir acceder al micrófono y webcam
	if ! grep -q "record" /etc/sysctl.conf; then
		echo -e "kern.audio.record=1\nkern.video.record=1" | \
		doas tee -a /etc/sysctl.conf
		multimedia="true"
	fi
# Establecer permisos para /dev/video0
	doas chmod 640 /dev/video0
}

staff-changes(){
# Si el número máximo de archivos no esta definido para staff, definelo
grep "openfiles=16384" /etc/login.conf || \
	doas sed -i 's/staff:\\$/staff:\\\
	:openfiles=16384:\\/g' /etc/login.conf && \
	doas cap_mkdb /etc/login.conf
}

ports_setup(){
# Descargar los ports
	if [ ! -d /usr/ports ]; then
		doas sh -c 'cd /usr && cvs -qd anoncvs@anoncvs.fr.openbsd.org:/cvs checkout -P ports'
	fi
}

# Instalar app de cli para manejar la basura
trash_dir() {
	# Crear el directorio /.Trash con permisos adecuados
	doas gmkdir --parent /.Trash
	doas chmod a+rw /.Trash
	doas chmod +t /.Trash
	# Instalar trash-cli
	pip install --user trash-cli >/dev/null
}

rcctl_enable() {
	# Lista de servicios a habilitar
	servicios="multicast messagebus avahi_daemon cupsd wpa_supplicant cron apmd obsdfreqd"
	# Habilitar servicios con rcctl
	for servicio in $servicios; do
		doas rcctl enable "$servicio"
	done
	# Configurar opciones específicas para algunos servicios
	doas rcctl set apmd flags -L
	doas rcctl set obsdfreqd flags -T 90,55
}

##########
# SCRIPT #
##########

# Ahora llamamos a nuestras funciones y otros
# comandos que no merecen su propia función

if doas pkg_add -Ix $tauon_packages $packages; then
	success "Los paquetes se instalaron correctamente"
else
	error "Hubo un error al instalar los paquetes"
fi

if fontdownload; then
	success "Las fuentes se descargaron y extrajeron correctamente"
else
	error "Hubo un error al descargar o extraer las fuentes"
fi

if pfetch_install; then
	success "pfetch se instaló correctamente"
else
	error "Hubo un error al instalar pfetch"
fi

if $HOME/.dotfiles/update.sh; then
	success "Los archivos de configuración se instalaron correctamente"
else
	error "Hubo un error al instalar los archivos de configuración"
fi

[ ! -d "$HOME/Pictures/Screenshots" ] && mkdir -p "$HOME/Pictures/Screenshots"

if gruvbox_install; then
	success "Los temas de aplicación e iconos se instalaron correctamente"
else
	error "Hubo un error al instalar los temas de aplicación e iconos"
fi

if gtk_config; then
	success "GTK4 se configuró correctamente"
else
	error "Hubo un error al configurar GTK4"
fi

NINJA_DIR="$HOME/.dotfiles/bin/xdg-ninja"
NINJA_URL="https://github.com/b3nj5m1n/xdg-ninja.git"

# Instalamos xdg-ninja
if git clone "$NINJA_URL" "$NINJA_DIR" >/dev/null; then
	success "xdg-ninja se instaló correctamente en $NINJA_DIR"
else
	error "Hubo un error al instalar xdg-ninja"
fi

# Creamos una carpeta para descargar el código del software que queremos instalar
[ -d "$HOME/.local/src" ] || mkdir -p "$HOME/.local/src"

if suckless_install; then
	success "El software suckless se instaló correctamente"
else
	error "Hubo un error al instalar el sotware suckless"
fi

if tauon_music_box; then
	success "Tauon Music Box se instaló correctamente"
else
	error "Hubo un error al instalar Tauon Music Box"
fi

if atool2_install; then
	success "atool2 se instaló correctamente"
else
	error "Hubo un error al instalar atool2"
fi

if qt_config; then
	success "QT5 se configuró correctamente"
else
	error "Hubo un error al configurar QT5"
fi

# Change login shell to zsh
chsh -s /usr/local/bin/zsh "$USER"

if crontab_install; then
	success "Cronie se configuró correctamente"
else
	error "Hubo un error al configurar Cronie"
fi

# configures startx and runs syspatch
root_install

# Preguntar si realizar ciertas acciones

# Respuesta por defecto
default_answer="s"

# Preguntar si activar la webcam y el micrófono
read -rp "¿Desea permitir el uso de webcam/micrófono? (S/n): " answer1
answer1=${answer1:-$default_answer}  # Si la respuesta está vacía, establece la respuesta predeterminada

[ "${answer1,,}" = "s" ] && \
if multimedia_enable; then
	success "El uso de cámara y micrófono se activo correctamente"
else
	error "Hubo un error al activar el uso de webcam y micrófono"
fi

# Pregunta si cambiar los limites del grupo staff
read -rp "¿Desea establecer los limites recomendados para el grupo staff? (S/n): " answer2
answer2=${answer2:-$default_answer}  # Si la respuesta está vacía, establece la respuesta predeterminada

# Verifica la respuesta del usuario
[ "${answer2,,}" = "s" ] && \
if staff-changes; then
	success "Los limites del grupo staff se establecieron correctamente"
else
	success "Hubo un error al establecer los limites del grupo staff"
fi

# Preguntar si se desea descargar el código de los ports
read -rp "¿Desea descargar los ports? (S/n): " answer3
answer3=${answer3:-$default_answer}

[ "${answer3,,}" = "s" ] && \
if ports_setup; then
	success "EL repositorio de \"ports\" se descargo correctamente"
else
	error "Hubo un error al descargar el repositorio de \"ports\""
fi

if doas usermod -G operator,users,wheel "$USER"; then
	success "Usuario añadido correctamente a los grupos operator,users,wheel"
else
	error "Hubo un error al añadir el usuario a los grupos operator,users,wheel"
fi

if trash_dir; then
	success "Se instaló software para manejar la papelera"
else
	error "Hubo un error al instalar el software para manejar la papelera"
fi

if rcctl_enable; then
	success "Se activaron los servicios exitosamente"
else
	error "Hubo un error al activar los servicios"
fi

# Crear directorios de npm para evitar usar .npm
mkdir -p "$HOME/.local/share/npm"
mkdir -p "$HOME/.local/share/npm/lib"

# Linkear Xauthority para evitar problemas con aplicaciones que no respeten $XAUTHORITY
ln -s "$HOME/.config/Xauthority" "$HOME/.Xauthority" 2>/dev/null

# Configurar el cursor
mkdir -p "$HOME/.local/share/icons" >/dev/null
ln -s /usr/local/lib/X11/icons/whiteglass "$HOME/.local/share/icons/whiteglass" >/dev/null

# Cambia los permisos de la webcam si se decidio
# permitir el uso de webcam en root-install.sh
[ "$multimedia" == "true" ] && doas chown "$USER" /dev/video0

if "$HOME/.dotfiles/tauon-config.sh" >/dev/null; then
	success "El reproductor de música fue configurado correctamente"
else
	error "Hubo un fallo al configurar el reproductor de música"
fi

echo "Instalación terminada"
