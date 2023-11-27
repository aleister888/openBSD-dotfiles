#!/bin/sh

########################
# Package Installation #
########################

doas pkg_add ghostscript-- alacritty arandr automake-1.16.5 avahi bash bat cdrtools chafa coreutils cups czkawka-gui dash-- dbus \
dragon-drop dunst easytag eza feh ffmpeg ffmpegthumbnailer flac fzf gcc%8 gcolor2 gimp%snapshot git gmake \
gnome-calculator gnome-keyring go gnupg handbrake hplip htop i3lock imagemagick imlib2 jdk%8 jdk%11 jq keepassxc--browser latexmk \
lf libnotify libopenmpt libreoffice libsamplerate libvorbis lxappearance mediainfo mpg123 mpv neovim nitrogen node \
nsxiv obsdfreqd odt2txt opusfile p5-File-MimeInfo p7zip pandoc papirus-icon-theme pavucontrol picom playerctl \
poppler-utils py-gobject py3-pip qt5ct redshift remmina rhythmbox ripgrep sdl2 sdl2-audiolib sdl2-gfx sdl2-image \
sdl2-mixer sdl2-net sdl2-pango sdl2-ttf stow sxhkd texlive_texmf-full thunderbird transmission-gtk trayer unrar \
unzip-- wavpack wget wpa_supplicant xarchiver xclip xcursor-themes xdg-user-dirs xdotool yarn youtube-dl zathura \
zathura-pdf-mupdf zim zsh neofetch gsed gawk ggrep gnuwatch symbola-ttf meson ninja cmake xcb libconfig libev uthash \
ungoogled-chromium octave unclutter zathura-cb xscreensaver

########################
# Download zsh plugins #
########################

git clone https://github.com/zsh-users/zsh-history-substring-search.git	.config/zsh/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git	.config/zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git		.config/zsh/zsh-autosuggestions

##################
# Install pfetch #
##################

git clone https://github.com/dylanaraps/pfetch.git	scripts/pfetch
doas cp ~/.dotfiles/scripts/pfetch/pfetch /usr/local/bin/

#################
# Stow dotfiles #
#################

[ ! -d $HOME/.local/scripts ] && mkdir -p $HOME/.local/scripts
stow --target=${HOME}/.local/scripts/ scripts/
[ ! -d $HOME/.config ] && mkdir $HOME/.config
stow --target=${HOME}/.config/ .config/
[ ! -d $HOME/.local/share/dwm ] && mkdir -p $HOME/.local/share/dwm
mkdir -p $HOME/.local/share/dwm; ln -s $HOME/.dotfiles/dwm/autostart.sh ~/.local/share/dwm/autostart.sh

# Symlink shell profile
rm ~/.profile
ln -s ~/.dotfiles/.profile ~/.profile

# Make directory for saving screenshots
[ ! -d $HOME/Pictures/Screenshots ] && mkdir -p $HOME/Pictures/Screenshots

#######
# GTK #
#######

# Installs GTK2/3 theme and icon theme
doas git clone https://github.com/jmattheis/gruvbox-dark-icons-gtk.git	/usr/local/share/icons/gruvbox-dark-icons-gtk
doas git clone https://github.com/jmattheis/gruvbox-dark-gtk.git	/usr/local/share/themes/gruvbox-dark-gtk

# Clones GTK4 theme repo into /tmp
git clone https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme.git	/tmp/Gruvbox_Theme

# Copy desired theme into the themes folder
doas cp -r /tmp/Gruvbox_Theme/themes/Gruvbox-Dark-B /usr/local/share/themes/Gruvbox-Dark-B

# Makes GTK4 config and stows the config folder again
[ ! -d $HOME/.dotfiles/.config/gtk-4.0 ] && mkdir $HOME/.dotfiles/.config/gtk-4.0
echo "[Settings]
gtk-theme-name=Gruvbox-Dark-B
gtk-icon-theme-name=gruvbox-dark-icons-gtk" > $HOME/.dotfiles/.config/gtk-4.0/settings.ini
stow --target=${HOME}/.config/ .config/

################################
# Manual Software Installation #
################################

git clone https://github.com/b3nj5m1n/xdg-ninja.git	scripts/xdg-ninja

# Create directory for software source
[ ! -d $HOME/.local/src ] && mkdir -p $HOME/.local/src

# Compile source already in the repo
doas gmake install --directory ~/.dotfiles/dwm
doas gmake install --directory ~/.dotfiles/dmenu
doas gmake install --directory ~/.dotfiles/dwmblocks

#

git clone https://github.com/phillbush/xclickroot.git ~/.local/src/xclickroot
doas make install ~/.local/src/xclickroot

#####################
# Window Swallowing #
#####################

# Complie devour (Window swallowing)
git clone https://github.com/salman-abedin/devour.git ~/.local/src/devour

# Patch devour for compiling in openBSD
echo '.POSIX:

NAME    = devour
VERSION = 11.0
X11LIB = /usr/X11R6/lib

CC     = cc
#CFLAGS = -std=c11 -D_POSIX_C_SOURCE=200809L -Wall -Wextra -pedantic -O2
CFLAGS = -std=c11 -D_POSIX_C_SOURCE=200809L -Wall -Wextra -pedantic -O2 -I/usr/X11R6/include
LDLIBS = -s -lX11 -L${X11LIB}

