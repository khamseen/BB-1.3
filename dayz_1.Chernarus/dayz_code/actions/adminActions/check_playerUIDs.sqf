private["_obj","_authorizedUID"];
_obj = _this select 3;
_objectID = _obj getVariable["ObjectID","0"];
//_objectUID = _obj getVariable["ObjectUID","0"];
_authorizedUID = _obj getVariable ["AuthorizedUID", []];
_authorizedOUID = (_authorizedUID select 0) select 0;
_authorizedPUID = _authorizedUID select 1;
//cutText [format["Object owner UIDs: %1\n_objectID: %2\n_objectUID: %3",str(_authorizedUID),str(_objectID),str(_authorizedOUID)], "PLAIN DOWN",1];
bbCDebug = call compile format ["%1",bbCustomDebug];
if (bbCDebug) then {missionNameSpace setVariable [format["%1",bbCustomDebug],false]; hintSilent ""; bbCDReload = 1;};
hintsilent format["Object owner UIDs: %1\n_objectID: %2\n_objectUID: %3",str(_authorizedPUID),str(_objectID),str(_authorizedOUID)];
player removeaction s_check_playerUIDs;
s_check_playerUIDs = -1;
sleep 10;
hint "";
if(bbCDReload == 1)then{missionNameSpace setVariable [format["%1",bbCustomDebug],true];[] spawn fnc_debug;bbCDReload=0;};