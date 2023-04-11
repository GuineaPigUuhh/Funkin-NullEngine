package;

class XmlUtil
{
	/**
	 * it transforms a String into a Bool, very cool right
	 */
	public static function parseBool(shit:String):Bool
	{
		return (shit == "true" ? true : false);
	}

	public static function parseArrayFloat(shit:String):Array<Float>
	{
		var all:Array<String> = shit.split(',');
		var floats:Array<Float> = [];

		for (e in all)
		{
			floats.push(Std.parseFloat(e));
		}

		return floats;
	}

	public static function parseArrayInt(shit:String):Array<Int>
	{
		var all:Array<String> = shit.split(',');
		var ints:Array<Int> = [];

		for (e in all)
		{
			ints.push(Std.parseInt(e));
		}

		return ints;
	}
}
