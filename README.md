<img src="https://raw.githubusercontent.com/aleister888/openBSD-dotfiles/master/img/puffy.png" align="left" height="100px" hspace="20px" vspace="0px">

## OpenBSD Dotfiles

`OpenBSD` dotfiles para mi `Thinkpad X270`

<p float="center">
    <img src="https://raw.githubusercontent.com/aleister888/openBSD-dotfiles/main/img/screenshot1.jpg" width="49%" />
    <img src="https://raw.githubusercontent.com/aleister888/openBSD-dotfiles/main/img/screenshot.jpg" width="49%" />
</p>

## Steps to Install

- Inicia sesión como root, y configura doas añadiendo estas lineas a `/etc/doas.conf`
    - `permit persist keepenv setenv { XAUTHORITY LANG LC_ALL } :wheel`
    - `permit nopass :wheel as root cmd /usr/bin/mixerctl`
- Añadete a ti mismo al grupo de sesión `staff` y al grupo `wheel` con:
    - `usermod -L staff username`
    - `usermod -G wheel username`
- Inicia sesión con tu usuario regular e instala bash y git con:
    - `doas pkg_add bash git`
- Clona el repositorio en tu carpeta  __HOME__ con:
    - `git clone https://github.com/aleister888/openBSD-dotfiles.git ~/.dotfiles`,
- Desde la carpeta `~/.dotfiles` ejecuta `install.sh`

_NOTA:_ Con la opción `persist` en `doas.conf` doas no te pedirá autentificación si ya te autentificaste hahce menos de 5 minutos, si alguna parte de la instalación dura mas de 5 minutos tendras que introducir la contraseña varias veces. Para hacer el proceso de configuración mas automático, sustituye `persist` por `nopass`. Lo que hará que doas no te pida ninguna contraseña.

### i3lock-fancy

OpenBSD no tiene un port de `ì3lock-fancy`, así que he añadido un script que simula el comportamiento de i3lock-fancy. Es solo un script que utiliza ImageMagick para añadir blur a tu pantalla y un icono de candado oscuro o claro, en función de si el centro de la pantalla es mas o menos brillante.

## TODO

- Terminar el PDF, explicando paso a paso como configurar chrome
- Testear el script de instalación en OpenBSD 7.5
