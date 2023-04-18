package;

import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.AssetType;
import openfl.utils.Assets as OpenFlAssets;

@:enum abstract FileType(String)
{
	public var SOUND = #if web "mp3" #else "ogg" #end;
	public var HSCRIPT = "hx";
	public var IMAGE = "png";
	public var XML = "xml";
	public var JSON = "json";
	public var TEXT = "txt";
	public var NULL = "";
}

/**
 * It's the Paths Class Only Better
 */
class AssetsHelper
{
	static function getPath(file:String, library:Null<String>):String
	{
		if (library != null)
			return getLibraryPath(file, library);

		return getPreloadPath(file);
	}

	inline static public function getFilePath(file:String, type:FileType = NULL, ?library:String):String
	{
		var ext:String = '.$type';
		if (type == NULL)
			ext = '';

		return getPath(file + ext, library);
	}

	inline static public function getLibraryPath(file:String, library:String):String
	{
		return '$library/$file';
	}

	inline static public function getPreloadPath(file:String):String
	{
		return 'assets/$file';
	}

	inline static public function image(file:String, ?library:String):String
	{
		return getFilePath('images/' + file, IMAGE, library);
	}

	inline static public function text(file:String, ?library:String)
	{
		return getFilePath('data/' + file, TEXT, library);
	}

	inline static public function xml(file:String, ?library:String)
	{
		return getFilePath('data/' + file, XML, library);
	}

	inline static public function json(file:String, ?library:String)
	{
		return getFilePath('data/' + file, JSON, library);
	}

	inline static public function font(file:String)
	{
		return getFilePath('fonts/' + file, NULL);
	}

	inline static public function video(file:String)
	{
		return getFilePath('videos/' + file, NULL);
	}

	inline static public function sound(file:String, ?library:String)
	{
		return getFilePath('sounds/' + file, SOUND, library);
	}

	inline static public function soundRandom(file:String, min:Int, max:Int, ?library:String)
	{
		return getFilePath('sounds/' + file + FlxG.random.int(min, max), SOUND, library);
	}

	inline static public function music(file:String, ?library:String)
	{
		return getFilePath('music/' + file, SOUND, library);
	}

	inline static public function inst(song:String)
	{
		return getFilePath('songs/${song}/Inst', SOUND);
	}

	inline static public function voices(song:String)
	{
		return getFilePath('songs/${song}/Voices', SOUND);
	}

	inline static public function getSparrowAtlas(file:String, ?library:String)
	{
		return FlxAtlasFrames.fromSparrow(image(file, library), getFilePath('images/' + file, XML, library));
	}

	inline static public function getPackerAtlas(file:String, ?library:String)
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(image(file, library), getFilePath('images/' + file, TEXT, library));
	}
}
