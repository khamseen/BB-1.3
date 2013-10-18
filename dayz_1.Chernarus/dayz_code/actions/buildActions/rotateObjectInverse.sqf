_object = _this select 3;



rotateDir = rotateDir - rotateIncrement;
if(rotateDir <= 0) then {
	rotateDir = 360;
};

_object setDir (getDir player) + rotateDir ;
