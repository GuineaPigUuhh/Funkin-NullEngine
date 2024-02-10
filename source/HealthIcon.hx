package;

import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

using StringTools;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	var char:String = '';
	var isPlayer:Bool = false;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();

		this.isPlayer = isPlayer;

		changeIcon(char);
		antialiasing = true;
		scrollFactor.set();
	}

	public function changeIcon(newChar:String):Void
	{
		if (newChar != 'bf-pixel' && newChar != 'bf-old')
			newChar = newChar.split('-')[0].trim();

		if (newChar != char)
		{
			if (animation.getByName(newChar) == null)
			{
				loadIcon(newChar);
				animation.add(newChar, [0, 1], 0, false, isPlayer);
			}
			animation.play(newChar);
			char = newChar;
		}
	}

	function loadIcon(char:String)
	{
		var customIcon_Path = AssetsHelper.getFilePath('characters/${char}/icon', IMAGE);
		if (AssetsHelper.fileExists(customIcon_Path))
			loadGraphic(customIcon_Path, true, 150, 150);
		else
			loadGraphic(AssetsHelper.image('icons/' + char), true, 150, 150);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}

	var bopTween:FlxTween = null;
	var saveScale:Array<Float> = [];
	var noMoreSaveScale:Bool = false;

	public function bop()
	{
		if (noMoreSaveScale == false)
		{
			saveScale.push(this.scale.x);
			saveScale.push(this.scale.y);

			noMoreSaveScale = true;
		}

		this.scale.set(saveScale[0] + 0.2, saveScale[1] + 0.2);

		if (bopTween != null)
			bopTween.cancel();
		bopTween = FlxTween.tween(this, {"scale.x": saveScale[0], "scale.y": saveScale[1]}, 0.2, {ease: FlxEase.circOut});
	}
}
