private ["_flagCount","_isOk","_allFlags","_panel","_convertInput","_authorizedUID","_authorizedOUID","_authorizedPUID"];
	_isOk = true;
	//[_panel, _convertInput, globalAuthorizedUID] call add_UIDCode;		
	addUIDCode = false;
	_panel 			= _this select 0;
	_convertInput 	= _this select 1;
	//globalAuthorizedUID 	= _this select 3;
	_authorizedUID = _panel getVariable ["AuthorizedUID", []];
	_authorizedPUID = _authorizedUID select 1;
	for "_i" from 0 to (count _convertInput - 1) do {_convertInput set [_i, (_convertInput select _i) + 48]};
	if ((toString _convertInput) in _authorizedPUID) exitWith 
	{
		CODEINPUT = [];
		//cuttext [format["PlayerUID %1 already in\nobject %2\n with UID: %3", (toString _convertInput), typeOf(_panel), str(keyCode)],"PLAIN DOWN",1];
		//hint format["PlayerUID %1 already in\nobject %2\n with UID: %3", (toString _convertInput), typeOf(_panel), str(keyCode)];
		hintsilent parseText format ["
		<t align='center' color='#FF0000'>ERROR</t><br/><br/>
		<t align='center'>Player UID %1 already has access to object</t><br/>
		<t align='center'>%2</t><br/><br/>
		<t align='left'>Object UID:</t>	<t align='right'>%3</t><br/>
		",(toString _convertInput), typeOf(_panel), str(keyCode)];
		sleep 5;
		if(bbCDReload == 1)then{missionNameSpace setVariable [format["%1",bbCustomDebug],true];[] spawn fnc_debug;bbCDReload=0;};
	};
private ["_authorizedUID","_authorizedOUID","_authorizedPUID"]; //Reset here to prevent copying other object IDs
	_flagCount = 0;
	_allFlags = nearestObjects [player, ["FlagCarrierBIS_EP1"], 25000];
	{
		if (typeOf(_x) == "FlagCarrierBIS_EP1") then {
			_authorizedUID = _x getVariable ["AuthorizedUID", []];
			_authorizedOUID = _authorizedUID select 0;
			_authorizedPUID = _authorizedUID select 1;
				//diag_log ("3 add_UIDCode flag checks whole UID" + str(_authorizedUID));
				//diag_log ("3 add_UIDCode flag checks OUID" + str(_authorizedOUID));
				//diag_log ("3 add_UIDCode flag checks PUID" + str(_authorizedPUID));
			if ((toString _convertInput) in _authorizedPUID && (typeOf(_x) == "FlagCarrierBIS_EP1")) then {
				//_isOk = false;
				_flagCount = _flagCount + 1;
			};
		};
		//if (!_isOk) exitWith {};
	} foreach _allFlags;
	if (_flagCount >= MaxPlayerFlags) exitWith {
		//cuttext [format["PlayerUID %1 already used on 3 flags!", (toString _convertInput)],"PLAIN DOWN",1];
		//hint format["PlayerUID %1 already used on 3 flags!", (toString _convertInput)];
		hintsilent parseText format ["
		<t align='center' color='#FF0000'>ERROR</t><br/><br/>
		<t align='center'>Player UID %1 already used on %2 flags!</t><br/>
		",(toString _convertInput),MaxPlayerFlags];
		sleep 5;
		if(bbCDReload == 1)then{missionNameSpace setVariable [format["%1",bbCustomDebug],true];[] spawn fnc_debug;bbCDReload=0;};
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
	//hint format["PlayerUID %1 access granted to\nobject %2 with UID: %3", (toString _convertInput), typeOf(_panel), str(keyCode)];
	hintsilent parseText format ["
	<t align='center' color='#00FF3C'>SUCCESS</t><br/><br/>
	<t align='center'>Player UID %1 access granted to object</t>
	<t align='center'>%2</t><br/><br/><br/>
	<t align='left'>Object UID:</t>	<t align='right'>%3</t><br/>
	",(toString _convertInput), typeOf(_panel), str(keyCode)];
	sleep 10;
	hint "";
	if(bbCDReload == 1)then{missionNameSpace setVariable [format["%1",bbCustomDebug],true];[] spawn fnc_debug;bbCDReload=0;};
	//cuttext [format["PlayerUID %1 access granted to\nobject %2 with UID: %3", (toString _convertInput), typeOf(_panel), str(keyCode)],"PLAIN DOWN",1];
	CODEINPUT = [];
