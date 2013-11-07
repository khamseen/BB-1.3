_allFlags = nearestObjects [player, ["FlagCarrierBIS_EP1"], 25000];
_flagCount = 0;
_flagMarkerArr = [];
{
	if (typeOf(_x) == "FlagCarrierBIS_EP1") then {
		_authorizedUID = _x getVariable ["AuthorizedUID", []];
		_authorizedPUID = _authorizedUID select 1;
		if ((getPlayerUid player) in _authorizedPUID) then {
			_flagCount = _flagCount + 1;
			if (_flagCount < 1) then {
				cutText ["You are not registered on any base flags yet", "PLAIN DOWN"];
			};
			if (_flagCount >= 1) then {
					_flagname = format ["Flag_%1",_x];
					_flagMarker = createMarkerLocal [_flagName,position _x];       
					_flagMarker setMarkerTypeLocal "Town";
					_flagMarker setMarkerColorLocal("ColorGreen");
					_flagMarker setMarkerTextLocal format ["%1's Flag", (name player)];
					_flagMarkerArr = _flagMarkerArr + [_flagMarker];
				cutText ["Check your map for flag locations. These will clear after 10 seconds.", "PLAIN DOWN"];
			};
		};
	};
} foreach _allFlags;
sleep 10;
{
	deleteMarkerLocal _x
} forEach _flagMarkerArr;