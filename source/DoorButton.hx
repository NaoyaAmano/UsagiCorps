package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class DoorButton extends FlxSprite
{
	public var id:Int;

	public function new(x:Float, y:Float, _id:Int)
	{
		super(x, y - 32);
		loadGraphic("assets/images/buttons.png", true, 32, 32);

		animation.add("blue-active", [0], 12, true);
		animation.add("blue-inactive", [1], 12, true);
		animation.add("red-active", [2], 12, true);
		animation.add("red-inactive", [3], 12, true);
		animation.add("green-active", [4], 12, true);
		animation.add("green-inactive", [5], 12, true);

		id = _id;

		// Keys 1 = red, 2 = green, 3 = blue

		switch (id)
		{
			case 1:
				animation.play("red-active");
			case 2:
				animation.play("green-active");
			case 3:
				animation.play("blue-active");
		}
	}
}
