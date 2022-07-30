package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class HUD extends FlxTypedGroup<FlxSprite>
{
	var upBackground:FlxSprite;
	var downBackground:FlxSprite;

	public var hudBunnies:FlxTypedGroup<FlxSprite>;

	public var bunnyOrder:Array<Array<String>> = [];

	public var bunnyOrder1:Array<String> = ["l", "l", "l", "l", "l"];
	public var bunnyOrder2:Array<String> = ["l", "l", "l", "l", "l"];
	public var bunnyOrder3:Array<String> = ["l", "c", "c", "l", "l"];
	public var bunnyOrder4:Array<String> = ["l", "c", "c", "c", "l"];
	public var bunnyOrder5:Array<String> = ["f", "c", "f", "l", "l"];
	public var bunnyOrder6:Array<String> = ["l", "c", "f", "f", "l"];
	public var bunnyOrder7:Array<String> = ["l", "c", "f", "f", "l"];
	public var bunnyOrder8:Array<String> = ["f", "c", "c", "l", "l"];

	public var lvlid:Int;

	public var completeText:FlxText;
	public var subText:FlxText;
	public var victoryText:FlxText;

	public var leftOpening:FlxSprite;
	public var rightOpening:FlxSprite;
	public var done:Bool = false;
	public var doneOpening:Bool = false;

	public function new(levelId:Int, _select:Bool)
	{
		super();

		lvlid = levelId;

		bunnyOrder = [
			bunnyOrder1,
			bunnyOrder2,
			bunnyOrder3,
			bunnyOrder4,
			bunnyOrder5,
			bunnyOrder6,
			bunnyOrder7,
			bunnyOrder8
		];

		upBackground = new FlxSprite(0, 0).makeGraphic(FlxG.width, 64, FlxColor.BLACK);

		hudBunnies = new FlxTypedGroup<FlxSprite>();

		if (!_select)
		{
			for (i in 0...5)
			{
				var bn:FlxSprite = new FlxSprite(30 * i + 40, 40).loadGraphic("assets/images/hudBunnies.png", true, 32, 32);
				bn.exists = true;
				bn.animation.add("l", [0], 12, true);
				bn.animation.add("c", [2], 12, true);
				bn.animation.add("f", [1], 12, true);
				bn.animation.add("dl", [3], 12, true);
				bn.animation.add("dc", [5], 12, true);
				bn.animation.add("df", [4], 12, true);

				var aName:String = bunnyOrder[levelId][i];

				bn.animation.play(aName);

				hudBunnies.add(bn);
				add(bn);
			}
		}

		completeText = new FlxText(0, 0, 0, "Out of Usagis", 20);
		completeText.alignment = CENTER;
		completeText.screenCenter();
		completeText.exists = false;

		subText = new FlxText(completeText.x - 20, completeText.y + 30, 0, "Press R to Retry the Stage", 12);
		subText.alignment = CENTER;
		subText.exists = false;

		victoryText = new FlxText(0, 0, 0, "Reactor Reached", 20);
		victoryText.alignment = CENTER;
		victoryText.screenCenter();
		victoryText.exists = false;

		leftOpening = new FlxSprite(-640, 0).loadGraphic("assets/images/leftClearing.png", false, 640, 480);
		rightOpening = new FlxSprite(640, 0).loadGraphic("assets/images/rightClearing.png", false, 640, 480);

		if (!_select)
		{
			leftOpening.x = 0;
			rightOpening.x = 40;
		}

		add(leftOpening);
		add(rightOpening);
		add(completeText);
		add(subText);
		add(victoryText);

		// add(upBackground);

		forEach(function(sprite) sprite.scrollFactor.set(0, 0));
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function closeTransition()
	{
		leftOpening.exists = true;
		rightOpening.exists = true;

		leftOpening.x += 8;
		rightOpening.x -= 8;

		if (leftOpening.x > -80)
		{
			done = true;
		}
	}

	public function openTransition()
	{
		leftOpening.x -= 8;
		rightOpening.x += 8;

		if (!leftOpening.isOnScreen())
		{
			leftOpening.exists = false;
			rightOpening.exists = false;
			doneOpening = true;
		}
	}
}
