/* See LICENSE file for copyright and license details. */

#define DLINES "16" // Lineas para los comandos de dmenu
#define TERM   "st" // Terminal
#define TERMT  "-t" // Flag usada para determinar el título de la terminal
#define TERMC  "st-256color" // Clase de ventana de la terminal
#define BROWSER "librewolf" // Navegador Web

// Constantes
static const unsigned int gappx          = 32;      // Separación entre las ventanas
static const unsigned int borderpx       = gappx/3; // Borde en pixeles de las ventanas
static const int vertpad                 = gappx;   // Separación vertical de la barra
static const int sidepad                 = gappx;   // Separación horizontal de la barra
static const int user_bh                 = gappx;   // Altura barra: 0 por defecto, >= 1 Altura añadida
static const unsigned int snap           = 0;       // Pixeles de cercanía para pegarse al borde (0 = desactivado)
static const unsigned int systraypinning = 0;       // Monitor para la barra de tareas (0: Monitor seleccionado, >0 Monitor X)
static const unsigned int systrayonleft  = 0;       // Posición de la barra de tareas (0: Esquina derecha, >0 Izquierda del estado)
static const unsigned int systrayspacing = gappx/2; // Espaciado de la barra de tareas
static const int systraypinningfailfirst = 1;       // Monitor barra (Seguro) 1: Barra de tareas en el 1er monitor
static const int showsystray             = 1;       // ¿Barra de tareas? (0: Desactivada)
static const int swallowfloating         = 0;       // 1 Significa tragarse nuevas ventanas por defecto
static const int showbar                 = 1;       // 0 Para desactivar la barra
static const int topbar                  = 1;       // 0 Para la barra en la parte inferior
static const int allowkill               = 1;       // ¿Permitir cerrar clientes por defecto?
static const float mfact                 = 0.45;    // Factor de escalado de la zona principal [0.05..0.95]
static const int nmaster                 = 1;       // Número de clientes en la zona principal
static const int resizehints             = 1;       // 1 ¿Respetar pistas de dibujado al redimensionar ventanas no-flotantes?
static const int lockfullscreen          = 1;       // 1 Fuerza el foco en las ventanas en pantalla completa
static const char *fonts[]               = { "Symbols Nerd Font:style=Regular:pixelsize=44:antialias=true:autohint=true", // Fuentes de dwm
                                             "Iosevka Nerd Font:bold:pixelsize=42:antialias=true:autohint=true" };        // Fuentes de dwm
static const char dmenufont[]            =   "Iosevka Nerd Font:bold:pixelsize=42:antialias=true:autohint=true";          // Fuente de dmenu
static const char background[]           = "#1D2021";
static const char background_sel[]       = "#282828";
static const char foreground[]           = "#D5C4A1";
static const char col_cyan[]             = "#83A598";
static const char col_red[]              = "#FB4934";
static const char col_magenta[]          = "#B16286";
static const char col_orange[]           = "#FE8019";
static const char *colors[][3]      = {
	// Colores:             Fuente          Fondo       Borde
	[SchemeNorm]        = { foreground, background,     col_cyan    }, // Color de las ventanas normales
	[SchemeSel]         = { foreground, background_sel, col_orange  }, // Color de las ventanas selccionadas
	[SchemeStatus]      = { foreground, background,     "#000000"   }, // Color de los espacios por defecto
	[SchemeTagsNorm]    = { foreground, background,     "#000000"   }, // Información (Normal)
	[SchemeTagsSel]     = { foreground, background_sel, "#000000"   }, // Color de los espacios seleccionados
	[SchemeInfoNorm]    = { foreground, background,     "#000000"   }, // Estado/información
	[SchemeInfoSel]     = { foreground, background_sel, "#000000"   }, // Información (Seleccionada)
	[SchemeScratchNorm] = { "#000000",  "#000000",      col_cyan    }, // Scratchpad (Normal)
	[SchemeScratchSel]  = { "#000000",  "#000000",      col_magenta }, // Scratchpad (Selecteccionado)
	// Los valores con "#000000" no son usados pero no pueden estar vacios
};

typedef struct {
	const char *name;
	const void *cmd;
} Sp;

