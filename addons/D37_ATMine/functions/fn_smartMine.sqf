_mine = param[0];
_radius = param[1, 50];
_nRounds = param[2, 3];

//Base
_pillar = createSimpleObject ["A3\Structures_F_Exp\Signs\Traffic\Bollard_01_F.p3d", position _mine];
_pillar attachTo [_mine, [0,0,0]];
_pillar setObjectScale 0.66;

//Values for mines
_propAlt = 0.3;
_propRadius = 0.05;
_angle = 360/_nRounds;

//Mines around the base
_propArray = [];
_mineModel =  "A3\Weapons_F\explosives\mine_AP_bouncing";
for "_i" from 0 to (_nRounds-1) do {
	_prop = createSimpleObject [_mineModel, position _mine];
	_prop attachTo [_mine, [_propRadius * cos(_angle * _i), _propRadius * sin(_angle * _i), _propAlt]];
	_propArray pushBack _prop;
};

//Fired ammo index
_i = 0;
while {(alive _mine) and (_i < _nRounds)} do {
	//Find stuff
	private _nearEntities = _mine nearEntities _radius;

	//Filter
	private _nearvehicles = _nearEntities select {!(_x isKindOf "Man") and !(_x isKindOf "Air")};

	//Filter active
	_nearvehicles = _nearvehicles select {speed _x > 10};

	//Filter alive
	_nearvehicles = _nearvehicles select {alive _x};

	if(count _nearvehicles > 0) then {
		//Select targets, priority to tanks
		_target = selectRandom _nearvehicles;
		_nearTanks = _nearvehicles select {(_x isKindOf "Tank")};
		if(count(_nearTanks) > 0) then {
			_target = selectRandom _nearTanks;
		};

		//Setup delay
		sleep random 2;
		
		//Remove one of the attached mines
		_chosenProp = (_propArray select 0);
		detach _chosenProp;
		deleteVehicle _chosenProp;
		_propArray deleteAt (_propArray find _chosenProp);
		_i = (_i + 1);

		//Pick the grenade from the launcher
		_pos = (position _mine);
		_pos set [0, (_pos select 0) + _propRadius * cos(_angle * _i)];
		_pos set [1, (_pos select 1) + _propRadius * sin(_angle * _i)];
		_pos set [2, (_pos select 2) + _propAlt];

		//Create grenade
		_grenade = "G_40mm_HE" createVehicle _pos;
		[_grenade, 90, 0] call BIS_fnc_setPitchBank;

		//Values for lead (mathlab says they are optimal)
		_v0 = 30;
		_dir = _grenade getDir _target;
		_tgtSpeed = velocity _target;

		//Simple lead algorithm
		_grenade setVelocityModelSpace [_v0 * sin(_dir) + (_tgtSpeed select 0), 
										_v0 * sin(60), 
										-_v0 * cos(_dir) - (_tgtSpeed select 1)];
		

		_pos = position _grenade;
		_time = time;
		//Timeout, Distance and vertical velocity
		while {(time - _time) < 3 and (_grenade distance2D _target > 5) and ((velocity _grenade) select 2 > 0)} do {
			//createSimpleObject ["A3\Structures_F_Heli\VR\Helpers\Sign_sphere10cm_F.p3d", _pos];
			_pos = getPosASL _grenade;
			sleep 0.05;
		};
		deleteVehicle _grenade;

		//Mine explosion 
		_exp = createMine ["APERSMine", _pos, [], 0];
		_exp setPosASL _pos;
		_exp setDamage 1;

		//Shell that fires
		_type = "Sh_125mm_APFSDS";
		_shell = _type createVehicle _pos;
		_shell setPosASL _pos;
		_shell setDir (_shell getDir _target);

		//Trigonometry
		_hTarget 	= (getPosASL _target) select 2;
		_hMissile 	= (getPosASL _shell) select 2;
		_deltaH 	= (_hMissile - _hTarget);
		_distance 	= _shell distance2d _target;
		_angle 		= _deltaH atan2 _distance;
		[_shell, -_angle, 0] call BIS_fnc_setPitchBank;

		//Some randomness + corrections
		_leadAngle = 2;
		_impSpeed = 350;
		_vertical = _impSpeed * sin(_leadAngle);
		_lateral = _impSpeed / 30;
		_shell setVelocityModelSpace [random[-_lateral,0,_lateral], _impSpeed, _vertical];

		//Set the crew to combat
		if(alive _target) then {
			{
				group _x setbehaviour "COMBAT";
			}forEach crew _target;
		};

		//Delay
		sleep  3;
	};
	sleep 0.1;
};

//cleanup
detach _pillar;
deleteVehicle _pillar;
{
	detach _x;
	deleteVehicle _x;
}forEach _propArray;

deleteVehicle _mine;
