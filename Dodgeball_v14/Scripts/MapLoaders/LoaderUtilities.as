// LoaderUtilities.as

#include "DummyCommon.as";

bool onMapTileCollapse(CMap@ map, u32 offset)
{
	if(isDummyTile(map.getTile(offset).type))
	{
		CBlob@ blob = getBlobByNetworkID(server_getDummyGridNetworkID(offset));
		if(blob !is null)
		{
			blob.server_Die();
		}
	}
	return true;
}

/*
TileType server_onTileHit(CMap@ this, f32 damage, u32 index, TileType oldTileType)
{
}
*/

void onSetTile(CMap@ map, u32 index, TileType tile_new, TileType tile_old)
{
	if(isDummyTile(tile_new))
	{
		map.SetTileSupport(index, 10);

		switch(tile_new)
		{
			case Dummy::SOLID:
			case Dummy::OBSTRUCTOR:
				map.AddTileFlag(index, Tile::SOLID | Tile::COLLISION);
				break;
			case Dummy::BACKGROUND:
			case Dummy::OBSTRUCTOR_BACKGROUND:
				map.AddTileFlag(index, Tile::BACKGROUND | Tile::LIGHT_PASSES | Tile::WATER_PASSES);
				break;
			case Dummy::LADDER:
				map.AddTileFlag(index, Tile::BACKGROUND | Tile::LIGHT_PASSES | Tile::LADDER | Tile::WATER_PASSES);
				break;
			case Dummy::PLATFORM:
				map.AddTileFlag(index, Tile::PLATFORM);
				break;
		}
	}

	switch(tile_new)
	{
		case CMap::tile_testblock:
		map.AddTileFlag(index, Tile::COLLISION | Tile::SOLID);
		map.RemoveTileFlag(index, Tile::LIGHT_PASSES | Tile::WATER_PASSES | Tile::LIGHT_SOURCE);
		break;

		case CMap::tile_platleftcor:
		map.AddTileFlag(index, Tile::COLLISION | Tile::SOLID);
		map.RemoveTileFlag(index, Tile::LIGHT_PASSES | Tile::WATER_PASSES | Tile::LIGHT_SOURCE);
		break;

		case CMap::tile_platleft:
		map.AddTileFlag(index, Tile::COLLISION | Tile::SOLID);
		map.RemoveTileFlag(index, Tile::LIGHT_PASSES | Tile::WATER_PASSES | Tile::LIGHT_SOURCE);
		break;

		case CMap::tile_plat:
		map.AddTileFlag(index, Tile::COLLISION | Tile::SOLID);
		map.RemoveTileFlag(index, Tile::LIGHT_PASSES | Tile::WATER_PASSES | Tile::LIGHT_SOURCE);
		break;

		case CMap::tile_platright:
		map.AddTileFlag(index, Tile::COLLISION | Tile::SOLID);
		map.RemoveTileFlag(index, Tile::LIGHT_PASSES | Tile::WATER_PASSES | Tile::LIGHT_SOURCE);
		break;

		case CMap::tile_platrightcor:
		map.AddTileFlag(index, Tile::COLLISION | Tile::SOLID);
		map.RemoveTileFlag(index, Tile::LIGHT_PASSES | Tile::WATER_PASSES | Tile::LIGHT_SOURCE);
		break;

		case CMap::tile_plattjunk:
		map.AddTileFlag(index, Tile::COLLISION | Tile::SOLID);
		map.RemoveTileFlag(index, Tile::LIGHT_PASSES | Tile::WATER_PASSES | Tile::LIGHT_SOURCE);
		break;

		case CMap::tile_platdown:
		map.AddTileFlag(index, Tile::COLLISION | Tile::SOLID);
		map.RemoveTileFlag(index, Tile::LIGHT_PASSES | Tile::WATER_PASSES | Tile::LIGHT_SOURCE);
		break;

		case CMap::tile_platdownend:
		map.AddTileFlag(index, Tile::COLLISION | Tile::SOLID);
		map.RemoveTileFlag(index, Tile::LIGHT_PASSES | Tile::WATER_PASSES | Tile::LIGHT_SOURCE);
		break;
	}
}
