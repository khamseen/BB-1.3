deleteMarkerLocal 'Flag 1';
deleteMarkerLocal 'Flag 2';
deleteMarkerLocal 'Flag 3';
_allFlags = nearestObjects [player, ["FlagCarrierBIS_EP1"], 25000];
_flagCount = 0;
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
				_flagMarker = createMarkerLocal ["Flag 1",position _x];       
				_flagMarker setMarkerTypeLocal "Town";
				_flagMarker setMarkerColorLocal("ColorGreen");
				_flagMarker setMarkerTextLocal format ["%1's Flag", (name player)];
				cutText ["Check your map for flag locations. These will clear after 10 seconds.", "PLAIN DOWN"];
				if (_flagCount >= 2) then {
					_flagMarker = createMarkerLocal ["Flag 2",position _x];
					_flagMarker setMarkerTypeLocal "Town";
					_flagMarker setMarkerColorLocal("ColorGreen");
					_flagMarker setMarkerTextLocal format ["%1's Flag", (name player)];
					if (_flagCount >= 3) then {
						_flagMarker = createMarkerLocal ["Flag 3",position _x];       
						_flagMarker setMarkerTypeLocal "Town";
						_flagMarker setMarkerColorLocal("ColorGreen");
						_flagMarker setMarkerTextLocal format ["%1's Flag", (name player)];
					};
				};
			};
		};
	};
} foreach _allFlags;
sleep 10;
deleteMarkerLocal 'Flag 1';
deleteMarkerLocal 'Flag 2';
deleteMarkerLocal 'Flag 3';