package;

import flixel.FlxG;

class SystemUtil
{
	public static function openURL(url:String)
	{
		#if CAN_OPEN_LINKS
		#if linux
		Sys.command('/usr/bin/xdg-open', [url, "&"]);
		#else
		FlxG.openURL(url);
		#end
		#end
	}
}
