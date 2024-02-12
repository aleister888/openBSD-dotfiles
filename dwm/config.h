// See LICENSE file for copyright and license details.
static const unsigned int borderpx    = 4;  // Border pixel of windows
static const unsigned int gappx       = 16; // Gaps between windows
static const int vertpad              = 16; // Vertical padding of bar
static const int sidepad              = 16; // Horizontal padding of bar
static const unsigned int snap        = 0;  // Snap pixel
static const int swallowfloating      = 0;  // 1 means swallow floating windows by default */
static const int showbar              = 1;  // 0 Means no bar
static const int topbar               = 1;  // 0 Means bottom bar
static const int startontag           = 0;  // 0 Means no tag active on start
static const int allowkill            = 1;  // Allow killing clients by default?
static const int user_bh              = 12; // 0 Default, >= 1 Is added to user_bh as height
static const char *fonts[]            = { "Symbols Nerd Font:pixelsize=24:antialias=true:autohint=true","Iosevka Nerd Font:bold:pixelsize=24:antialias=true:autohint=true" };
static const char autostartblocksh[]  = "autostart_blocking.sh";
static const char autostartsh[]       = "autostart.sh";
static const char dwmdir[]            = "dwm";
static const char localshare[]        = ".local/share";
static const char dmenufont[]         = "Iosevka Nerd Font:bold:pixelsize=24:antialias=true:autohint=true";
static const char col_gray1[]         = "#1D2021";
static const char col_gray2[]         = "#282828";
static const char col_gray3[]         = "#3C3836";
static const char col_gray4[]         = "#504945";
static const char col_cyan[]          = "#83A598";
static const char col_red[]           = "#FB4934";
static const char col_magenta[]       = "#B16286";
static const char col_orange[]        = "#FE8019";
// Left
static const char tag_foreground[]    = "#D5C4A1";
static const char tag_background[]    = "#1D2021";
static const char seltag_foreground[] = "#D5C4A1";
static const char seltag_background[] = "#3C3836";
// Middle
static const char mid_foreground[]    = "#D5C4A1";
static const char mid_background[]    = "#282828";
static const char selmid_foreground[] = "#D5C4A1";
static const char selmid_background[] = "#282828";
// Right
static const char status_foreground[] = "#EBDBB2";
static const char status_background[] = "#1D2021";
static const char *colors[][3]      = {
	//               	    fg                 bg                 border
	[SchemeNorm]		= { tag_foreground,    tag_background,    col_gray1  }, // Normal Windows
	[SchemeSel]		= { seltag_foreground, seltag_background, col_orange }, // Selected Windows
	[SchemeTagsNorm]	= { tag_foreground,    tag_background,    "#ffffff"  }, // Tag Left (Normal)
	[SchemeTagsSel]		= { seltag_foreground, seltag_background, "#ffffff"  }, // Tag Left (Selected)
	[SchemeInfoNorm]	= { mid_foreground,    mid_background,    "#ffffff"  }, // Info (Normal)
	[SchemeInfoSel]		= { selmid_foreground, selmid_background, "#ffffff"  }, // Info (Selected)
	[SchemeStatus]		= { status_foreground, status_background, "#ffffff"  }, // Statusbar
	[SchemeScratchSel]	= { "#ffffff",		"#ffffff",		col_cyan   }, // Scratchpad (Normal)
	[SchemeScratchNorm] 	= { "#ffffff",		"#ffffff",		col_gray1  }, // Scratchpad (Selected)
	[SchemeUrg]		= { "#ffffff",		"#ffffff",		col_magenta}, // Urgent Window
	// Values filled with "#ffffff" are not used but cannot be empty
};

typedef struct {
	const char *name;
	const void *cmd;
} Sp;

