class CustomStage
{
	public var executed:Bool = false;
	public var script:FunkinScript;
	public var stage:String = null;
	public var preset_vars(default, set):Map<String, Dynamic> = [];

	public function set_preset_vars(value:Map<String, Dynamic>)
	{
		preset_vars = value;
		for (name => value in preset_vars)
		{
			set(name, value);
		}
		return value;
	}

	public function new(curStage:String)
	{
		stage = curStage;
	}

	public function execute()
	{
		executed = true;

		var script_local = AssetsHelper.getFilePath('stages/${stage}/Script', HSCRIPT);
		script = new FunkinScript(script_local);
		script.load();

		call('onCreate', []);
	}

	public function set(name:String, value:Dynamic)
	{
		if (executed)
			script.set(name, value);
	}

	public function get(name:String)
	{
		if (executed)
			return script.get(name);
		return null;
	}

	public function call(name:String, value:Array<Dynamic>)
	{
		if (executed)
			script.call(name, value);
	}
}
