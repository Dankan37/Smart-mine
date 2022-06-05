class cfgMagazines {
	//configfile >> "CfgMagazines" >> "ATMine_Range_Mag"
	//["CA_Magazine","Default"]
	class Default;
	class CA_Magazine: Default {};
	class ATMine_Range_Mag: CA_Magazine {};

	class ATMineSmart_Range_Mag: ATMine_Range_Mag {
		ammo = "ATMineSmart_Range_Ammo";
		descriptionShort = "Type: Smart Anti-tank mine <br />Rounds: 1<br />Used on: Ground";
		displayName = "Smart AT Mine";
		author = "Dankan37";
		editorPreview = "\A3\OPMine\Data\images\SmartMine.jpg";
		mass = 130;
	};
};