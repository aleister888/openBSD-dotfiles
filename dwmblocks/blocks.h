static char delim[] ="";
static unsigned int delimLen = 0;
static const Block blocks[] = {
	/*Icon*/			/*Command*/					/*Updt. Interval & Signal*/
	// Current song
	{""				, "~/.local/scripts/sb/sb-music &",				1,	2},
	// Charging status
	{" ^d^^c#CC241D^"		, "~/.local/scripts/sb/sb-bat",  				1,	0},
	// Battery percentage
	{" ^c#FB4934^"			, "apm | awk '{print $4}' | grep %",				1,	0},
	// Free space
	{" ^d^^c#98971A^ ^c#B8BB26^"	, "df -h | egrep 'home|data' | awk '{print $4}' | xargs",	0,	0},
	// Kernel version
	{" ^d^^c#D79921^ ^c#FABD2F^"	, "uname -r",							0,	0},
	// Volume icon
	{" ^d^^c#458588^"		, "~/.local/scripts/sb/sb-vol-icon",    			1,	1},
	// Volume level
	{" ^c#83A598^"			, "~/.local/scripts/sb/sb-vol",    				0,	1},
	// Weather
	//{" ^d^^c#D79921^"		, "~/.local/scripts/sb/sb-weather-icon",			0,	0},
	//{" ^c#FABD2F^"			, "~/.local/scripts/sb/sb-weather",				0,	0},
	// CPU Temp
	//{" ^d^^c#D79921^ ^c#FABD2F^"	, "~/.local/scripts/sb/sb-temp",    				1,	0},
	// Memory used
	{"% ^d^^c#B16286^ ^c#D3869B^"	, "vmstat | awk 'END {printf $3}'",    				5,	0},
	// Date
	{" ^d^^c#689D6A^ ^c#8EC07C^"	, "date +'%d/%m'",    						0,	0},
	//{"C ^d^^c#AE4335^ ^c#DB5947^", "date +'%d/%m'",    						0,	0},
	// Time
	{" ^d^^c#D65D0E^ ^c#FE8019^"	, "date +'%I:%M'",						1,	0},
	{""				, "echo ' '",							0,	0},

};
