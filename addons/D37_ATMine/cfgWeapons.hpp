class cfgWeapons {
	class Put {
		class MineMuzzle;
		class MineSmartMuzzle: MineMuzzle {
			magazines[] = {"ATMineSmart_Range_Mag"};
			class EventHandlers {
				fired = "[(_this select 6),50, 3] spawn D37_fnc_smartMine;";
			};
		};

		muzzles[] += {"MineSmartMuzzle"};
	};
};