BIN_DIR = /usr/local/bin

SRC = devour.c
OBJ = devour.o

all: $(NAME)
$(NAME): $(OBJ)
install: all
	@mkdir -p $(BIN_DIR)
	@mv $(NAME) $(BIN_DIR)
	@rm -f $(OBJ)
	@echo Done moving the binary to ${DESTDIR}${BIN_DIR}
uninstall:
	@rm -f $(BIN_DIR)/$(NAME)
	@echo Done removing the binary from $(BIN_DIR)

.PHONY: all install uninstall' > ~/.local/src/devour/Makefile

doas gmake install --directory ~/.local/src/devour

#########
# Fonts #
#########

doas wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Agave.zip -O /tmp/Agave.zip
doas wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/NerdFontsSymbolsOnly.zip -O /tmp/Symbols.zip
doas unzip /tmp/Agave.zip -d /usr/local/share/fonts/Agave
doas unzip /tmp/Symbols.zip -d /usr/local/share/fonts/NerdFontsSymbolsOnly

################
# Music Player #
################

git clone https://github.com/Taiko2k/TauonMusicBox.git ~/.local/src/tauon-music-box --branch v7.5.0

# Patch Tauon Compile Script
sed -i 's/gcc/egcc/g' ~/.local/src/tauon-music-box/compile-phazor.sh

git -C ~/.local/src/tauon-music-box submodule update --init --recursive

pip install --user -r ~/.local/src/tauon-music-box/requirements.txt

pip install urllib3==1.26.6

sh -c 'cd ~/.local/src/tauon-music-box && git submodule update --init --recursive && bash compile-phazor.sh'

#########
# Atool #
#########

git clone https://github.com/solsticedhiver/atool2.git ~/.local/src/atool2

sed -i 's|/bin/bash|/usr/local/bin/bash|g' ~/.local/src/atool2/configure

# Make symlinks for compling atool on openBSD
rm ~/.local/src/atool2/build-aux/missing ~/.local/src/atool2/build-aux/install-sh
ln -s /usr/local/share/automake-1.16/missing ~/.local/src/atool2/build-aux/missing
ln -s /usr/local/share/automake-1.16/install-sh  ~/.local/src/atool2/build-aux/install-sh
# Compile
sh -c 'cd ~/.local/src/atool2 && ./configure'
sh -c 'cd ~/.local/src/atool2 && gmake'
# Copy binaries to ~/.local/bin
sh -c 'cd ~/.local/src/atool2 && cp acat adiff als apack arepack atool aunpack ~/.local/bin/' && echo "Done copying binaries"

##########
# Neovim #
##########

# Install VimPlug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# Symlink neovim to vim
doas ln -s /usr/local/bin/nvim /usr/local/bin/vim

# Install plguins
nvim -c :PlugInstall --headless &


# Change login shell to zsh
chsh -s /usr/local/bin/zsh `whoami`

# Setup cron before enabling service
[ ! -f /etc/crontab ] && echo "SHELL=/bin/sh
MAILTO=`whoami`
# Auto suspend laptop
* * * * *		`whoami`	/home/`whoami`/.local/scripts/bat" > /tmp/crontab && doas mv /tmp/crontab /etc/crontab

# Set Wallpaper

mkdir -p ~/.config/nitrogen
echo "[xin_-1]
file=/home/`whoami`/.dotfiles/img/wallpaper.png
mode=4
bgcolor=#000000" > ~/.config/nitrogen/bg-saved.cfg

# configures startx and runs syspatch
doas ./root-install.sh

# Add regular user into desired groups
doas usermod -G operator $(whoami)
doas usermod -G staff $(whoami)
doas usermod -G users $(whoami)
doas usermod -G wheel $(whoami)

##########
# Compfy #
##########

git clone https://github.com/allusive-dev/compfy.git ~/.local/src/compfy
sh -c 'cd ~/.local/src/compfy && LDFLAGS="-L/usr/X11R6/lib -L/usr/local/lib" CPPFLAGS="-I/usr/X11R6/include -I/usr/local/include" meson --buildtype=release . build'
sh -c 'cd ~/.local/src/compfy && ninja -C build'

#########
# Trash #
#########

doas gmkdir --parent /.Trash
doas chmod a+rw /.Trash
doas chmod +t /.Trash
pip install trash-cli

############
# Services #
############

doas rcctl enable multicast
doas rcctl enable messagebus
doas rcctl enable avahi_daemon
doas rcctl enable cupsd
doas rcctl enable wpa_supplicant
doas rcctl enable cron
doas rcctl enable apmd
doas rcctl set apmd flags -L
doas rcctl enable obsdfreqd
doas rcctl set obsdfreqd flags -T 90,55

#######
# NPM #
#######

mkdir -p ~/.local/share/npm
mkdir -p ~/.local/share/npm/lib

ln -s ~/.config/Xauthority ~/.Xauthority

# grep "kern.video.record=1" || doas sh -c 'echo "kern.video.record=1" >> /etc/sysctl.conf' && \
# doas chown `whoami` /dev/video0
