private ["_cntBases","_isOk","_allFlags","_panel","_convertInput"];
	_isOk = true;
	//[_panel, _convertInput, globalAuthorizedUID] call add_UIDCode;		
	addUIDCode = false;
	_panel 			= _this select 0;
	_convertInput 	= _this select 1;
	//globalAuthorizedUID 	= _this select 3;
	for "_i" from 0 to (count _convertInput - 1) do {_convertInput set [_i, (_convertInput select _i) + 48]};
	if ((toString _convertInput) in globalAuthorizedUID) exitWith 
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
			if ((toString _convertInput) in _authorizedUID && (typeOf(_x) == "FlagCarrierUSA")) exitWith {
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
	globalAuthorizedUID set [count globalAuthorizedUID, (toString _convertInput)];
	_panel setVariable ["AuthorizedUID", globalAuthorizedUID, true];
	// Update to database
	PVDZ_veh_Save = [_panel,"gear"];
	publicVariableServer "PVDZ_veh_Save";
	if (isServer) then {
		PVDZ_veh_Save call server_updateObject;
	};
	hint format["PlayerUID %1 access granted to\nobject %2 with UID: %3", (toString _convertInput), typeOf(_panel), str(keyCode)];
	cuttext [format["PlayerUID %1 access granted to\nobject %2 with UID: %3", (toString _convertInput), typeOf(_panel), str(keyCode)],"PLAIN DOWN",1];
	CODEINPUT = [];
