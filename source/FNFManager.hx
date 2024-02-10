package;

import sys.FileSystem;
#if desktop
import sys.FileSystem;
import sys.io.File;
import sys.thread.Thread;
#end

class FNFManager
{
	public static var managers:Array<Dynamic> = [WeeksManager, CharactersManager, MenuCharactersManager, StagesDataManager];

	public static function load()
	{
		for (managerShit in managers)
		{
			managerShit.load();
		}
	}

	public static function reload()
	{
		for (managerShit in managers)
		{
			managerShit.reload();
		}
	}
}

class CharactersManager
{
	public static var charList:Array<String> = [];

	static var vanillaChars:Array<String> = [
		"bf", "dad", "gf", "spooky", "pico", "mom", "mom-car", "bf-car", "parents-christmas", "monster-christmas", "bf-christmas", "gf-christmas", "monster",
		"bf-pixel", "senpai", "senpai-angry", "spirit", "tankman", "pico-speaker", "bf-holding-gf"
	]; // Only use this if your character is from Source Code

	public static function load()
	{
		for (char in vanillaChars)
		{
			charList.push(char);
		}
	}

	public static function reload()
	{
		charList = [];
		load();
	}
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
		weeksXml = Xml.parse(File.getContent(AssetsHelper.xml('weeks')));

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
		menuCharsXml = Xml.parse(File.getContent(AssetsHelper.xml('menu_characters')));
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

class StagesDataManager
{
	public static var stagesDataXml:Xml;
	public static var stagesDataMAP:Map<String, StageData> = [];

	public static var stageList:Array<String> = [];

	public static function load()
	{
		stagesDataXml = Xml.parse(File.getContent(AssetsHelper.xml('stages')));
		for (e in stagesDataXml.elementsNamed('stageData'))
		{
			var stageData:StageData = {
				camZoom: 1.05,
				camSpeed: 1,
				charsPos: {dad: [100, 100], gf: [400, 130], boyfriend: [770, 450]},
			};

			if (e.exists('camZoom'))
				stageData.camZoom = Std.parseFloat(e.get('camZoom'));
			if (e.exists('camSpeed'))
				stageData.camSpeed = Std.parseFloat(e.get('camSpeed'));

			for (char in e.elementsNamed('charPos'))
			{
				Reflect.setProperty(stageData.charsPos, char.get('name'), XmlUtil.parseArrayFloat(char.get('position')));
			}

			stageList.push(e.get('name'));
			stagesDataMAP.set(e.get('name'), stageData);
		}
	}

	public static function reload()
	{
		stageList = [];
		stagesDataMAP = [];
		load();
	}
}

typedef StageData =
{
	var camZoom:Float;
	var camSpeed:Float;
	var charsPos:{dad:Array<Float>, gf:Array<Float>, boyfriend:Array<Float>};
}
