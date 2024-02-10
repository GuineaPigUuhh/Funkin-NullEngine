class CustomStage
{
	public var executed:Bool = false;
	public var script:FunkinScript;
	public var stage:String = null;

	public function new(curStage:String)
	{
		stage = curStage;
	} // to load

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
