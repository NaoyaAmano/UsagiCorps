package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

// It's actually a laser but we have no time and my eyes are dry please have mercy on my soul
class Spikes extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y - 18);
		loadGraphic("assets/images/laser.png", true, 32, 32);
		animation.add("middle", [3, 4, 5], 12, true);
		animation.play("middle");

		setSize(32, 18);
		offset.set(0, 14); // if (startDir != null) {}
	}
}
