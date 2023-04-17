package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;

class CustomStage
{
	public var foreground:FlxTypedGroup<FlxBasic>;
	public var layers:FlxTypedGroup<FlxBasic>;

	public var stageScript:FunkinScript = null;
	public var executedScript:Bool = false;

	public function createStage(curStage:String)
	{
		executedScript = true;

		foreground = new FlxTypedGroup<FlxBasic>();
		layers = new FlxTypedGroup<FlxBasic>();

		stageScript = new FunkinScript(Paths.getPreloadPath('stages/' + curStage + '.hx'));
		stageScript.load();

		set('addSprite', addSprite);

		call('onCreate', []);
	}

	public function set(name:String, value:Any)
	{
		if (executedScript)
			stageScript.set(name, value);
	}

	public function call(name:String, value:Array<Any>)
	{
		if (executedScript)
			stageScript.call(name, value);
	}

	public function addSprite(sprite:FlxBasic, back:Bool)
	{
		if (back == true)
			foreground.add(sprite);
		else
			layers.add(sprite);
	}

	public function addLayerToGame(laye:String)
	{
		if (executedScript)
		{
			switch (laye)
			{
				case "layers":
					FlxG.state.add(layers);
				case "foreground":
					FlxG.state.add(foreground);
			}
		}
	}
}
