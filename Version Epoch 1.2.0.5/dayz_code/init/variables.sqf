
//####----####----####---- Base Building 1.3 Start ----####----####----####

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

	addUIDCode = false;
	removeUIDCode = false;
	globalAuthorizedUID = [];
	adminSuperAccess = ["55893190","#####"]; //Replace with your admin playerUIDs for base building
	AIGuards = 0; //Sarge AI Base Guard (Currently not working)/ 1 = Enabled // 0 = Disabled
	
	
//EXTENDED BASE BUILDING
        baseBuildingExtended=true;
        rotateDir = 0;
        objectHeight=0;
        objectDistance=0;
        objectParallelDistance=0;
        rotateIncrement=30;
		rotateIncrementSmall=10;
        objectIncrement=0.3;
		objectIncrementSmall=0.1;
        objectTopHeight=8;
        objectLowHeight=-10;
        maxObjectDistance=6;
        minObjectDistance=-1;
		
// Base Building Keybinds
	DZ_BB_E  = false; //Elevate
	DZ_BB_L  = false; //Lower
	DZ_BB_Es = false; //Elevate Small
	DZ_BB_Ls = false; //Lower Small
	DZ_BB_Rl = false; //Rotate Left
	DZ_BB_Rr = false; //Rotate Right
	DZ_BB_Rls= false; //Rotate Left Small
	DZ_BB_Rrs= false; //Rotate Right Small
	DZ_BB_A  = false; //Push Away
	DZ_BB_N  = false; //Pull Near
	DZ_BB_Le = false; //Move Left
	DZ_BB_Ri = false; //Move Right
		
SafeObjects = ["Land_Fire_DZ", "TentStorage", "Wire_cat1", "Sandbag1_DZ", "Hedgehog_DZ", "StashSmall", "StashMedium", "BearTrap_DZ", "DomeTentStorage", "CamoNet_DZ", "Trap_Cans", "TrapTripwireFlare", "TrapBearTrapSmoke", "TrapTripwireGrenade", "TrapTripwireSmoke", "TrapBearTrapFlare", "Grave", "Concrete_Wall_EP1", "Infostand_2_EP1", "WarfareBDepot", "Base_WarfareBBarrier10xTall", "WarfareBCamp", "Base_WarfareBBarrier10x", "Land_fortified_nest_big", "Land_Fort_Watchtower", "Land_fort_rampart_EP1", "Land_HBarrier_large", "Land_fortified_nest_small", "Land_BagFenceRound", "Land_fort_bagfence_long", "Land_Misc_Cargo2E", "Misc_Cargo1Bo_military", "Ins_WarfareBContructionSite", "Land_pumpa", "Land_CncBlock", "Misc_cargo_cont_small_EP1", "Land_prebehlavka", "Fence_corrugated_plate", "ZavoraAnim", "Land_tent_east", "Land_CamoNetB_EAST", "Land_CamoNetB_NATO", "Land_CamoNetVar_EAST", "Land_CamoNetVar_NATO", "Land_CamoNet_EAST", "Land_CamoNet_NATO", "Fence_Ind_long", "Fort_RazorWire", "Fence_Ind","Land_sara_hasic_zbroj","Land_Shed_wooden","Land_Barrack2","Land_vez","FlagCarrierBIS_EP1","Land_A_Minaret_Porto_EP1","Land_Ind_Shed_01_main","Land_Fire_barrel","Land_WoodenRamp","Land_House_C_4_EP1","Land_House_C_11_EP1","Land_House_K_6_EP1","Land_House_K_7_EP1","Land_House_C_9_EP1","Land_House_C_10_EP1","Land_House_C_12_EP1","Land_House_C_5_V3_EP1","Land_House_C_3_EP1","Land_House_L_4_EP1","Land_House_L_6_EP1","Land_House_L_7_EP1","Land_House_L_8_EP1","Land_House_L_1_EP1","Land_House_C_5_EP1","Land_House_C_2_EP1","Land_ConcreteRamp","RampConcrete","HeliH","HeliHCivil","Land_Campfire","Land_ladder","Land_ladder_half","Land_Misc_Scaffolding","Land_Ind_TankSmall2_EP1","PowerGenerator_EP1","Land_Ind_IlluminantTower","Land_A_Castle_Gate","Land_A_Castle_Stairs_A"];
//####----####----####---- Base Building 1.3 End ----####----####----####
