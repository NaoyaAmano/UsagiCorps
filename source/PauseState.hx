import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PauseState extends FlxSubState
{
	var completeText:FlxText;
	var subText:FlxText;
	var subText2:FlxText;

	var done:Bool;

	var leftOpening:FlxSprite;
	var rightOpening:FlxSprite;
	var sts:Int;
	var begin:Bool = false;
	var begin2:Bool = false;

	public function new(color:FlxColor, curState:Int)
	{
		super(color);

		sts = curState;

		completeText = new FlxText(0, 0, 0, "On Pause", 20);
		completeText.alignment = CENTER;
		completeText.screenCenter();

		completeText.scrollFactor.set(0, 0);

		subText = new FlxText(completeText.x - 20, completeText.y + 30, 0, "Press R to Retry the Stage", 12);
		subText.alignment = CENTER;

		subText.scrollFactor.set(0, 0);

		subText2 = new FlxText(completeText.x - 20, completeText.y + 60, 0, "Press Q to return to Menu", 12);
		subText2.alignment = CENTER;

		subText2.scrollFactor.set(0, 0);

		leftOpening = new FlxSprite(-640, 0).loadGraphic("assets/images/leftClearing.png", false, 640, 480);
		rightOpening = new FlxSprite(640, 0).loadGraphic("assets/images/rightClearing.png", false, 640, 480);
		leftOpening.scrollFactor.set(0, 0);
		rightOpening.scrollFactor.set(0, 0);

		add(completeText);
		add(subText);
		add(subText2);
		add(leftOpening);
		add(rightOpening);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.R && !begin2)
		{
			begin = true;
		}

		if (begin)
		{
			closeTransition();
			if (done)
			{
				var target:String = Std.string(sts);
				FlxG.switchState(new LevelState("assets/data/0" + target + ".tmx"));
				close();
			}
		}

		if (FlxG.keys.justPressed.Q && !begin)
		{
			begin2 = true;
		}

		if (begin2)
		{
			closeTransition();

			if (done)
			{
				var target:String = Std.string(sts);
				FlxG.switchState(new SelectMenu());
				close();
			}
		}

		if (FlxG.keys.justPressed.ESCAPE)
		{
			close();
		}
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
}
