package;

import flixel.FlxG;

class MenuInput {
	public static inline function wheelChange():Int {
		if(!ClientPrefs.mouseWheelMenus) return 0;
		if(FlxG.mouse.wheel > 0) return -1;
		if(FlxG.mouse.wheel < 0) return 1;
		return 0;
	}
}