// Nombre de los espacios cuando estan vacios y cuando tienen ventanas. Layout por defecto
static const char *tags[]	= { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12" };
static const char *alttags[]	= { "", "", "󰈹", "", "󰙯", "", "󰋅", "", "",  "󱁤",  "",  "" };
static const int taglayouts[]	= {   0,   0,   0,   0,   2,   2,   0,   0,   2,    0,    3,    3 };

// Reglas pre-establecidas para colocar las ventanas
static const Rule rules[] = {
	// Clase Instancia Título Espacio Flotante Terminal -Tragado Monitor Tecla Scratch
	// Terminal
	{ TERMC,		NULL,	NULL,	0,	0,	1,	0,	-1,     0},
	// Barra de iconos
	{ "trayer",		NULL,	NULL,	0,	1,	0,	0,	-1,     0},
	// Ventanas flotantes
	{ "Yad",		NULL,	NULL,	0,	1,	0,	0,	-1,     0},
	{ "Gcolor3",		NULL,	NULL,	0,	1,	0,	0,	-1,     0},
	{ "Pavucontrol",	NULL,	NULL,	0,	1,	0,	0,	-1,     0},
	{ "Alarm-clock-applet",	NULL,	NULL,	0,	1,	0,	0,	-1,     0},
	{ "Galculator",		NULL,	NULL,	0,	1,	0,	0,	-1,     0},
	// Espacio 1: Música
	{ "tauonmb",		NULL,	NULL,	1 << 0,	0,	0,	0,	-1,     0},
	// Espacio 2: Correo
	{ "thunderbird",	NULL,	NULL,	1 << 1,	0,	0,	0,	-1,     0},
	{ "electron-mail",	NULL,	NULL,	1 << 1,	0,	0,	0,	-1,     0},
	// Espacio 3: Internet
	{ "LibreWolf",		NULL,	NULL,	1 << 2,	0,	0,	0,	-1,     0},
	{ "Tor Browser",	NULL,	NULL,	1 << 2,	0,	0,	0,	-1,     0},
	// Espacio 4: Oficina
	{ "Zim",		NULL,	NULL,	1 << 3,	0,	0,	0,	-1,     's'},
	{ "Soffice",		NULL,	NULL,	1 << 3,	0,	0,	0,	-1,     0},
	// Espacio 5: Chats
	{ "WebCord",		NULL,	NULL,	1 << 4,	0,	0,	0,	-1,     0},
	{ "TelegramDesktop",	NULL,	NULL,	1 << 4,	0,	0,	0,	-1,     0},
	{ "TelegramDesktop","telegram-desktop","Media viewer",1 << 4,1,0,0,	-1,     0},
	{ "revolt-desktop",	NULL,	NULL,	1 << 4,	0,	0,	0,	-1,     0},
	// Espacio 6: Gaming y Virtualización
	{ "Virt-manager",	NULL,	NULL,	1 << 5,	0,	0,	0,	-1,     0},
	{ "looking-glass-client",NULL,	NULL,	1 << 5,	0,	0,	0,	-1,     0},
	{ "MultiMC",		NULL,	NULL,	1 << 5,	1,	0,	0,	-1,     0},
	{ "Minecraft* 1.16.5",	NULL,	NULL,	1 << 5,	0,	0,	0,	-1,     0},
	// Espacio 7: Guitarra/Producción Musical
	{ "TuxGuitar",		NULL,	NULL,	1 << 6,	0,	0,	0,	-1,     0},
	{ "Gmetronome",		NULL,	NULL,	1 << 6,	1,	0,	0,	-1,     0},
	{ "REAPER",		NULL,	NULL,	1 << 6,	0,	0,	0,	-1,     0},
	{ "Guitarix",		NULL,	NULL,	1 << 6,	0,	0,	0,	-1,     0},
	// Espacio 8: Gráficos
	{ "krita",		NULL,	NULL,	1 << 7,	0,	0,	0,	-1,     0},
	{ "Fr.handbrake.ghb",	NULL,	NULL,	1 << 7,	0,	0,	0,	-1,     0},
	{ "Gimp",		NULL,	NULL,	1 << 7,	0,	0,	0,	-1,     0},
	// Espacio 9: Organizar/Descargar Música
	{ "Lrcget",		NULL,	NULL,	1 << 8,	0,	0,	0,	-1,     0},
	{ "Easytag",		NULL,	NULL,	1 << 8,	0,	0,	0,	-1,     0},
	{ "Picard",		NULL,	NULL,	1 << 8,	0,	0,	0,	-1,     0},
	{ "qBittorrent",	NULL,	NULL,	1 << 8,	0,	0,	0,	-1,     0},
	// Espacio 10: Utilidades/Configuración
	{ "org.gnome.clocks",	NULL,	NULL,	1 << 9,	1,	0,	0,	-1,     0},
	{ "KeePassXC",		NULL,	NULL,	1 << 9,	0,	0,	0,	-1,     0},
	{ "Timeshift-gtk",	NULL,	NULL,	1 << 9,	0,	0,	0,	-1,     0},
	{ "BleachBit",		NULL,	NULL,	1 << 9,	0,	0,	0,	-1,     0},
	{ "Gnome-disks",	NULL,	NULL,	1 << 9,	0,	0,	0,	-1,     0},
	{ "Clamtk",		NULL,	NULL,	1 << 9,	1,	0,	0,	-1,     0},
	{ "balena-etcher",	NULL,	NULL,	1 << 9,	1,	0,	0,	-1,     0},
	{ "Nitrogen",		NULL,	NULL,	1 << 9,	1,	0,	0,	-1,     0},
	{ "Blueman-manager",	NULL,	NULL,	1 << 9,	0,	0,	0,	-1,     0},
	{ "Arandr",		NULL,	NULL,	1 << 9,	0,	0,	0,	-1,     0},
	{ "Lxappearance",	NULL,	NULL,	1 << 9,	0,	0,	0,	-1,     0},
	{ "qt5ct",		NULL,	NULL,	1 << 9,	0,	0,	0,	-1,     0},
	{ "baobab",		NULL,	NULL,	1 << 9,	0,	0,	0,	-1,     0},
	// Scratchpad
	{ NULL,	NULL,"scratchpad",              0,      1,      1,      1,      -1,     's'},
};

#include "layouts.c" // Archivo con los layouts adicionales

static const Layout layouts[] = {
	{ "[]=",      tile },           // Layout por defecto
	{ "><>",      NULL },           // Ningún layout significa comportamiento flotante
	{ "[M]",      monocle },        // Las ventans ocupan toda la pantalla
	{ "|M|",      centeredmaster }, // 3 Columnas (Zona principal centrada)
	{ "|||",      col },            // Columnas (Zona principal a la izquierda)
	{ "TTT",      bstack },         // Zona principal en la parte superior
};

// Definiciones de las Teclas
#define MODKEY Mod1Mask // Super (Win) como modificador
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },
#define STACKKEYS(MOD,ACTION) \
/* Poner el foco/Mover a la posición anterior */	{ MOD, XK_comma,  ACTION##stack, {.i = INC(-1) } }, \
/* Poner el foco/Mover a la posición posterior */	{ MOD, XK_period, ACTION##stack, {.i = INC(+1) } }, \
/* Poner el foco/Mover a la posición anterior */	{ MOD, XK_Left,   ACTION##stack, {.i = INC(-1) } }, \
/* Poner el foco/Mover a la posición posterior */	{ MOD, XK_Right,  ACTION##stack, {.i = INC(+1) } }, \
/* Poner el foco/Mover a la primera ventana principal */{ MOD, XK_minus,  ACTION##stack, {.i = 0 } },

// Invocador de comandos
#define SHCMD(cmd) { .v = (const char*[]){ "/usr/bin/zsh", "-c", cmd, NULL } }

// Comandos
static char dmenumon[2] = "0"; // Comando para ejecutar dmenu
static const char *dmenucmd[] = { "dbus-launch", "dmenu_run",
"-m",  dmenumon,       "-fn", dmenufont,
"-nb", background,     "-nf", foreground,
"-sb", background_sel, "-sf", foreground,
"-c",                  "-l",  DLINES, NULL };
static const char *termcmd[]  = { TERM, NULL };      // Terminal
static const char *layoutmenu_cmd = "layoutmenu.sh"; // Script para cambiar el layout
static const char *scratchpadcmd[] = { "s", NULL };  // Tecla para los scratchpads
static const char *spawnscratchpadcmd[] = { TERM, TERMT, "scratchpad", NULL }; // Comando para invocar un scratchpad

#include <X11/XF86keysym.h> // Incluir teclas especiales

static const Key keys[] = {
	// Modificador                  Tecla      Función           Argumento
	// Abrir dmenu
	{ MODKEY,                       XK_p,      spawn,            {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_p,      spawn,            SHCMD("j4-dmenu-desktop --dmenu 'dmenu -c -l 16'") },
	// Abrir terminal
	{ MODKEY|ShiftMask,             XK_Return, spawn,            {.v = termcmd } },
	// Configurar pantallas
	{ MODKEY,                       XK_F1,     spawn,            SHCMD("monitor-layout") },
	{ MODKEY|ShiftMask,             XK_F1,     spawn,            SHCMD("arandr") },
	// Abrir aplicaciones más usadas
	{ MODKEY,                       XK_F2,     spawn,            {.v = (const char*[]){ BROWSER, NULL } } },
	{ MODKEY,                       XK_F3,     spawn,            {.v = (const char*[]){ TERM, "lf", NULL } } },
	{ MODKEY,                       XK_F4,     spawn,            SHCMD("tauon") },
	// Montar/Desmontar dispositivos android
	{ MODKEY,                       XK_F5,     spawn,            SHCMD("android-mount") },
	{ MODKEY|ShiftMask,             XK_F5,     spawn,            SHCMD("android-umount") },
	// Menu de apagado
	{ MODKEY,                       XK_F11,    spawn,            SHCMD("powermenu") },
	// Cerrar dwm
	{ MODKEY|ShiftMask,             XK_F11,    spawn,            SHCMD("pkill dwm") },
	// Ajustes de audio
	{ MODKEY,                       XK_F12,    spawn,           SHCMD("pavucontrol") },
	// Cambiar música
	{ MODKEY,                       XK_z,      spawn,            SHCMD("curl 'http://localhost:7814/api1/back'; pkill -54 dwmblocks") },
	{ MODKEY,                       XK_x,      spawn,            SHCMD("curl 'http://localhost:7814/api1/next'; pkill -54 dwmblocks") },
	{ MODKEY|ShiftMask,             XK_z,      spawn,            SHCMD("music play-pause; pkill -54 dwmblocks") },
	{ MODKEY|ShiftMask,             XK_x,      spawn,            SHCMD("music play-pause; pkill -54 dwmblocks") },
	{ 0,                XF86XK_AudioPlay,      spawn,            SHCMD("music play-pause; pkill -54 dwmblocks") },
	// Cambiar volumen
	{ MODKEY,                       XK_n,      spawn,            SHCMD("pactl set-sink-volume @DEFAULT_SINK@ -5%; pkill -44 dwmblocks") },
	{ MODKEY,                       XK_m,      spawn,            SHCMD("pactl set-sink-volume @DEFAULT_SINK@ +5%; pkill -44 dwmblocks") },
	{ MODKEY|ControlMask,           XK_n,      spawn,            SHCMD("pactl set-sink-mute @DEFAULT_SINK@ toggle; pkill -44 dwmblocks") },
	{ MODKEY|ControlMask,           XK_m,      spawn,            SHCMD("pactl set-sink-mute @DEFAULT_SINK@ toggle; pkill -44 dwmblocks") },
	{ MODKEY|ShiftMask,             XK_n,      spawn,            SHCMD("pactl set-sink-volume @DEFAULT_SINK@ 32768; pkill -44 dwmblocks") },
	{ MODKEY|ShiftMask,             XK_m,      spawn,            SHCMD("pactl set-sink-volume @DEFAULT_SINK@ 65536; pkill -44 dwmblocks") },
	// Forzar cerrar ventana
	{ MODKEY|ShiftMask,             XK_c,      spawn,            SHCMD("xkill") },
	// Abrir/Cerrar barra de tareas
	{ MODKEY,                       XK_t,      spawn,            SHCMD("pkill trayer || trayer --align center --edge top --expand false --width 10 --height 48 --distance 90 --iconspacing 6 --SetDockType false") },
	// Tomar capturas de pantalla
	{ MODKEY,                       XK_o,      spawn,            SHCMD("screenshot all_clip") },
	{ MODKEY|ShiftMask,             XK_o,      spawn,            SHCMD("screenshot selection_clip") },
	{ MODKEY|ControlMask,           XK_o,      spawn,            SHCMD("screenshot all_save") },
	{ MODKEY|ShiftMask|ControlMask, XK_o,      spawn,            SHCMD("screenshot selection_save") },
	// Mostrar/Ocultar barra
	{ MODKEY,                       XK_b,      togglebar,        {0} },
	// Hacer/Deshacer ventana permamente
	{ MODKEY,                       XK_a,      togglesticky,     {0} },
	// Cambiar de espacio
	{ MODKEY,                       XK_q,      shiftviewclients, { .i = -1 } },
	{ MODKEY,                       XK_w,      shiftviewclients, { .i = +1 } },
	// Cambiar foco/Mover ventana
	STACKKEYS(MODKEY,                                            focus)
	STACKKEYS(MODKEY|ShiftMask,                                  push)
	// Incrementar/Decrementar el número de ventanas de la zona principal
	{ MODKEY,                       XK_j,      incnmaster,       {.i = +1 } },
	{ MODKEY,                       XK_k,      incnmaster,       {.i = -1 } },
	// Incrementar/Decrementar el tamaño de la zona principal y las ventanas
	{ MODKEY,                       XK_u,      setmfact,         {.f = -0.025} },
	{ MODKEY,                       XK_i,      setmfact,         {.f = +0.025} },
	{ MODKEY|ShiftMask,             XK_u,      setcfact,         {.f = -0.25} },
	{ MODKEY|ShiftMask,             XK_i,      setcfact,         {.f = +0.25} },
	// Cerrar aplicación
	{ MODKEY|ShiftMask,             XK_q,      killclient,       {0} },
	// Hacer/Deshacer ventana flotante
	{ MODKEY|ShiftMask,             XK_space,  togglefloating,   {0} },
	// Cambiar de monitor / Mover las ventanas entre monitores
	// (Sólo para teclado español, "´" y "ç" son teclas del layout español)
	{ MODKEY,                       XK_dead_acute, focusmon,     {.i = -1 } },
	{ MODKEY,                       XK_ccedilla,   focusmon,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_dead_acute, tagmon,       {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_ccedilla,   tagmon,       {.i = +1 } },
	// Scratchpads
        { MODKEY,                       XK_s,      togglescratch,    {.v = scratchpadcmd } },
        { MODKEY|ControlMask,           XK_s,      removescratch,    {.v = scratchpadcmd } },
        { MODKEY|ShiftMask,             XK_s,      setscratch,       {.v = scratchpadcmd } },
	{ MODKEY,                       XK_f,      spawn,            {.v = spawnscratchpadcmd } },
	// Cambiar la distribución de las ventanas
	{ MODKEY,                       XK_e,      setlayout,        {.v = &layouts[0]} },
	{ MODKEY,                       XK_r,      setlayout,        {.v = &layouts[1]} },
	{ MODKEY|ShiftMask,             XK_e,      setlayout,        {.v = &layouts[2]} },
	{ MODKEY|ShiftMask,             XK_r,      setlayout,        {.v = &layouts[3]} },
	{ MODKEY,                       XK_y,      setlayout,        {.v = &layouts[4]} },
	{ MODKEY|ShiftMask,             XK_y,      setlayout,        {.v = &layouts[5]} },
	// Teclas para cada espacio
	TAGKEYS(                        XK_1,                        0)
	TAGKEYS(                        XK_2,                        1)
	TAGKEYS(                        XK_3,                        2)
	TAGKEYS(                        XK_4,                        3)
	TAGKEYS(                        XK_5,                        4)
	TAGKEYS(                        XK_6,                        5)
	TAGKEYS(                        XK_7,                        6)
	TAGKEYS(                        XK_8,                        7)
	TAGKEYS(                        XK_9,                        8)
	TAGKEYS(                        XK_0,                        9)
	TAGKEYS(                        XK_apostrophe,              10)
	TAGKEYS(                        XK_exclamdown,              11)
};

// Botónes del ratón
// Click puede ser ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, o ClkRootWin.
static const Button buttons[] = {
	// Click                Combinación     Botón           Función         Argumento
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {.v = &layouts[0]} },
	{ ClkLtSymbol,          0,              Button3,        layoutmenu,     {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkRootWin,           0,              Button2,        spawn,          SHCMD("xmenu-sinks") },
	{ ClkRootWin,           0,              Button3,        spawn,          SHCMD("xmenu-apps") },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
