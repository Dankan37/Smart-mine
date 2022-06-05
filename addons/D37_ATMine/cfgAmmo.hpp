class CfgAmmo {
	//configfile >> "CfgAmmo" >> "ATMine_Range_Ammo"
	//["MineBase","MineCore","TimeBombCore","Default"]
	class Default;
	class TimeBombCore: Default{};
	class MineCore: TimeBombCore {};
	class MineBase: MineCore {};
	class ATMine_Range_Ammo: MineBase {};

	class ATMineSmart_Range_Ammo: ATMine_Range_Ammo {
		defaultMagazine = "ATMineSmart_Range_Mag";
		displayName = "Smart AI Mine";
		hit = 10;
		armor = 0;
		explosive = 0;
		indirectHit = 0;
		indirectHitRange = 0;
		author = "Dankan37";
	};
};