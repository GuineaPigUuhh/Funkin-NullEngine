package;

import Paths;
import hscript.*;
#if sys
import sys.FileSystem;
import sys.io.File;
#end

class ScriptTemplate
{
	public var path:String = "";
	public var fileExists = FileSystem.exists("");
	public var createPreset:Bool = false;

	public function new(path:String)
	{
		onCreate(path);

		if (createPreset == true)
			preset();
	}

	public function onCreate(path:String)
	{
		this.path = path;

		fileExists = FileSystem.exists(path);
	}

	public function load()
		onLoad();

	public static function getScriptPath(path:String)
	{
		var shit = Paths.getPreloadPath('$path.hx');
		return shit;
	}

	public function onLoad() {}

	public function preset() {}

	public function set(name:String, value:Dynamic) {}

	public function get(name:String)
	{
		return null;
	}

	public function call(name:String, value:Array<Dynamic>)
	{
		var result = onCall(name, value == null ? [] : value);

		return result;
	}

	public function onCall(name:String, value:Array<Dynamic>)
	{
		return null;
	}
}
