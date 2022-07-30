package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

// I AM THAT DESESPERATE
class StartLaser extends FlxSprite
{
	var startDir:Int;

	public function new(x:Float, y:Float)
	{
		super(x, y - 18);
		loadGraphic("assets/images/turretBase.png", true, 64, 32);
		animation.add("normal", [0, 1, 2], 12, true);
		animation.play("normal");

		setSize(32, 18);
		offset.set(0, 14); // if (startDir != null) {}
	}
}
