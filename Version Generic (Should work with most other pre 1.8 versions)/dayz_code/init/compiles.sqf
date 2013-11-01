
//Custom Self Actions File
fnc_usec_selfActions = compile preprocessFileLineNumbers "dayz_code\compile\fn_selfActions.sqf";

//Base Building 1.3 Specific Compiles
player_build 			= compile preprocessFileLineNumbers "dayz_code\actions\player_build.sqf";
antiWall 				= compile preprocessFileLineNumbers "dayz_code\compile\antiWall.sqf";
anti_discWall 			= compile preprocessFileLineNumbers "dayz_code\compile\anti_discWall.sqf";
refresh_build_recipe_dialog 		= compile preprocessFileLineNumbers "buildRecipeBook\refresh_build_recipe_dialog.sqf";
refresh_build_recipe_list_dialog 	= compile preprocessFileLineNumbers "buildRecipeBook\refresh_build_recipe_list_dialog.sqf";
add_UIDCode  			= compile preprocessFileLineNumbers "dayz_code\external\keypad\fnc_keyPad\functions\add_UIDCode.sqf";
remove_UIDCode  		= compile preprocessFileLineNumbers "dayz_code\external\keypad\fnc_keyPad\functions\remove_UIDCode.sqf";

getNetting = {
	//Determine camoNet since camoNets cannot be targeted with Crosshair
	if (isNull _obj) then {
		switch (true) do
		{
			case(camoNetB_East distance player < 10 && isNull _obj):
			{
				_obj = camoNetB_East;
				//_objectID = _obj getVariable["ObjectID","0"];
				//_objectUID = _obj getVariable["ObjectUID","0"];
				//_ownerID = _obj getVariable ["characterID","0"];
			};
			case(camoNetVar_East distance player < 10 && isNull _obj):
			{
				_obj = camoNetVar_East;
				//_objectID = _obj getVariable["ObjectID","0"];
				//_objectUID = _obj getVariable["ObjectUID","0"];
				//_ownerID = _obj getVariable ["characterID","0"];
			};
			case(camoNet_East distance player < 10 && isNull _obj):
			{
				_obj = camoNet_East;
				//_objectID = _obj getVariable["ObjectID","0"];
				//_objectUID = _obj getVariable["ObjectUID","0"];
				//_ownerID = _obj getVariable ["characterID","0"];
			};
			case(camoNetB_Nato distance player < 10 && isNull _obj):
			{
				_obj = camoNetB_Nato;
				//_objectID = _obj getVariable["ObjectID","0"];
				//_objectUID = _obj getVariable["ObjectUID","0"];
				//_ownerID = _obj getVariable ["characterID","0"];
			};
			case(camoNetVar_Nato distance player < 10 && isNull _obj):
			{
				_obj = camoNetVar_Nato;
				//_objectID = _obj getVariable["ObjectID","0"];
				//_objectUID = _obj getVariable["ObjectUID","0"];
				//_ownerID = _obj getVariable ["characterID","0"];
			};
			case(camoNet_Nato distance player < 10 && isNull _obj):
			{
				_obj = camoNet_Nato;
				//_objectID = _obj getVariable["ObjectID","0"];
				//_objectUID = _obj getVariable["ObjectUID","0"];
				//_ownerID = _obj getVariable ["characterID","0"];
			};
		};
	};
	_obj
};

//Keybinds
	dayz_spaceInterrupt = {
		private "_handled";
		_dikCode = _this select 1;
		_shiftState = _this select 2;
		_ctrlState = _this select 3;
		_altState = _this select 4;
		_handled = false;
	//Keybinds for Base Building
		//Elevate NumPad 8
		if ((_dikCode == 0x48) && !_shiftState) then {
			DZ_BB_E = true;
			_handled = true;
		};
		//Lower NumPad 5
		if ((_dikCode == 0x4C) && !_shiftState) then {
			DZ_BB_L = true;
			_handled = true;
		};
		//Elevate Small shift + NumPad 8
		if (_dikCode == 0x48) then {
			DZ_BB_Es = true;
			_handled = true;
		};
		//Lower Small shift + NumPad 5
		if (_dikCode == 0x4C) then {
			DZ_BB_Ls = true;
			_handled = true;
		};
		//Rotate Left NumPad 7
		if ((_dikCode == 0x47) && !_shiftState) then {
			DZ_BB_Rl = true;
			_handled = true;
		};
		//Rotate Right NumPad 9
		if ((_dikCode == 0x49) && !_shiftState) then {
			DZ_BB_Rr = true;
			_handled = true;
		};
		//Rotate Left Small Shift + NumPad 7
		if (_dikCode == 0x47) then {
			DZ_BB_Rls = true;
			_handled = true;
		};
		//Rotate Right Small Shift + NumPad 9
		if (_dikCode == 0x49) then {
			DZ_BB_Rrs = true;
			_handled = true;
		};
		//Push Away NumPad 4
		if (_dikCode == 0x4B) then {
			DZ_BB_A = true;
			_handled = true;
		};
		//Pull Near NumPad 1
		if (_dikCode == 0x4F) then {
			DZ_BB_N = true;
			_handled = true;
		};
		//Move Left NumPad 2
		if (_dikCode == 0x50) then {
			DZ_BB_Le = true;
			_handled = true;
		};
		//Move Right NumPad 3
		if (_dikCode == 0x51) then {
			DZ_BB_Ri = true;
			_handled = true;
		};
		_handled
	};