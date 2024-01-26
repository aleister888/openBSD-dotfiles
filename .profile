# $OpenBSD: dot.profile,v 1.8 2022/08/10 07:40:37 tb Exp $
#
# sh/ksh initialization

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
export BROWSER="ungoogled-chromium"
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
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc"
export GOPATH="$XDG_DATA_HOME"/go
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
alias wget='wget --hsts-file="$XDG_CONFIG_HOME"/wget-hsts'
alias gpg2='gpg2 --homedir "$XDG_DATA_HOME"/gnupg'


# lf Icons
export LF_ICONS="di=:fi=:tw=󱝏:ow=:ex=:ln=:or=:\
*.mp3=:*.opus=:*.ogg=:*.m4a=:*.flac=:*.ape=:*.wav=:*.cue=:\
*.RPP=󰋅:*.RPP-bak=󰋅:*.rpp=󰋅:*.rpp-bak=󰋅:*.rpp-PROX=󰋅:*drums.wav=󰋅:\
*.tg=:*.gp=:*.gp3=:*.gp4=:*.gp5=:*.gpx=:*.vst3=:*.so=:\
*.mkv=:*.mp4=:*.m4v=:*.webm=:*.mpeg=:*.avi=:*.mov=:\
*.png=:*.webp=:*.ico=:*.jpg=:*.jpe=:*.jpeg=:*.JPG=:\
*.gif=:*.svg=:*.tif=:*.tiff=:*.xcf=:*.eps=:*.kra=:\
*.vim=:*.ms=:*.xml=:*.csv=:*.xlsx=:*.djvu=:*.sh=:\
*.mpg=:*.wmv=:*.m4b=:*.flv=:*.MOV=:*.kdenlive=:\
*config.h=󱁻:*config.def.h=󱁻:*.json=󱁻:*.ini=󱁻:*.yml=󱁻:\
*.reapeaks=󰋅:*other.wav=󰋅:*vocals.wav=󰋅:*bass.wav=󰋅:\
*.z64=󰖺:*.v64=󰖺:*.n64=󰖺:*.gba=󰖺:*.nes=󰖺:*.gdi=󰖺:\
*PKGBUILD=󱁼:*Makefile=󱁼:*Makefile.inc=󱁼:*.mk=󱁼:\
*.zip=:*.rar=:*.7z=:*.gz=:*.xz=:*.xnb=:\
*.conf=󱁻:*.cfg=󱁻:*.vdf=󱁻:*.dmx=󱁻:*.toml=󱁻:\
*cover.jpg=:*cover.jpeg=:*cover.png=:\
*.txt=:*.tex=:*.markdown=:*.md=:\
*.c=󱁼:*.o=󱁼:*.h=󱁼:*.go=󱁼:*.cache=󱁿:\
*.r=:*.R=:*.rmd=:*.Rmd=:*.m=:\
*.log=:*.reg=:*.aux=:*.toc=:\
*.vtt=:*.srt=:*.blend=:\
*.jar=:*.java=:*.js=:\
*.dll=:*.vst3=:*.exe=:\
*.pdf=:*.cbr=:*.cbz=:\
*README=:*LICENSE=:\
*.part=󰌹:*.torrent=󰌹:\
*.desktop=󱆭:*.lnk=󱆭:\
*.tmp=󱁿:*.history=󱁿:\
*Missing-Tabs=󰵦:\
*.iso=:*.img=:\
*Dockerfile=:\
*.vader=:\
*.html=󰌀:\
*.docx=:\
*.epub=:\
*.kdbx=:\
*.mask=:\
*.gpg=:\
*.css=󰸌:\
*.mid=󰡂:\
*.bib=:\
*.git=:\
*.bin=:\
*.py="

# lf Colors
export LF_COLORS="~/.config/=01;32:~/.local/=01;32:\
~/.local/share=01;36:~/.local/src=01;36:~/.local/scripts=01;36:\
.github/=33:.git/=33:.git*=32:.git*=32:\
tw=01;34:ow=01;34:st=01;34:di=01;34:\
su=01;32:sg=01;32:ex=01;32:\
bd=33;01:cd=33;01:\
ln=01;36:\
so=01;35:\
or=31;01:\
pi=33:\
fi=00"
