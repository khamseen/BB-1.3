private["_character","_id","_obj","_authorizedUID","_authorizedPUID","_allFlags","_objAuth"];
_character = _this select 1;
_id = _this select 2;
_obj = _this select 3;
if (isNull _obj) then {_obj = call getNetting;};
_allFlags = nearestObjects [_obj, ["FlagCarrierBIS_EP1"], 500];
		{
				_authorizedUID = _x getVariable ["AuthorizedUID", []];
				_authorizedPUID = _authorizedUID select 1;
				if ((getPlayerUid _character) in _authorizedPUID && typeOf(_x) == "FlagCarrierBIS_EP1") exitWith {
					_objAuthWhole = _obj getVariable ["AuthorizedUID", []];
					_objAuth = _objAuthWhole select 1;
						{
							if (_x != (getPlayerUID player) && !(_x in _objAuth)) then {
								_objAuth set [count _objAuth, _x];
							};
						} forEach _authorizedPUID;
					if (count _objAuth > 0) then {
						private ["_authorizedUID","_authorizedOUID","_authorizedPUID","_updatedAuthorizedUID"]; //Reset here to avoid taking whole flag array to new object
						_authorizedUID = _obj getvariable ["AuthorizedUID", []]; //Get object main array
						_authorizedOUID = _authorizedUID select 0; //Select only the objectUID array
						_updatedAuthorizedUID = ([_authorizedOUID] + [_objAuth]); //Combine objectUID array with new playerUIDs array
						_obj setVariable ["AuthorizedUID", _updatedAuthorizedUID, true];
						// Send to database
						PVDZ_veh_Save = [_obj,"gear"];
						publicVariableServer "PVDZ_veh_Save";
					
						if (isServer) then {
							PVDZ_veh_Save call server_updateObject;
						};
					};
					if (count _objAuth > 0) then {
						bbCDebug = missionNameSpace getVariable [format["%1",bbCustomDebug],false];
						if (bbCDebug) then {missionNameSpace setVariable [format["%1",bbCustomDebug],false]; hintSilent ""; bbCDReload = 1;};
						hintsilent parseText format ["
						<t align='center' color='#00FF3C'>SUCCESS</t><br/><br/>
						<t align='left'>You gave access to the following base owners player UIDs:</t><br/>
						<t align='left'>%1</t><br/>
						",str(_objAuth)];
						sleep 5;
						hint "";
						if(bbCDReload == 1)then{missionNameSpace setVariable [format["%1",bbCustomDebug],true];[] spawn fnc_debug;bbCDReload=0;};
					} else {
						bbCDebug = missionNameSpace getVariable [format["%1",bbCustomDebug],false];
						if (bbCDebug) then {missionNameSpace setVariable [format["%1",bbCustomDebug],false]; hintSilent ""; bbCDReload = 1;};
						cutText ["Everyone already has access to this object", "PLAIN DOWN"];
						sleep 5;
						hint "";
						if(bbCDReload == 1)then{missionNameSpace setVariable [format["%1",bbCustomDebug],true];[] spawn fnc_debug;bbCDReload=0;};
					};
				};
		} foreach _allFlags;
		sleep 10;
		hint "";

