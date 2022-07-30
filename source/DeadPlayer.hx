package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class DeadPlayer extends FlxSprite
{
	public var canFall:Bool = false;
	public var isClimb:Bool = false;
	public var type:String;

	public function new(x:Float, y:Float, _type:String)
	{
		super(x, y);
		loadGraphic("assets/images/dead-sheet.png", true, 40, 40);

		animation.add("land", [0], 12, true);
		animation.add("flight", [1, 2, 3, 4], 12, true);
		animation.add("climb", [5], 12, true);

		type = _type;
		immovable = false;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (canFall)
		{
			velocity.y += 4;
		}
		else
		{
			immovable = true;
		}

		if (immovable)
			velocity.y = 0;

		switch (type)
		{
			case "land":
				animation.play("land");
				setSize(25, 20);
				offset.set(8, 20);
			case "flight":
				animation.play("flight");
				setSize(24, 26);
				offset.set(8, 10);
			case "climb":
				animation.play("climb");

				if (isClimb)
				{
					if (flipX)
					{
						setSize(22, 20);
						offset.set(1, 10);
					}
					else
					{
						setSize(22, 20);
						offset.set(14, 10);
					}

					if (flipY)
					{
						setSize(22, 20);
						offset.set(10, 10);
					}
					else
					{
						setSize(22, 20);
						offset.set(4, 10);
					}
				}
				else
				{
					setSize(25, 20);
					offset.set(8, 20);
				}
		}
	}
}
