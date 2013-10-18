private["_obj","_authorizedUID"];
_obj = _this select 3;
_objectID = _obj getVariable["ObjectID","0"];
_objectUID = _obj getVariable["ObjectUID","0"];
_authorizedUID = _obj getVariable ["AuthorizedUID", []];
cutText [format["Object owner UIDs: %1\n_objectID: %2\n_objectUID: %3",str(_authorizedUID),str(_objectID),str(_objectUID)], "PLAIN DOWN",1];
hintsilent format["Object owner UIDs: %1\n_objectID: %2\n_objectUID: %3",str(_authorizedUID),str(_objectID),str(_objectUID)];
player removeaction s_check_playerUIDs;
s_check_playerUIDs = -1;