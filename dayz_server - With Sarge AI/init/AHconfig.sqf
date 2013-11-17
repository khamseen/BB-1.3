/*  Key to open the menu  */ _OpenMenuKey = 0x3C;    /* google DIK_KeyCodes (0x3C is F2) */
/*  AdminPassword         */ _AdminPassword = "74656";

/*  Mod OverWatch ?       */ _MOW = false;   /* true or false */
/*  Mod EPOCH ?           */ _MEH =  false;   /* true or false */

/*  LOW ADMIN HERE        */ _HF_L_Kham_AList = 	["0","0","0"]; //do not have a , at the end.
/*  NORMAL ADMIN HERE     */ _HF_N_Kham_AList =["0","0","0"]; //do not have a , at the end.
/*  SUPER ADMIN HERE      */ _HF_S_Kham_AList = ["55893190","0","0"]; //do not have a , at the end.
/*  BANNED PLAYER HERE    */ _BLOCKED =			["0","0","0"]; //do not have a , at the end.

/*  Top esc menu TXT      */ _TopOfESC = ''; //do not use ' or " in this text.
/*  Bottom esc menu TXT   */ _LowerTop = ''; //do not use ' or " in this text.
/*  Bottom esc menu TXT2  */ _LowerBottom = ''; //do not use ' or " in this text.
/*  Color esc menu TXT    */ _EscColor = [0,0.6,1,1];

/*  DebugMonitor TXT      */ _BottomDebug = 'infiSTAR.de'; //do not use ' or " in this text.
/*  DebugMonitor Key      */ _ODK =  0xCF;	/* google DIK_KeyCodes (0xCF is END) */
/*  Use DebugMonitor      */ _DMS = false;	/* true or false */	/* starts up with debugmonitor ON if true */
/*  DebugMonitor Action   */ _DMW = false;	/* true or false */	/* "Debug" option on mousewheel */
/*  DebugMonitor ITEM     */ _DBI = false;	/* item or false */	/* _DBI = 'your item choice'; */

/*  BLOCK ALL CMDMenus    */ _BCM =  true;   /* true or false */	/* we don't need commandingMenus. */
/*  Check Actions ?       */ _CSA =  true;   /* true or false */	/* tested mods: DayZ/Epoch/OverWatch */
/*  Use AUTOBAN HACKER    */ _UAB =  true;   /* true or false */	/* recommended to use - we always used this. */
/*  Use FileScan ?        */ _UFS =  true;   /* true or false */	/* spams the rpt but often finds hackers */
/*  Use _AdminPassword ?  */ _APW = false;   /* true or false */	/* admins need to insert a password on load in */
/*  Use cut-scene ?       */ _UCS = false;   /* true or false */	/* dynamicText ~ often colored, animated or used in credits */
/*  Use SafeZones ?       */ _USZ = false;   /* true or false */	/* if you have a zone where people get godmode/anti zombie aggro */
/*  Forbid VON Sidechat   */ _VON = false;   /* true or false */	/* talking on sidechat will put out a warning and kick if continue */
/*  Use vehicle check?    */ _UVC = false;   /* true or false */	/* using _ALLOWED_Vehicles and _FORBIDDEN_Vehicles lists */
/*  Vehicle WHITELIST     */ _UVW = false;   /* true or false */	/* if false - _ALLOWED_Vehicles won't not be used */

/*  ALLOWED  Vehicles     */ _ALLOWED_Vehicles = 
[
	'ALL IF _UVW = false','Tractor','Policecar'
];
/*  FORBIDDEN Vehicles    */ _FORBIDDEN_Vehicles = 
[
	'A10','AH1Z','AH64D'
];
/*  ALLOWED CMDMenus      */ _cMenu = 
[
	'','RscMainMenu','RscMoveHigh','#WATCH','#WATCH0',
	'RscWatchDir','RscDisplayClassSelecter','RscDisplayGenderSelect',
	'RscDisplaySpawnSelecter','RscWatchMoreDir','#GETIN','RscStatus',
	'RscCombatMode','RscFormations','RscTeam','RscSelectTeam','RscReply',
	'RscCallSupport','#ACTION','#CUSTOM_RADIO','RscRadio','RscGroupRootMenu'
];
/*  FORBIDDEN Weapons     */ _ForbiddenWeapons = 
[
	'BAF_AS50_scoped','BAF_AS50_TWS','BAF_AS50_scoped_Large','BAF_AS50_TWS_Large',
	'PMC_AS50_scoped','PMC_AS50_TWS'
];