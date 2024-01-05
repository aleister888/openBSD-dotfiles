#!/bin/sh

xrandr --dpi 96

doas /usr/bin/mixerctl outputs.hp_boost=on

syncthing --no-browser --reset-deltas > /tmp/syncthing.log &

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
dbus-update-activation-environment --all &
dbus-launch &
pgrep unclutter		|| unclutter -idle 1 -grab &
pgrep sxhkd		|| sxhkd &
pgrep compfy		|| compfy &
#pgrep picom		|| picom &
pgrep dunst		|| dunst &
pgrep dwmblocks		|| dwmblocks &
pgrep xscreensaver	|| xscreensaver --no-splash &
pgrep http-server	|| npx http-server ~/.local/share/startpage/ 8080 &

if [ "$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | tail -1 | awk '{print $2}')" = "192.168.0.169" ]; then
	barrier-gui &
	env AUDIORECDEVICE=snd/0.mon ices2 ~/.config/ices2/ices-sndio.xml &
fi

while true; do
	pgrep http-server || npx http-server ~/.local/share/startpage/ 8080 &
	sleep 30;
done &

while true; do
	rm ~/.serverauth* ~/*.core ~/.pki ~/.dvdcss
	sleep 240;
done &

# Restart dwmblocks every 5 seconds
while true; do
	sleep 5;
	count="$(pgrep dwmblocks | wc -l)"
	for i in $(seq $count); do
	kill -9 `pgrep dwmblocks | head -n1`
	done
	dwmblocks &
done &
