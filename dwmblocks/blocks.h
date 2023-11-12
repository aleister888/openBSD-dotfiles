static char delim[] ="";
static unsigned int delimLen = 0;
static const Block blocks[] = {
	/*Icon*/					/*Command*/					/*Update Interval*/	/*Update Signal*/
	// Current song
	{""						, "~/.local/scripts/sb/sb-tauon",		0,	 		2},
	// Free space
	{" ^d^^c#98971A^ ^c#B8BB26^"	, "df -h | egrep 'home|data' | awk '{print $4}' | xargs",	0,	 		0},
	// Kernel version
	{" ^d^^c#458588^ ^c#83A598^"	, "uname -r",					0,	0},
	// Volume icon
	{" ^d^^c#B16286^"		, "~/.local/scripts/sb/sb-vol-icon",    	1,	1},
	// Volume level
	{" ^c#D3869B^"			, "~/.local/scripts/sb/sb-vol",    		0,	1},
	// Charging status
	{" ^d^^c#689D6A^"		, "~/.local/scripts/sb/sb-bat",  		1,	0},
	// Battery percentage
	{" ^c#8EC07C^"			, "apm | awk '{print $4}' | grep %",		1,	0},
	// CPU Temp
	{" ^d^^c#D79921^ ^c#FABD2F^"	, "~/.local/scripts/sb/sb-temp",    		1,	0},
	// Memory used
	//{" ^d^^c#D79921^ ^c#FABD2F^"	, "vmstat | awk 'END {printf $3}'",    		5,	0},
	// Date
	{"C ^d^^c#AE4335^ ^c#DB5947^"	, "date +'%d/%m'",    				0,	0},
	// Time
	{" ^d^^c#D65D0E^ ^c#FE8019^"	, "date +'%I:%M'",				1,	0},
	{""				, "echo ' '",					0,	0},

};
