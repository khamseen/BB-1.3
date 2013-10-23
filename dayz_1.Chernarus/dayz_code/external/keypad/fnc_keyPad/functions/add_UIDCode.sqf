private ["_cntBases","_isOk","_allFlags","_panel","_convertInput","_authorizedPUID"];
	_isOk = true;
	//[_panel, _convertInput, globalAuthorizedUID] call add_UIDCode;		
	addUIDCode = false;
	_panel 			= _this select 0;
	_convertInput 	= _this select 1;
	//globalAuthorizedUID 	= _this select 3;
	for "_i" from 0 to (count _convertInput - 1) do {_convertInput set [_i, (_convertInput select _i) + 48]};
	if ((toString _convertInput) in _authorizedPUID) exitWith 
	{
		CODEINPUT = [];
		cuttext [format["PlayerUID %1 already in\nobject %2\n with UID: %3", (toString _convertInput), typeOf(_panel), str(keyCode)],"PLAIN DOWN",1];
		hint format["PlayerUID %1 already in\nobject %2\n with UID: %3", (toString _convertInput), typeOf(_panel), str(keyCode)];
	};
	_cntBases = 0;
	_allFlags = nearestObjects [player, ["FlagCarrierUSA"], 24000];
	{
		if (typeOf(_x) == "FlagCarrierUSA") then {
			_authorizedUID = _x getVariable ["AuthorizedUID", []];
			_authorizedOUID = _authorizedUID select 0;
			_authorizedPUID = _authorizedUID select 1;
				//diag_log ("3 add_UIDCode flag checks whole UID" + str(_authorizedUID));
				//diag_log ("3 add_UIDCode flag checks OUID" + str(_authorizedOUID));
				//diag_log ("3 add_UIDCode flag checks PUID" + str(_authorizedPUID));
			if ((toString _convertInput) in _authorizedPUID && (typeOf(_x) == "FlagCarrierUSA")) exitWith {
				_isOk = false;
				_cntBases = _cntBases + 1;
			};
		};
		if (!_isOk) exitWith {};
	} foreach _allFlags;
	if (!_isOk && _cntBases <= 3) exitWith {
		cuttext [format["PlayerUID %1 already used on 3 flags!", (toString _convertInput)],"PLAIN DOWN",1];
		hint format["PlayerUID %1 already used on 3 flags!", (toString _convertInput)];
	};
	_authorizedUID = _panel getVariable ["AuthorizedUID", []]; //Get's whole array stored for object
	_authorizedOUID = _authorizedUID select 0; //Sets objectUID as first element
	_authorizedPUID = _authorizedUID select 1; //Sets playerUID as second element
	_authorizedPUID set [count _authorizedPUID, (toString _convertInput)]; //Updates playerUID element with new code
	_updatedAuthorizedUID = ([_authorizedOUID] + [_authorizedPUID]); //Recombines the arrays
	//diag_log ("4 add_UIDCode what's being passed to updateObject whole UID" + str(_updatedAuthorizedUID));
	_panel setVariable ["AuthorizedUID", _updatedAuthorizedUID, true]; //Writes the updates array to the variable for passing to server_updateObject
	//diag_log ("4 add_UIDCode what's being passed to updateObject whole UID" + str(_authorizedUID));
	//diag_log ("4 add_UIDCode what's being passed to updateObject OUID" + str(_authorizedOUID));
	//diag_log ("4 add_UIDCode what's being passed to updateObject PUID" + str(_authorizedPUID));
	// Update to database
	PVDZ_veh_Save = [_panel,"gear"];
	publicVariableServer "PVDZ_veh_Save";
	if (isServer) then {
		PVDZ_veh_Save call server_updateObject;
	};
	hint format["PlayerUID %1 access granted to\nobject %2 with UID: %3", (toString _convertInput), typeOf(_panel), str(keyCode)];
	sleep 10;
	hint "";
	//cuttext [format["PlayerUID %1 access granted to\nobject %2 with UID: %3", (toString _convertInput), typeOf(_panel), str(keyCode)],"PLAIN DOWN",1];
	CODEINPUT = [];
