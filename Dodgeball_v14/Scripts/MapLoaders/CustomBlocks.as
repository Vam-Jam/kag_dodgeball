
/**
 *	Template for modders - add custom blocks by
 *		putting this file in your mod with custom
 *		logic for creating tiles in HandleCustomTile.
 *
 * 		Don't forget to check your colours don't overlap!
 *
 *		Note: don't modify this file directly, do it in a mod!
 */

namespace CMap
{
	enum CustomTiles
	{
		//pick tile indices from here - indices > 256 are advised.
		tile_testblock = 384, //after 1 hour of trying to figure out the system i did it..
		tile_platleftcor = 387,
		tile_platleft = 388,
		tile_plat = 389,
		tile_platright = 390,
		tile_platrightcor = 391,
		tile_plattjunk = 392,
		tile_platdown = 393,
		tile_platdownend = 394,
	};
};

void HandleCustomTile(CMap@ map, int offset, SColor pixel)
{
	//change this in your mod
}
