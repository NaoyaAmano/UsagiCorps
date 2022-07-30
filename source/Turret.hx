package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Turret extends FlxSprite
{
	var SPEED:Int = 200;
	var slowTimer:Int = 65;
	var curSlowTimer:Int;

	public var turretBase:FlxSprite;

	public var muzzle:FlxSprite;

	var shootDir:Int;
	var baseDir:Int;

	public function new(x:Float, y:Float, _dir:Int, _baseDir:Int)
	{
		super(x, y - 32);

		/*
			Key
			1 = Left
			2 = Up
			3 = Right
			4 = Down
		 */

		loadGraphic("assets/images/turret.png", true, 32, 32);

		turretBase = new FlxSprite(x, y - 32).loadGraphic("assets/images/base.png", true, 32, 32);
		muzzle = new FlxSprite(x - 12, y - 44).loadGraphic("assets/images/muzzle.png", true, 54, 54);

		animation.add("left", [0], 12, true);
		animation.add("up", [1], 12, true);
		animation.add("right", [2], 12, true);
		animation.add("down", [3], 12, true);

		turretBase.animation.add("down", [0], 12, true);
		turretBase.animation.add("left", [1], 12, true);
		turretBase.animation.add("up", [2], 12, true);
		turretBase.animation.add("right", [3], 12, true);

		muzzle.animation.add("left", [0, 1], 12, false);
		muzzle.animation.add("up", [2, 3], 12, false);
		muzzle.animation.add("right", [4, 5], 12, false);
		muzzle.animation.add("down", [6, 7], 12, false);
		muzzle.exists = false;

		shootDir = _dir;
		baseDir = _baseDir;

		switch (shootDir)
		{
			case 1:
				animation.play("left");
			case 2:
				animation.play("up");
			case 3:
				animation.play("right");
			case 4:
				animation.play("down");
		}

		switch (baseDir)
		{
			case 1:
				turretBase.animation.play("down");
			case 2:
				turretBase.animation.play("left");
			case 3:
				turretBase.animation.play("up");
			case 4:
				turretBase.animation.play("right");
		}

		curSlowTimer = slowTimer;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (curSlowTimer > 0)
		{
			curSlowTimer--;
			if (muzzle.animation.finished)
				muzzle.exists = false;
		}
		else
		{
			if (isOnScreen())
			{
				var proyectile:FlxSprite = LevelState.turretBullets.recycle();
				proyectile.exists = true;
				proyectile.reset(x, y + 8);

				muzzle.exists = true;

				switch (shootDir)
				{
					case 1:
						muzzle.animation.play("left");
						proyectile.velocity.set(SPEED * -1, 0);
					case 2:
						muzzle.animation.play("up");
						proyectile.velocity.set(0, -1 * SPEED);
					case 3:
						muzzle.animation.play("right");
						proyectile.velocity.set(SPEED * 1, 0);
					case 4:
						muzzle.animation.play("down");
						proyectile.velocity.set(0, SPEED * 1);
				}

				curSlowTimer = slowTimer;
			}
		}
	}
}
