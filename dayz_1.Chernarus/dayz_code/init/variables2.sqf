Cow01 = 					"Cow01";
Cow02 =						"Cow02";
Cow03 = 					"Cow03";
Cow04 =						"Cow04";
Fin = 						"DZ_Fin";
Goat = 						"Goat";
Hen = 						"Hen";
Pastor = 					"DZ_Pastor";
Rabbit = 					"Rabbit";
Sheep = 					"Sheep";
WildBoar = 					"WildBoar";
Citizen3 = 					"Citizen3";
Worker1 = 					"Worker1";
Villager1 = 				"Villager1";
TK_CIV_Takistani01_EP1 = 	"TK_CIV_Takistani01_EP1";
TK_CIV_Takistani05_EP1 = 	"TK_CIV_Takistani05_EP1";
TK_INS_Soldier_EP1 = 		"TK_INS_Soldier_EP1";
CZ_Soldier_DES_EP1 = 		"CZ_Soldier_DES_EP1";
US_Soldier_EP1 = 			"US_Soldier_EP1";
BAF_Soldier_MTP = 			"BAF_Soldier_MTP";
BAF_Soldier_DDPM = 			"BAF_Soldier_DDPM";
BAF_Soldier_L_MTP = 		"BAF_Soldier_L_MTP";
BAF_Soldier_L_DDPM = 		"BAF_Soldier_L_DDPM";
BAF_Soldier_Officer_MTP = 	"BAF_Soldier_Officer_MTP";
BAF_Soldier_Officer_DDPM =	"BAF_Soldier_Officer_DDPM";
BAF_Soldier_Sniper_MTP = 	"BAF_Soldier_Sniper_MTP";
BAF_Soldier_SniperH_MTP = 	"BAF_Soldier_SniperH_MTP";
BAF_Soldier_SniperN_MTP = 	"BAF_Soldier_SniperN_MTP";
CDF_Soldier	=				"CDF_Soldier";
CDF_Soldier_Militia = 		"CDF_Soldier_Militia";
CDF_Soldier_AR = 			"CDF_Soldier_AR";
Soldier_Crew_PMC =			"Soldier_Crew_PMC";
dayz_animalDistance = 800;
dayz_maxAnimals = 5;
dayz_zSpawnDistance = 1000;
dayz_maxLocalZombies = 40;
dayz_spawnDelay = 1800;
dayz_firstLoad = true;
dayz_spawnWait = -1800;
dayz_maxZeds = 1000;
//Daimyo Custom Variables
	//Strings
	globalSkin 			= "";
	//Arrays
	allbuildables_class = [];
	allbuildables 		= [];
	allbuild_notowns 	= [];
	allremovables 		= [];
	wallarray 			= [];
	structures			= [];
	CODEINPUT 			= [];
	keyCode 			= [];
	//Booleans
//	logoutReady 		= false;
//	logoutActive 		= false;
	haloProc			= false;
	remProc 			= false;
	hasBuildItem 		= false;
	rem_procPart 		= false;
	procChop 			= false;
	repProc 			= false;
	keyValid 			= false;
	procBuild 			= false;
	removeObject		= false;
	currentBuildRecipe 	= 0;
	dayz_playersInTown 	= false;
	dayz_townCheckPlayer = -60;
	dayz_townCheckDelay = 60;
	dayz_townSpawnReached = false;
	dayz_insureSpawn = 0;
	dayz_confirmSpawnReached = 0;
	rd_Debug = 0;
	addUIDCode = false;
	removeUIDCode = false;
	globalAuthorizedUID = [];

s_silver_smelt = -1;
s_player_flipveh = -1;

//W4rgo Melee
playerMeleeHitted = [];
knockedDown= [];
tiedUp= [];

//EXTENDED BASE BUILDING
        baseBuildingExtended=true;
        rotateDir = 0;
        objectHeight=0;
        objectDistance=0;
        objectParallelDistance=0;
        rotateIncrement=30;
        objectIncrement=0.3;
		objectIncrementSmall=0.1;
        objectTopHeight=8;
        objectLowHeight=-10;
        maxObjectDistance=6;
        minObjectDistance=-1;
		
crafting_menu_open = false;
adminSuperAccess = ["92639110","2814726","72528902"];
adminModerateAccess = [];
adminNoviceAccess = [];
seraja_pos = (getMarkerPos "seraja_debug"); 
southern_pos = (getMarkerPos "southern_army_debug");
a2_pos = (getMarkerPos "object_a2_debug");

AllPlayers = ["SurvivorW2_DZ","Survivor2_DZ","Sniper1_DZ","Soldier1_DZ","Camo1_DZ","BanditW1_DZ",
	"Bandit1_DZ","Survivor3_DZ","Rocket_DZ","US_Soldier_EP1","BAF_Soldier_DDPM",
	"BAF_Soldier_Officer_DDPM","BAF_Soldier_MTP","BAF_Soldier_L_DDPM","CZ_Soldier_DES_EP1",
	"CamoWinter_DZN","CamoWinterW_DZN","Sniper1W_DZN"];

if (isServer) then {
	zHorde_inProgress = 0;
	publicVariable "zHorde_inProgress";
};
dayz_NearestCity = (nearestLocations [player,["NameCityCapital","NameCity","NameVillage","NameLocal"],500000]) select 0;
