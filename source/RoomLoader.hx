package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.editors.tiled.TiledLayer.TiledLayerType;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledTileSet;
import flixel.addons.tile.FlxTilemapExt;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import haxe.io.Path;

class RoomLoader extends TiledMap
{
	inline static var c_PATH_LEVEL_TILESHEETS = "assets/tiled/";
	inline static var c_PATH_LEVEL_LEVELDATA = "assets/data/";
	inline static var c_PATH_LEVEL_MUSICDATA = "assets/music/";

	// Decorative Images
	var decoSprite:FlxSprite;

	public var decoGroup:FlxGroup;

	// Array of tilemaps used for collision
	public var foregroundTiles:FlxGroup;
	public var groupObjects:FlxGroup;
	public var backgroundGroup:FlxGroup;

	public var spikeGroup:FlxTypedGroup<Spikes>;
	public var doorGroup:FlxTypedGroup<Door>;
	public var buttonGroup:FlxTypedGroup<DoorButton>;
	public var turretGroup:FlxTypedGroup<Turret>;
	public var baseGroup:FlxTypedGroup<StartLaser>;

	// I need to make a group for every enemy since individually they cannot act as a group.
	// I straight up ahead don't know how optimal is this sorry :[
	// Transition Triggers
	public var collidableTileLayers:Array<FlxTilemap>;

	public function new(tiledLevel:FlxTiledMapAsset, state:LevelState)
	{
		super(tiledLevel);

		foregroundTiles = new FlxGroup();
		groupObjects = new FlxGroup();
		backgroundGroup = new FlxGroup();
		decoGroup = new FlxGroup();

		spikeGroup = new FlxTypedGroup<Spikes>();
		doorGroup = new FlxTypedGroup<Door>();
		buttonGroup = new FlxTypedGroup<DoorButton>();
		turretGroup = new FlxTypedGroup<Turret>();
		baseGroup = new FlxTypedGroup<StartLaser>();

		FlxG.camera.setScrollBoundsRect(0, 0, fullWidth, fullHeight, true);
		loadObjects(state);

		// Load Tilemaps

		for (layer in layers)
		{
			if (layer.type != TiledLayerType.TILE)
				continue;
			var tileLayer:TiledTileLayer = cast layer;

			// Getting the tileset from the tileset property, needs to be equal to the image name of the tileset without the extension in tiled

			var tileSheetName:String = tileLayer.properties.get("tileset");

			if (tileSheetName == null)
				throw "'tileset' property not defined for the '" + tileLayer.name + "' layer. Please add the property to the layer.";

			var tileSet:TiledTileSet = null;
			for (ts in tilesets)
			{
				if (ts.name == tileSheetName)
				{
					tileSet = ts;
					break;
				}
			}

			if (tileSet == null)
				throw "Tileset '"
					+ tileSheetName
					+ "' not found. Did you misspell the 'tilesheet' property in '"
					+ tileLayer.name
					+ "' layer?";

			var imagePath = new Path(tileSet.imageSource);
			var processedPath = c_PATH_LEVEL_TILESHEETS + imagePath.file + "." + imagePath.ext;

			// could be a regular FlxTilemap if there are no animated tiles
			var tilemap = new FlxTilemapExt();
			tilemap.loadMapFromArray(tileLayer.tileArray, width, height, processedPath, tileSet.tileWidth, tileSet.tileWidth, OFF, tileSet.firstGID, 1, 1);

			if (tileLayer.properties.contains("nocollide"))
			{
				foregroundTiles.add(tilemap);
			}
			else
			{
				if (collidableTileLayers == null)
					collidableTileLayers = new Array<FlxTilemap>();

				foregroundTiles.add(tilemap);
				collidableTileLayers.push(tilemap);
			}

			if (tileLayer.properties.contains("id"))
			{
				var lvlid:String = tileLayer.properties.get("id");
				var usag:Int = Std.parseInt(lvlid);
				state.lvlUsag = usag;
			}
		}
	}

	public function loadObjects(state:LevelState)
	{
		for (layer in layers)
		{
			final entityLayer:TiledObjectLayer = cast layer;
			final backgroundLayer:TiledObjectLayer = cast layer;
			final decoLayer:TiledObjectLayer = cast layer;

			if (layer.name == "Entities")
			{
				for (o in entityLayer.objects)
				{
					addEntities(state, o, entityLayer, groupObjects);
				}
			}
			else if (layer.name == "Background")
			{
				for (o in backgroundLayer.objects)
				{
					addBackgrounds(state, o, backgroundLayer, backgroundGroup);
				}
			}
			else if (layer.name == "Decorative")
			{
				for (o in decoLayer.objects)
				{
					addDecorations(state, o, decoLayer, decoGroup);
				}
			}
		}
	}

