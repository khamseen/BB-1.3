/*
Base Building DayZ by Daimyo
*/
private["_authorizedUID","_allFlags","_newAttachCoords","_startingPos","_buildables","_flagradius","_okToBuild","_allowedExtendedMode","_flagNearest","_flagNearby","_requireFlag","_funcExitScriptCombat","_funcExitScript","_playerCombat","_isSimulated","_isDestructable","_townRange","_longWloop","_medWloop","_smallWloop","_inTown","_inProgress","_modDir","_startPos","_tObjectPos","_buildable","_chosenRecipe","_cnt","_cntLoop","_dialog","_buildCheck","_isInCombat","_playerCombat","_check_town","_eTool","_toolBox","_town_pos","_town_name","_closestTown","_roadAllowed","_toolsNeeded","_inBuilding","_attachCoords","_requirements","_result","_alreadyBuilt","_uidDir","_p1","_p2","_uid","_worldspace","_panelNearest2","_staticObj","_onRoad","_itemL","_itemM","_itemG","_qtyL","_qtyM","_qtyG","_cntLoop","_finished","_checkComplete","_objectTemp","_locationPlayer","_object","_id","_isOk","_text","_mags","_hasEtool","_canDo","_hasToolbox","_inVehicle","_isWater","_onLadder","_building","_medWait","_longWait","_location","_isOk","_dir","_classname","_item","_itemT","_itemS","_itemW","_qtyT","_qtyS","_qtyW"];

// Location placement declarations
_locationPlayer = player modeltoworld [0,0,0];
_location 		= player modeltoworld [0,0,0]; // Used for object start location and to keep track of object position throughout
_attachCoords = [0,0,0];
_dir 			= getDir player;
_building 		= nearestObject [player, "Building"];
_staticObj 		= nearestObject [player, "Static"];

// Restriction Checks

