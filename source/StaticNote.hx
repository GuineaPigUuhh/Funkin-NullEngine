package;

import flixel.FlxG;
import flixel.FlxSprite;
import shaderslmfao.ColorSwap;

using StringTools;

class StaticNote extends FlxSprite
{
	public var noteData:Int = 0;
	public var player:Int = 0;

	public override function new(x:Float, y:Float, data:Int, player:Int)
	{
		super(x, y);

		noteData = data;

		this.player = player;

		var colorswap:ColorSwap = new ColorSwap();
		shader = colorswap.shader;
		colorswap.update(Note.arrowColors[noteData]);

		switch (PlayState.curStage)
		{
			case 'school' | 'schoolEvil':
				loadGraphic(AssetsHelper.image('weeb/pixelUI/arrows-pixels'), true, 17, 17);
				animation.add('green', [6]);
				animation.add('red', [7]);
				animation.add('blue', [5]);
				animation.add('purplel', [4]);

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;

				switch (Math.abs(noteData))
				{
					case 0:
						animation.add('static', [0]);
						animation.add('pressed', [4, 8], 12, false);
						animation.add('confirm', [12, 16], 24, false);
					case 1:
						animation.add('static', [1]);
						animation.add('pressed', [5, 9], 12, false);
						animation.add('confirm', [13, 17], 24, false);
					case 2:
						animation.add('static', [2]);
						animation.add('pressed', [6, 10], 12, false);
						animation.add('confirm', [14, 18], 12, false);
					case 3:
						animation.add('static', [3]);
						animation.add('pressed', [7, 11], 12, false);
						animation.add('confirm', [15, 19], 24, false);
				}

			default:
				frames = AssetsHelper.getSparrowAtlas('NOTE_assets');
				animation.addByPrefix('green', 'arrowUP');
				animation.addByPrefix('blue', 'arrowDOWN');
				animation.addByPrefix('purple', 'arrowLEFT');
				animation.addByPrefix('red', 'arrowRIGHT');

				antialiasing = true;
				setGraphicSize(Std.int(width * 0.7));

				switch (Math.abs(noteData))
				{
					case 0:
						animation.addByPrefix('static', 'arrow static instance 1');
						animation.addByPrefix('pressed', 'left press', 24, false);
						animation.addByPrefix('confirm', 'left confirm', 24, false);
					case 1:
						animation.addByPrefix('static', 'arrow static instance 2');
						animation.addByPrefix('pressed', 'down press', 24, false);
						animation.addByPrefix('confirm', 'down confirm', 24, false);
					case 2:
						animation.addByPrefix('static', 'arrow static instance 4');
						animation.addByPrefix('pressed', 'up press', 24, false);
						animation.addByPrefix('confirm', 'up confirm', 24, false);
					case 3:
						animation.addByPrefix('static', 'arrow static instance 3');
						animation.addByPrefix('pressed', 'right press', 24, false);
						animation.addByPrefix('confirm', 'right confirm', 24, false);
				}
		}

		updateHitbox();
		scrollFactor.set();
	}

	public override function update(elapsed:Float)
	{
		switch (player)
		{
			case 0:
				if (animation.curAnim.name == 'confirm' && animation.curAnim.finished)
				{
					playAnim('static');
				}
		}
		super.update(elapsed);
	}

	public function playAnim(Anim:String, Force:Bool = false)
	{
		animation.play(Anim, Force);

		if (animation.curAnim.name == 'confirm' && !PlayState.curStage.startsWith('school'))
		{
			centerOffsets();
			offset.x -= 13;
			offset.y -= 13;
		}
		else
			centerOffsets();
	}

	public function inGame()
	{
		playAnim('static');
		x += Note.swagWidth * noteData;
		x += 50;
		x += ((FlxG.width / 2) * player);
		ID = noteData;
	}
}
