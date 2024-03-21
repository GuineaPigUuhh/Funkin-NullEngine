package;

class DifficultyUtil
{
	public static var diffs:Array<String> = ["EASY", "NORMAL", "HARD"];
	public static var diffsExt:Map<String, String> = ["EASY" => "-easy", "NORMAL" => "", "HARD" => "-hard"];

	public static function getDifficulty(index:Int)
	{
		return diffs[index];
	}

	public static function getExtension(diff:Dynamic)
	{
		var ext:String = '';
		try
		{
			ext = diffsExt.get(diffsExt[diff]);
		}
		catch (e)
			ext = diffsExt.get(diff);
		return ext;
	}
}
