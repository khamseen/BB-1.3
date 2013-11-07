
Find

_canDo = (!r_drag_sqf and !r_player_unconscious and !_onLadder);

AFTER that, add

//####----####----####---- Base Building 1.3 Start ----####----####----####
_currentSkin = typeOf(player);
			// Get closest camonet since we cannot target with crosshair Base Building Script
			camoNetB_East = nearestObject [player, "Land_CamoNetB_EAST"];
			camoNetVar_East = nearestObject [player, "Land_CamoNetVar_EAST"];
			camoNet_East = nearestObject [player, "Land_CamoNet_EAST"];
			camoNetB_Nato = nearestObject [player, "Land_CamoNetB_NATO"];
			camoNetVar_Nato = nearestObject [player, "Land_CamoNetVar_NATO"];
			camoNet_Nato = nearestObject [player, "Land_CamoNet_NATO"];
			flag_basePole = nearestObject [player, "FlagCarrierBIS_EP1"];
	// Check mags in player inventory to show build recipe menu	
	_mags = magazines player;
	if ("ItemTankTrap" in _mags || "ItemSandbag" in _mags || "ItemWire" in _mags || "PartWoodPile" in _mags || "PartGeneric" in _mags) then {
		hasBuildItem = true;
	} else { hasBuildItem = false;};
	//Build Recipe Menu Action
	if((speed player <= 1) && hasBuildItem && _canDo) then {
		if (s_player_recipeMenu < 0) then {
			s_player_recipeMenu = player addaction [("<t color=""#0074E8"">" + ("Build Recipes") +"</t>"),"buildRecipeBook\build_recipe_dialog.sqf","",5,false,true,"",""];
		};
		if (s_player_buildHelp < 0) then {
			s_player_buildHelp = player addaction [("<t color=""#FF9500"">" + ("Base Building Help") +"</t>"),"dayz_code\actions\build_help.sqf","",5,false,true,"",""];
		};
		if (s_player_showFlags < 0) then {
			s_player_showFlags = player addAction [("<t color=""#FF9500"">" + ("Show My Flags") +"</t>"),"dayz_code\actions\show_flag_markers.sqf","",5,false,true,"",""];
		};
	} else {
		player removeAction s_player_buildHelp;
		s_player_buildHelp = -1;
		player removeAction s_player_recipeMenu;
		s_player_recipeMenu = -1;
		player removeAction s_player_showFlags;
		s_player_showFlags = -1;
	};

	//Add in custom eventhandlers or whatever on skin change
	if (_currentSkin != globalSkin) then {
		globalSkin = _currentSkin;
		player removeEventHandler ["AnimChanged",0];
		player removeMPEventHandler ["MPHit", 0]; 
		player removeEventHandler ["AnimChanged", 0];
		//haloAction = player addEventHandler ["AnimChanged", {_this spawn ss_halo;}];
		ehWall = player addEventHandler ["AnimChanged", { player call antiWall; } ];
		empHit = player addMPEventHandler ["MPHit", {_this spawn fnc_plyrHit;}];
	};
		// Remove CamoNets, (Not effecient but works)
		if((isNull cursorTarget) && _hasToolbox && _canDo && !remProc && !procBuild && 
		(camoNetB_East distance player < 10 or 
		camoNetVar_East distance player < 10 or 
		camoNet_East distance player < 10 or 
		camoNetB_Nato distance player < 10 or 
		camoNetVar_Nato distance player < 10 or 
		camoNet_Nato distance player < 10)) then {
		if (s_player_deleteCamoNet < 0) then {
			s_player_deleteCamoNet = player addaction [("<t color=""#F01313"">" + ("Remove Netting") +"</t>"),"dayz_code\actions\player_remove.sqf",ObjNull,1,true,true,"",""];
		};
	} else {
		player removeAction s_player_deleteCamoNet;
		s_player_deleteCamoNet = -1;
	};	
	
		// FlagPole Access (more reliable than cursortarget)
	if ((isNull cursorTarget) && !procBuild && player distance flag_basePole <= 10) then { //Changed this to stop client RPT spam when building flags
		_authorizedUID = flag_basePole getVariable ["AuthorizedUID", []];
		_authorizedPUID = _authorizedUID select 1;
		_authorizedGateCodes = ((getPlayerUid player) in _authorizedPUID);
		if (_authorizedGateCodes) then {
			//_lever = flag_basePole;
			if (s_player_addFlagAuth < 0) then {
				s_player_addFlagAuth = player addAction ["FlagPole: Add Player UIDs for Base Building Access", "dayz_code\external\keypad\fnc_keyPad\enterCodeAdd.sqf", flag_basePole, 1, false, true, "", ""];
			};
			if (s_player_removeFlagAuth < 0) then {
				s_player_removeFlagAuth = player addaction [("<t color=""#F01313"">" + ("FlagPole: Remove Player UIDs") +"</t>"),"dayz_code\external\keypad\fnc_keyPad\enterCodeRemove.sqf", flag_basePole, 1, false, true, "", ""];
			};
			if (s_player_removeFlag < 0) then {
				s_player_removeFlag = player addaction [("<t color=""#F01313"">" + ("Permanently Remove Flag (restrictions apply)") +"</t>"),"dayz_code\actions\player_remove.sqf", flag_basePole,1,false,true,"",""];
			};
			if (AIGuards == 1) then {
				if (s_player_guardToggle < 0) then {
					s_player_guardToggle = player addaction [("<t color=""#FFFFFF"">" + ("Toggle Guards to Kill all non-base owners (default on)") +"</t>"),"dayz_code\actions\toggle_base_guards.sqf",flag_basePole,1,false,true,"",""];
				};
			};
		};
	} else {
		player removeAction s_player_removeFlag;
		s_player_removeFlag = -1;
		player removeAction s_player_addFlagAuth;
		s_player_addFlagAuth = -1;
		player removeAction s_player_removeFlagAuth;
		s_player_removeFlagAuth = -1;
		player removeAction s_player_guardToggle;
		s_player_guardToggle = -1;
	};
	//Admin check UIDs flag
	_adminRemoval = ((getPlayerUID player) in adminSuperAccess);
	if (_adminRemoval && (isNull cursorTarget) && flag_basePole distance player <= 10) then {
		if (s_check_flag_playerUIDs < 0) then {
			s_check_flag_playerUIDs = player addAction ["ADMIN: Get Owner UIDs of FlagPole", "dayz_code\actions\adminActions\check_playerUIDs.sqf",flag_basePole, 1, false, true, "", ""];
		};
	} else {
		player removeAction s_check_flag_playerUIDs;
		s_check_flag_playerUIDs = -1;
	};