static const char *tags[]	= { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
static const char *alttags[]	= { "", "", "󰈹", "", "", "", "󱁤", "󰋅", "" };
static const int taglayouts[]	= {   0,   0,   0,   0,   0,   0,   0,   0,   0 };

// There are two options when it comes to per-client rules:
static const Rule rules[] = {
	// class		instance title tag     allowkill float terminal -swallow fakefullscreen monitor
	// Terminal
	{ "Alacritty",		NULL,    NULL, 0,      1,        0,    1,       0,       0,             -1},
	// Tray
	{ "trayer",		NULL,    NULL, 0,      0,        0,    0,       0,       0,             -1},
	// Floating Windows
	{ "Yad",		NULL,    NULL, 0,      1,        1,    0,       0,       0,             -1},
	{ "Gcolor2",		NULL,    NULL, 0,      1,        1,    0,       0,       0,             -1},
	{ "gnome-calculator",	NULL,    NULL, 0,      1,        1,    0,       0,       0,             -1},
	// Tag 1: Music
	{ "Tauon Music Box",	NULL,    NULL, 1 << 0, 1,        0,    0,       0,       0,             -1},
	{ "Easytag",		NULL,    NULL, 1 << 0, 1,        0,    0,       0,       0,             -1},
	// Tag 2: Mail
	{ "thunderbird",	NULL,    NULL, 1 << 1, 1,        0,    0,       0,       0,             -1},
	// Tag 3: Internet
	{ "Chromium-browser",	NULL,    NULL, 1 << 2, 1,        0,    0,       0,       1,             -1},
	{ "Abaddon",		NULL,    NULL, 1 << 2, 1,        0,    0,       0,       0,             -1},
	{ "transmission-gtk",	NULL,    NULL, 1 << 2, 1,        0,    0,       0,       0,             -1},
	{ "Transmission-gtk",	NULL,    NULL, 1 << 2, 1,        0,    0,       0,       0,             -1},
	// Tag 4: Office
	{ "Zim",		NULL,    NULL, 1 << 3, 1,        0,    0,       0,       0,             -1},
	// Tag 6: Graphics
	{ "Fr.handbrake.ghb",	NULL,    NULL, 1 << 5, 1,        0,    0,       0,       0,             -1},
	{ "Gimp",		NULL,    NULL, 1 << 5, 1,        0,    0,       0,       0,             -1},
	// Tag 7: Utilities
	{ "org.gnome.clocks",	NULL,    NULL, 1 << 6, 1,        1,    0,       0,       0,             -1},
	{ "KeePassXC",		NULL,    NULL, 1 << 6, 1,        0,    0,       0,       0,             -1},
	{ "Timeshift-gtk",	NULL,    NULL, 1 << 6, 1,        0,    0,       0,       0,             -1},
	{ "BleachBit",		NULL,    NULL, 1 << 6, 1,        0,    0,       0,       0,             -1},
	{ "Nitrogen",		NULL,    NULL, 1 << 6, 1,        1,    0,       0,       0,             -1},
	{ "Arandr",		NULL,    NULL, 1 << 6, 1,        0,    0,       0,       0,             -1},
	{ "Lxappearance",	NULL,    NULL, 1 << 6, 1,        0,    0,       0,       0,             -1},
	{ "qt5ct",		NULL,    NULL, 1 << 6, 1,        0,    0,       0,       0,             -1},
	// class instance title         tags mask allowkill isfloating terminal -swallow isfakefullscreen monitor scratch key
	{ NULL,  NULL,    "scratchpad", 0,        1,        1,         0,       1,       0,               -1,     's' },
};

static const float mfact        = 0.5; // Factor of master area size [0.05..0.95]
static const int nmaster        = 1;   // Number of clients in master area
static const int resizehints    = 1;   // 1 Means respect size hints in tiled resizals
static const int decorhints     = 0;   // 1 Means respect decoration hints
static const int lockfullscreen = 1;   // 1 Will force focus on the fullscreen window

static const Layout layouts[] = {
	{ "[]=",      tile },           // First entry is default
	{ "><>",      NULL },           // No layout function means floating behavior
	{ "[M]",      monocle },        // Windows occupies whole space
	{ "|M|",      centeredmaster }, // 3 Columns layout (Centered master)
	{ "|||",      col },            // Columns layout (Left master)
	{ "TTT",      bstack },         // Bottom stack
};

// Key Definitions
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

// Command spawner
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

// Commands
static char dmenumon[2] = "0"; // Component of dmenucmd, manipulated in spawn()
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nf", tag_foreground, "-nb", tag_background, "-sf", seltag_foreground, "-sb", seltag_background, "-c", "-l", "16", NULL };
static const char *termcmd[]  = { "alacritty", NULL };
static const char *layoutmenu_cmd = "layoutmenu.sh";
static const char *scratchpadcmd[] = { "s", NULL };
static const char *spawnscratchpadcmd[] = { "alacritty", "-t", "scratchpad", NULL };

static const Key keys[] = {
	// modifier                     key        function          argument
	// open dmenu
	{ MODKEY,                       XK_d,      spawn,            {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, spawn,            {.v = termcmd } },
	// toggle bar
	{ MODKEY,                       XK_b,      togglebar,        {0} },
	// toggle sticky
	{ MODKEY|Mod1Mask,              XK_s,      togglesticky,         {0} },
	// change tag
	{ MODKEY,                       XK_q,      shiftviewclients, { .i = -1 } },
	{ MODKEY,                       XK_w,      shiftviewclients, { .i = +1 } },
	// change focus
	{ MODKEY,                       XK_Right,  focusstack,       {.i = +1 } },
	{ MODKEY,                       XK_Left,   focusstack,       {.i = -1 } },

	// move windows
	{ MODKEY|ShiftMask,             XK_Right,  rotatestack,      {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_Left,   rotatestack,      {.i = -1 } },
	// increase/decrease stack
	{ MODKEY,                       XK_j,      incnmaster,       {.i = +1 } },
	{ MODKEY,                       XK_k,      incnmaster,       {.i = -1 } },
	// increase/decrease stack size
	{ MODKEY,                       XK_u,      setmfact,         {.f = -0.025} },
	{ MODKEY,                       XK_i,      setmfact,         {.f = +0.025} },
	{ MODKEY,                       XK_h,      setcfact,         {.f = +0.25} },
	{ MODKEY,                       XK_l,      setcfact,         {.f = -0.25} },
	// swap master/stack window
        { MODKEY|ControlMask,           XK_Left,   zoom,             {0} },
        { MODKEY|ControlMask,           XK_Right,  zoom,             {0} },
	{ MODKEY|ShiftMask,             XK_q,      killclient,       {0} },
	{ MODKEY|ShiftMask,             XK_F11,    quit,             {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating,   {0} },
	// monitor control
	{ MODKEY,                       XK_comma,  focusmon,         {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,         {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,           {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,           {.i = +1 } },
	// scratchpads
        { MODKEY,                       XK_s,      togglescratch,    {.v = scratchpadcmd } },
        { MODKEY|ControlMask,           XK_s,      removescratch,    {.v = scratchpadcmd } },
        { MODKEY|ShiftMask,             XK_s,      setscratch,       {.v = scratchpadcmd } },
	{ MODKEY,                       XK_f,      spawn,            {.v = spawnscratchpadcmd } },
	// change layout
	{ MODKEY,                       XK_e,      setlayout,        {.v = &layouts[0]} },
	{ MODKEY,                       XK_r,      setlayout,        {.v = &layouts[1]} },
	{ MODKEY|ShiftMask,             XK_e,      setlayout,        {.v = &layouts[2]} },
	{ MODKEY|ShiftMask,             XK_r,      setlayout,        {.v = &layouts[3]} },
	{ MODKEY,                       XK_y,      setlayout,        {.v = &layouts[4]} },
	{ MODKEY|ShiftMask,             XK_y,      setlayout,        {.v = &layouts[5]} },
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

// Button definitions
// Click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin
static const Button buttons[] = {
	// click                event mask      button          function        argument
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {.v = &layouts[0]} },
	{ ClkLtSymbol,          0,              Button3,        layoutmenu,     {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

