	
	_object = _this select 3 select 0;
	_className = _this select 3 select 1;
	_objectPos = _this select 3 select 2;
	_objectDir = _this select 3 select 3;
	player removeAction repositionAction;
	buildReady=false;
	deleteVehicle _object;
	_object = createVehicle [_classname, _objectPos, [], 0, "NONE"]; //Changed to NONE to avoid breaking legs or killing people whilst placing
	_object setDir _objectDir;
	call player_build2;
	bbCDebug = missionNameSpace getVariable [format["%1",BBCustomDebug],false];
	if (bbCDebug) then {missionNameSpace setVariable [format["%1",BBCustomDebug],false]; hintSilent ""; bbCDReload = 1;};