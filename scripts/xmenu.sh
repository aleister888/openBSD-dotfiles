#!/bin/sh
cat <<EOF | xmenu -r | dash &
IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/internet-web-browser.svg			Internet
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/firefox.svg			Firefox			firefox
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/thunderbird.svg			Thunderbird		thunderbird
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/discord.svg	Discord		cd ~/.local/src/abaddon/build && ./abaddon
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/syncthing-gtk.svg			Syncthing		xdg-open http://127.0.0.1:8384
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/transmission.svg			Transmission		transmission-gtk
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/barrier.svg			Barrier			LANG=es_ES.UTF-8 barrier-gui

IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/multimedia.svg				Sound & Video
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/tauonmb.svg			Tauon			tauon
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/jack_mixer.svg			Tauon Remote Control	tauon-yad 192.168.0.186
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/jack_mixer.svg			Tauon Control		tauon-yad localhost
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/mpv.svg				mpv			mpv --player-operation-mode=pseudo-gui
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/pavucontrol.svg			Pavucontrol		pavucontrol
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/easytag.svg			EasyTAG			easytag

IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/preferences-desktop-color.svg		Graphics
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/gimp.svg				GIMP			gimp-2.99
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/fr.handbrake.ghb.svg		HandBrake		ghb
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/gcolor2.svg			Gcolor2			gcolor2

IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/applications-office.svg			Office
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/zim.svg				Zim			zim
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/wireshark.svg		Wireshark		wireshark
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/libreoffice-writer.svg		Libre Office Writer	libreoffice --writer
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/libreoffice-calc.svg		Libre Office Calc	libreoffice --calc
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/libreoffice-impress.svg		Libre Office Impress	libreoffice --impress
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/zathura.svg			Zathura			zathura
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/gnome-calculator.svg		Calculator		gnome-calculator
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/remmina.svg			Remmina			remmina
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/accessories-notes.svg		Aula Virtual		xdg-open https://aulavirtual.ual.es/
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/system-users.svg			Campus Virtual		xdg-open https://campus.ual.es/

IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/applications-utilities.svg			Utilities
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/htop.svg				HTop			$TERMINAL -e htop
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/keepassxc.svg			KeePassXC		keepassxc
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/bleachbit.svg	Bleachbit	cd ~/.local/src/bleachbit && python3 ./bleachbit.py
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/fr.romainvigier.MetadataCleaner.svg	Czkawka			czkawka_gui
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/grandr.svg				Display Settings	arandr
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/preferences-desktop-theme.svg	GTK Settings		lxappearance
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/qt5ct.svg				QT Settings		qt5ct

IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/firefox.svg					Firefox		firefox
IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/thunderbird.svg					Thunderbird	thunderbird
IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/system-file-manager.svg				File-Manager	$TERMINAL -e lf
IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/terminal.svg					Terminal	$TERMINAL
IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/system-shutdown.svg				Power
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/system-lock-screen.svg			Lock		~/.local/scripts/i3lock-fancy
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/system-suspend-hibernate.svg		Lock & Suspend	~/.local/scripts/i3lock-fancy && zzz
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/sleep.svg					Suspend		zzz
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/system-log-out.svg				Logout		pkill dwm
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/system-shutdown.svg			Shutdown	xterm -title scratchpad -e "doas halt -p"
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/system-reboot.svg				Reboot		xterm -title scratchpad -e "doas reboot"
	IMG:/usr/local/share/icons/Papirus-Dark/128x128/apps/preferences-desktop-screensaver.svg	Screensaver	xscreensaver-command --suspend
EOF
