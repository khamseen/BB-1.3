// This file is for server specific settings. Refer to the documentation at
// development.dayztaviana.com site for further details.

diag_log "Started executing user settings file.";						// Log start

if (!isDedicated) then {
	_null = [] execVM  "dayz_code\external\rd_debug.sqf";						// Debug menu key binding
	_null = [] execVM  "dayz_code\external\dy_activecombat.sqf";				// ActiveCombat
	_null = [] execVM  "dayz_code\external\kh_actions.sqf";						// Vehicle refuel
	//_null = [] execVM  "dayz_code\external\kh_test_time_skew.sqf";				// Test time skew
	_null = [] execVM  "dayz_code\external\en_DynamicWeatherEffects.sqf";		// Customised weather effects
	//_null = [] execVM  "dayz_code\external\cargo\Init.sqf";					    // Cargo drop
	_null = [] execVM "dayz_code\external\dy_work\take_itemFix.sqf"; 	// Take item dupe fix
	_null = [] execVM "dayz_code\external\dy_work\player_bomb.sqf";		// Booby traps bomb
	_null = [] execVM "dayz_code\external\dy_work\initWall.sqf";		// Doesnt allow players to get out of vehicle through specified walls
	_null = [] execVM "dayz_code\external\dy_work\build_list.sqf";		// build_list for building arrays
	_null = [] execVM "dayz_code\external\dy_work\take_backPackfix.sqf";	//backpack dupe fix
	_null = [] execVM "dayz_code\actions\w4_melee\meleeMonitor.sqf"; // w4rgos melee monitor
	[] ExecVM "axs_gearmanagement\doGear.sqf";
	//player setVariable ["BIS_noCoreConversations", true];
	// Turn off AI chat
	//_null = [] execVM "dayz_code\external\dy_work\disable_buttons.sqf";
	
};

diag_log "Finished executing user settings file.";						// Log finish