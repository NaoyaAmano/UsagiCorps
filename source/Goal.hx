package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Goal extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y - 64);
		loadGraphic("assets/images/reactor.png", true, 64, 64);
	}
}
