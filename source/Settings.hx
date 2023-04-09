package;

import flixel.FlxG;

class Settings
{
    public static var inicialSaves:Array<{name:String, value:Dynamic}> = [
        {
            name: "censor-naughty",
            value: true
        },
        {
            name: "downscroll",
            value: false
        },
        {
            name: "flashing-menu",
            value: true
        },
        {
            name: "camera-zoom",
            value: true
        },
        {
            name: "fps-counter",
            value: true
        },
        {
            name: "auto-pause",
            value: true
        }
    ];

    public static function init()
    {
        FlxG.save.bind('settings', 'capybaracoding');
        for(e in inicialSaves)
        {
            if(Reflect.getProperty(FlxG.save.data, e.name) == null)
                Reflect.setProperty(FlxG.save.data, e.name, e.value); 
        }
        FlxG.save.flush();
    }    
}