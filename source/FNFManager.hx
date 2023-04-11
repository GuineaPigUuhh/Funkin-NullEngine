package;

#if desktop
import sys.FileSystem;
import sys.io.File;
import sys.thread.Thread;
#end

class FNFManager
{
	public static function load()
	{
		WeeksManager.load();
		CharactersManager.load();
		MenuCharactersManager.load();
	}

	public static function reload()
	{
		WeeksManager.reload();
		CharactersManager.reload();
		MenuCharactersManager.reload();
	}
}

class CharactersManager
{
	public static var charXml:Xml;
	public static var charsMAP:Map<String, CharData> = [];

	public static function load()
	{
		charXml = Xml.parse(File.getContent(Paths.xml('characters')));
		for (e in charXml.elementsNamed("char"))
		{
			var charData:CharData = {
				flipX: false,
				isGF: false,
				antialiasing: true,
				icon: "bf",
				scale: 1,
				sprite: "characters/BOYFRIEND",
				anims: []
			};

			if (e.exists("sprite"))
				charData.sprite = e.get("sprite");
			else
				charData.sprite = 'characters/' + e.get("name");

			if (e.exists("icon"))
				charData.icon = e.get("icon");
			else
				charData.icon = e.get("name");

			charData.antialiasing = (XmlUtil.parseBool(e.get("antialiasing")) == true ? true : false);

			if (e.exists('flipX'))
				charData.flipX = XmlUtil.parseBool(e.get("flipX"));

			if (e.exists("scale"))
				charData.scale = Std.parseFloat(e.get("scale"));

			if (e.exists("isGF"))
				charData.isGF = XmlUtil.parseBool(e.get("isGF"));
			else
				charData.isGF = false;

			for (anim in e.elementsNamed("anim"))
			{
				var animData:CharAnimData = {
					name: "animName",
					prefix: "animPrefix",
					indices: null,
					loop: false,
					fps: 24,
					offset: [0, 0]
				};

				animData.name = anim.get("name");
				animData.prefix = anim.get("prefix");
				animData.loop = XmlUtil.parseBool(anim.get("loop"));
				animData.fps = Std.parseInt(anim.get("fps"));

				var offsetArray:Array<Float> = XmlUtil.parseArrayFloat(anim.get("offset"));
				animData.offset = offsetArray;

				var indicesArray:Array<Int> = XmlUtil.parseArrayInt(anim.get("indices"));
				if (anim.exists("indices"))
					animData.indices = indicesArray;

				charData.anims.push(animData);
			}

			charsMAP.set(e.get("name"), charData);
		}
	}

	public static function reload()
	{
		charsMAP = [];
		load();
	}
}

typedef CharData =
{
	var flipX:Bool;
	var antialiasing:Bool;
	var icon:String;
	var sprite:String;
	var isGF:Bool;
	var scale:Float;

	var anims:Array<CharAnimData>;
}

typedef CharAnimData =
{
	var name:String;
	var prefix:String;
	var indices:Array<Int>;
	var loop:Bool;
	var fps:Int;
	var offset:Array<Float>;
}

class WeeksManager
{
	public static var weeksXml:Xml;

	public static var weekNames:Array<String> = [];
	public static var weekSongs:Array<Array<String>> = [];
	public static var weekCharacters:Array<Array<String>> = [];
	public static var weekTitles:Array<String> = [];

	// HOLYSHIT FREEPLAY AREA!!!!
	public static var weekIcons:Array<Array<String>> = [];
	public static var weekColors:Array<Array<String>> = [];

	public static function load()
	{
		weeksXml = Xml.parse(File.getContent(Paths.xml('weeks')));
		for (e in weeksXml.elementsNamed('week'))
		{
			var songs:Array<String> = [];
			var characters:Array<String> = [];

			// HOLYSHIT FREEPLAY AREA!!!!
			var icons:Array<String> = [];
			var colors:Array<String> = [];

			for (c in e.get("characters").split(","))
			{
				characters.push(c);
			}
			for (s in e.elementsNamed('song'))
			{
				songs.push(s.get("name"));
				icons.push(s.get("icon"));
				colors.push(s.get("color"));
			}

			weekNames.push(e.get("name"));
			weekTitles.push(e.get("title"));
			weekSongs.push(songs);
			weekCharacters.push(characters);

			// HOLYSHIT FREEPLAY AREA!!!!
			weekColors.push(colors);
			weekIcons.push(icons);
		}
	}

	public static function reload()
	{
		weekNames = [];
		weekSongs = [];
		weekCharacters = [];
		weekTitles = [];

		// HOLYSHIT FREEPLAY AREA!!!!
		weekIcons = [];
		weekColors = [];

		load();
	}
}

class MenuCharactersManager
{
	public static var menuCharsXml:Xml;
	public static var menuCharsMAP:Map<String, MenuCharData> = [];

	public static function load()
	{
		menuCharsXml = Xml.parse(File.getContent(Paths.xml('menu_characters')));
		for (e in menuCharsXml.elementsNamed('char'))
		{
			var menuCharData:MenuCharData = {
				idleAnim: "idle",
				confirmAnim: "",
				flipX: false,
				offset: [0, 0],
				scale: 1
			};

			menuCharData.idleAnim = e.get('idleAnim');
			if (e.exists('confirmAnim'))
			{
				menuCharData.confirmAnim = e.get('confirmAnim');
			}

			if (e.exists('flipX'))
				menuCharData.flipX = XmlUtil.parseBool(e.get('flipX'));

			if (e.exists('offset'))
				menuCharData.offset = XmlUtil.parseArrayFloat(e.get('offset'));

			if (e.exists('scale'))
				menuCharData.scale = Std.parseFloat(e.get('scale'));

			menuCharsMAP.set(e.get('name'), menuCharData);
		}
	}

	public static function reload()
	{
		menuCharsMAP = [];
		load();
	}
}

typedef MenuCharData =
{
	var scale:Float;
	var idleAnim:String;
	var confirmAnim:String;
	var offset:Array<Float>;
	var flipX:Bool;
}
