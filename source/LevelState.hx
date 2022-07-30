package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.display.Sprite;
import openfl.filters.ShaderFilter;

class LevelState extends FlxState
{
	// Music and SFXs
	public static var curSong:FlxSound;

	// Level Data
	public var lvlTargetString:String = "";
	public var roomName:String = "";
	public var roomSong:String = "";
	public var ui:HUD;

	var roomDir:String;
	var roomScreens:RoomLoader;
	var rsTimer:Int = 200;
	var rscTimer:Int;

	// UI and Miscellaneous
	var posText:FlxText;

	// Level Decorations
	public var decoSprt:FlxSprite;

	// Entity Initialization
	public var player:Player;
	public var deadBots:FlxTypedGroup<DeadPlayer>;
	public var spk:Spikes;
	public var door:Door;
	public var btn:DoorButton;
	public var trt:Turret;
	public var playerSpawner:FlxSprite;

	// var deadPlayer:DeadPlayer;
	// Explosions and VFX
	// var explodeSpriteGroup:FlxTypedGroup<FlxSprite>;
	// For that one person who will check the source code i will say i apologyze for my sins again creation itself
	public var deadRobos:Int = 0;
	public var curRobo:Int = 0;
	public var playerPos:FlxPoint;
	public var levelnum:Int;
	public var goal:Goal;
	public var resetCounter:Int = 120;
	public var lvlUsag:Int;

	static public var turretBullets:FlxTypedGroup<FlxSprite>;

	var explodeSpriteGroup:FlxTypedGroup<FlxSprite>;

	var explodeSound:FlxSound;
	var openSound:FlxSound;
	var song:FlxSound;
	var pauseMenu:PauseState;
	var redo:Bool;

	public function new(_roomDir:String)
	{
		super();
		roomDir = _roomDir;
	}

	override public function create()
	{
		// Debug UI

		// Level Init and Adding entities.
		roomScreens = new RoomLoader(roomDir, this);

		add(roomScreens.backgroundGroup);
		add(roomScreens.decoGroup);
		add(roomScreens.foregroundTiles);
		add(roomScreens.groupObjects);

		// Camera Setup
		FlxG.cameras.bgColor = FlxColor.GRAY;

		camera.pixelPerfectRender = true;

		playerPos = new FlxPoint(player.x, player.y);

		camera.focusOn(playerPos);
		camera.follow(player, LOCKON, 0.08);

		Player.onVictory = false;

		ui = new HUD(lvlUsag, false);

		// Spawn

		playerSpawner = new FlxSprite(player.x, player.y).loadGraphic("assets/images/spawner.png", false, 64, 64);

		// Player Setup

		add(player.walljumpCheckL);
		add(player.walljumpCheckR);

		rscTimer = rsTimer;

		// Dead Bots

		deadBots = new FlxTypedGroup<DeadPlayer>();

		for (i in 0...15)
		{
			var deadUsagi = new DeadPlayer(player.x, player.y, "land");
			deadUsagi.exists = false;
			deadBots.add(deadUsagi);
		}

		// Turret Bullets

		turretBullets = new FlxTypedGroup<FlxSprite>();

		for (i in 0...50)
		{
			var bullet = new FlxSprite(-100, -100).loadGraphic("assets/images/bullet.png", true, 14, 14);
			bullet.animation.add("p", [0, 1], 12, true);
			bullet.animation.play("p");
			bullet.exists = false;
			turretBullets.add(bullet);
		}

		// Explosions

		explodeSpriteGroup = new FlxTypedGroup<FlxSprite>();

		for (i in 0...4)
		{
			var explosionSprite:FlxSprite;
			explosionSprite = new FlxSprite(0, 0).loadGraphic("assets/images/explode.png", true, 80, 50);
			explosionSprite.animation.add("Explode", [0, 1, 2, 3, 4, 5, 6, 7, 8], 12, false);
			explosionSprite.exists = false;
			explodeSpriteGroup.add(explosionSprite);
		}

		add(playerSpawner);
		add(deadBots);
		add(explodeSpriteGroup);
		add(turretBullets);
		add(ui);

		// Sound Effects

		explodeSound = new FlxSound();
		explodeSound = FlxG.sound.load("assets/music/explosion.wav", 0.04);

		openSound = new FlxSound();
		openSound = FlxG.sound.load("assets/music/open.wav", 0.3, false);

		song = new FlxSound();
		song = FlxG.sound.load("assets/music/level.mp3", 0.35, true);
		song.play();

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// Collissions

		if (!ui.doneOpening)
			ui.openTransition();

		roomScreens.collideWithLevel(player);

		if (player != null)
		{
			player.leftWallOverlap = player.isTouching(FlxObject.LEFT);
			player.rightWallOverlap = player.isTouching(FlxObject.RIGHT);
		}

		if (player.overlaps(goal) && player.MODE == "land")
		{
			Player.onVictory = true;
			FlxG.camera.zoom = 1.2;
			ui.victoryText.exists = true;

			if (resetCounter > 0)
			{
				resetCounter--;
			}
			else
			{
				ui.closeTransition();

				if (ui.done)
				{
					var target:Int = lvlUsag + 2;
					var trg:String = Std.string(target);
					FlxG.switchState(new LevelState("assets/data/0" + trg + ".tmx"));
				}
			}
		}

		for (dd in deadBots.members)
		{
			roomScreens.collideWithLevel(dd);
			FlxG.collide(player, dd);
			FlxG.collide(dd, roomScreens.doorGroup);
			FlxG.collide(dd, deadBots);

			if (!dd.isTouching(FlxObject.FLOOR))
				dd.canFall = true;
			else
				dd.canFall = false;
		}

		for (bullet in turretBullets)
		{
			FlxG.overlap(bullet, player, hitByProyectile);

			if (!bullet.isOnScreen())
				bullet.exists = false;
		}

		for (dr in roomScreens.doorGroup.members)
		{
			if (door.keepColliding)
			{
				FlxG.collide(dr, player);
			}

			if (dr.deadAmmount <= 0 && !dr.trigger)
				dr.exists = false;

			if (dr.trigger && dr.keepColliding)
				for (btn in roomScreens.buttonGroup)
				{
					if ((btn.id == dr.triggerid) && player.overlaps(btn))
					{
						switch (btn.id)
						{
							case 1:
								btn.animation.play("red-inactive");
							case 2:
								btn.animation.play("green-inactive");
							case 3:
								btn.animation.play("blue-inactive");
						}

						switch (dr.triggerid)
						{
							case 1:
								dr.animation.play("open-red");
							case 2:
								dr.animation.play("open-green");
							case 3:
								dr.animation.play("open-blue");
						}
						openSound.play();
						dr.keepColliding = false;
					}
				}
		}

		if ((FlxG.keys.justPressed.X || player.overlaps(roomScreens.spikeGroup) || player.overlaps(roomScreens.baseGroup))
			&& player.exists
			&& deadRobos < 5)
		{
			killRobo();
		}
		else if (deadRobos >= 5)
		{
			ui.completeText.exists = true;
			ui.subText.exists = true;

			if (FlxG.keys.justPressed.R)
			{
				redo = true;
			}

			if (redo)
			{
				ui.closeTransition();

				if (ui.done)
				{
					var target:Int = lvlUsag + 1;
					var trg:String = Std.string(target);
					FlxG.switchState(new LevelState("assets/data/0" + trg + ".tmx"));
				}
			}
		}

		if (!player.exists && deadRobos < 5)
		{
			// Dear god this is so unoptimal but we have no time to waste

			if (rscTimer > 0)
				rscTimer--;
			else
			{
				player.reset(playerPos.x, playerPos.y);
				rscTimer = rsTimer;
				curRobo++;
				switch (ui.bunnyOrder[ui.lvlid][curRobo])
				{
					case "l":
						player.MODE = "land";
					case "c":
						player.MODE = "climb";
					case "f":
						player.MODE = "flight";
				}
			}
		}

		if (FlxG.keys.justPressed.ESCAPE && !Player.onVictory)
		{
			openPauseMenu();
		}

		for (exp in explodeSpriteGroup)
		{
			if (exp.exists && exp.animation.finished)
			{
				exp.exists = false;
			}
		}
	}

