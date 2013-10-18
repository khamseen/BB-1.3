private["_character","_id","_lever","_authorizedUID","_allFlags","_leverAuth"];
_character = _this select 1;
_id = _this select 2;
_lever = _this select 3;
_allFlags = nearestObjects [_lever, ["FlagCarrierUSA"], 500];
		{
				_authorizedUID = _x getVariable ["AuthorizedUID", []];
				if ((getPlayerUid _character) in _authorizedUID && typeOf(_x) == "FlagCarrierUSA") exitWith {
					_leverAuth = _lever getVariable ["AuthorizedUID", []];
						{
							if (_x != (getPlayerUID player) && !(_x in _leverAuth)) then {
								_leverAuth set [count _leverAuth, _x];
							};
						} forEach _authorizedUID;
					if (count _leverAuth > 0) then {
						_lever setVariable ["AuthorizedUID", _leverAuth, true];
						// Send to database
						PVDZ_veh_Save = [_lever,"gear"];
						publicVariableServer "PVDZ_veh_Save";
					
						if (isServer) then {
							PVDZ_veh_Save call server_updateObject;
						};
					};
					if (count _leverAuth > 0) then {
						cutText [format["You gave access to the following base owners playerUIDs: %1",str(_leverAuth)], "PLAIN DOWN",1];
						hintsilent format["You gave access to the following base owners playerUIDs: %1",str(_leverAuth)];
					} else {
						cutText ["Everyone already has access to this object", "PLAIN DOWN"];
					};
				};
		} foreach _allFlags;

