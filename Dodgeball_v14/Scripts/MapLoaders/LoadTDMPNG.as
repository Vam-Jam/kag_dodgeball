// TDM PNG loader base class - extend this to add your own PNG loading functionality!

#include "BasePNGLoader.as";

const SColor color_tradingpost_1(0xff8888ff);
const SColor color_tradingpost_2(0xffff8888);
const SColor color_testblock(0xff8a7ba3);
const SColor color_platleftcor(0xff59aead);
const SColor color_platleft(0xff59c6ba);
const SColor color_plat(0xff569b99);
const SColor color_platright(0xff56adab);
const SColor color_platrightcor(0xff56a9b5);
const SColor color_plattjunk(0xff429aa8);
const SColor color_platdown(0xff43a4b3);
const SColor color_platdownend(0xff43b4bf);

//the loader

class TDMPNGLoader : PNGLoader
{

	TDMPNGLoader()
	{
		super();
	}

	//override this to extend functionality per-pixel.
	void handlePixel(SColor pixel, int offset)
	{
		PNGLoader::handlePixel(pixel, offset);

		// TRADING POST
		if (pixel == color_tradingpost_1)
		{
			spawnBlob(map, "tradingpost", offset, 0);
			offsets[autotile_offset].push_back(offset);
		}
		else if (pixel == color_tradingpost_2)
		{
			spawnBlob(map, "tradingpost", offset, 1);
			offsets[autotile_offset].push_back(offset);
		}
		else if (pixel == color_testblock)
		{
			map.SetTile(offset, CMap::tile_testblock);
		}
		else if (pixel == color_platleftcor)
		{
			map.SetTile(offset, CMap::tile_platleftcor);
		}
		else if (pixel == color_platleft)
		{
			map.SetTile(offset, CMap::tile_platleft);
		}
		else if (pixel == color_plat)
		{
			map.SetTile(offset, CMap::tile_plat);
		}
		else if (pixel == color_platright)
		{
			map.SetTile(offset, CMap::tile_platright);
		}
		else if (pixel == color_platrightcor)
		{
			map.SetTile(offset, CMap::tile_platrightcor);
		}
		else if (pixel == color_plattjunk)
		{
			map.SetTile(offset, CMap::tile_plattjunk);
		}
		else if (pixel == color_platdown)
		{
			map.SetTile(offset, CMap::tile_platdown);
		}
		else if (pixel == color_platdownend)
		{
			map.SetTile(offset, CMap::tile_platdownend);
		}
	}

	//override this to add post-load offset types.
	void handleOffset(int type, int offset, int position, int count)
	{
		PNGLoader::handleOffset(type, offset, position, count);
	}
}

// --------------------------------------------------

bool LoadMap(CMap@ map, const string& in fileName)
{
	print("LOADING TDM PNG MAP " + fileName);

	TDMPNGLoader loader();

	return loader.loadMap(map , fileName);
}
