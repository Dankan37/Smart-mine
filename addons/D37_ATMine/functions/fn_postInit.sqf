{
	if((typeOf _x) == "ATMineSmart_Range_Ammo") then {
		[_x, 50, 3] spawn D37_fnc_smartMine;
	};
}forEach allMines;