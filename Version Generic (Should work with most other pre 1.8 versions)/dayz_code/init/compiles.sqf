
//Custom Self Actions File
fnc_usec_selfActions 				= compile preprocessFileLineNumbers "dayz_code\compile\fn_selfActions.sqf";

//Base Building 1.3 Specific Compiles
player_build 						= compile preprocessFileLineNumbers "dayz_code\compile\player_build.sqf";
antiWall 							= compile preprocessFileLineNumbers "dayz_code\compile\antiWall.sqf";
anti_discWall 						= compile preprocessFileLineNumbers "dayz_code\compile\anti_discWall.sqf";
refresh_build_recipe_dialog 		= compile preprocessFileLineNumbers "buildRecipeBook\refresh_build_recipe_dialog.sqf";
refresh_build_recipe_list_dialog 	= compile preprocessFileLineNumbers "buildRecipeBook\refresh_build_recipe_list_dialog.sqf";
add_UIDCode  						= compile preprocessFileLineNumbers "dayz_code\external\keypad\fnc_keyPad\functions\add_UIDCode.sqf";
remove_UIDCode  					= compile preprocessFileLineNumbers "dayz_code\external\keypad\fnc_keyPad\functions\remove_UIDCode.sqf";

//Determine camoNet since camoNets cannot be targeted with Crosshair
getNetting = {
	if (isNull _obj) then {
		switch (true) do
		{
			case(camoNetB_East distance player < 10 && isNull _obj):
			{
				_obj = camoNetB_East;
			};
			case(camoNetVar_East distance player < 10 && isNull _obj):
			{
				_obj = camoNetVar_East;
			};
			case(camoNet_East distance player < 10 && isNull _obj):
			{
				_obj = camoNet_East;
			};
			case(camoNetB_Nato distance player < 10 && isNull _obj):
			{
				_obj = camoNetB_Nato;
			};
			case(camoNetVar_Nato distance player < 10 && isNull _obj):
			{
				_obj = camoNetVar_Nato;
			};
			case(camoNet_Nato distance player < 10 && isNull _obj):
			{
				_obj = camoNet_Nato;
			};
		};
	};
	_obj
};
