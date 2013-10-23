/*
This script allows players to add player UIDs to the object 
so that they may use the object as well
*/

private ["_displayok","_lever","_authorizedPUID"];
_lever = _this select 3;
//keyCode = _lever getVariable ["ObjectUID","0"];
// globalAuthorizedUID is the playerUID that is being checked 
globalAuthorizedUID = _lever getVariable ["AuthorizedUID", []];
keyCode = (globalAuthorizedUID select 0) select 0;
_authorizedPUID = globalAuthorizedUID select 1;
accessedObject = _lever;

_displayok = createdialog "KeypadGate";
addUIDCode = true;
//Show current UIDs until new UID is added
while {addUIDCode} do {
//cuttext [format["All Current Player UID(s): %1\nEnter Player UID you would like to give access to\nobject: %2\nwith UID: %3",str(_authorizedPUID), typeOf(_lever), keyCode],"PLAIN DOWN",1];
hint format["All Current Player UID(s): %1\nEnter Player UID you would like to give access to object: %2\nwith UID: %3",str(_authorizedPUID), typeOf(_lever), str(keyCode)];
sleep 3;
if (!addUIDCode) exitwith {};
};