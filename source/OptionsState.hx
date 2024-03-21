package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxObject;

class OptionsState extends MusicBeatState
{
	static var curSelected:Int = 0;

	var options:Array<String> = ["Controls", "Gameplay", "Graphics"];

	var grpOptions:FlxTypedGroup<Alphabet>;
	var camObject:FlxObject;

	public static var inGameplay:Bool = false;

	override public function create()
	{
		var bg:FlxSprite = new FlxSprite().loadGraphic(AssetsHelper.image('menus/main/menuBG'));
		bg.scrollFactor.set();
		add(bg);

		camObject = new FlxObject(0, 0, 1, 1);
		camObject.screenCenter(X);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...options.length)
		{
			var optionText:Alphabet = new Alphabet(0, (70 * i) + 30, options[i], true, false);
			optionText.alpha = 0.8;
			grpOptions.add(optionText);
		}

		FlxG.camera.follow(camObject, LOCKON, 0.08);
		changeSelection();
		super.create();
	}

	override public function update(elapsed)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			select();
		}

		if (controls.UI_UP)
		{
			changeSelection(-1);
		}

		if (controls.DOWN_UP)
		{
			changeSelection(1);
		}

		if (controls.BACK)
		{
			FlxG.switchState(new MainMenuState());
		}
	}

	function changeSelection(index:Int = 0)
	{
		grpOptions.members[curSelected].alpha = 0.8;

		curSelected += FlxMath.wrap(curSelected + index, 0, grpOptions.length - 1);

		grpOptions.members[curSelected].alpha = 1;
		camObject.y = grpOptions.members[curSelected].y;
	}

	function select()
	{
		switch (options[curSelected])
		{
			default:
		}
	}
}
