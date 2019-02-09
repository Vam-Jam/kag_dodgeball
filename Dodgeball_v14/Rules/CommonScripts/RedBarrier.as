// red barrier before match starts

const f32 BARRIER_PERCENT = 0.005f;
bool barrier_set = false;

bool shouldBarrier(CRules@ this)
{
	CMap@ map = getMap();
	if(map.getMapName() == "Maps/db19.png")
	{
			return false;
	}
	else
	{
		return this.isIntermission() || this.isWarmup() || this.isBarrier() || this.isMatchRunning();
	}
}

void onTick(CRules@ this)
{
	if (shouldBarrier(this))
	{
		if (!barrier_set)
		{
			barrier_set = true;
			addBarrier();
		}

		f32 x1, x2, y1, y2;
		getBarrierPositions(x1, x2, y1, y2);
		const f32 middle = x1 + (x2 - x1) * 0.5f;

		CBlob@[] blobsInBox;
		if (getMap().getBlobsInBox(Vec2f(x1, y1), Vec2f(x2, y2), @blobsInBox))
		{
			for (uint i = 0; i < blobsInBox.length; i++)
			{
				CBlob @b = blobsInBox[i];
				if (b.hasTag("player") || b.hasTag("no barrier pass"))
				{
					Vec2f pos = b.getPosition();

					f32 f = b.getMass() * 5.0f;

					if (pos.x < middle)
					{
						b.AddForce(Vec2f(-f, -f * 0.1f));
					}
					else
					{
						b.AddForce(Vec2f(f, -f * 0.1f));
					}
				}
			}
		}
	}
	else
	{
	}
}

void Reset(CRules@ this)
{
	barrier_set = false;
}

void onRestart(CRules@ this)
{
	Reset(this);
}

void onInit(CRules@ this)
{
	Reset(this);
}

void onRender(CRules@ this)
{
	if (shouldBarrier(this))
	{
		f32 x1, x2, y1, y2;
		getBarrierPositions(x1, x2, y1, y2);
		GUI::DrawRectangle(getDriver().getScreenPosFromWorldPos(Vec2f(x1, y1)), getDriver().getScreenPosFromWorldPos(Vec2f(x2, y2)), SColor(150, 255, 153, 225)); //transpancey, blue, green, red
	}
}

void getBarrierPositions(f32 &out x1, f32 &out x2, f32 &out y1, f32 &out y2)
{
	CMap@ map = getMap();
	const f32 mapWidth = map.tilemapwidth * map.tilesize;
	const f32 mapMiddle = mapWidth * 0.505f;
	const f32 barrierWidth = BARRIER_PERCENT * mapWidth;
	x1 = mapMiddle - barrierWidth;
	x2 = mapMiddle + barrierWidth;
	y2 = map.tilemapheight * map.tilesize;
	y1 = -y2;
	y2 *= 2.0f;
}

/**
 * Adding the barrier sector to the map
 */

void addBarrier()
{
	CMap@ map = getMap();

	f32 x1, x2, y1, y2;
	getBarrierPositions(x1, x2, y1, y2);

	Vec2f ul(x1, y1);
	Vec2f lr(x2, y2);

	if (map.getSectorAtPosition((ul + lr) * 0.5, "barrier") is null)
		map.server_AddSector(Vec2f(x1, y1), Vec2f(x2, y2), "barrier");
}

/**
 * Removing the barrier sector from the map
 */

void removeBarrier()
{
	CMap@ map = getMap();

	f32 x1, x2, y1, y2;
	getBarrierPositions(x1, x2, y1, y2);

	Vec2f ul(x1, y1);
	Vec2f lr(x2, y2);

	map.RemoveSectorsAtPosition((ul + lr) * 0.5 , "barrier");
}