_hasEtool 		= "ItemEtool" in weapons player;
_hasToolbox 	= 	"ItemToolbox" in items player;
_onLadder 		=	(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
_canDo 			= (!r_drag_sqf and !r_player_unconscious and !_onLadder); //USE!!
_isWater 		= 	(surfaceIsWater _locationPlayer) or dayz_isSwimming;
_inVehicle 		= (vehicle player != player);
_isOk = [player,_building] call fnc_isInsideBuilding;
_closestTown = (nearestLocations [player,["NameCityCapital","NameCity","NameVillage","Airport"],25600]) select 0;
_town_name = text _closestTown;
_town_pos = position _closestTown;

// Booleans  Some not used, possibly use later
_roadAllowed 	= false;
_medWait 		= false;
_longWait 		= false;
_checkComplete 	= false;
_finished 		= false;
_eTool 			= false;
_toolBox 		= false;
_alreadyBuilt 	= false;
_inBuilding 	= false;
_inTown 		= false;
_inProgress 	= false;
_result 		= false;
_isSimulated 	= false;
_isDestructable = false;
_requireFlag 	= false;
_flagNearby 	= false;
_okToBuild 		= false;
// Strings
_classname 		= "";
_check_town		= "";

// Other
_flagRadius 	= 200; //Meters around flag that players can build
_cntLoop 		= 0;
_chosenRecipe 	= [];
_requirements 	= [];
_buildable 		= [];
_buildables		= [];
_longWloop		= 2;
_medWloop		= 1;
_smallWloop 	= 0;
_cnt 			= 0;
_playerCombat 	= player;



	// Function to exit script without combat activate
	_funcExitScript = {
		player removeAction attachGroundAction;
		player removeAction elevateAction;
		player removeAction lowerAction;                       
		player removeAction rotateAction;
		player removeAction rotateAction2;     
		player removeAction objectAwayAction;
		player removeAction objectNearAction;
		player removeAction objectRightAction;
		player removeAction objectLeftAction;
		player removeAction finishAction;
		 player removeAction restablishAction;
		 player removeAction elevateActionSmall;
    player removeAction lowerActionSmall;
		procBuild = false;
		breakOut "exit";
	};
	// Function to exit script with combat activate
	_funcExitScriptCombat = {
		player removeAction attachGroundAction;
		player removeAction elevateAction;
		player removeAction lowerAction;                       
		player removeAction rotateAction;
		player removeAction rotateAction2;     
		player removeAction objectAwayAction;
		player removeAction objectNearAction;
		player removeAction objectRightAction;
		player removeAction objectLeftAction;
		player removeAction finishAction;
		 player removeAction restablishAction;
		 player removeAction elevateActionSmall;
    player removeAction lowerActionSmall;
		procBuild = false;
		_playerCombat setVariable["startcombattimer", 1, true];
		breakOut "exit";
	};
	// Do first checks to see if player can build before counting
	if (procBuild) then {cutText ["Your already building!", "PLAIN DOWN"];call _funcExitScript;};
	if(_isWater) then {cutText [localize "str_player_26", "PLAIN DOWN"];call _funcExitScript;};
	if(_onLadder) then {cutText [localize "str_player_21", "PLAIN DOWN"];call _funcExitScript;};
	if (_inVehicle) then {cutText ["Can't do this in vehicle", "PLAIN DOWN"];call _funcExitScript;};
	disableSerialization;
	closedialog 1;
	// Ashfor Fix: Did player try to drop mag and keep action active (not really needed but leave here just in case)
	//_item = _this;
	//if (_item in (magazines player) ) then { // needs }; 
	// Global variables for loop method, procBuild may not be needed if implemented in fn_selfactions.sqf
		if (dayz_combat == 1) then {
			cutText ["Your currently in combat, time reduced to 3 seconds. \nCanceling/escaping will set you back into combat", "PLAIN DOWN"];
			sleep 3;
			_playerCombat setVariable["combattimeout", 0, true];
			dayz_combat = 0;
		};
	r_interrupt = false;
	r_doLoop = true;
	procBuild = true;
	//Global build_list reference params:
	//[_qtyT, _qtyS, _qtyW, _qtyL, _qtyM, _qtyG], "Classname", [_attachCoords, _toolBox, _eTool, _medWait, _longWait, _inBuilding, _roadAllowed, _inTown];
	call gear_ui_init;
	// Count mags in player inventory and add to an array
	_mags = magazines player;
		if ("ItemTankTrap" in _mags) then {
			_qtyT = {_x == "ItemTankTrap"} count magazines player;
			_buildables set [count _buildables, _qtyT];
			_itemT = "ItemTankTrap";
		} else { _qtyT = 0; _buildables set [count _buildables, _qtyT]; };
			
		if ("ItemSandbag" in _mags) then {
			_qtyS = {_x == "ItemSandbag"} count magazines player;
			_buildables set [count _buildables, _qtyS]; 
			_itemS = "ItemSandbag";
		} else { _qtyS = 0; _buildables set [count _buildables, _qtyS]; };
		
		if ("ItemWire" in _mags) then {
			_qtyW = {_x == "ItemWire"} count magazines player;
			_buildables set [count _buildables, _qtyW]; 
			_itemW = "ItemWire";
			} else { _qtyW = 0; _buildables set [count _buildables, _qtyW]; };
			if ("PartWoodPile" in _mags) then {
			_qtyL = {_x == "PartWoodPile"} count magazines player;
			_buildables set [count _buildables, _qtyL]; 
			_itemL = "PartWoodPile";
		} else { _qtyL = 0; _buildables set [count _buildables, _qtyL]; };
		
		if ("PartGeneric" in _mags) then {
			_qtyM = {_x == "PartGeneric"} count magazines player;
			_buildables set [count _buildables, _qtyM]; 
			_itemM = "PartGeneric";
		} else { _qtyM = 0; _buildables set [count _buildables, _qtyM]; };
		
		if ("HandGrenade_West" in _mags) then {
			_qtyG = {_x == "HandGrenade_West"} count magazines player;
			_buildables set [count _buildables, _qtyG]; 
			_itemG = "HandGrenade_West";
		} else { _qtyG = 0; _buildables set [count _buildables, _qtyG]; };

	/*-- Add another item for recipe here by changing _qtyI, "Item_Classname", and add recipe into build_list.sqf array!
		Dont forget to add recipe to recipelist so your players can know how to make object via recipe
	//		if ("Item_Classname" in _mags) then {
	//		_qtyI = {_x == "Item_Classname"} count magazines player;
	//		_buildables set [count _buildables, _qtyI]; 
	//		_itemG = "Item_Classname";
	//	} else { _qtyI = 0; _buildables set [count _buildables, _qtyI]; };
	*/
		
	// Check what object is returned from global array, then return classname
		for "_i" from 0 to ((count allbuildables) - 1) do
		{
			_buildable = (allbuildables select _i) select _i - _i;
			_result = [_buildables,_buildable] call BIS_fnc_areEqual;
				if (_result) then {
					_classname = (allbuildables select _i) select _i - _i + 1;
					_requirements = (allbuildables select _i) select _i - _i + 2;
					_chosenRecipe = _buildable;
				};
			_buildable = [];
		};
	// Quit here if no proper recipe is acquired else set names properly
	if (_classname == "") then {cutText ["You need the EXACT amount of whatever you are trying to build without extras.", "PLAIN DOWN"];call _funcExitScriptCombat;};
	if (_classname == "Grave") then {_text = "Booby Trap";};
	if (_classname == "Concrete_Wall_EP1") then {_text = "Gate Concrete Wall";};
	if (_classname == "Infostand_2_EP1") then {_text = "Gate Panel Keypad Access";};
	if (_classname != "Infostand_2_EP1" && 
		_classname != "Concrete_Wall_EP1" &&  
		_classname != "Grave") then {
	//_text = _classname;
	_text = getText (configFile >> "CfgVehicles" >> _classname >> "displayName");				
	};
	_buildable = [];

	//Get Requirements from build_list.sqf global array [_attachCoords, _startPos, _modDir, _toolBox, _eTool, _medWait, _longWait, _inBuilding, _roadAllowed, _inTown];
	_attachCoords 	= _requirements select 0;
	_startPos 		= _requirements select 1;
	_modDir 		= _requirements select 2;
	_toolBox 		= _requirements select 3;
	_eTool 			= _requirements select 4;
	_medWait 		= _requirements select 5;
	_longWait 		= _requirements select 6;
	_inBuilding 	= _requirements select 7;
	_roadAllowed 	= _requirements select 8;
	_inTown 		= _requirements select 9;
	_isSimulated 	= _requirements select 12;
	_isDestrutable	= _requirements select 13;
	_requireFlag 	= _requirements select 14;
	// Get _startPos for object
	_location 		= player modeltoworld _startPos;
	//One flag per base
	if (_classname == "FlagCarrierUSA") then { 
		_allFlags = nearestObjects [player, ["FlagCarrierUSA"], 25000];
		{
			if (typeOf(_x) == "FlagCarrierUSA") then {
				_authorizedUID = _x getVariable ["AuthorizedUID", []];
				if ((getPlayerUid player) in _authorizedUID && (_classname == "FlagCarrierUSA")) exitWith {
					cutText [format["Your playerUID is already registered to one flagpole, you can be added to up to 3 flagpoles. Check Map for temporary flag marker! 10 seconds!\nBuild canceled for %1",_text], "PLAIN DOWN",1];
				   _flagMarker = createMarkerLocal ["Flag Position",position _x];       
				   _flagMarker setMarkerTypeLocal "warning";
				   _flagMarker setMarkerColorLocal("ColorBlack");
				   _flagMarker setMarkerTextLocal format ["%1's Flag", (name player)];
				   sleep 10;
				   call _funcExitScriptCombat;
				};
			};
		} foreach _allFlags;
	};
	//Dont allow players to build in others bases
	if (_classname != "Grave") then {
		_allFlags = nearestObjects [player, ["FlagCarrierUSA"], 500];
		{
			if (typeOf(_x) == "FlagCarrierUSA") then {
				_authorizedUID = _x getVariable ["AuthorizedUID", []];
				if ((getPlayerUid player) in _authorizedUID && _x distance player <= 200) then {
				 _okToBuild = true;	
				};
			};
			if (_okToBuild) exitWIth {};
			if (!_okToBuild && !_requireFlag && _x distance player <= _flagRadius) then {cutText [format["Build canceled for %1\nCannot build in other players bases, only Booby traps are allowed.",_text], "PLAIN DOWN",1];call _funcExitScriptCombat;};
		} foreach _allFlags;
	};
	
	//Check Requirements
	if (_requireFlag) then {
		_allFlags = nearestObjects [player, ["FlagCarrierUSA"], 25000];
		{
			if (typeOf(_x) == "FlagCarrierUSA") then {
				_authorizedUID = _x getVariable ["AuthorizedUID", []];
				if ((getPlayerUid player) in _authorizedUID && (_classname == "FlagCarrierUSA")) then {
					cutText [format["Your playerUID is already registered to one flagpole, you can be added to up to 3 flagpoles. Check Map for temporary flag marker! 10 seconds!\nBuild canceled for %1",_text], "PLAIN DOWN",1];
				   _flagMarker = createMarkerLocal ["Flag Position",position _x];       
				   _flagMarker setMarkerTypeLocal "warning";
				   _flagMarker setMarkerColorLocal("ColorBlack");
				   _flagMarker setMarkerTextLocal format ["%1's Flag", (name player)];
				   sleep 10;
				   call _funcExitScriptCombat;
				};
				if ((getPlayerUid player) in _authorizedUID && _x distance player <= _flagRadius) then {
					_flagNearby = true;
				};
			};
		} foreach _allFlags;
		if (!_flagNearby) then {
			cutText [format["Either no flag is within %1 meters or you or you have not built a flag pole and claimed your land \nBuild canceled for %2",_flagRadius, _text], "PLAIN DOWN",1];call _funcExitScriptCombat;
		};
	};
	
	if (_toolBox) then {
		if (!_hasToolbox) then {cutText [format["You need a tool box to build %1",_text], "PLAIN DOWN",1];call _funcExitScriptCombat; };
	};
	if (_eTool) then {
		if (!_hasEtool) then {cutText [format["You need an entrenching tool to build %1",_text], "PLAIN DOWN",1];call _funcExitScriptCombat; };
	};
	if (!_inBuilding) then {
		if (_isOk) then {cutText [format["%1 cannot be built inside of buildings!",_text], "PLAIN DOWN",1];call _funcExitScriptCombat; };
	};
	if (!_roadAllowed) then { // Do another check for object being on road
		_onRoad = isOnRoad _locationPlayer;
		if(_onRoad) then {cutText [format["You cannot build %1 on the road",_text], "PLAIN DOWN",1];call _funcExitScriptCombat;};
	};
	if (!_inTown) then {
		for "_i" from 0 to ((count allbuild_notowns) - 1) do
		{
			_check_town = (allbuild_notowns select _i) select _i - _i;
			if (_town_name == _check_town) then {
				_townRange = (allbuild_notowns select _i) select _i - _i + 1;
				if (_locationPlayer distance _town_pos <= _townRange) then {
					cutText [format["You cannot build %1 within %2 meters of area %3",_text, _townRange, _town_name], "PLAIN DOWN",1];call _funcExitScriptCombat;
				};
			};
		};
	};

	
	_flagNearest = nearestObjects [player, ["FlagCarrierUSA"], (_flagRadius * 2)];
	if (_classname == "FlagCarrierUSA" && (count _flagNearest > 0)) then {cutText [format["Only 1 flagpole per base in a %1 meter radius! Remember, this includes the other bases build radius as well.",(_flagRadius * 2)], "PLAIN DOWN",1];call _funcExitScriptCombat;};

	// Begin building process
	_buildCheck = false;
	buildReady = false;
	player allowdamage false;
	_object = createVehicle [_classname, _location, [], 0, "CAN_COLLIDE"];
	_object setDir (getDir player);
	if (_modDir > 0) then {
	_object setDir (getDir player) + _modDir;
	};
	_allowedExtendedMode = (typeOf(_object) in allExtendables);
    player removeAction attachGroundAction;
    player removeAction elevateAction;
    player removeAction lowerAction;                       
    player removeAction rotateAction;
    player removeAction rotateAction2;     
    player removeAction objectAwayAction;
    player removeAction objectNearAction;
    player removeAction objectRightAction;
    player removeAction objectLeftAction;
    player removeAction finishAction;
    player removeAction restablishAction;
	player removeAction elevateActionSmall;
    player removeAction lowerActionSmall;
		
    if(_allowedExtendedMode)then {
		finishAction 		= player addAction ["Finish building!", "dayz_code\actions\buildActions\finishBuild.sqf",_object, 1, true, true, "", ""];
        elevateAction 		= player addAction ["Elevate", "dayz_code\actions\buildActions\elevateObject.sqf",_object, 1, true, true, "", ""];
        lowerAction 		= player addAction ["Lower", "dayz_code\actions\buildActions\lowerObject.sqf",_object, 1, true, true, "", ""];
		elevateActionSmall 	= player addAction ["Elevate Slightly", "dayz_code\actions\buildActions\elevateObjectSmall.sqf",_object, 1, true, true, "", ""];
        lowerActionSmall 	= player addAction ["Lower Slightly", "dayz_code\actions\buildActions\lowerObjectSmall.sqf",_object, 1, true, true, "", ""];
        rotateAction 		= player addAction ["Rotate", "dayz_code\actions\buildActions\rotateObject.sqf",_object, 1, true, true, "", ""];
        rotateAction2		= player addAction ["Rotate inverse", "dayz_code\actions\buildActions\rotateObjectInverse.sqf",_object, 1, true, true, "", ""];
        objectAwayAction 	= player addAction ["Push away", "dayz_code\actions\buildActions\pushObject.sqf",_object, 1, true, true, "", ""];
        objectNearAction 	= player addAction ["Pull near", "dayz_code\actions\buildActions\pullObject.sqf",_object, 1, true, true, "", ""];
        objectRightAction 	= player addAction ["Move left", "dayz_code\actions\buildActions\rightObject.sqf",_object, 1, true, true, "", ""];
        objectLeftAction 	= player addAction ["Move right", "dayz_code\actions\buildActions\leftObject.sqf",_object, 1, true, true, "", ""];
        restablishAction 	= player addAction ["Restablish", "dayz_code\actions\buildActions\restablishObject.sqf",_object, 1, true, true, "", ""];
        attachGroundAction 	= player addAction ["Attach to ground", "dayz_code\actions\buildActions\attachGroundObject.sqf",_object, 1, true, true, "", ""];
    };
     
    rotateDir = _modDir;
	player allowdamage true;
	hint "";
	if (_allowedExtendedMode) then {
		cutText ["-Build process started(Previous extended settings saved, use 'restablish action' for default position).  EXTENDED MODE: Move around to re-position, use 'Actions' to adjust\n-Select 'finish build' action when done to see preview after restart", "PLAIN DOWN", 10];
	} else {
		cutText ["-Build process started (Default).  Move around to re-position\n-Stay still to begin build timer", "PLAIN DOWN", 10];
	};	
	//_startingPos = getPos player;  // used to restrict distance of build
	while {!buildReady} do {
	if (_allowedExtendedMode) then {
		hintsilent "-Build process started.  EXTENDED MODE: Move around to re-position, use Actions to adjust\n-Select finish build action when done to see preview after restart";
	} else {
		hintsilent "-Build process started (Default).  \n-Move around to re-position\n-Stay still to begin build timer";
	};	
		_playerCombat = player;
		_isInCombat = _playerCombat getVariable["startcombattimer",0];
		_dialog = findDisplay 106;
			if ((speed player <= 12) && (speed player >= -9)) then {
			   if(_allowedExtendedMode) then {
                    _newAttachCoords = [];
                    _newAttachCoords = [(objectParallelDistance+(_attachCoords select 0)),(objectDistance + (_attachCoords select 1)),(objectHeight + (_attachCoords select 2))];
                    _object attachto [player, _newAttachCoords];
					_object setDir (getDir player) + rotateDir;
               } else {
                    _object attachto [player, _attachCoords];
					_inProgress = true;
					_object setDir (getDir player) + rotateDir;
                };	
			};
			if (speed player == 0) then {
				if (_inProgress) then {
					detach _object;
					sleep 0.03;
					_location = getposATL _object;
					_dir = getDir _object;
					_object setpos [(getposATL _object select 0),(getposATL _object select 1), 0];
					_location = _object modeltoworld [0,0,0];
					deletevehicle _object;
					_object = createVehicle [_classname, _location, [], 0, "CAN_COLLIDE"];
					_object setDir _dir;
					if (typeOf(_object) == "Grave") then {
						_object setpos [(getposATL _object select 0),(getposATL _object select 1), -0.12];
					} else {
						_object setpos [(getposATL _object select 0),(getposATL _object select 1), 0];
					};
					_cntLoop = 50;
					_inProgress = false;
					while {speed player == 0 && !buildReady} do {
						sleep 0.1;
						if (_cntLoop <= 100 && _cntLoop % 10 == 0) then {
						cutText [format["Building of %1 starts in %2 seconds. Move to restart timer and position",_text, (_cntLoop / 10)], "PLAIN DOWN",1];
						};
						// Cancel build if rules broken
						_isInCombat = _playerCombat getVariable["startcombattimer",0];
						_dialog = findDisplay 106;
						if ((!(isNull _dialog) || _isInCombat > 0) && (isPlayer _playerCombat) ) then {
							detach _object;
							deletevehicle _object;
							cutText [format["Build canceled for %1. Player in combat or opened gear.",_text], "PLAIN DOWN",1];call _funcExitScriptCombat;
							if (!_roadAllowed) then { // Check object being placed on road
								_onRoad = isOnRoad getposATL(_object);
								if(_onRoad) then {cutText [format["You cannot build %1 on the road",_text], "PLAIN DOWN",1];call _funcExitScriptCombat;};
							};
						};
						_cntLoop = _cntLoop - 1;
						if (_cntLoop <= 0) then {
							buildReady = true;
							_cntLoop = 0;
						};
					};
				};
			};
			//Check if trying to build in other players bases
			if (_classname != "Grave") then {
				_okToBuild = true;
				_allFlags = nearestObjects [player, ["FlagCarrierUSA"], 500];
				{
					if (typeOf(_x) == "FlagCarrierUSA") then {
						_authorizedUID = _x getVariable ["AuthorizedUID", []];
						if ((getPlayerUid player) in _authorizedUID && _x distance player <= 200) then {
						 _okToBuild = true;	
						};
					};
					if (_okToBuild) exitWIth {};
					if (!_okToBuild && _x distance player <= _flagRadius) exitWith {cutText [format["Build canceled for %1\nCannot build in other players bases, only Booby traps are allowed.",_text], "PLAIN DOWN",1];call _funcExitScriptCombat;};
				} foreach _allFlags;
			};
			//Check if object requires flag and player is trying to walk it out from his flag radius
			if (_requireFlag) then {
				_allFlags = nearestObjects [player, ["FlagCarrierUSA"], 600];
				{
					if (typeOf(_x) == "FlagCarrierUSA") then {
						_authorizedUID = _x getVariable ["AuthorizedUID", []];
						if ((getPlayerUid player in _authorizedUID) && (_x distance player >= _flagRadius) || (_x distance _object >= _flagRadius)) then {
							cutText [format["Build canceled for %1\nYou and or the object need to be within %2 meters of your flag to build.",_text, _flagRadius, _text], "PLAIN DOWN",1];detach _object;deletevehicle _object;call _funcExitScriptCombat;
						};
					};
				} foreach _allFlags;
			};
			// Cancel build if rules broken
			if ((!(isNull _dialog) || (speed player >= 12 || speed player <= -9) || _isInCombat > 0) && (isPlayer _playerCombat) ) then {
				detach _object;
				deletevehicle _object;
				cutText [format["Build canceled for %1. Player moving too fast, in combat or opened gear.",_text], "PLAIN DOWN",1];call _funcExitScriptCombat;
			};
		sleep 0.03;
	};
	if (buildReady) then {
	    if(_allowedExtendedMode) then {
			_objectDir = getDir _object;
			detach _object;
			_objectPos = getPosATL _object;
			deletevehicle _object;
			_object = createVehicle [_classname, _objectPos, [], 0, "CAN_COLLIDE"];
			_object setDir _objectDir;
			buildReady=false;
			_location = _objectPos;//getposATL _object;
			_dir = _objectDir;//getDir _object;
			cutText [format["AFTER RESTART: This is how the %1 object will look.",_text], "PLAIN DOWN",1];
			sleep 5;
		};
	cutText [format["Building beginning for %1.",_text], "PLAIN DOWN",1];
	} else {cutText [format["Build canceled for %1. Something went wrong!",_text], "PLAIN DOWN",1];call _funcExitScriptCombat;};
	// Begin Building
	//Do quick check to see if player is not playing nice after placing object
	_locationPlayer = player modeltoworld [0,0,0];
	_onLadder 		=	(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
	_canDo 			= (!r_drag_sqf and !r_player_unconscious and !_onLadder); //USE!!
	_isWater 		= 	(surfaceIsWater _locationPlayer) or dayz_isSwimming;
	_inVehicle 		= (vehicle player != player);
	_isOk = [player,_building] call fnc_isInsideBuilding;
	if (!_inBuilding) then {
		if (_isOk) then {deletevehicle _object; cutText [format["%1 cannot be built inside of buildings!",_text], "PLAIN DOWN",1];call _funcExitScriptCombat; };
	};
	// Did player walk object into restricted town?
	_closestTown = (nearestLocations [player,["NameCityCapital","NameCity","NameVillage"],25600]) select 0;
	_town_name = text _closestTown;
	_town_pos = position _closestTown;
	if (!_inTown) then {
		for "_i" from 0 to ((count allbuild_notowns) - 1) do
		{
			_check_town = (allbuild_notowns select _i) select _i - _i;
			if (_town_name == _check_town) then {
				_townRange = (allbuild_notowns select _i) select _i - _i + 1;
				if (_locationPlayer distance _town_pos <= _townRange ||  _object distance _town_pos <= _townRange) then {
					 deletevehicle _object; cutText [format["You cannot build %1 within %2 meters of area %3",_text, _townRange, _town_name], "PLAIN DOWN",1];call _funcExitScriptCombat;
				};
				if (_classname == "FlagCarrierUSA") then {
					if (_object distance _town_pos <= (_townRange + _flagRadius)) then {
						 deletevehicle _object; cutText [format["You cannot build %1 within %2 meters of area %3\nWhen building a %1, you must consider the %4 meter radius around the %1 conflicting with town radius of %5 meters",_text, (_townRange + _flagRadius), _town_name, _flagRadius, _townRange], "PLAIN DOWN",1];call _funcExitScriptCombat;
					};
				};
			};
		};
	};

	r_interrupt = false;
	r_doLoop = true;
	_cntLoop = 0;
	//Physically begin building 
	switch (true) do
	{
		case(_longWait):
		{
			_cnt = _longWloop;
			_cnt = _cnt * 10;
			for "_i" from 0 to _longWloop do
			{
				cutText [format["Building %1.  %2 seconds left.\nMove from current position to cancel",_text,_cnt + 10], "PLAIN DOWN",1];
				if (player distance _locationPlayer > 1) then {deletevehicle _object; cutText [format["Build canceled for %1, position of player moved",_text], "PLAIN DOWN",1]; call _funcExitScriptCombat;};
				if (!_canDo || _onLadder || _inVehicle || _isWater) then {deletevehicle _object; cutText [format["Build canceled for %1, player is unable to continue",_text], "PLAIN DOWN",1]; call _funcExitScriptCombat;};
				player playActionNow "Medic";
				sleep 1;
				[player,"repair",0,false] call dayz_zombieSpeak;
				_id = [player,50,true,(getPosATL player)] spawn player_alertZombies;
				//DayZ interrupt feature like when canceling bandaging
				while {r_doLoop} do {
					if (r_interrupt) then {
						r_doLoop = false;
					};
					if (_cntLoop >= 80) then {
						r_doLoop = false;
						_finished = true;
					};
					sleep .1;
					_cntLoop = _cntLoop + 1;
				};
				if (r_interrupt) then {
					deletevehicle _object; 
					[objNull, player, rSwitchMove,""] call RE;
					player playActionNow "stop";
					cutText [format["Build canceled for %1, position of player moved",_text], "PLAIN DOWN",1]; 
					procBuild = false;_playerCombat setVariable["startcombattimer", 1, true]; 
					breakOut "exit";
				};
				r_doLoop = true;
				_cntLoop = 0;
				_cnt = _cnt - 10;
			};
			sleep 1.5;
		};
		case(_medWait):
		{
			_cnt = _medWloop;
			_cnt = _cnt * 10;
			for "_i" from 0 to _medWloop do
			{
				cutText [format["Building %1.  %2 seconds left.\nMove from current position to cancel",_text,_cnt + 10], "PLAIN DOWN",1];
				if (player distance _locationPlayer > 1) then {deletevehicle _object; cutText [format["Build canceled for %1, position of player moved",_text], "PLAIN DOWN",1]; call _funcExitScriptCombat;};
				if (!_canDo || _onLadder || _inVehicle || _isWater) then {deletevehicle _object; cutText [format["Build canceled for %1, player is unable to continue",_text], "PLAIN DOWN",1]; call _funcExitScriptCombat;};
				player playActionNow "Medic";
				sleep 1;
				[player,"repair",0,false] call dayz_zombieSpeak;
				_id = [player,50,true,(getPosATL player)] spawn player_alertZombies;
				while {r_doLoop} do {
					if (r_interrupt) then {
						r_doLoop = false;
					};
					if (_cntLoop >= 80) then {
						r_doLoop = false;
						_finished = true;
					};
					sleep .1;
					_cntLoop = _cntLoop + 1;
				};
				if (r_interrupt) then {
					deletevehicle _object; 
					[objNull, player, rSwitchMove,""] call RE;
					player playActionNow "stop";
					cutText [format["Build canceled for %1, position of player moved",_text], "PLAIN DOWN",1]; 
					procBuild = false;_playerCombat setVariable["startcombattimer", 1, true]; 
					breakOut "exit";
				};
				r_doLoop = true;
				_cntLoop = 0;
				_cnt = _cnt - 10;
			};
			sleep 1.5;
		};
		case(!_medWait && !_longWait):
		{
			_cnt = _smallWloop;
			_cnt = _cnt * 10;
			for "_i" from 0 to _smallWloop do
			{
				cutText [format["Building %1.  %2 seconds left.\nMove from current position to cancel",_text,_cnt + 10], "PLAIN DOWN",1];
				if (player distance _locationPlayer > 1) then {deletevehicle _object; cutText [format["Build canceled for %1, position of player moved",_text], "PLAIN DOWN",1]; call _funcExitScriptCombat;};
				if (!_canDo || _onLadder || _inVehicle || _isWater) then {deletevehicle _object; cutText [format["Build canceled for %1, player is unable to continue",_text], "PLAIN DOWN",1]; call _funcExitScriptCombat;};
				player playActionNow "Medic";
				sleep 1;
				[player,"repair",0,false] call dayz_zombieSpeak;
				_id = [player,50,true,(getPosATL player)] spawn player_alertZombies;
				while {r_doLoop} do {
					if (r_interrupt) then {
						r_doLoop = false;
					};
					if (_cntLoop >= 80) then {
						r_doLoop = false;
						_finished = true;
					};
					sleep .1;
					_cntLoop = _cntLoop + 1;
				};
				if (r_interrupt) then {
					deletevehicle _object; 
					[objNull, player, rSwitchMove,""] call RE;
					player playActionNow "stop";
					cutText [format["Build canceled for %1, position of player moved",_text], "PLAIN DOWN",1]; 
					procBuild = false;_playerCombat setVariable["startcombattimer", 1, true]; 
					breakOut "exit";
				};
				r_doLoop = true;
				_cntLoop = 0;
				_cnt = _cnt - 10;
			};
			sleep 1.5;
		};
	};
	
	// Do last check to see if player attempted to remvoe buildables
	_mags = magazines player;
	_buildables = []; // reset original buildables
		if ("ItemTankTrap" in _mags) then {
			_qtyT = {_x == "ItemTankTrap"} count magazines player;
			_buildables set [count _buildables, _qtyT]; 
		} else { _qtyT = 0; _buildables set [count _buildables, _qtyT]; };
			
		if ("ItemSandbag" in _mags) then {
			_qtyS = {_x == "ItemSandbag"} count magazines player;
			_buildables set [count _buildables, _qtyS]; 
		} else { _qtyS = 0; _buildables set [count _buildables, _qtyS]; };
		
		if ("ItemWire" in _mags) then {
			_qtyW = {_x == "ItemWire"} count magazines player;
			_buildables set [count _buildables, _qtyW]; 
			} else { _qtyW = 0; _buildables set [count _buildables, _qtyW]; };
			if ("PartWoodPile" in _mags) then {
			_qtyL = {_x == "PartWoodPile"} count magazines player;
			_buildables set [count _buildables, _qtyL]; 
		} else { _qtyL = 0; _buildables set [count _buildables, _qtyL]; };
		
		if ("PartGeneric" in _mags) then {
			_qtyM = {_x == "PartGeneric"} count magazines player;
			_buildables set [count _buildables, _qtyM]; 
		} else { _qtyM = 0; _buildables set [count _buildables, _qtyM]; };
		
		if ("HandGrenade_West" in _mags) then {
			_qtyG = {_x == "HandGrenade_West"} count magazines player;
			_buildables set [count _buildables, _qtyG]; 
		} else { _qtyG = 0; _buildables set [count _buildables, _qtyG]; };

	// Check if it matches again
	disableUserInput true;
	cutText ["Keyboard disabled while confirm recipes\n -Anti-Dupe", "PLAIN DOWN"];
	_result = [_buildables,_chosenRecipe] call BIS_fnc_areEqual;
	disableUserInput false;
	if (_result) then {
	//Build final product!

		//Finish last requirement checks, _isSimulated disables objects physics if specified, _isDestructable checks if object needs to be invincible
		if (!_isSimulated) then {
			_object enablesimulation false;
		};
		if (!_isDestructable) then {
			_object addEventHandler ["HandleDamage", {false}];
		};
		

	// set the codes for gate
	//--------------------------------

		// New Method
		_uidDir = _dir;
		_uidDir = round(_uidDir);
		_uid = "";
		{
			_x = _x * 10;
			if ( _x < 0 ) then { _x = _x * -10 };
			_uid = _uid + str(round(_x));
		} forEach _location;
		_uid = _uid + str(round(_dir));

	//--------------------------------

		switch (_classname) do
		{
			case "Grave":
			{
				_object setVariable ["isBomb", 1, true];//this will be known as a bomb instead of checking with classnames in player_bomb
				cutText [format["You have constructed a %1\nIt will only set off for enemies, add friendly playerUIDs so it will not trigger for them",_text], "PLAIN DOWN",1];	
			};
			case "Infostand_2_EP1":
			{
				cutText [format["You have constructed a %1\nBuild one outside as well. Look at Object to give base owners access as well!",_text,_uid], "PLAIN DOWN",60];
			};
			case "FlagCarrierUSA":
			{
				cutText [format["You have constructed a %1\nYou can now build within a %3 radius around this area, add friends playerUIDs to allow them to build too.",_text,_flagRadius], "PLAIN DOWN",60];
			};
			default {
				cutText [format["You have constructed a %1",_text,_uid], "PLAIN DOWN",60];
				//cutText [format[localize "str_build_01",_text], "PLAIN DOWN"];
			};
		};
		//Remove required magazines
		if (_qtyT > 0) then {
			for "_i" from 0 to _qtyT do
			{
				player removeMagazine _itemT;
			};
		};
		if (_qtyS > 0) then {
			for "_i" from 0 to _qtyS do
			{
				player removeMagazine _itemS;
			};
		};
		if (_qtyW > 0) then {
			for "_i" from 0 to _qtyW do
			{
				player removeMagazine _itemW;
			};
		};
		if (_qtyL > 0) then {
			for "_i" from 0 to _qtyL do
			{
				player removeMagazine _itemL;
			};
		};
		if (_qtyM > 0) then {
			for "_i" from 0 to _qtyM do
			{
				player removeMagazine _itemM;
			};
		};
		//Grenade only is needed when building booby trap
		if (_qtyG > 0 && _classname == "Grave") then {
			for "_i" from 0 to _qtyG do
			{
				player removeMagazine _itemG;
			};
		};
	_playerUID = [];
	_playerUID set [count _playerUID, (getPlayerUID player)];
	// Send to database
	_object setVariable ["AuthorizedUID", _playerUID, true];
	_object setVariable ["characterID",dayz_characterID,true];
	//dayzPublishObj = [dayz_characterID,_object,[_dir,_location],_classname];
	PVDZ_obj_Publish = [dayz_characterID,_object,[_dir,_location],_classname,_playerUID];
	publicVariableServer "PVDZ_obj_Publish";
		if (isServer) then {
			PVDZ_obj_Publish call server_publishObj;
		};
	} else {
	detach _object;
	deletevehicle _object; 
	cutText ["You need the EXACT amount of whatever you are trying to build without extras.", "PLAIN DOWN"];call _funcExitScriptCombat;};
	
	player allowdamage true;
	procBuild = false;_playerCombat setVariable["startcombattimer", 1, true];