	function hitByProyectile(proyectile:FlxSprite, _player:Player)
	{
		proyectile.exists = false;
		killRobo();
	}

	public function openPauseMenu()
	{
		pauseMenu = new PauseState(FlxColor.TRANSPARENT, lvlUsag + 1);
		openSubState(pauseMenu);
	}

	function killRobo()
	{
		player.landSound.stop();
		player.climbSound.stop();
		player.flightSound.stop();

		var dd:DeadPlayer = deadBots.recycle();
		explodeSound.play();
		deadRobos++;

		var explosion:FlxSprite = explodeSpriteGroup.recycle();
		explosion.exists = true;
		explosion.reset(player.x + (player.width - explosion.width) / 2, player.y + (player.height - explosion.height) / 2);
		explosion.animation.play("Explode");

		switch (player.MODE)
		{
			case "land":
				dd.setPosition(player.x, player.y - 8);
				dd.type = "land";
			case "climb":
				dd.setPosition(player.x, player.y - 8);
				dd.type = "climb";

				if (player.onClimb)
				{
					dd.isClimb = true;
					dd.canFall = false;
					if (player.leftWallOverlap)
					{
						dd.angle = 90;
						dd.offset.set(0, 15);
					}
					if (player.rightWallOverlap)
					{
						dd.angle = 270;
						dd.offset.set(15, 15);
					}
				}
			case "flight":
				dd.setPosition(player.x, player.y - 8);
				dd.type = "flight";
				dd.canFall = false;
		}

		if (player.flipX)
			dd.flipX = true;
		else
			dd.flipX = false;

		add(dd);

		camera.shake(0.02, 0.1);
		player.exists = false;

		for (rb in roomScreens.doorGroup.members)
		{
			if (!rb.trigger)
			{
				rb.deadAmmount -= deadRobos;
			}
		}
	}
}
