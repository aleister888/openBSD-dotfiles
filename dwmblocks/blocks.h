static char delim[] ="";
static unsigned int delimLen = 0;
static const Block blocks[] = {
	/*Icon*/			/*Command*/					/*Updt. Interval & Signal*/
	// Current song
	{""				, "sb-music",							1,	2},
	// Free space
	{" ^d^^c#98971A^ ^c#B8BB26^"	, "df -h | egrep 'home|data' | awk '{print $4}' | xargs",	0,	0},
	// Charging status
	{" ^d^^c#D79921^"		, "sb-bat",  							1,	0},
	// Battery percentage
	{" ^c#FABD2F^"			, "apm | awk '{print $4}' | grep %",				1,	0},
	// Volume icon
	{" ^d^^c#458588^"		, "sb-vol-icon",    						1,	1},
	// Volume level
	{" ^c#83A598^"			, "sb-vol",    							0,	1},
	// Memory used
	{"% ^d^^c#B16286^ ^c#D3869B^"	, "vmstat | awk 'END {printf $3}'",    				5,	0},
	// Date
	{" ^d^^c#689D6A^ ^c#8EC07C^"	, "date +'%d/%m'",    						0,	0},
	// Time
	{" ^d^^c#D65D0E^ ^c#FE8019^"	, "date +'%I:%M '",						1,	0},
};
