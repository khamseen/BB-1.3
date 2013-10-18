scriptName "Functions\misc\fn_selfActions.sqf";
/***********************************************************
	ADD ACTIONS FOR SELF
	- Function
	- [] call fnc_usec_selfActions;
************************************************************/
_vehicle = vehicle player;
_inVehicle = (_vehicle != player);
_cursorTarget = cursorTarget;
_primaryWeapon = primaryWeapon player;
_currentWeapon = currentWeapon player;
_onLadder = (getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;

_nearLight = nearestObject [player,"LitObject"];
_canPickLight = false;
if (!isNull _nearLight) then {
	if (_nearLight distance player < 4) then {
		_canPickLight = isNull (_nearLight getVariable ["owner",objNull]);
	};
};
_canDo = (!r_drag_sqf and !r_player_unconscious and !_onLadder);

//####----####----####---- Base Building 1.3 Start ----####----####----####
_currentSkin = typeOf(player);
			// Get closest camonet since we cannot target with crosshair Base Building Script
			camoNetB_East = nearestObject [player, "Land_CamoNetB_EAST"];
			camoNetVar_East = nearestObject [player, "Land_CamoNetVar_EAST"];
			camoNet_East = nearestObject [player, "Land_CamoNet_EAST"];
			camoNetB_Nato = nearestObject [player, "Land_CamoNetB_NATO"];
			camoNetVar_Nato = nearestObject [player, "Land_CamoNetVar_NATO"];
			camoNet_Nato = nearestObject [player, "Land_CamoNet_NATO"];
			flag_basePole = nearestObject [player, "FlagCarrierUSA"];
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
		if (s_player_generalRecipes < 0) then {
			s_player_generalRecipes = player addaction [("<t color=""#FF9500"">" + ("General Recipes") +"</t>"),"dayz_code\actions\general_recipes.sqf","",5,false,true,"",""];
		};
		if (s_player_buildHelp < 0) then {
			s_player_buildHelp = player addaction [("<t color=""#FF9500"">" + ("Base Building Help") +"</t>"),"dayz_code\actions\build_help.sqf","",5,false,true,"",""];
		};
	} else {
		player removeAction s_player_buildHelp;
		s_player_buildHelp = -1;
		player removeAction s_player_generalRecipes;
		s_player_generalRecipes = -1;
		player removeAction s_player_recipeMenu;
		s_player_recipeMenu = -1;
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
		_authorizedUID = flag_basePole getVariable ["AuthorizedUID", []];
		_authorizedGateCodes = ((getPlayerUid player) in _authorizedUID);
	if ((isNull cursorTarget) && _authorizedGateCodes && player distance flag_basePole <= 10) then { // && _validGateCodes 
		//_lever = flag_basePole;
		if (s_player_addFlagAuth < 0) then {
			s_player_addFlagAuth = player addAction ["FlagPole: Enter friendly playerUIDs to Gain Permanent Base Building Access", "dayz_code\external\keypad\fnc_keyPad\enterCodeAdd.sqf", flag_basePole, 1, false, true, "", ""];
		};
		if (s_player_removeFlagAuth < 0) then {
			s_player_removeFlagAuth = player addaction [("<t color=""#F01313"">" + ("FlagPole: Enter playerUIDs to Remove Permanent Base Building Access") +"</t>"),"dayz_code\external\keypad\fnc_keyPad\enterCodeRemove.sqf", flag_basePole, 1, false, true, "", ""];
		};
		if (s_player_removeFlag < 0) then {
			s_player_removeFlag = player addaction [("<t color=""#F01313"">" + ("Permanently Remove Flag (restrictions apply)") +"</t>"),"dayz_code\actions\player_remove.sqf", flag_basePole,1,false,true,"",""];
		};
		if (s_player_guardToggle < 0) then {
			s_player_guardToggle = player addaction [("<t color=""#FFFFFF"">" + ("Toggle Guards to Kill all non-base owners (default on)") +"</t>"),"dayz_code\actions\toggle_base_guards.sqf",flag_basePole,1,false,true,"",""];
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

//Grab Flare
if (_canPickLight and !dayz_hasLight) then {
	if (s_player_grabflare < 0) then {
		_text = getText (configFile >> "CfgAmmo" >> (typeOf _nearLight) >> "displayName");
		s_player_grabflare = player addAction [format[localize "str_actions_medical_15",_text], "\z\addons\dayz_code\actions\flare_pickup.sqf",_nearLight, 1, false, true, "", ""];
		s_player_removeflare = player addAction [format[localize "str_actions_medical_17",_text], "\z\addons\dayz_code\actions\flare_remove.sqf",_nearLight, 1, false, true, "", ""];
	};
} else {
	player removeAction s_player_grabflare;
	player removeAction s_player_removeflare;
	s_player_grabflare = -1;
	s_player_removeflare = -1;
};

if (dayz_onBack != "" && !dayz_onBackActive && !_inVehicle && !_onLadder && !r_player_unconscious) then {
	if (s_player_equip_carry < 0) then {
		_text = getText (configFile >> "CfgWeapons" >> dayz_onBack >> "displayName");
		s_player_equip_carry = player addAction [format[localize "STR_ACTIONS_WEAPON", _text], "\z\addons\dayz_code\actions\player_switchWeapon.sqf", "action", 0.5, false, true];
	};
} else {
	player removeAction s_player_equip_carry;
	s_player_equip_carry = -1;
};

//fishing
if ((_currentWeapon in Dayz_fishingItems) && !dayz_fishingInprogress && !_inVehicle && !dayz_isSwimming) then {
	if (s_player_fishing < 0) then {
		s_player_fishing = player addAction [localize "STR_ACTION_CAST", "\z\addons\dayz_code\actions\player_goFishing.sqf",player, 0.5, false, true];
	};
} else {
	player removeAction s_player_fishing;
	s_player_fishing = -1;
};
if ((_primaryWeapon in Dayz_fishingItems) && !dayz_fishingInprogress && (_inVehicle and (driver _vehicle != player))) then {
		if (s_player_fishing_veh < 0) then {
			s_player_fishing_veh = _vehicle addAction [localize "STR_ACTION_CAST", "\z\addons\dayz_code\actions\player_goFishing.sqf",_vehicle, 0.5, false, true];
		};
} else {
	_vehicle removeAction s_player_fishing_veh;
	s_player_fishing_veh = -1;
};	

if (!isNull _cursorTarget and !_inVehicle and (player distance _cursorTarget < 4)) then { //Has some kind of target
	
	_isVehicle = _cursorTarget isKindOf "AllVehicles";
	_isMan = _cursorTarget isKindOf "Man";
	_isAnimal = _cursorTarget isKindOf "Animal";
	_isZombie = _cursorTarget isKindOf "zZombie_base";
	_isDestructable = _cursorTarget isKindOf "BuiltItems";
	_isTent = _cursorTarget isKindOf "TentStorage";
	_isStash = _cursorTarget isKindOf "StashSmall";
	_isMediumStash = _cursorTarget isKindOf "StashMedium";
	_isHarvested = _cursorTarget getVariable["meatHarvested",false];
	_ownerID = _cursorTarget getVariable ["characterID","0"];
	_isVehicletype = typeOf _cursorTarget in ["ATV_US_EP1","ATV_CZ_EP1"];
	_isFuel = false;
	_hasFuel20 = "ItemJerrycan" in magazines player;
	_hasFuel5 = "ItemFuelcan" in magazines player;
	_hasFuelE20 = "ItemJerrycanEmpty" in magazines player;
	_hasFuelE5 = "ItemFuelcanEmpty" in magazines player;
	_hasKnife = "ItemKnife" in items player;
	_hasToolbox = "ItemToolbox" in items player;
	_hasbottleitem = "ItemWaterbottle" in magazines player;
	_isAlive = alive _cursorTarget;
	_canmove = canmove _cursorTarget;
	_text = getText (configFile >> "CfgVehicles" >> typeOf _cursorTarget >> "displayName");
	_isPlant = typeOf _cursorTarget in Dayz_plants;
	if (_hasFuelE20 or _hasFuelE5) then {
		_isFuel = (_cursorTarget isKindOf "Land_Ind_TankSmall") or (_cursorTarget isKindOf "Land_fuel_tank_big") or (_cursorTarget isKindOf "Land_fuel_tank_stairs") or (_cursorTarget isKindOf "Land_wagon_tanker");
	};
	
//####----####----####---- Base Building 1.3 Start ----####----####----####

	_authorizedUID = cursorTarget getVariable ["AuthorizedUID", []];
	_authorizedGateCodes = ((getPlayerUid player) in _authorizedUID);
	_codePanels = ["Infostand_2_EP1", "Fence_corrugated_plate", "FlagCarrierUSA"];
	
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
			s_player_addGateAuthorization = player addAction ["Enter Friendly Player UIDs to Gain Permanent Gate/Object Access", "dayz_code\external\keypad\fnc_keyPad\enterCodeAdd.sqf", _lever, 1, false, true, "", ""];
		};
		if (s_player_removeGateAuthorization < 0) then {
				//s_player_removeGateAuthorization = player addAction ["Enter Player UIDs to Remove Permanent Gate Access", "dayz_code\external\keypad\fnc_keyPad\enterCodeRemove.sqf", _lever, 1, false, true, "", ""];
				s_player_removeGateAuthorization = player addaction [("<t color=""#F01313"">" + ("Enter Player UIDs to Remove Permanent Gate/Object Access") +"</t>"),"dayz_code\external\keypad\fnc_keyPad\enterCodeRemove.sqf", _lever, 1, false, true, "", ""];
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
	_adminRemoval = ((getPlayerUID player) in adminSuperAccess);
	_authorizedUID = cursorTarget getVariable ["AuthorizedUID", []];
	_authorizedGateCodes = ((getPlayerUid player) in _authorizedUID);
	if (_adminRemoval || _authorizedGateCodes && (typeOf(cursortarget) in allbuildables_class)) then {
		if (s_check_playerUIDs < 0) then {
			s_check_playerUIDs 	= player addAction ["Get Owner UIDs of Object", "dayz_code\actions\adminActions\check_playerUIDs.sqf",cursorTarget, 1, false, true, "", ""];
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

	//gather
	if(_isPlant and _canDo) then {
		if (s_player_gather < 0) then {
			_text = getText (configFile >> "CfgVehicles" >> typeOf _cursorTarget >> "displayName");
			s_player_gather = player addAction [format[localize "str_actions_gather",_text], "\z\addons\dayz_code\actions\player_gather.sqf",_cursorTarget, 1, true, true, "", ""];
		};
	} else {
		player removeAction s_player_gather;
		s_player_gather = -1;
	};

	//Allow player to force save
	if((_isVehicle or _isTent or _isStash or _isMediumStash) and _canDo and !_isMan and (damage _cursorTarget < 1)) then {
		if (s_player_forceSave < 0) then {
			s_player_forceSave = player addAction [format[localize "str_actions_save",_text], "\z\addons\dayz_code\actions\forcesave.sqf",_cursorTarget, 1, true, true, "", ""];
		};
	} else {
		player removeAction s_player_forceSave;
		s_player_forceSave = -1;
	};

	//flip vehicle
	if ((_isVehicletype) and !_canmove and _isAlive and (player distance _cursorTarget >= 2) and (count (crew _cursorTarget))== 0 and ((vectorUp _cursorTarget) select 2) < 0.5) then {
		if (s_player_flipveh < 0) then {
			s_player_flipveh = player addAction [format[localize "str_actions_flipveh",_text], "\z\addons\dayz_code\actions\player_flipvehicle.sqf",_cursorTarget, 1, true, true, "", ""];
		};
	} else {
		player removeAction s_player_flipveh;
		s_player_flipveh = -1;
	};

	//Allow player to fill Fuel can
	if((_hasFuelE20 or _hasFuelE5) and _isFuel and !_isZombie and !_isAnimal and !_isMan and _canDo and !a_player_jerryfilling) then {
		if (s_player_fillfuel < 0) then {
			s_player_fillfuel = player addAction [localize "str_actions_self_10", "\z\addons\dayz_code\actions\jerry_fill.sqf",[], 1, false, true, "", ""];
		};
	} else {
		player removeAction s_player_fillfuel;
		s_player_fillfuel = -1;
	};

	//Allow player to fill vehicle 20L
	if(_hasFuel20 and _canDo and !_isZombie and !_isAnimal and !_isMan and _isVehicle and (fuel _cursorTarget < 1) and (damage _cursorTarget < 1)) then {
		if (s_player_fillfuel20 < 0) then {
			s_player_fillfuel20 = player addAction [format[localize "str_actions_medical_10",_text,"20"], "\z\addons\dayz_code\actions\refuel.sqf",["ItemJerrycan"], 0, true, true, "", "'ItemJerrycan' in magazines player"];
		};
	} else {
		player removeAction s_player_fillfuel20;
		s_player_fillfuel20 = -1;
	};

	//Allow player to fill vehicle 5L
	if(_hasFuel5 and _canDo and !_isZombie and !_isAnimal and !_isMan and _isVehicle and (fuel _cursorTarget < 1)) then {
		if (s_player_fillfuel5 < 0) then {
			s_player_fillfuel5 = player addAction [format[localize "str_actions_medical_10",_text,"5"], "\z\addons\dayz_code\actions\refuel.sqf",["ItemFuelcan"], 0, true, true, "", "'ItemFuelcan' in magazines player"];
		};
	} else {
		player removeAction s_player_fillfuel5;
		s_player_fillfuel5 = -1;
	};

	//Allow player to spihon vehicles
	if ((_hasFuelE20 or _hasFuelE5) and !_isZombie and !_isAnimal and !_isMan and _isVehicle and _canDo and !a_player_jerryfilling and (fuel _cursorTarget > 0) and (damage _cursorTarget < 1)) then {
		if (s_player_siphonfuel < 0) then {
			s_player_siphonfuel = player addAction [format[localize "str_siphon_start"], "\z\addons\dayz_code\actions\siphonFuel.sqf",_cursorTarget, 0, true, true, "", ""];
		};
	} else {
		player removeAction s_player_siphonfuel;
		s_player_siphonfuel = -1;
	};

	//Harvested
	if (!alive _cursorTarget and _isAnimal and _hasKnife and !_isHarvested and _canDo) then {
		if (s_player_butcher < 0) then {
			s_player_butcher = player addAction [localize "str_actions_self_04", "\z\addons\dayz_code\actions\gather_meat.sqf",_cursorTarget, 3, true, true, "", ""];
		};
	} else {
		player removeAction s_player_butcher;
		s_player_butcher = -1;
	};
//Fireplace Actions check
	if (inflamed _cursorTarget and _canDo) then {
	/*
		{
			if (_x in magazines player) then {
				_hastinitem = true;
			};
		} forEach boil_tin_cans;
		
		_rawmeat = meatraw;
		_hasRawMeat = false;
		{
			if (_x in magazines player) then {
				_hasRawMeat = true;
			};
		} forEach _rawmeat;
	*/
		_hasRawMeat = {_x in meatraw} count magazines player > 0;
		_hastinitem = {_x in boil_tin_cans} count magazines player > 0;
		
	//Cook Meat	
		if (_hasRawMeat and !a_player_cooking) then {
			if (s_player_cook < 0) then {
				s_player_cook = player addAction [localize "str_actions_self_05", "\z\addons\dayz_code\actions\cook.sqf",_cursorTarget, 3, true, true, "", ""];
			};
		}; 
	//Boil Water
		if (_hastinitem and _hasbottleitem and !a_player_boil) then {
			if (s_player_boil < 0) then {
				s_player_boil = player addAction [localize "str_actions_boilwater", "\z\addons\dayz_code\actions\boil.sqf",_cursorTarget, 3, true, true, "", ""];
			};
		};
	} else {
		if (a_player_cooking) then {
			player removeAction s_player_cook;
			s_player_cook = -1;
		};
		if (a_player_boil) then {
			player removeAction s_player_boil;
			s_player_boil = -1;
		};
	};

	if(_cursorTarget == dayz_hasFire and _canDo) then {
		if ((s_player_fireout < 0) and !(inflamed _cursorTarget) and (player distance _cursorTarget < 3)) then {
			s_player_fireout = player addAction [localize "str_actions_self_06", "\z\addons\dayz_code\actions\fire_pack.sqf",_cursorTarget, 0, false, true, "",""];
		};
	} else {
		player removeAction s_player_fireout;
		s_player_fireout = -1;
	};

	//Packing my tent
	if(_cursorTarget isKindOf "TentStorage" and _canDo and _ownerID == dayz_characterID) then {
		if ((s_player_packtent < 0) and (player distance _cursorTarget < 3)) then {
			s_player_packtent = player addAction [localize "str_actions_self_07", "\z\addons\dayz_code\actions\tent_pack.sqf",_cursorTarget, 0, false, true, "",""];
		};
	} else {
		player removeAction s_player_packtent;
		s_player_packtent = -1;
		};

	//Sleep
	if(_cursorTarget isKindOf "TentStorage" and _canDo and _ownerID == dayz_characterID) then {
		if ((s_player_sleep < 0) and (player distance _cursorTarget < 3)) then {
			s_player_sleep = player addAction [localize "str_actions_self_sleep", "\z\addons\dayz_code\actions\player_sleep.sqf",_cursorTarget, 0, false, true, "",""];
		};
	} else {
		player removeAction s_player_sleep;
		s_player_sleep = -1;
	};

	//Repairing Vehicles
	if ((dayz_myCursorTarget != _cursorTarget) and _isVehicle and !_isMan and _hasToolbox and (damage _cursorTarget < 1)) then {
		if (s_player_repair_crtl < 0) then {
			dayz_myCursorTarget = _cursorTarget;
			_menu = dayz_myCursorTarget addAction [localize "str_actions_rapairveh", "\z\addons\dayz_code\actions\repair_vehicle.sqf",_cursorTarget, 0, true, false, "",""];
			//_menu1 = dayz_myCursorTarget addAction [localize "str_actions_salvageveh", "\z\addons\dayz_code\actions\salvage_vehicle.sqf",_cursorTarget, 0, true, false, "",""];
			s_player_repairActions set [count s_player_repairActions,_menu];
			//s_player_repairActions set [count s_player_repairActions,_menu1];
			s_player_repair_crtl = 1;
		} else {
			{dayz_myCursorTarget removeAction _x} forEach s_player_repairActions;s_player_repairActions = [];
			s_player_repair_crtl = -1;
		};
	};

	if (_isMan and !_isAlive and !_isZombie and !_isAnimal) then {
		if (s_player_studybody < 0) then {
			s_player_studybody = player addAction [localize "str_action_studybody", "\z\addons\dayz_code\actions\study_body.sqf",_cursorTarget, 0, false, true, "",""];
		};
	} else {
		player removeAction s_player_studybody;
		s_player_studybody = -1;
	};
} else {
	//Engineering
	{dayz_myCursorTarget removeAction _x} forEach s_player_repairActions;s_player_repairActions = [];
	player removeAction s_player_repair_crtl;
	s_player_repair_crtl = -1;
	dayz_myCursorTarget = objNull;
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
	//Others
	player removeAction s_player_forceSave;
	s_player_forceSave = -1;
	player removeAction s_player_flipveh;
	s_player_flipveh = -1;
	player removeAction s_player_sleep;
	s_player_sleep = -1;
	player removeAction s_player_deleteBuild;
	s_player_deleteBuild = -1;
	player removeAction s_player_butcher;
	s_player_butcher = -1;
	player removeAction s_player_cook;
	s_player_cook = -1;
	player removeAction s_player_boil;
	s_player_boil = -1;
	player removeAction s_player_fireout;
	s_player_fireout = -1;
	player removeAction s_player_packtent;
	s_player_packtent = -1;
	player removeAction s_player_fillfuel;
	s_player_fillfuel = -1;
	player removeAction s_player_studybody;
	s_player_studybody = -1;
	//fuel
	player removeAction s_player_fillfuel20;
	s_player_fillfuel20 = -1;
	player removeAction s_player_fillfuel5;
	s_player_fillfuel5 = -1;
	//Allow player to siphon vehicle fuel
	player removeAction s_player_siphonfuel;
	s_player_siphonfuel = -1;
	//Allow player to gather
	player removeAction s_player_gather;
	s_player_gather = -1;
};