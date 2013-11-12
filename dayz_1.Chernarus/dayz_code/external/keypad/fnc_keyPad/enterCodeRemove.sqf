/*
This script allows players to remove player UIDs from object so that 
they may no longer use the object
*/

private ["_displayok","_obj","_authorizedPUID"];
_obj = _this select 3;
if (isNull _obj) then {_obj = [] call getNetting;};
accessedObject = _obj;
//globalAuthorizedUID = _obj getVariable ["AuthorizedUID", []];
_authorizedUID = _obj getVariable ["AuthorizedUID", []];
_authorizedPUID = _authorizedUID select 1;
keyCode = _obj getVariable ["ObjectUID","0"];
_displayok = createdialog "KeypadGate";
removeUIDCode = true;
//Show current UIDs until new UID is removed
while {removeUIDCode} do {
bbCDebug = call compile format ["%1",bbCustomDebug];
if (bbCDebug) then {missionNameSpace setVariable [format["%1",bbCustomDebug],false]; hintSilent ""; bbCDReload = 1;};
hintsilent parseText format ["
		<t align='center' color='#0074E8'>Current Player UID(s):</t><br/>
		<t align='center'>%1</t><br/><br/>
		<t align='center' color='#F5CF36'>Enter UID of player you would like to REMOVE access from object: %2</t><br/><br/>
		<t align='left' color='#0074E8'>Object UID:</t>	<t align='right'>%3</t><br/>
		",str(_authorizedPUID), typeOf(_obj), str(keyCode)];
sleep 3;
if (!removeUIDCode) exitwith {};
};
};