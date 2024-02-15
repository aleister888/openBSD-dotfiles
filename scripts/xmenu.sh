#!/bin/sh

ICONPATH="/usr/local/share/icons/Papirus-Dark/128x128/apps"
RADIOFLAG="-t scratchpad -e mpv"

cat <<EOF | xmenu -r | dash &
IMG:$ICONPATH/internet-web-browser.svg				Internet
	IMG:$ICONPATH/google-chrome.svg				Chromium		chrome
	IMG:$ICONPATH/discord.svg				Discord			cd "$HOME/.local/src/abaddon/" && ./build/abaddon || notify-send "Abaddon not installed"
	IMG:$ICONPATH/thunderbird.svg				Thunderbird		thunderbird
	IMG:$ICONPATH/syncthing-gtk.svg				Syncthing		xdg-open http://127.0.0.1:8384
	IMG:$ICONPATH/transmission.svg				Transmission		transmission-gtk
	IMG:$ICONPATH/barrier.svg				Barrier			LANG=es_ES.UTF-8 barrier-gui

IMG:$ICONPATH/multimedia.svg					Sound & Video
	IMG:$ICONPATH/tauonmb.svg				Tauon			tauon
	IMG:$ICONPATH/jack_mixer.svg				Tauon Remote Control	tauon-yad 192.168.0.186
	IMG:$ICONPATH/mpv.svg					mpv			mpv --player-operation-mode=pseudo-gui
	IMG:$ICONPATH/pavucontrol.svg				Pavucontrol		pavucontrol
	IMG:$ICONPATH/easytag.svg				EasyTAG			easytag
	IMG:$ICONPATH/picard.svg				Picard			picard --stand-alone-instance

IMG:$ICONPATH/radiotray.svg					Radio
	Your Classical - Relax	 				$TERMINAL $RADIOFLAG "http://relax.stream.publicradio.org/relax.mp3"
	Adroit Jazz Underground	 				$TERMINAL $RADIOFLAG "https://icecast.walmradio.com:8443/jazz"
	KCSM Jazz 91.1 FM					$TERMINAL $RADIOFLAG "http://ice7.securenetsystems.net/KCSM2"
	Deep House Radio					$TERMINAL $RADIOFLAG "http://62.210.105.16:7000/stream"
	Progulus (Prog Rock)					$TERMINAL $RADIOFLAG "http://centova.radioservers.biz:8063/stream.ogg"
	TEKNO1							$TERMINAL $RADIOFLAG "http://cressida.shoutca.st:8591/stream/1/"
	Radio Schizoid - Dub Techno				$TERMINAL $RADIOFLAG "http://94.130.113.214:8000/dubtechno"
	RNE							$TERMINAL $RADIOFLAG "https://rtvelivestream.akamaized.net/rtvesec/rne/rne_r1_main.m3u8"
	Onda Cero						$TERMINAL $RADIOFLAG "https://livefastly-webs.ondacero.es/almeria-pull/audio/master.m3u8"
	Cadena SER						$TERMINAL $RADIOFLAG "http://21223.live.streamtheworld.com:80/CADENASER.mp3"
	MSNBC							$TERMINAL $RADIOFLAG "https://tunein.streamguys1.com/msnbc-tesla"
	BBC							$TERMINAL $RADIOFLAG "http://stream.live.vc.bbcmedia.co.uk/bbc_world_service"

IMG:$ICONPATH/preferences-desktop-color.svg			Graphics
	IMG:$ICONPATH/gimp.svg					GIMP			gimp-2.99
	IMG:$ICONPATH/fr.handbrake.ghb.svg			HandBrake		ghb
	IMG:$ICONPATH/gcolor2.svg				Gcolor2			gcolor2

IMG:$ICONPATH/applications-office.svg				Office
	IMG:$ICONPATH/zim.svg					Zim			zim
	IMG:$ICONPATH/octave.svg				Octave			/usr/local/bin/octave --gui
	IMG:$ICONPATH/libreoffice-writer.svg			Libre Office Writer	libreoffice --writer
	IMG:$ICONPATH/libreoffice-calc.svg			Libre Office Calc	libreoffice --calc
	IMG:$ICONPATH/libreoffice-impress.svg			Libre Office Impress	libreoffice --impress
	IMG:$ICONPATH/zathura.svg				Zathura			zathura
	IMG:$ICONPATH/gnome-calculator.svg			Calculator		gnome-calculator
	IMG:$ICONPATH/remmina.svg				Remmina			remmina
	IMG:$ICONPATH/accessories-notes.svg			Aula Virtual		xdg-open https://aulavirtual.ual.es/
	IMG:$ICONPATH/system-users.svg				Campus Virtual		xdg-open https://campus.ual.es/

IMG:$ICONPATH/applications-utilities.svg			Utilities
	IMG:$ICONPATH/htop.svg					HTop			$TERMINAL -e htop
	IMG:$ICONPATH/keepassxc.svg				KeePassXC		keepassxc
	IMG:$ICONPATH/bleachbit.svg				Bleachbit		cd ~/.local/src/bleachbit && python3 ./bleachbit.py || notify-send "Bleachbit not installed"
	IMG:$ICONPATH/fr.romainvigier.MetadataCleaner.svg	Czkawka			czkawka_gui
	IMG:$ICONPATH/grandr.svg				Display Settings	arandr
	IMG:$ICONPATH/preferences-desktop-theme.svg		GTK Settings		lxappearance
	IMG:$ICONPATH/qt5ct.svg					QT Settings		qt5ct

IMG:$ICONPATH/google-chrome.svg					Chromium		chrome
IMG:$ICONPATH/thunderbird.svg					Thunderbird		thunderbird
IMG:$ICONPATH/system-file-manager.svg				File-Manager		$TERMINAL -e lf
IMG:$ICONPATH/st.svg						Terminal		$TERMINAL
IMG:$ICONPATH/system-shutdown.svg				Power
	IMG:$ICONPATH/system-lock-screen.svg			Lock			~/.local/scripts/i3lock-fancy
	IMG:$ICONPATH/system-suspend-hibernate.svg		Lock & Suspend		~/.local/scripts/i3lock-fancy && zzz
	IMG:$ICONPATH/sleep.svg					Suspend			zzz
	IMG:$ICONPATH/system-log-out.svg			Logout			pkill dwm
	IMG:$ICONPATH/system-shutdown.svg			Shutdown		xterm -title scratchpad -e "doas halt -p"
	IMG:$ICONPATH/system-reboot.svg				Reboot			xterm -title scratchpad -e "doas reboot"
EOF

#IMG:$ICONPATH/multimc.svg					MultiMC			~/.local/scripts/minecraft
