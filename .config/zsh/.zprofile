#!/bin/zsh

PATH=$HOME/.local/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin:/usr/local/jdk-17/bin/
export PATH HOME TERM

if [ "$PWD" != "$HOME" ] && [ "$PWD" -ef "$HOME" ] ; then cd ; fi

export MOZ_ACCELERATED=1
export MOZ_WEBRENDER=1

# Set default locale
export CHARSET=UTF-8
export LANG="es_ES.UTF-8"

# Apps
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export READER="zathura"
export TERMINAL="alacritty"
export TERM="alacritty"
#export BROWSER="firefox"
export BROWSER="chrome"
export VIDEO="mpv"
export OPENER="xdg-open"
export PAGER="less"
export WM="dwm"

export _JAVA_AWT_WM_NONREPARENTING=1

# QT Apps Settings
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_FONT_DPI=96

export GTK_THEME=Gruvbox-Dark-B

# Export XDG Dirs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_VIDEOS_DIR="$HOME/Videos"

export XDG_CURRENT_DESKTOP=X-Generic

# Cleanup $HOME directory of dotfiles
export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority
export XAUTHORITY="$XDG_CONFIG_HOME"/Xauthority
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc"
export GOPATH="$XDG_DATA_HOME"/go
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
alias wget='wget --hsts-file="$XDG_CONFIG_HOME"/wget-hsts'
alias gpg2='gpg2 --homedir "$XDG_DATA_HOME"/gnupg'

# lf Icons
export LF_ICONS="di=:\
fi=:\
tw=:\
ow=:\
ex=:\
ln=:\
or=:\
*.dll=:\
*.vst3=:\
*.exe=:\
*.txt=:\
*.ms=:\
*.tex=:\
*.markdown=:\
*.vim=:\
*.png=::\
*.webp=::\
*.ico=::\
*.jpg=:\
*.jpe=:\
*.jpeg=:\
*.JPG=:\
*.gif=:\
*.svg=:\
*.tif=:\
*.tiff=:\
*.xcf=:\
*.eps=:\
*.html=爵:\
*.xml=:\
*.gpg=:\
*.css=:\
*.kra=:\
*.pdf=:\
*.docx=:\
*.djvu=:\
*.epub=:\
*.cbr=:\
*.cbz=:\
*.csv=:\
*.xlsx=:\
*.md=:\
*README=:\
*LICENSE=:\
*.r=:\
*.R=:\
*.rmd=:\
*.Rmd=:\
*.m=:\
*.mp3=:\
*.opus=:\
*.ogg=:\
*.m4a=:\
*.flac=:\
*.ape=:\
*.wav=:\
*.cue=:\
*cover.jpg=:\
*cover.jpeg=:\
*cover.png=:\
*.tg=:\
*.gp=:\
*.gp3=:\
*.gp4=:\
*.gp5=:\
*.gpx=:\
*Missing-Tabs=:\
*.vst3=:\
*.so=:\
*.mid=:\
*.mkv=:\
*.mp4=:\
*.m4v=:\
*.webm=:\
*.mpeg=:\
*.avi=:\
*.mov=:\
*.mpg=:\
*.wmv=:\
*.m4b=:\
*.flv=:\
*.MOV=:\
*.kdenlive=:\
*.zip=:\
*.rar=:\
*.7z=:\
*.gz=:\
*.xz=:\
*.xnb=:\
*.z64=:\
*.v64=:\
*.n64=:\
*.gba=:\
*.nes=:\
*.gdi=:\
*.log=:\
*.reg=:\
*.aux=:\
*.toc=:\
*.iso=﫭:\
*.img=﫭:\
*.bib=:\
*.ged=:\
*.part=ﯜ:\
*.torrent=﮾:\
*.kdbx=:\
*.jar=:\
*.java=:\
*.js=:\
*.RPP=:\
*.RPP-bak=:\
*.rpp=:\
*.rpp-bak=:\
*.rpp-PROX=:\
*.reapeaks=:\
*other.wav=:\
*.psarc=:\
*vocals.wav=:\
*bass.wav=:\
*drums.wav=:\
*.vtt=:\
*.srt=:\
*.desktop=ﭯ:\
*.lnk=ﭯ:\
*.conf=:\
*.cfg=:\
*.vdf=:\
*.dmx=:\
*.toml=:\
*config.h=:\
*config.def.h=:\
*.json=:\
*.ini=:\
*.yml=:\
*PKGBUILD=殮:\
*Makefile=殮:\
*Makefile.inc=殮:\
*.mk=殮:\
*.c=:\
*.o=:\
*.h=:\
*.go=:\
*.cache=羽:\
*.tmp=羽:\
*.history=羽:\
*.mask=ﴣ:\
*Dockerfile=:\
*.vader=:\
*.sh=:\
*.git=:\
*.py=:\
*.blend=:\
"

# lf colors
export LF_COLORS="~/.config/=01;32:\
~/.local/=01;32:\
~/.local/share=33:\
~/.local/src=33:\
~/.local/scripts=33:\
~/.config/lf/lfrc=31:\
.git/=33:.git*=32:\
.github/=33:.git*=32:\
ln=01;36:\
or=31;01:\
tw=01;34:\
ow=01;34:\
st=01;34:\
di=01;34:\
pi=33:\
so=01;35:\
bd=33;01:\
cd=33;01:\
su=01;32:\
sg=01;32:\
ex=01;32:\
fi=00:\
"

# lf colors

export LF_COLORS="~/.config/=01;32:\
~/.local/=01;32:\
~/.local/share=33:\
~/.local/src=33:\
~/.local/scripts=33:\
~/.config/lf/lfrc=31:\
.git/=33:.git*=32:\
.github/=33:.git*=32:\
ln=01;36:\
or=31;01:\
tw=01;34:\
ow=01;34:\
st=01;34:\
di=01;34:\
pi=33:\
so=01;35:\
bd=33;01:\
cd=33;01:\
su=01;32:\
sg=01;32:\
ex=01;32:\
fi=00:\
"

# start dwm
if [[ "$(tty)" = "/dev/ttyC0" ]]; then
        startx
fi
if [[ "$(tty)" = "/dev/ttyC0" ]]; then
	clear;
	exit
fi
