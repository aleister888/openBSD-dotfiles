/* See LICENSE file for copyright and license details. */

// Constantes
static const unsigned int gappx          = 16;      // Separación entre las ventanas
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
static const char dmenufont[]            = "Iosevka Nerd Font:bold:pixelsize=22"; // Fuentes
static const char *fonts[]               = { "Symbols Nerd Font:pixelsize=24","Iosevka Nerd Font:bold:pixelsize=22" };
static const char background[]           = "#1D2021";
static const char background_sel[]       = "#282828";
static const char foreground[]           = "#EBDBB2";
static const char col_cyan[]             = "#458588";
static const char col_red[]              = "#FB4934";
static const char col_magenta[]          = "#B16286";
static const char col_orange[]           = "#FE8019";
static const char *colors[][3] = {
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
static const char *tags[]	= { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
static const char *alttags[]	= { "", "", "", "", "", "󱁤", "", "", "" };
static const int taglayouts[]	= {   0,   0,   0,   0,   0,   0,   0,   0,   0 };

// Reglas pre-establecidas para colocar las ventanas
static const Rule rules[] = {
	// Clase Instancia      Título Espacio Flotante Terminal -Tragado Monitor Tecla Scratch
	// Terminal
	{ "st-256color",	NULL,    NULL, 0,      0,    1,       0,      -1},
	// -Tragado
	{ "Dragon-drop",	NULL,    NULL, 0,      1,    0,      -1,      -1},
	// Ventanas flotantes
	{ "Yad",		NULL,    NULL, 0,      1,    0,       0,      -1},
	{ "Gcolor2",		NULL,    NULL, 0,      1,    0,       0,      -1},
	{ "gnome-calculator",	NULL,    NULL, 0,      1,    0,       0,      -1},
	{ "Gsimplecal",		NULL,    NULL, 0,      1,    0,       0,      -1},
	// Espacio 1: Música
	{ "tauonmb",		NULL,    NULL, 1 << 0, 0,    0,       0,      -1},
	{ "Easytag",		NULL,    NULL, 1 << 0, 0,    0,       0,      -1},
	// Espacio 2: Correo
	{ "thunderbird",	NULL,    NULL, 1 << 1, 0,    0,       0,      -1},
	// Espacio 3: Internet
	{ "Chromium-browser",	NULL,    NULL, 1 << 2, 0,    0,       0,      -1},
	{ "Abaddon",		NULL,    NULL, 1 << 2, 0,    0,       0,      -1},
	{ "Transmission-gtk",	NULL,    NULL, 1 << 2, 0,    0,       0,      -1},
	// Espacio 4: Oficina
	{ "Zim",		NULL,    NULL, 1 << 3, 0,    0,       0,      -1},
	// Espacio 5: Gráficos
	{ "Fr.handbrake.ghb",	NULL,    NULL, 1 << 4, 0,    0,       0,      -1},
	{ "Gimp",		NULL,    NULL, 1 << 4, 0,    0,       0,      -1},
	// Espacio 6: Utilidades/Configuración
	{ "KeePassXC",		NULL,    NULL, 1 << 5, 0,    0,       0,      -1},
	{ "BleachBit",		NULL,    NULL, 1 << 5, 0,    0,       0,      -1},
	{ "Nitrogen",		NULL,    NULL, 1 << 5, 1,    0,       0,      -1},
	{ "Arandr",		NULL,    NULL, 1 << 5, 0,    0,       0,      -1},
	{ "Lxappearance",	NULL,    NULL, 1 << 5, 0,    0,       0,      -1},
	{ "qt5ct",		NULL,    NULL, 1 << 5, 0,    0,       0,      -1},
	// Scratchpad
	{ NULL,		NULL,"scratchpad",     0,      1,    1,       1,      -1,     's'},
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
#define SHCMD(cmd) { .v = (const char*[]){ "/usr/local/bin/zsh", "-c", cmd, NULL } }

// Comandos
static char dmenumon[2] = "0"; // Comando para ejecutar dmenu
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", background, "-nf", foreground,
"-sb", background_sel, "-sf", foreground, "-c", "-l", "12", NULL };
static const char *termcmd[]  = { "st", NULL }; // Terminal
static const char *layoutmenu_cmd = "layoutmenu.sh"; // Script para cambiar el layout
static const char *scratchpadcmd[] = { "s", NULL }; // Tecla para los scratchpads
static const char *spawnscratchpadcmd[] = { "st", "-t", "scratchpad", NULL }; // Comando para invocar un scratchpad

static const Key keys[] = {
	// Modificador                  Tecla      Función           Argumento
	// Abrir dmenu
	{ MODKEY,                       XK_p,      spawn,            {.v = dmenucmd } },
	// Abrir terminal
	{ MODKEY|ShiftMask,             XK_Return, spawn,            {.v = termcmd } },
	// Menu de apagado
	{ MODKEY,                       XK_F11,    spawn,            SHCMD("powermenu") },
	// Abrir aplicaciones más usadas
	{ MODKEY,                       XK_F2,     spawn,            SHCMD("chrome") },
	{ MODKEY,                       XK_F3,     spawn,            SHCMD("st lf") },
	{ MODKEY,                       XK_F4,     spawn,            SHCMD("tauon") },
	// Desactivar/Activar modo escritura
	{ MODKEY|ShiftMask,             XK_t,      spawn,            SHCMD("typemode") },
	// Desmontar discos (Ya se montan automaticamente con hotplugd)
	{ MODKEY|ShiftMask,             XK_F5,     spawn,            SHCMD("dmenuumount") },
	// Configurar pantallas
	{ MODKEY,                       XK_F1,     spawn,            SHCMD("monitor-layout") },
	{ MODKEY|ShiftMask,             XK_F1,     spawn,            SHCMD("arandr") },
	// Abrir/Cerrar Calendario
	{ MODKEY|ControlMask,           XK_c,      spawn,            SHCMD("gsimplecal") },
	// Cambiar música
	{ MODKEY,                       XK_z,      spawn,            SHCMD("playerctl previous; pkill -USR2 dwmblocks") },
	{ MODKEY,                       XK_x,      spawn,            SHCMD("playerctl next; pkill -USR2 dwmblocks") },
	{ MODKEY|ShiftMask,             XK_z,      spawn,            SHCMD("playerctl play-pause") },
	{ MODKEY|ShiftMask,             XK_x,      spawn,            SHCMD("playerctl play-pause") },
	// Subir/Bajar volumen
	{ MODKEY,                       XK_n,      spawn,            SHCMD("sndioctl output.level=-0.025; pkill -USR1 dwmblocks") },
	{ MODKEY,                       XK_m,      spawn,            SHCMD("sndioctl output.level=+0.025; pkill -USR1 dwmblocks") },
	// Volumen al 100%/50%
	{ MODKEY|ShiftMask,             XK_n,      spawn,            SHCMD("sndioctl output.level=0.75; pkill -USR1 dwmblocks") },
	{ MODKEY|ShiftMask,             XK_m,      spawn,            SHCMD("sndioctl output.level=1; pkill -USR1 dwmblocks") },
	// Silenciar/Activar Micrófono
	{ MODKEY|ShiftMask,             XK_F4,     spawn,            SHCMD("mic-mute-toggle") },
	// Bajar Brillo
	// Cambiar brillo (100%/40%)
	{ MODKEY|ShiftMask,             XK_v,      spawn,            SHCMD("xbacklight -steps 1 -set 40") },
	{ MODKEY|ShiftMask,             XK_b,      spawn,            SHCMD("xbacklight -steps 1 -set 100") },
	// Forzar cierre de ventana
	{ MODKEY|ShiftMask,             XK_c,      spawn,            SHCMD("xkill") },
	// Tomar capturas de pantalla
	{ 0,                            XK_Print,  spawn,            SHCMD("screenshot all_clip") },
	{ ShiftMask,                    XK_Print,  spawn,            SHCMD("screenshot selection_clip") },
	{ MODKEY,                       XK_o,      spawn,            SHCMD("screenshot all_clip") },
	{ MODKEY|ShiftMask,             XK_o,      spawn,            SHCMD("screenshot selection_clip") },
	{ MODKEY|ControlMask,           XK_o,      spawn,            SHCMD("screenshot all_save") },
	{ MODKEY|ShiftMask|ControlMask, XK_o,      spawn,            SHCMD("screenshot selection_save") },
	// Mostrar/Ocultar barra
	{ MODKEY,                       XK_b,      togglebar,        {0} },
	// Hacer/Deshacer ventana permamente
	{ MODKEY|ShiftMask,             XK_a,      togglesticky,     {0} },
	{ MODKEY|ControlMask,           XK_a,      togglesticky,     {0} },
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
	// Cerrar dwm
	{ MODKEY|ShiftMask,             XK_F11,    spawn,            SHCMD("pkill dwm") },
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
};

// Botónes del teclado
// Click puede ser ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, o ClkRootWin.
static const Button buttons[] = {
	// Click                Combinación     Botón           Función         Argumento
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {.v = &layouts[0]} },
	{ ClkLtSymbol,          0,              Button3,        layoutmenu,     {0} },
	{ ClkRootWin,           0,              Button3,        spawn,          SHCMD("xmenu.sh") },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
