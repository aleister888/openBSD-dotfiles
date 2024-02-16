<img src="https://raw.githubusercontent.com/aleister888/openBSD-dotfiles/master/img/puffy.png" align="left" height="100px">

## OpenBSD Dotfiles

`OpenBSD` dotfiles for my `Thinkpad X270`

<p float="left">
    <img src="https://raw.githubusercontent.com/aleister888/openBSD-dotfiles/main/img/screenshot1.jpg" width="49.5%" />
    <img src="https://raw.githubusercontent.com/aleister888/openBSD-dotfiles/main/img/screenshot.jpg" width="49.5%" />
</p>

## Steps to Install

- Log in as root, configure doas (Put these lines in /etc/doas.conf)
    - `permit persist keepenv setenv { XAUTHORITY LANG LC_ALL } :wheel`
    - `permit nopass :wheel as root cmd /usr/bin/mixerctl`
- Add yourself to the staff login group, and the wheel group with:
    - `usermod -L staff username`
    - `usermod -G wheel username`
- Log in as your regular user and install bash and git with:
    - `doas pkg_add bash git`
- Clone into your __HOME__ directory with:
    - `git clone https://github.com/aleister888/openBSD-dotfiles.git ~/.dotfiles`,
- cd into `~/.dotfiles` and run `install.sh`

For only stowing dotfiles install "stow" and run instead `update.sh`

_NOTE:_ With the `persist` option in `doas.conf`, doas will not require authentication via password-entry for five minutes after the last time doas was ran. If the installation of packages takes more than 5 minutes (and it will most likely will) password authentication will be required again. To make the script fully automated replace `persist` with `nopass` in the first `doas.conf` example line.

## Software used

- [dwm](https://dwm.suckless.org/) [(my build)](https://github.com/aleister888/openBSD-dotfiles/tree/main/dwm)
- [dmenu](https://tools.suckless.org/dmenu/) [(my build)](https://github.com/aleister888/openBSD-dotfiles/tree/main/dmenu)
- [alacritty](https://alacritty.org/)
- [dwmblocks](https://github.com/UtkarshVerma/dwmblocks-async/)
- [Tauon Music Box](https://github.com/Taiko2k/TauonMusicBox)

## Useful Stuff

### i3lock-fancy

OpenBSD doesn't have a `i3lock-fancy` port, so i added a script that
simulates `i3lock-fancy` behaviour by manually adding blur and a lock icon.

It detects if it should display a dark or light icon even better than
the original i3lock-fancy because it reads brightness only from the part
of the screen where the lock icon will be displayed.

### Bleachbit and Abaddon (Discord client)

I provide scripts to compile bleachbit and abaddon automatically

## GTK gruvbox theme from:

- [GTK theme](https://github.com/jmattheis/gruvbox-dark-icons-gtk)
- [Icon theme](https://github.com/jmattheis/gruvbox-dark-gtk)

## TODO

- Configure Tauon automatically (set gruvbox theme and agave font)
- Deploy dotfiles with update.sh from install.sh to avoid duplicate functions
- Asking the user if they want to auto install abaddon and/or bleachbit
- Translate the README to Spanish
