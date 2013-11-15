//Original Script created by Andrew Gregory aka axeman axeman@thefreezer.co.uk
//Edited by Rosska85 for use with DayZ Base Building 1.3
private ["_id","_lever","_doTowerLights","_nrTowers","_lCol","_lbrt","_lamb","_ndGen","_nrGen","_genCls","_doLit","_gnCnt","_getNearestBaseFlag","_nearestFlag","_nearestLightTowers","_twr","_twrPos","_rad","_oset","_nrTLs","_ang","_a","_b","_tl"];
_id = _this select 2;
_lever = _this select 3 select 0;
_doTowerLights = _this select 3 select 1;
_lever removeAction _id;
//####----####----Can edit these values----####----####
_lCol = [1, 0.88, 0.73]; // Colour of lights on tower when directly looked at | RGB Value from 0 to 1.
_lbrt = 0.04;//Brightness (also visible distance) of light source.
_lamb = [1, 0.88, 0.73]; // Colour of surrounding (ambient) light | RGB Value from 0 to 1.
_ndGen = true;//If true, a generator must be in range of the base flag for tower lights to work.
_genCls = "PowerGenerator_EP1";//Class name of generator (If you change this you'll need to add the new generator to the build list).
//####----####----End Edit Values----####----####

_getNearestBaseFlag = nearestObjects [_lever, ["FlagCarrierBIS_EP1"], BBFlagRadius];//Find the nearest base flag.
_nearestFlag = _getNearestBaseFlag select 0; //Selects the base flag from the returned array.
_nearestLightTowers = nearestObjects [_nearestFlag, ["Land_Ind_IlluminantTower"], BBFlagRadius];//Finds all towers in range of that flag.

_func_axeTL = {
	_twr = _this select 0;
	_twrPos =  getPos _twr;
	_rad=2.65;
	_oset=14;
	_nrTLs= position _twr nearObjects ["#lightpoint",30];
	if(count _nrTLs > 3)then{
	{
		if(_doLit)then{
		_x setLightColor _lCol;
		_x setLightBrightness _lbrt;
		_x setLightAmbient _lamb;
		}else{
		deleteVehicle _x;
		};
	sleep .2;
	}forEach _nrTLs;
	}else{
		if(_doLit)then{
			for "_tls" from 1 to 4 do {
			_ang=(360 * _tls / 4)-_oset;
			_a = (_twrPos select 0)+(_rad * cos(_ang));
			_b = (_twrPos select 1)+(_rad * sin(_ang));
			_tl = "#lightpoint" createVehicle [_a,_b,(_twrPos select 2) + 26] ;
			_tl setLightColor _lCol;
			_tl setLightBrightness _lbrt;
			_tl setLightAmbient _lamb;
			_tl setDir _ang;
			_tl setVectorUp [0,0,-1];
			sleep .4;
			};
		};
	};
};
_nrTowers = _nearestLightTowers;
if (_doTowerLights) then {
	{
	_doLit=true;
		if(_ndGen)then{
		_nrGen = nearestObjects [_nearestFlag, ["FlagCarrierBIS_EP1"], BBFlagRadius];
		_gnCnt = count _nrGen;
			if(_gnCnt < 1)then{
			cutText ["You need to build a generator in range of the flag.","PLAIN DOWN"];
			_doLit=false;
			};
		};
	[_x] call _func_axeTl;
	}forEach _nrTowers;
} else {
	{
	_doLit=false;
	[_x] call _func_axeTL;
	}forEach _nrTowers;
};