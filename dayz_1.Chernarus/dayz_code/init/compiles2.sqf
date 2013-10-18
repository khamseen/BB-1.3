//call compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\setup_functions_med.sqf"; 				// Functions used by CLIENT for medical
//call compile preprocessFileLineNumbers "dayz_code\init\publicEH.sqf";										// PublicEH experimental

fnc_usec_selfActions 		= compile preprocessFileLineNumbers "dayz_code\compile\fn_selfActions.sqf";			// fnc_usec_selfActions - Custom actions
player_spawn_2 				= compile preprocessFileLineNumbers "dayz_code\system\player_spawn_2.sqf";					// player_spawn_2 - Debug menu
vehicle_localHandleDamage 	= compile preprocessFileLineNumbers "dayz_code\compile\vehicle_localHandleDamage.sqf";			
vehicle_localHandleKilled 	= compile preprocessFileLineNumbers "dayz_code\compile\vehicle_localHandleKilled.sqf";	
GLT_addMagazine 			= compile preprocessFileLineNumbers "dayz_code\compile\GLT_addMagazine.sqf";	 // faster way to bis_fnc_addInv
zHorde_begin 				= compile preprocessFileLineNumbers "dayz_code\compile\zHorde_begin.sqf";	 // zHorde clientside begin

//EventHandlers important
//fnc_vehicleEventHandler = 	compile preprocessFileLineNumbers "dayz_code\init\vehicle_init.sqf";			//Initialize vehicle
//vehicle_handleDamage    = compile preprocessFileLineNumbers "dayz_code\compile\vehicle_handleDamage.sqf";
//DayZ Gameplay changes
player_alertZombies 	= compile preprocessFileLineNumbers "dayz_code\compile\player_alertZombies.sqf";
player_spawnCheck 		= compile preprocessFileLineNumbers "dayz_code\compile\player_spawnCheck.sqf";
player_zombieAttack 	= compile preprocessFileLineNumbers "dayz_code\compile\player_zombieAttack.sqf";
player_fired 			= compile preprocessFileLineNumbers "dayz_code\compile\player_fired.sqf";
spawn_loot 				= compile preprocessFileLineNumbers "dayz_code\compile\spawn_loot.sqf";
building_spawnZombies	= compile preprocessFileLineNumbers "dayz_code\compile\building_spawnZombies.sqf";
//zombie_generate = 			compile preprocessFileLineNumbers "dayz_code\compile\zombie_generate.sqf";
//building_spawnLoot = compile preprocessFileLineNumbers "dayz_code\compile\building_spawnLoot.sqf";
wild_spawnZombies 		= 	compile preprocessFileLineNumbers "dayz_code\compile\wild_spawnZombies.sqf";			//Server compile, used for loiter behaviour
rand_spawnZombies 		= 	compile preprocessFileLineNumbers "dayz_code\compile\rand_spawnZombies.sqf";			//Server compile, used for loiter behaviour
player_tentPitch 		=	compile preprocessFileLineNumbers "dayz_code\compile\tent_pitch.sqf";
player_packTent 		= 	compile preprocessFileLineNumbers "dayz_code\compile\player_packTent.sqf";
dayz_zombieSpeak 		= 	compile preprocessFileLineNumbers "dayz_code\compile\object_speak.sqf";
zombie_findTargetAgent	= 	compile preprocessFileLineNumbers "dayz_code\compile\zombie_findTargetAgent.sqf";

player_makeFire 		=	compile preprocessFileLineNumbers "dayz_code\actions\player_makefire.sqf";
player_animalCheck 		=	compile preprocessFileLineNumbers "dayz_code\compile\player_animalCheck.sqf";

//Custom mechanics
player_locateTown 		= compile preprocessFileLineNumbers "dayz_code\compile\player_locateTown.sqf";
player_build 			= compile preprocessFileLineNumbers "dayz_code\compile\player_build.sqf";
player_chopWood 		= compile preprocessFileLineNumbers "dayz_code\compile\player_chopWood.sqf";
antiWall 				= compile preprocessFileLineNumbers "dayz_code\compile\antiWall.sqf";
anti_discWall 			= compile preprocessFileLineNumbers "dayz_code\compile\anti_discWall.sqf";
//fnc_halo_net = compile preprocessFileLineNumbers "dayz_code\compile\halo_net.sqf"; // forces player to open chute at X meters
//bis_open_chute = compile preprocessFileLineNumbers "dayz_code\compile\bis_open_chute.sqf"; // Open chute script
//ss_halo  = compile preprocessFileLineNumbers "dayz_code\external\ss_halo.sqf"; // Open chute script
refresh_build_recipe_dialog 		= compile preprocessFileLineNumbers "buildRecipeBook\refresh_build_recipe_dialog.sqf";
refresh_build_recipe_list_dialog 	= compile preprocessFileLineNumbers "buildRecipeBook\refresh_build_recipe_list_dialog.sqf";
add_UIDCode  			= compile preprocessFileLineNumbers "dayz_code\external\keypad\fnc_keyPad\functions\add_UIDCode.sqf";
remove_UIDCode  		= compile preprocessFileLineNumbers "dayz_code\external\keypad\fnc_keyPad\functions\remove_UIDCode.sqf";

