/*
This script allows players to remove player UIDs from object so that 
they may no longer use the object
*/

private ["_displayok","_lever","_authorizedPUID"];
_lever = _this select 3;
accessedObject = _lever;
//globalAuthorizedUID = _lever getVariable ["AuthorizedUID", []];
_authorizedUID = _lever getVariable ["AuthorizedUID", []];
_authorizedPUID = _authorizedUID select 1;
keyCode = _lever getVariable ["ObjectUID","0"];
_displayok = createdialog "KeypadGate";
removeUIDCode = true;
//Show current UIDs until new UID is removed
while {removeUIDCode} do {
//cuttext [format["All Player UID(s): %1\nType ONE UID in Keypad to remove", str(_authorizedPUID)],"PLAIN DOWN",1];
//hintsilent format["All Player UID(s): %1\nType ONE UID in Keypad to remove", str(_authorizedPUID)];
hintsilent parseText format ["
		<t align='center' color='#0074E8'>Current Player UID(s):</t><br/>
		<t align='center'>%1</t><br/><br/>
		<t align='center' color='#F5CF36'>Enter UID of player you would like to REMOVE access from object: %2</t><br/><br/>
		<t align='left' color='#0074E8'>Object UID:</t>	<t align='right'>%3</t><br/>
		",str(_authorizedPUID), typeOf(_lever), str(keyCode)];
sleep 3;
if (!removeUIDCode) exitwith {};
sleep 15;
hint "";
};