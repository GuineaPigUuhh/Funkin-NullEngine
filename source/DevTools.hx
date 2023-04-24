package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class DevTools extends MusicBeatState
{
	var editors:Array<String> = ["Chart Editor", "Offset Editor"];
	var textEditors:Array<FlxText> = [];

	var curSelected:Int = 0;

	var camFollow:FlxObject;

	override public function create()
	{
		var bg:FlxSprite = new FlxSprite().loadGraphic(AssetsHelper.image('menus/main/menuDesat'));
		bg.color = 0x292636;
		bg.scrollFactor.set();
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollow.screenCenter();
		add(camFollow);

		for (i in 0...editors.length)
		{
			var editorText:FlxText = new FlxText(40, 50 + (55 * i), 1280, 36);
			editorText.text = editors[i];
			editorText.ID = i;
			editorText.setFormat(AssetsHelper.font("vcr", "ttf"), 36, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			editorText.borderSize = 2.3;

			add(editorText);
			textEditors.push(editorText);
		}

		FlxG.camera.follow(camFollow, null, 0.06);

		changeSelection();

		super.create();
	}

	override public function update(elapsed:Float)
	{
		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP)
			changeSelection(-1);
		if (downP)
			changeSelection(1);

		if (accepted)
		{
			newState();
		}

		if (controls.BACK)
		{
			FlxG.sound.play(AssetsHelper.sound('cancelMenu'));
			FlxG.switchState(new MainMenuState());
		}

		super.update(elapsed);
	}

	function newState()
	{
		switch (editors[curSelected])
		{
			case "Chart Editor":
				FlxG.switchState(new ChartingState());
			case "Offset Editor":
				FlxG.switchState(new AnimationDebug());
		}
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(AssetsHelper.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = textEditors.length - 1;
		if (curSelected >= textEditors.length)
			curSelected = 0;

		for (e in textEditors)
		{
			e.x = 40;
			e.alpha = 0.6;
			if (e.ID == curSelected)
			{
				e.x = 40 + 20;
				e.alpha = 1;
				camFollow.y = e.y - 20;
			}
		}
	}
}
