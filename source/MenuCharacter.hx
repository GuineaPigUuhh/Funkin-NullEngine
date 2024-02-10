package;

import FNFManager.MenuCharactersManager;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class MenuCharacter extends FlxSprite
{
	public var character:String;

	var originX:Float = 0;
	var originY:Float = 0;

	public function new(x:Float, character:String = 'bf')
	{
		super(x);
		y += 70;

		originX = x;
		originY = y;

		frames = AssetsHelper.getCustomPathSparrowAtlas('menu_characters/vanillaChars');

		antialiasing = true;

		changeChar(character);
	}

	public function changeChar(character:String)
	{
		if (character == this.character)
			return;

		this.character = character;

		visible = true;
		scale.set(1, 1);
		updateHitbox();

		setPosition(originX, originY);

		switch (character)
		{
			case "":
				visible = false;

			default:
				var curData = MenuCharactersManager.get(character);

				animation.addByPrefix(character, curData.idleAnim, 24);
				if (curData.confirmAnim != "")
					animation.addByPrefix(character + '-confirm', curData.confirmAnim, 24, false);

				flipX = curData.flipX;
				if (curData.scale != 1)
				{
					scale.set(curData.scale, curData.scale);
					updateHitbox();
				}

				x += curData.offset[0];
				y += curData.offset[1];

				animation.play(character);
		}
	}
}
