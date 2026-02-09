package tuna.io;

import haxe.io.Bytes;
import haxe.Http;
import haxe.Json;

class FileSystem {
	public static var preloaded:Bool = false;
	public static var onPreloadComplete:Void->Void = null;

	public static var preloadedBytes:Map<String, Bytes> = new Map();
	@:noCompletion public static var manifestLen:Int = 0;
	@:noCompletion private static var manifestProgress:Int = 0;

	@:noCompletion
	public static function init(?onComplete:Void->Void) {
		onPreloadComplete = onComplete;

		#if (js || html5)
		Assets.loadTextAsync("manifest.json").then(s -> {
			var manifest:Array<String> = Json.parse(s);
			manifestLen = manifest.length;
			for (file in manifest) {
				Assets.loadBytesAsync(file).then(b -> {
					preloadedBytes.set(file, b);
                    manifestProgress++;
                    checkComplete();
				});
			}
		});
		#else
		preloaded = true;
		if (onPreloadComplete != null)
			onPreloadComplete();
		#end
	}

	private static function checkComplete() {
		if (manifestProgress >= manifestLen) {
			preloaded = true;
			trace("Preloading complete! (" + manifestProgress + "/" + manifestLen + ")");
			if (onPreloadComplete != null)
				onPreloadComplete();
		}
	}

	public static function getProgress():Float {
		if (manifestLen == 0)
			return 1.0;
		return manifestProgress / manifestLen;
	}
}
