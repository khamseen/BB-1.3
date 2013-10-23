private ["_finalInput","_panel","_convertInput","_authorizedPUID"];
	
	//[_panel, _convertInput, globalAuthorizedUID] call add_UIDCode;	
	removeUIDCode = false;	
	_panel 			= _this select 0;
	_convertInput 	= _this select 1;
	//globalAuthorizedUID 	= _this select 3;
	for "_i" from 0 to (count _convertInput - 1) do {_convertInput set [_i, (_convertInput select _i) + 48]};
	if (!((toString _convertInput) in _authorizedPUID)) exitWith 
	{
		CODEINPUT = [];
		cuttext [format["PlayerUID %1 not found in\nobject %2 with UID: %3", (toString _convertInput), typeOf(_panel), str(keyCode)],"PLAIN DOWN",1];
		hint format["PlayerUID %1  not found in\nobject %2 with UID: %3", (toString _convertInput), typeOf(_panel), str(keyCode)];
	};
	_finalInput = (toString _convertInput);
	_authorizedUID = _panel getVariable ["AuthorizedUID", []]; //Get's whole array stored for object
	_authorizedOUID = _authorizedUID select 0; //Sets objectUID as first element
	_authorizedPUID = _authorizedUID select 1; //Sets playerUID as second element
	_authorizedPUID = _authorizedPUID - [_finalInput];
	_updatedAuthorizedUID = ([_authorizedOUID] + [_authorizedPUID]); //Recombines the arrays
	//diag_log ("4 remove_UIDCode what's being passed to updateObject whole UID" + str(_updatedAuthorizedUID));
	_panel setVariable ["AuthorizedUID", _updatedAuthorizedUID, true];
	// Update to database
	PVDZ_veh_Save = [_panel,"gear"];
	publicVariableServer "PVDZ_veh_Save";
	if (isServer) then {
		PVDZ_veh_Save call server_updateObject;
	};
	hint format["PlayerUID %1 access removed from\nobject %2 with UID: %3", (toString _convertInput), typeOf(_panel), str(keyCode)];
	//cuttext [format["PlayerUID %1 access removed from\nobject %2 with UID: %3", (toString _convertInput), typeOf(_panel), str(keyCode)],"PLAIN DOWN",1];
	CODEINPUT = [];