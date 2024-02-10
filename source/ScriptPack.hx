package;

import sys.FileSystem;
import sys.io.File;

using StringTools;

class ScriptPack
{
	var scripts:Array<FunkinScript> = [];

	public function new(folder:String)
	{
		var betterFolder = AssetsHelper.getDefaultPath(folder);
		if (FileSystem.exists(betterFolder))
		{
			var filesLoads:Array<String> = [];
			for (file in FileSystem.readDirectory(betterFolder))
			{
				if (file.endsWith(".hx"))
				{
					if (!filesLoads.contains(file))
					{
						filesLoads.push(file);
						scripts.push(new FunkinScript(betterFolder + file));
					}
				}
			}
		}
	}

	public function load()
	{
		for (e in scripts)
		{
			e.load();
		}
	}

	public function set(name:String, value:Any)
	{
		for (e in scripts)
		{
			e.set(name, value);
		}
	}

	public function call(name:String, shit:Array<Any>)
	{
		for (e in scripts)
		{
			e.call(name, shit);
		}
	}
}
