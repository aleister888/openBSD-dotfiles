/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 4;        /* border pixel of windows */
static const unsigned int gappx     = 36;        /* gaps between windows */
static const unsigned int snap      = 0;       /* snap pixel */
static const int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int allowkill          = 1;        /* allow killing clients by default? */
static const int user_bh            = 0;	/* 0 default, >= 1 user_bh as height */
static const char *fonts[]          = { "Monospace:pixelsize=22:bold:antialias=true:autohint=true",
					"Symbols Nerd Font:bold:pixelsize=22:antialias=true:autohint=true" };
static const char autostartblocksh[] = "autostart_blocking.sh";
static const char autostartsh[] = "autostart.sh";
static const char dwmdir[] = "dwm";
static const char localshare[] = ".local/share";
static const char dmenufont[]       = "Monospace:pixelsize=20:antialias=true:autohint=true";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#222222";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#bbbbbb";
static const char col_cyan[]        = "#3A3A3A";
static const char col_red[]         = "#3A3A3A";
static const char col_orange[]      = "#424242";
// Left
static const char tag_foreground[]        = "#bbbbbb";
static const char tag_background[]        = "#222222";
static const char seltag_foreground[]        = "#222222";
static const char seltag_background[]        = "#3A3A3A";
// Middle
static const char mid_foreground[]        = "#bbbbbb";
static const char mid_background[]        = "#222222";
static const char selmid_foreground[]        = "#bbbbbb";
static const char selmid_background[]        = "#222222";
// Right
static const char status_foreground[]        = "#222222";
static const char status_background[]        = "#222222";
static const char *colors[][3]      = {
	/*               	    fg         		bg		border   */
	[SchemeNorm]		= { col_gray3,		col_gray1,	col_gray2 },
	[SchemeSel]		= { col_gray4,		col_cyan, 	col_cyan  },
	[SchemeTagsNorm]	= { tag_foreground,	tag_background,	"#ffffff"  }, // Tagbar left unselected {text,background,not used but cannot be empty}
	[SchemeTagsSel]		= { seltag_foreground,	seltag_background, "#ffffff"  }, // Tagbar left selected {text,background,not used but cannot be empty}
	[SchemeInfoNorm]	= { mid_foreground,	mid_background,	"#ffffff"  }, // infobar middle  unselected {text,background,not used but cannot be empty}
	[SchemeInfoSel]		= { selmid_foreground,	selmid_background, "#ffffff"  }, // infobar middle  selected {text,background,not used but cannot be empty}
	[SchemeStatus]		= { status_foreground,	status_background, "#ffffff"  }, // Statusbar right {text,background,not used but cannot be empty}
	[SchemeScratchSel] = { col_gray4, col_cyan,  col_orange },
	[SchemeScratchNorm]  = { col_gray4, col_cyan,  col_red  },
};

typedef struct {
	const char *name;
	const void *cmd;
} Sp;

/* tagging */	/* Sound & Video, Mail, Internet, Office, Games, Graphics, Utilities, Looking-Glass & Virt-Manager, Guitar */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
static const char *alttags[] = { "", "", "󰈹", "", "󱓷", "", "󱁤", "", "" };
static const int taglayouts[] = { 0, 2, 0, 0, 0, 0, 0, 3, 0 };

// There are two options when it comes to per-client rules:
static const Rule rules[] = {
	/* class		instance	title	tags mask	awkill	isfloating	isfakefullscreen monitor */
	{ "trayer",		NULL,		NULL,	0,		0,	1,		0,		-1},
//	{ "supertuxkart",	NULL,		NULL,	0,		1,	0,		0,		-1},
	/* Floating Windows */
	{ "Yad",		NULL,		NULL,	0,		1,	1,		0,		-1},
	{ "Gcolor2",		NULL,		NULL,	0,		1,	1,		0,		-1},
	{ "Pavucontrol",	NULL,		NULL,	0,		1,	1,		0,		-1},
	/* Tag 1: MUSIC */
	{ "Tauon Music Box",	NULL,		NULL,	1 << 0,		1,	0,		0,		-1},
	{ "Easytag",		NULL,		NULL,	1 << 0,		1,	0,		0,		-1},
	/* Tag 3: Mail */
	{ "thunderbird",	NULL,		NULL,	1 << 1,		1,	0,		0,		-1},
	/* Tag 3: INTERNET */
	{ "Firefox",		NULL,		NULL,	1 << 2,		1,	0,		1,		-1},
	{ "firefox",		NULL,		NULL,	1 << 2,		1,	0,		1,		-1},
	{ "chromium-browser",	NULL,		NULL,	1 << 2,		1,	0,		1,		-1},
	{ "Chromium-browser",	NULL,		NULL,	1 << 2,		1,	0,		1,		-1},
	{ "Abaddon",		NULL,		NULL,	1 << 2,		1,	0,		0,		-1},
	{ "transmission-gtk",	NULL,		NULL,	1 << 2,		1,	0,		0,		-1},
	{ "Transmission-gtk",	NULL,		NULL,	1 << 2,		1,	0,		0,		-1},
	/* Tag 4: Office */
	{ "Soffice",		NULL,		NULL,	1 << 3,		1,	0,		0,		-1},
	{ "Zim",		NULL,		NULL,	1 << 3,		1,	1,		0,		-1},
	{ "gnome-calculator",	NULL,		NULL,	1 << 3,		1,	1,		0,		-1},
	/* Tag 6: Graphics */
	{ "Fr.handbrake.ghb",	NULL,		NULL,	1 << 5,		1,	0,		0,		-1},
	{ "Gimp",		NULL,		NULL,	1 << 5,		1,	0,		0,		-1},
	{ "Minecraft* 1.16.5",	NULL,		NULL,	1 << 5,		1,	0,		0,		-1},
	{ "Minecraft 1.12.2",	NULL,		NULL,	1 << 5,		1,	0,		0,		-1},
	{ "Blockgame",		NULL,		NULL,	1 << 5,		1,	1,		0,		-1},
	/* Tag 7: Utilities */
	{ "org.gnome.clocks",	NULL,		NULL,	1 << 6,		1,	1,		0,		-1},
	{ "KeePassXC",		NULL,		NULL,	1 << 6,		1,	0,		0,		-1},
	{ "Timeshift-gtk",	NULL,		NULL,	1 << 6,		1,	0,		0,		-1},
	{ "BleachBit",		NULL,		NULL,	1 << 6,		1,	0,		0,		-1},
	{ "Nitrogen",		NULL,		NULL,	1 << 6,		1,	1,		0,		-1},
	{ "Arandr",		NULL,		NULL,	1 << 6,		1,	0,		0,		-1},
	{ "Lxappearance",	NULL,		NULL,	1 << 6,		1,	0,		0,		-1},
	{ "qt5ct",		NULL,		NULL,	1 << 6,		1,	0,		0,		-1},
	/* class instance title		tags mask	allowkill	isfloating	isfakefullscreen	monitor		scratch key */
	{ NULL,	 NULL,	 "scratchpad",	0,		1,		1,		0,			-1,		's' },
};

