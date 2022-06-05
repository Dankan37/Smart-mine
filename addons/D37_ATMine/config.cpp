#include "BIS_AddonInfo.hpp"
class cfgPatches 
{
    class D37_scripts
    {
        units[] = {"ATMineSmart","ModuleMine_ATSmart"};
		weapons[] = {"MineSmartMuzzle"};
		requiredVersion = 0.1;
		requiredAddons[] = {"A3_Weapons_F_Explosives","A3_Modules_F_Curator_Mines","CuratorOnly_Modules_F_Curator_Mines"};
    };
};

#include "cfgFunctions.hpp"
#include "cfgVehicles.hpp"
#include "cfgAmmo.hpp"
#include "cfgMagazines.hpp"
#include "cfgWeapons.hpp"