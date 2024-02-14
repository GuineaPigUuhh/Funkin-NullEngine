class Main
{
	static var libs = [
		new Lib("flixel", "5.5.0"),
		new Lib("flixel-addons", "3.2.1"),
		new Lib("flixel-demos", "3.1.0"),
		new Lib("flixel-tools", "1.5.1"),
		new Lib("flixel-ui", "2.5.0"),
		new Lib("hscript", "2.5.0"),
		new Lib("polymod", "1.7.0"),
		new Lib("flxanimate", "", "https://github.com/Dot-Stuff/flxanimate"),
		new Lib("hxcodec", "2.5.1")
	];

	public static function main()
	{
		for (daLib in libs)
		{
			daLib.install();
			daLib.set();
		}
	}
}

class Lib
{
	public var isGit = false;

	public var name = null;
	public var version = null;
	public var url = null;

	public function new(name:String, version:String = "", ?url:Null<String>)
	{
		this.name = name;
		this.version = version;
		this.url = url;
		if (url != null)
		{
			isGit = true;
			this.version = "";
		}
	}

	public function install()
	{
		if (isGit)
		{
			Sys.command('haxelib git ${name} ${url}');
		}
		else
		{
			Sys.command('haxelib install ${name} ${version}');
		}
	}

	public function set()
	{
		if (isGit)
		{
			Sys.command('haxelib set ${name} git');
		}
		else
		{
			Sys.command('haxelib set ${name} ${version}');
		}
	}
}
