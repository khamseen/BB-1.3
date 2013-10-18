
//Custom Self Actions File
fnc_usec_selfActions = compile preprocessFileLineNumbers "dayz_code\compile\fn_selfActions.sqf";

//Base Building 1.3 Specific Compiles
player_build2 			= compile preprocessFileLineNumbers "dayz_code\compile\player_build2.sqf";
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