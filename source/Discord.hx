package;

import Sys.sleep;

using StringTools;

#if DISCORD_ALLOWED
import hxdiscord_rpc.Discord;
import hxdiscord_rpc.Types;
#end

class DiscordClient
{
	#if DISCORD_ALLOWED
	private static var presence:DiscordRichPresence = DiscordRichPresence.create();
	public static var connected_user:String = "Unknown";

	public static final _defID:String = "1204517234467278979";
	public static var clientID(default, set):String = _defID;

	public static function set_clientID(value:String)
	{
		if ((clientID != value) && isInitialized)
		{
			shutdown();
			init();
			updatePresence();
		}
		return clientID = value;
	}

	public static var isInitialized:Bool = false;

	public static function init()
	{
		var handlers:DiscordEventHandlers = DiscordEventHandlers.create();
		handlers.ready = cpp.Function.fromStaticFunction(onReady);
		handlers.disconnected = cpp.Function.fromStaticFunction(onDisconnected);
		handlers.errored = cpp.Function.fromStaticFunction(onError);
		Discord.Initialize(clientID, cpp.RawPointer.addressOf(handlers), 1, null);

		if (!isInitialized)
			trace("new DiscordPrecense(): Created");

		sys.thread.Thread.create(() ->
		{
			var localID:String = clientID;
			while (localID == clientID)
			{
				#if DISCORD_DISABLE_IO_THREAD
				Discord.UpdateConnection();
				#end
				Discord.RunCallbacks();
				Sys.sleep(0.5);
			}
		});
		isInitialized = true;
	}

	private static function onReady(request:cpp.RawConstPointer<DiscordUser>):Void
	{
		var requestPtr:cpp.Star<DiscordUser> = cpp.ConstPointer.fromRaw(request).ptr;

		connected_user = cast(requestPtr.username, String);
		if (Std.parseInt(cast(requestPtr.discriminator, String)) != 0)
			trace('(Discord) Connected to User (${connected_user}#${cast (requestPtr.discriminator, String)})');
		else
			trace('(Discord) Connected to User (${connected_user})');

		changePresence();
	}

	private static function onError(errorCode:Int, message:cpp.ConstCharStar):Void
		trace('Discord: Error ($errorCode: ${cast (message, String)})');

	private static function onDisconnected(errorCode:Int, message:cpp.ConstCharStar):Void
		trace('Discord: Disconnected ($errorCode: ${cast (message, String)})');

	public dynamic static function shutdown()
	{
		Discord.Shutdown();
		isInitialized = false;
	}

	public static function updatePresence()
		Discord.UpdatePresence(cpp.RawConstPointer.addressOf(presence));

	public static function changePresence(details:String = "Nothing", ?state:Null<String>, ?smallImageKey:String, ?hasStartTimestamp:Bool, ?endTimestamp:Float)
	{
		var startTimestamp:Float = 0;
		if (hasStartTimestamp)
			startTimestamp = Date.now().getTime();
		if (endTimestamp > 0)
			endTimestamp = startTimestamp + endTimestamp;

		presence.details = details;
		presence.state = state;
		presence.largeImageKey = 'icon';
		presence.smallImageKey = smallImageKey;
		presence.startTimestamp = Std.int(startTimestamp / 1000);
		presence.endTimestamp = Std.int(endTimestamp / 1000);

		updatePresence();
	}
	#end
}
