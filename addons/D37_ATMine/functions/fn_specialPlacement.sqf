_mainObect = param[0];
_pos = position _mainObect;
_mine = objNull;
_i = 0;

sleep 0.05;
while{(isNull _mine) and (_i < 20)} do {
	sleep 0.05;
	_mine = _pos nearestObject "ATMineSmart_Range_Ammo";
	_isTaken = (_mine getVariable ["SRT_isTaken", false]);

	if(_isTaken) then {
		_mine = objNull;
	};

	_i = (_i + 1);
};

if(!(isNull _mine)) then {
	_mainObect setVariable ["SRT_isTaken", true];
	_mine setVariable ["SRT_isTaken", true];

	[_mine, 50, 3] spawn D37_fnc_smartMine;
};
