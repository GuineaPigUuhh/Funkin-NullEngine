package;

import flixel.FlxG;
import hscript.*;
#if sys
import sys.FileSystem;
import sys.io.File;
#end

class FunkinScript extends ScriptTemplate
{
	public var interp:Interp;
	public var parser:Parser;

	public override function onCreate(path:String)
	{
		super.onCreate(path);

		interp = new Interp();
		parser = new Parser();

		parser.allowTypes = true;
		parser.allowJSON = true;
		parser.allowMetadata = true;

		createPreset = true;
	}

	public override function onLoad()
	{
		var getScript = parser.parseString(File.getContent(path));
		interp.execute(getScript);
	}

	public override function set(name:String, value:Dynamic)
		interp.variables.set(name, value);

	public override function get(name:String)
		return interp.variables.get(name);

	public override function onCall(name:String, value:Array<Dynamic>)
	{
		if (interp == null)
			return null;

		if (interp.variables.exists(name))
		{
			var functionH = get(name);

			var result = null;
			result = Reflect.callMethod(null, functionH, value);
			return result;
		}
		return null;
	}

	public override function preset()
	{
		var daState = FlxG.state;

		set("add", daState.add);
		set("destroy", daState.destroy);
		set("remove", daState.remove);

		// haxe
		set('Type', Type);
		set('Math', Math);
		set('Std', Std);
		set('Date', Date);

		// flixel
		set('FlxG', flixel.FlxG);
		set('FlxBasic', flixel.FlxBasic);
		set('FlxObject', flixel.FlxObject);
		set('FlxSprite', flixel.FlxSprite);
		set('FlxSound', flixel.system.FlxSound);
		set('FlxSort', flixel.util.FlxSort);
		set('FlxStringUtil', flixel.util.FlxStringUtil);
		set('FlxState', flixel.FlxState);
		set('FlxSubState', flixel.FlxSubState);
		set('FlxText', flixel.text.FlxText);
		set('FlxTimer', flixel.util.FlxTimer);
		set('FlxTween', flixel.tweens.FlxTween);
		set('FlxEase', flixel.tweens.FlxEase);
		set('FlxTrail', flixel.addons.effects.FlxTrail);

		// funkin
		set('Alphabet', Alphabet);
		set('CoolUtil', CoolUtil);
		set('Character', Character);
		set('Conductor', Conductor);
		set('AssetsHelper', AssetsHelper);
		set('Settings', Settings);
	}
}
