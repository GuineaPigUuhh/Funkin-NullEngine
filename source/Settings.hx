package;

import flixel.FlxG;
import tjson.TJSON as Json;

using StringTools;

#if desktop
import sys.FileSystem;
import sys.io.File;
import sys.thread.Thread;
#end

class Settings
{
	public static var inicialSaves:Array<{name:String, value:Dynamic}> = [
		{
			name: "censor-naughty",
			value: true
		},
		{
			name: "downscroll",
			value: false
		},
		{
			name: "flashing-menu",
			value: true
		},
		{
			name: "camera-zoom",
			value: true
		},
		{
			name: "fps-counter",
			value: true
		},
		{
			name: "auto-pause",
			value: true
		}
	];
	public static var json:Dynamic;

	public static function loadJson()
	{
		json = Json.parse(File.getContent(AssetsHelper.getFilePath('Settings', JSON, "engine")));
	}

	public static function get(name:String)
	{
		name = name.replace(" ", "_");
		return Reflect.getProperty(json, name);
	}

	public static function init()
	{
		loadJson();
		return;

		FlxG.save.bind('settings', 'guineapiguuhh');
		for (e in inicialSaves)
		{
			if (Reflect.getProperty(FlxG.save.data, e.name) == null)
				Reflect.setProperty(FlxG.save.data, e.name, e.value);
		}
		FlxG.save.flush();
	}
}