/* layout(s) */
static const float mfact     = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile }, // First entry is default
	{ "><>",      NULL }, // No layout function means floating behavior
	{ "[M]",      monocle },
	{ "|M|",      centeredmaster }, // 3 Columns Layout
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "alacritty", NULL };
static const char *scratchpadcmd[] = { "s", NULL };
static const char *spawnscratchpadcmd[] = { "alacritty", "-t", "scratchpad", NULL };

static const Key keys[] = {
	/* modifier                     key            function                argument */
	// open dmenu
	{ MODKEY,                       XK_d,          spawn,                 {.v = dmenucmd } },
	{ MODKEY,                       XK_Return,     spawn,                 {.v = termcmd } },
	// toggle bar
	//{ MODKEY,                       XK_b,          togglebar,              {0} },
	{ MODKEY,                       XK_0,          togglebar,              {0} },
	// toggle sticky
	{ MODKEY|Mod1Mask,		XK_s,	       togglesticky,	       {0} },
	// change tag
	{ MODKEY,			XK_q,	       shiftviewclients,       { .i = -1 } },
	{ MODKEY,			XK_w,	       shiftviewclients,       { .i = +1 } },
	// change focus
	{ MODKEY,                       XK_Right,      focusstack,             {.i = +1 } },
	{ MODKEY,                       XK_Left,       focusstack,             {.i = -1 } },
	// move windows
	{ MODKEY|ShiftMask,             XK_Right,      rotatestack,            {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_Left,       rotatestack,            {.i = -1 } },
	// increase/decrease stack
	{ MODKEY,                       XK_j,          incnmaster,             {.i = +1 } },
	{ MODKEY,                       XK_k,          incnmaster,             {.i = -1 } },
	// increase/decrease stack size
	{ MODKEY,                       XK_u,          setmfact,               {.f = -0.025} },
	{ MODKEY,                       XK_i,          setmfact,               {.f = +0.025} },
	{ MODKEY,                       XK_h,          setcfact,               {.f = +0.25} },
	{ MODKEY,                       XK_l,          setcfact,               {.f = -0.25} },
	// swap master/stack window
        { MODKEY|ControlMask,           XK_Left,       zoom,                   {0} },
        { MODKEY|ControlMask,           XK_Right,      zoom,                   {0} },
	{ MODKEY|ShiftMask,             XK_q,          killclient,             {0} },
	{ MODKEY|ShiftMask,             XK_F11,        quit,                   {0} },
	{ MODKEY|ShiftMask,             XK_space,      togglefloating,         {0} },
	// monitor control
	{ MODKEY,                       XK_comma,      focusmon,               {.i = -1 } },
	{ MODKEY,                       XK_period,     focusmon,               {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,      tagmon,                 {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period,     tagmon,                 {.i = +1 } },
	// scratchpads
        { MODKEY,                       XK_s,          togglescratch,  {.v = scratchpadcmd } },
        { MODKEY|ControlMask,           XK_s,          removescratch,  {.v = scratchpadcmd } },
        { MODKEY|ShiftMask,             XK_s,          setscratch,     {.v = scratchpadcmd } },
	{ MODKEY,                       XK_f,          spawn,          {.v = spawnscratchpadcmd } },
	// change layout
	{ MODKEY,                       XK_e,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_r,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY|ShiftMask,             XK_e,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY|ShiftMask,             XK_r,      setlayout,      {.v = &layouts[3]} },
	TAGKEYS(                        XK_1,                                  0)
	TAGKEYS(                        XK_2,                                  1)
	TAGKEYS(                        XK_3,                                  2)
	TAGKEYS(                        XK_4,                                  3)
	TAGKEYS(                        XK_5,                                  4)
	TAGKEYS(                        XK_6,                                  5)
	TAGKEYS(                        XK_7,                                  6)
	TAGKEYS(                        XK_8,                                  7)
	TAGKEYS(                        XK_9,                                  8)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
//	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
//	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

