package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxAssets;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class MenuState extends FlxState
{
	public static var curSong:FlxSound;

	var pressText:FlxText;
	var cover:FlxSprite;

	override public function create()
	{
		super.create();

		FlxG.cameras.bgColor = FlxColor.fromString("#5F5F5F");

		pressText = new FlxText(FlxG.width / 2 - 90, FlxG.height / 2 + 120, 0, "Press Any Button", 15);
		pressText.alignment = CENTER;

		curSong = new FlxSound();
		curSong = FlxG.sound.load("assets/music/theme.mp3", 0.5, true);
		curSong.persist = true;
		curSong.play();

		cover = new FlxSprite(0, 0).loadGraphic("assets/images/cover.png");

		add(cover);
		add(pressText);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ANY)
			FlxG.camera.fade(FlxColor.WHITE, 1, false, function()
			{
				FlxG.switchState(new SelectMenu());
			});
	}
}
