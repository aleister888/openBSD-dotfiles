#!/bin/sh

xrandr --dpi 96

doas /usr/bin/mixerctl outputs.hp_boost=on

pgrep syncthing || syncthing --no-browser > /tmp/syncthing.log &

setxkbmap -model pc104 -layout es,us  -option grp:win_space_toggle -option caps:none &

# Enable Middle Click on Thinkpads
xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation" 1 &
xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Button" 2 &
xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Axes" 6 7 4 5 &

# Disable screen diming
xset -dpms; xset s off &
# Update Xresources
xrdb ~/.config/Xresources &

# Start processes if they aren't already started
nitrogen --restore &
pgrep dbus || sh -c 'dbus-update-activation-environment --all & dbus-launch' &
pgrep sxhkd		|| sxhkd &
pgrep picom		|| picom &
pgrep dunst		|| dunst &
pgrep dwmblocks		|| dwmblocks &
pgrep node		|| npx http-server ~/.local/share/startpage/ 8080 &

if [ "$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | tail -1 | awk '{print $2}')" = "192.168.0.169" ]; then
	pgrep barrier || barrier-gui &
fi

# Check for running loops before starting them
# (Otherwise they will start with each dwm restart)
if [ -f /tmp/clean_lock ]; then
	exit
else
	touch /tmp/clean_lock
	while true; do
		rm ~/.serverauth* ~/*.core ~/.pki
		sleep 60;
	done &
fi

# Restart dwmblocks
if [ -f /tmp/dwmblock_lock ]; then
	exit
else
	touch /tmp/dwmblocks_lock
	while true; do
		sleep 60;
		count="$(pgrep dwmblocks | wc -l)"
		for i in $(seq $count); do
		kill -9 `pgrep dwmblocks | head -n1`
		done
		dwmblocks &
	done &
fi
