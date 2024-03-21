package;

class ScriptsPackWrapper
{
	public var packs:Map<String, ScriptPack> = [];
	public var preset_vars(default, set):Map<String, Dynamic> = [];

	public function set_preset_vars(value:Map<String, Dynamic>)
	{
		preset_vars = value;
		for (name => value in preset_vars)
			set(name, value);
		return value;
	}

	public function new(packs:Map<String, ScriptPack>)
	{
		this.packs = packs;
	}

	public function init()
	{
		for (i in packs)
			i.load();
		call("onCreate", []);
	}

	public function set(name:String, value:Dynamic)
	{
		for (i in packs)
			i.set(name, value);
	}

	public function getPack(name:String)
		return packs.get(name);

	public function call(name:String, values:Array<Dynamic>)
	{
		for (i in packs)
			i.call(name, values);
	}
}
