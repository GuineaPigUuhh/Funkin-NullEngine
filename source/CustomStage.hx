class CustomStage
{
	public var executed:Bool = false;
	public var script:FunkinScript;

	public function new(curStage:String)
	{
		configStage(curStage);
	}

	function configStage(curStage:String)
	{
		executed = true;

		script = new FunkinScript(AssetsHelper.hscript('stages/${curStage}'));
		script.load();

		call('onCreate', []);

		if (!AssetsHelper.fileExists(AssetsHelper.hscript('stages/${curStage}')))
		{
			trace('ERROR: no has file');
		}
	}

	public function set(name:String, value:String)
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
