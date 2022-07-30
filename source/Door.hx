package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.util.FlxColor;

class Door extends FlxSprite
{
	public var deadAmmount:Int;
	public var trigger:Bool;
	public var triggerid:Int;
	public var keepColliding:Bool = true;

	var openSound:FlxSound;

	public function new(x:Float, y:Float, ?_ammount:Int, ?_trigger:Bool, ?_triggerid:Int)
	{
		super(x, y - 44);

		deadAmmount = _ammount;
		trigger = _trigger;
		if (trigger != null)
			triggerid = _triggerid;

		immovable = true;

		loadGraphic("assets/images/doors.png", true, 32, 54);

		animation.add("4", [0, 1], 12, true);
		animation.add("3", [2, 3], 12, true);
		animation.add("2", [4, 5], 12, true);
		animation.add("1", [6, 7], 12, true);
		animation.add("locked-green", [8], 12, true);
		animation.add("open-green", [10], 12, true);
		animation.add("locked-red", [11], 12, true);
		animation.add("open-red", [13], 12, true);
		animation.add("locked-blue", [14], 12, true);
		animation.add("open-blue", [16], 12, true);

		if (trigger)
		{
			// Keys 1 = red, 2 = green, 3 = blue

			switch (triggerid)
			{
				case 1:
					animation.play("locked-red");
				case 2:
					animation.play("locked-green");
				case 3:
					animation.play("locked-blue");
			}
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (!trigger)
		{
			switch (deadAmmount)
			{
				case 4:
					animation.play("4");
				case 3:
					animation.play("3");
				case 2:
					animation.play("2");
				case 1:
					animation.play("1");
			}
		}
	}
}