//####----####----####---- Base Building 1.3 END ----####----####----####

Now find

	//Allow player to delete objects
	if(_isDestructable and _hasToolbox and _canDo) then {
		if (s_player_deleteBuild < 0) then {
			s_player_deleteBuild = player addAction [format[localize "str_actions_delete",_text], "\z\addons\dayz_code\actions\remove.sqf",cursorTarget, 1, true, true, "", ""];
		};
	} else {
		player removeAction s_player_deleteBuild;
		s_player_deleteBuild = -1;
	};
	
Replace that with

//####----####----####---- Base Building 1.3 Start ----####----####----####
	//Checks for playerUIDs
	_authorizedUID = cursorTarget getVariable ["AuthorizedUID", []];
		_authorizedPUID = _authorizedUID select 1; //selects only the second element of the array
		_authorizedGateCodes = ((getPlayerUid player) in _authorizedPUID); //checks for playerUID in second element of array
	_codePanels = ["Infostand_2_EP1", "Fence_corrugated_plate", "FlagCarrierBIS_EP1"];
	_adminRemoval = ((getPlayerUID player) in adminSuperAccess);
	
	// Operate Gates AND Add Authorization to Gate
	if ((typeOf(cursortarget) in _codePanels) && _authorizedGateCodes || ((typeOf(cursortarget) in allbuildables_class) && _authorizedGateCodes)) then { // && _validGateCodes 
		_lever = cursorTarget;
		_gates = nearestObjects [_lever, ["Concrete_Wall_EP1"], 15];
		if (s_player_gateActions < 0) then {
			if (typeOf(cursortarget) == "Fence_corrugated_plate") then {
					s_player_gateActions = player addAction ["Operate Single Metal Gate", "dayz_code\external\keypad\fnc_keyPad\operate_gates.sqf", _lever, 1, false, true, "", ""];
			} else {
				if (typeOf(cursortarget) == "Infostand_2_EP1") then {
					if (count _gates > 0) then {
						s_player_gateActions = player addAction ["Operate Nearest Concrete Gates Within 15 meters", "dayz_code\external\keypad\fnc_keyPad\operate_gates.sqf", _lever, 1, false, true, "", ""];
					} else {s_player_gateActions = player addAction ["No gates around to operate", "", _lever, 1, false, true, "", ""];};
				};
			};
		};
		if (s_player_giveBaseOwnerAccess < 0) then {
			s_player_giveBaseOwnerAccess = player addAction ["Give all base owners (from flagpole) access to object/gate", "dayz_code\external\keypad\fnc_keyPad\functions\give_gateAccess.sqf", _lever, 1, false, true, "", ""];
		};
		if (s_player_addGateAuthorization < 0) then {
			s_player_addGateAuthorization = player addAction ["Add Player UIDs to Grant Gate/Object Access", "dayz_code\external\keypad\fnc_keyPad\enterCodeAdd.sqf", _lever, 1, false, true, "", ""];
		};
		if (s_player_removeGateAuthorization < 0) then {
				//s_player_removeGateAuthorization = player addAction ["Remove Player UIDs from Gate/Object Access", "dayz_code\external\keypad\fnc_keyPad\enterCodeRemove.sqf", _lever, 1, false, true, "", ""];
				s_player_removeGateAuthorization = player addaction [("<t color=""#F01313"">" + ("Remove Player UIDs from Gate/Object Access") +"</t>"),"dayz_code\external\keypad\fnc_keyPad\enterCodeRemove.sqf", _lever, 1, false, true, "", ""];
		};
	} else {
		player removeAction s_player_giveBaseOwnerAccess;
		s_player_giveBaseOwnerAccess = -1;
		player removeAction s_player_gateActions;
		s_player_gateActions = -1;
		player removeAction s_player_addGateAuthorization;
		s_player_addGateAuthorization = -1;
		player removeAction s_player_removeGateAuthorization;
		s_player_removeGateAuthorization = -1;
	};
	// Operate ROOFS
	if ((typeOf(cursortarget) in _codePanels) && _authorizedGateCodes) then {
		_lever = cursorTarget;
		_gates = nearestObjects [_lever, ["Land_Ind_Shed_01_main"], 200];
		if (s_player_roofToggle < 0) then {
			if (typeOf(cursortarget) == "Infostand_2_EP1") then {
				if (count _gates > 0) then {
					s_player_roofToggle = player addAction ["Operate Roof Covers", "dayz_code\external\keypad\fnc_keyPad\operate_roofs.sqf", _lever, 1, false, true, "", ""];
				} else {s_player_roofToggle = player addAction ["No roof covers around to operate", "", _lever, 1, false, true, "", ""];};
			};
		};
	} else {
		player removeAction s_player_roofToggle;
		s_player_roofToggle = -1;
	};
	//Admin check playerUIDs
	if (_adminRemoval || _authorizedGateCodes && (typeOf(cursortarget) in allbuildables_class)) then {
		if (s_check_playerUIDs < 0) then {
			s_check_playerUIDs 	= player addAction ["ADMIN: Get Owner UIDs of Object", "dayz_code\actions\adminActions\check_playerUIDs.sqf",cursorTarget, 1, false, true, "", ""];
		};
	} else {
		player removeAction s_check_playerUIDs;
		s_check_playerUIDs = -1;
	};
	// Remove Object Normal/Owner removal
	if((typeOf(cursortarget) in allremovables) && _hasToolbox && _canDo && !remProc && !procBuild && !removeObject) then {
		if (s_player_deleteBuild < 0) then {
			s_player_deleteBuild = player addAction [format[localize "str_actions_delete",_text], "dayz_code\actions\player_remove.sqf",cursorTarget, 1, true, true, "", ""];
		};
	} else {
		player removeAction s_player_deleteBuild;
		s_player_deleteBuild = -1;
	};

	//INFLAME BARRELS
    if((typeOf(cursortarget) == "Infostand_2_EP1") && _authorizedGateCodes) then {
        _lever = cursortarget;
        if (s_player_inflameBarrels < 0) then {
            s_player_inflameBarrels = player addAction ["Lights ON", "dayz_code\actions\lights\inflameBarrels.sqf", _lever, 1, false, true, "", ""];
        };
    } else {
        player removeAction s_player_inflameBarrels;
        s_player_inflameBarrels = -1;
    };
    //DEFLAME BARRELS
    if((typeOf(cursortarget) == "Infostand_2_EP1") && _authorizedGateCodes) then {
        _lever = cursortarget;
        if (s_player_deflameBarrels < 0) then {
            s_player_deflameBarrels = player addAction ["Lights OFF", "dayz_code\actions\lights\deflameBarrels.sqf", _lever, 1, false, true, "", ""];
        };
    } else {
        player removeAction s_player_deflameBarrels;
        s_player_deflameBarrels = -1;
    };