//First Load
	server_firstLoad = compile preprocessFileLineNumbers "dayz_code\compile\server_firstLoad.sqf";
	
getNetting = {
	//Determine camoNet since camoNets cannot be targeted with Crosshair
	if (isNull _obj) then {
		switch (true) do
		{
			case(camoNetB_East distance player < 10 && isNull _obj):
			{
				_obj = camoNetB_East;
				//_objectID = _obj getVariable["ObjectID","0"];
				//_objectUID = _obj getVariable["ObjectUID","0"];
				//_ownerID = _obj getVariable ["characterID","0"];
			};
			case(camoNetVar_East distance player < 10 && isNull _obj):
			{
				_obj = camoNetVar_East;
				//_objectID = _obj getVariable["ObjectID","0"];
				//_objectUID = _obj getVariable["ObjectUID","0"];
				//_ownerID = _obj getVariable ["characterID","0"];
			};
			case(camoNet_East distance player < 10 && isNull _obj):
			{
				_obj = camoNet_East;
				//_objectID = _obj getVariable["ObjectID","0"];
				//_objectUID = _obj getVariable["ObjectUID","0"];
				//_ownerID = _obj getVariable ["characterID","0"];
			};
			case(camoNetB_Nato distance player < 10 && isNull _obj):
			{
				_obj = camoNetB_Nato;
				//_objectID = _obj getVariable["ObjectID","0"];
				//_objectUID = _obj getVariable["ObjectUID","0"];
				//_ownerID = _obj getVariable ["characterID","0"];
			};
			case(camoNetVar_Nato distance player < 10 && isNull _obj):
			{
				_obj = camoNetVar_Nato;
				//_objectID = _obj getVariable["ObjectID","0"];
				//_objectUID = _obj getVariable["ObjectUID","0"];
				//_ownerID = _obj getVariable ["characterID","0"];
			};
			case(camoNet_Nato distance player < 10 && isNull _obj):
			{
				_obj = camoNet_Nato;
				//_objectID = _obj getVariable["ObjectID","0"];
				//_objectUID = _obj getVariable["ObjectUID","0"];
				//_ownerID = _obj getVariable ["characterID","0"];
			};
		};
	};
	_obj
};
/*
if (isServer) then {
	add_unit_server = compile preprocessFileLineNumbers "dayz_code\compile\add_unit_server.sqf";
house_patrol = compile preprocessFileLineNumbers "dayz_code\compile\housePatrol.sqf";

	//DY Unit Compiles
	ai_spawn_inner_objectA2 = 			compile preprocessFileLineNumbers "units\unitCompiles\ai_spawn_inner_objectA2.sqf";
	ai_spawn_inner_seraja = 			compile preprocessFileLineNumbers "units\unitCompiles\ai_spawn_inner_seraja.sqf";
	ai_spawn_inner_southern = 			compile preprocessFileLineNumbers "units\unitCompiles\ai_spawn_inner_southern.sqf";
	ai_spawn_objectA2 = 				compile preprocessFileLineNumbers "units\unitCompiles\ai_spawn_objectA2.sqf";
	ai_spawn_seraja = 					compile preprocessFileLineNumbers "units\unitCompiles\ai_spawn_seraja.sqf";
	ai_spawn_southern = 				compile preprocessFileLineNumbers "units\unitCompiles\ai_spawn_southern.sqf";
	
	
	//#### DZAI ####
	ai_fired = 			compile preprocessFileLineNumbers "dayz_code\compile\ai_fired.sqf";	//Calculates weapon noise of AI unit
	ai_alertzombies = 	compile preprocessFileLineNumbers "dayz_code\compile\ai_alertzombies.sqf"; //AI weapon noise attracts zombie attention
	fnc_damageAI = 		compile preprocessFileLineNumbers "dayz_code\compile\fn_damageHandlerAI.sqf";
	//npc_locateTown = 	compile preprocessFileLineNumbers "dayz_code\compile\npc_locateTown.sqf";
	//npc_spawnCheck = 	compile preprocessFileLineNumbers "dayz_code\compile\npc_spawnCheck.sqf";
	npc_zombieCheck = 	compile preprocessFileLineNumbers "dayz_code\compile\npc_zombieCheck.sqf";
	npc_zombieAttack = 	compile preprocessFileLineNumbers "dayz_code\compile\npc_zombieAttack.sqf";
	fnc_unit_resupply	= 	compile preprocessFileLineNumbers "dayz_code\compile\unit_resupply.sqf";
	mission_spawnAI = compile preprocessFileLineNumbers "Missions\mission_spawnAI.sqf";
	//npcBuilding_spawnZombies = compile preprocessFileLineNumbers "dayz_code\compile\npcBuilding_spawnZombies.sqf";
};*/