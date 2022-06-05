class cfgVehicles {
	//["MineBase","MineGeneric","Static","All"]
	//configfile >> "CfgVehicles" >> "ATMine"

	class MineGeneric;
	class MineBase: MineGeneric {};
	class ATMine: MineBase {};

	class ATMineSmart: ATMine {
		scope = 2;

		displayName = "Smart AT Mine";
		descriptionShort = "Type: Smart Anti-tank mine <br />Rounds: 1<br />Used on: Ground";
		ammo = "ATMineSmart_Range_Ammo";

		class EventHandlers {
			class smartMine {
				init = "[_this select 0, 50, 3] spawn D37_fnc_smartMine;";
			};
		};

		editorPreview = "OPMine\Data\images\SmartMine.jpg";
	};

	//configfile >> "CfgVehicles" >> "ModuleMine_ATMine_F"
	//["ModuleMine_F","ModuleEmpty_F","Thing","All"]
	class ModuleEmpty_F;
	class ModuleMine_F: ModuleEmpty_F {
		class EventHandlers;
	};

	class ModuleMine_ATSmart: ModuleMine_F {
		author = "Dankan37";
		scopeCurator = 2;
		displayName = "Smart AT Mine";
		icon = "iconExplosiveAT";
		explosive = "ATMineSmart_Range_Ammo";

		class EventHandlers:EventHandlers {
			class myMod {
				init = "[(_this select 0)] spawn D37_fnc_specialPlacement;";
			}
		}
	};
};