	function addEntities(state:LevelState, o:TiledObject, g:TiledObjectLayer, group:FlxGroup)
	{
		var x:Int = o.x;
		var y:Int = o.y;

		switch (o.type.toLowerCase())
		{
			case "spike":
				var _spk:Spikes;
				// This makes sure that the player from the level state is the same as here
				_spk = new Spikes(x, y);
				state.spk = _spk;
				spikeGroup.add(_spk);
				groupObjects.add(_spk);

			case "border_laser":
				var _lsr:StartLaser;
				// This makes sure that the player from the level state is the same as here
				_lsr = new StartLaser(x, y);

				if (o.flippedHorizontally)
					_lsr.flipX = true;
				else
					_lsr.flipX = false;

				baseGroup.add(_lsr);
				groupObjects.add(_lsr);

			case "goal":
				var _goal:Goal;
				// This makes sure that the player from the level state is the same as here
				_goal = new Goal(x, y);
				state.goal = _goal;
				groupObjects.add(_goal);

			case "turret":
				var _trt:Turret;
				// This makes sure that the player from the level state is the same as here

				var turretDir:String = o.properties.get("shootDir");
				var dir = Std.parseInt(turretDir);

				var baseDir:String = o.properties.get("baseDir");
				var bDir = Std.parseInt(turretDir);

				_trt = new Turret(x, y, dir, bDir);
				state.trt = _trt;
				turretGroup.add(_trt);
				groupObjects.add(_trt);
				groupObjects.add(_trt.turretBase);
				groupObjects.add(_trt.muzzle);

			case "button":
				var _btn:DoorButton;
				// This makes sure that the player from the level state is the same as here
				var buttonId:String = o.properties.get("id");
				var id = Std.parseInt(buttonId);

				_btn = new DoorButton(x, y, id);
				state.btn = _btn;
				buttonGroup.add(_btn);
				groupObjects.add(_btn);

			case "door":
				var _door:Door;

				// This will get redone once the jam is done

				// This makes sure that the player from the level state is the same as here

				var deadAm:String = o.properties.get("deadCondition");
				var am:Int = Std.parseInt(deadAm);
				var tg:Bool = o.properties.contains("trigger");
				var triggerID:String = o.properties.get("id");
				var id:Int = Std.parseInt(triggerID); // This serves to link which button is linked to a door

				_door = new Door(x, y, am, tg, id);
				state.door = _door;
				doorGroup.add(_door);
				groupObjects.add(_door);

			//	Player
			case "_hero":
				var hero:Player;
				// This makes sure that the player from the level state is the same as here
				hero = new Player(x, y);
				state.player = hero;
				groupObjects.add(hero);
		}
	}

	function addBackgrounds(state:LevelState, o:TiledObject, g:TiledObjectLayer, group:FlxGroup)
	{
		var x:Int = o.x;
		var y:Int = o.y;

		var xPrlx:Float = 0.0;
		var yPrlx:Float = 0.0;
		var cvt:String;
		var bPath:String = "assets/images/";
		var bName:String = o.name;

		if (o.properties.contains("xParallax"))
		{
			cvt = o.properties.get("xParallax");
			xPrlx = Std.parseFloat(cvt);
		}

		if (o.properties.contains("yParallax"))
		{
			cvt = o.properties.get("yParallax");
			yPrlx = Std.parseFloat(cvt);
		}

		var bg:FlxSprite = new FlxSprite(x, y - o.height).loadGraphic(bPath + bName + ".png", o.width, o.height);

		if (bg != null)
		{
			if (o.flippedHorizontally)
				bg.flipX = true;

			bg.scrollFactor.set(xPrlx, yPrlx);
			// state.backg = bg;
			backgroundGroup.add(bg);
		}
		else
		{
			FlxG.log.advanced("Background not Found");
		}
	}

	function addDecorations(state:LevelState, o:TiledObject, g:TiledObjectLayer, group:FlxGroup)
	{
		var x:Int = o.x;
		var y:Int = o.y;

		var imagePath:String = "assets/images/level_assets/decorations/";
		var decoName:String = o.name;

		decoSprite = new FlxSprite(x, y - o.height).loadGraphic(imagePath + decoName + ".png", false, o.width, o.height);

		if (decoSprite == null)
			FlxG.log.advanced("Image not Found");

		if (o.flippedHorizontally)
			decoSprite.flipX = true;

		state.decoSprt = decoSprite;
		decoGroup.add(decoSprite);
	}

	// Collision Handling, make sure to collide the map with objects and not the other way around

	public function collideWithLevel(obj:FlxObject, ?notifyCallback:FlxObject->FlxObject->Void, ?processCallback:FlxObject->FlxObject->Bool):Bool
	{
		if (collidableTileLayers == null)
			return false;

		for (map in collidableTileLayers)
		{
			if (FlxG.overlap(map, obj, notifyCallback, processCallback != null ? processCallback : FlxObject.separate))
			{
				return true;
			}
		}
		return false;
	}
}
