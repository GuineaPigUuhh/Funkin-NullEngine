package;

import haxe.Json;
import haxe.format.JsonParser;
import haxe.macro.Type.AnonType;
import sys.FileSystem;

using StringTools;

#if desktop
import sys.FileSystem;
import sys.io.File;
import sys.thread.Thread;
#end

class FNFManager
{
	public static var managers:Array<Dynamic> = [WeeksManager, CharactersManager, MenuCharactersManager, StagesDataManager];

	public static function load() {}

	public static function reload() {}
}

class CharactersManager
{
	public static var charList:Array<String> = [];

	static var vanillaChars:Array<String> = [
		"dad", "gf", "spooky", "pico", "mom", "mom-car", "bf-car", "parents-christmas", "monster-christmas", "bf-christmas", "gf-christmas", "monster",
		"bf-pixel", "senpai", "senpai-angry", "spirit", "tankman", "pico-speaker", "bf-holding-gf"
	]; // Only use this if your character is from Source Code

	public static function loadList()
	{
		charList = [];
		for (char in vanillaChars)
			charList.push(char);
		for (char in FileSystem.readDirectory(AssetsHelper.getDefaultPath("characters/")))
			charList.push(char);
	}
}

class WeeksManager
{
	public static var weekNames:Array<String> = [];
	public static var weekSongs:Array<Array<String>> = [];
	public static var weekCharacters:Array<Array<String>> = [];
	public static var weekTitles:Array<String> = [];

	// FREEPLAY
	public static var weekIcons:Array<Array<String>> = [];
	public static var weekColors:Array<Array<String>> = [];

	public static function resetStaticVariables()
	{
		weekNames = [];
		weekSongs = [];
		weekCharacters = [];
		weekTitles = [];

		// FREEPLAY
		weekIcons = [];
		weekColors = [];
	}

	public static function load()
	{
		resetStaticVariables();
		for (week in FileSystem.readDirectory(AssetsHelper.getDefaultPath("weeks/")))
		{
			if (week.endsWith(".json"))
			{
				var realJson = week.replace(".json", "");
				var customWeek:WeekData = Json.parse(File.getContent(AssetsHelper.getFilePath('weeks/${realJson}', JSON)));

				weekNames.push(realJson);
				weekCharacters.push(customWeek.characters);
				weekTitles.push(customWeek.title);

				var _Songs:Array<String> = [];
				var _Icons:Array<String> = [];
				var _Colors:Array<String> = [];
				for (song in customWeek.songs)
				{
					_Songs.push(song.name);
					_Icons.push(song.icon);
					_Colors.push(song.color);
				}
				weekSongs.push(_Songs);
				weekIcons.push(_Icons);
				weekColors.push(_Colors);
			}
		}
	}
}

typedef WeekData =
{
	var hideInFreeplay:Bool;
	var hideInStorymode:Bool;
	var title:String;
	var characters:Array<String>;
	var songs:Array<WeekSongData>;
}

typedef WeekSongData =
{
	var name:String;
	var icon:String;
	var color:String;
}

class MenuCharactersManager
{
	public static function get(curChar)
	{
		return Json.parse(File.getContent(AssetsHelper.getFilePath('menu_characters/${curChar}', JSON)));
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
	public static var stageList:Array<String> = [];

	public static function get(curStage:String)
	{
		return Json.parse(File.getContent(AssetsHelper.getFilePath('stages/${curStage}/Config', JSON)));
	}

	public static function loadList()
	{
		stageList = [];
		for (stage in FileSystem.readDirectory(AssetsHelper.getDefaultPath("stages/")))
			stageList.push(stage);
	}
}

typedef StageData =
{
	var cam_zoom:Float;
	var cam_speed:Float;
	var charsPos:Dynamic;
}