//####----####----####---- Base Building 1.3 End ----####----####----####

	
Then find

	{dayz_myCursorTarget removeAction _x} forEach s_player_repairActions;s_player_repairActions = [];
	dayz_myCursorTarget = objNull;
	
After that, add

//####----####----####---- Base Building 1.3 Start ----####----####----####
	player removeAction s_player_giveBaseOwnerAccess;
	s_player_giveBaseOwnerAccess = -1;
	player removeAction s_player_gateActions;
	s_player_gateActions = -1;
	player removeAction s_player_roofToggle;
	s_player_roofToggle = -1;
	player removeAction s_player_addGateAuthorization;
	s_player_addGateAuthorization = -1;
	player removeAction s_player_removeGateAuthorization;
	s_player_removeGateAuthorization = -1;
    player removeAction s_player_disarm;
    s_player_disarm = -1;
	player removeAction s_player_inflameBarrels;
    s_player_inflameBarrels = -1;
    player removeAction s_player_deflameBarrels;
    s_player_deflameBarrels = -1;
	player removeAction s_check_playerUIDs;
	s_check_playerUIDs = -1;
	player removeAction s_player_disarmBomb;
	s_player_disarmBomb = -1;
	player removeAction s_player_codeObject;
	s_player_codeObject = -1;
	player removeAction s_player_enterCode;
	s_player_enterCode = -1;
//####----####----####---- Base Building 1.3 End ----####----####----####

Save and close!