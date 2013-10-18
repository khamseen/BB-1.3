_object = _this select 3;



rotateDir = rotateDir + rotateIncrement;
if(rotateDir >= 360) then {
	rotateDir = 0;
};

_object setDir (getDir player) + rotateDir ;
