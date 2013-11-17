	player removeAction attachGroundAction;
    player removeAction finishAction;
    player removeAction restablishAction;
	hint "";
	if(bbCDReload == 1)then{missionNameSpace setVariable [format["%1",BBCustomDebug],true];[] spawn fnc_debug;bbCDReload=0;};
buildReady=true;
