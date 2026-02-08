package tuna.utils;

import haxe.Timer;

class Time {
	public static function getTime():Float {
		return Timer.stamp() * 1000;
	}

	public static function sleep(ms:Float) {
		#if sys
		Sys.sleep(ms / 1000);
		#elseif (js || html5)
		var start = getTime();
		while (getTime() - start < ms) {}
		#end
	}
}
