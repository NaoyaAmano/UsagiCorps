import flixel.FlxBasic.FlxType;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;

class SelectMenu extends FlxState
{
	public static var PROGRESSION:Int = 1;

	var background:FlxSprite;
	var frontGround:FlxSprite;

	var clickSound:FlxSound;

	var doorGroup:FlxTypedGroup<FlxSprite>;
	var doorItem:Array<String> = [];
	var ui:HUD;
	var doTransition:Bool;
	var target:Int = 0;

	public function new()
	{
		super();
	}

	override function create()
	{
		super.create();

		clickSound = FlxG.sound.load("assets/music/menu1.wav", 0.4);

		// Will do a refactoring eventually this for now is everything i have :[
		// The refactoring took less time than i anticipated lmao

		ui = new HUD(0, true);

		doorGroup = new FlxTypedGroup<FlxSprite>();
		var j:Int = 0;
		var yPos:Int = 128;
		for (i in 0...8)
		{
			if (i > 3 && j > 3)
			{
				j = 0;
				yPos = 288;
			}

			var door:FlxSprite = new FlxSprite((128 * (j)) + 80, yPos).loadGraphic("assets/images/menu_door.png", true, 96, 96);
			door.ID = i + 1;
			door.animation.add("closed", [0], 12, false);
			door.animation.add("opening", [1, 2, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4], 12, false);
			doorGroup.add(door);

			doorItem[i] = "0" + Std.string(i);

			j++;
		}

		background = new FlxSprite(0, 0).loadGraphic("assets/images/menuBackground.png", false, 1152, 960);
		frontGround = new FlxSprite(24, 24).loadGraphic("assets/images/menu_background.png", false, 560, 400);

		//
		add(background);
		add(frontGround);
		add(doorGroup);
		add(ui.leftOpening);
		add(ui.rightOpening);

		FlxG.sound.defaultSoundGroup.resume();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		background.x -= 2;
		if (background.x <= -384)
			background.x = 0;

		for (doors in doorGroup)
		{
			if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(doors) && !doTransition)
			{
				doors.animation.play("opening");
				doTransition = true;
				target = doors.ID;
				clickSound.play();
			}
		}

		if (doTransition)
		{
			ui.closeTransition();

			if (ui.done)
			{
				FlxG.sound.defaultSoundGroup.pause();
				FlxG.switchState(new LevelState("assets/data/0" + target + ".tmx"));
			}
		}
	}
}
