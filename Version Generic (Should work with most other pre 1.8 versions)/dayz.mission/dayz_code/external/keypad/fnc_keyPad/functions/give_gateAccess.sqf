private["_character","_id","_lever","_authorizedUID","_authorizedPUID","_allFlags","_leverAuth"];
_character = _this select 1;
_id = _this select 2;
_lever = _this select 3;
_allFlags = nearestObjects [_lever, ["FlagCarrierBIS_EP1"], 500];
		{
				_authorizedUID = _x getVariable ["AuthorizedUID", []];
				_authorizedPUID = _authorizedUID select 1;
				if ((getPlayerUid _character) in _authorizedPUID && typeOf(_x) == "FlagCarrierBIS_EP1") exitWith {
					_leverAuthWhole = _lever getVariable ["AuthorizedUID", []];
					_leverAuth = _leverAuthWhole select 1;
						{
							if (_x != (getPlayerUID player) && !(_x in _leverAuth)) then {
								_leverAuth set [count _leverAuth, _x];
							};
						} forEach _authorizedPUID;
					if (count _leverAuth > 0) then {
						private ["_authorizedUID","_authorizedOUID","_authorizedPUID","_updatedAuthorizedUID"]; //Reset here to avoid taking whole flag array to new object
						_authorizedUID = _lever getvariable ["AuthorizedUID", []]; //Get object main array
						_authorizedOUID = _authorizedUID select 0; //Select only the objectUID array
						_updatedAuthorizedUID = ([_authorizedOUID] + [_leverAuth]); //Combine objectUID array with new playerUIDs array
						_lever setVariable ["AuthorizedUID", _updatedAuthorizedUID, true];
						// Send to database
						dayzUpdateVehicle = [_lever,"gear"];
						publicVariableServer "dayzUpdateVehicle";
					
						if (isServer) then {
							dayzUpdateVehicle call server_updateObject;
						};
					};
					if (count _leverAuth > 0) then {
						//cutText [format["You gave access to the following base owners playerUIDs: %1",str(_leverAuth)], "PLAIN DOWN",1];
						//hintsilent format["You gave access to the following base owners playerUIDs: %1",str(_leverAuth)];
						hintsilent parseText format ["
						<t align='center' color='#00FF3C'>SUCCESS</t><br/><br/>
						<t align='left'>You gave access to the following base owners player UIDs:</t><br/>
						<t align='left'>%1</t><br/>
						",str(_leverAuth)];
					} else {
						cutText ["Everyone already has access to this object", "PLAIN DOWN"];
					};
				};
		} foreach _allFlags;
		sleep 10;
		hint "";

