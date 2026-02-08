package tuna.fs;

import haxe.io.Bytes;
import haxe.Http;
import haxe.Json;

class FileSystem {
	public static var preloaded:Bool = false;
	public static var onPreloadComplete:Void->Void = null;

	public static var preloadedBytes:Map<String, Bytes> = [];
	@:noCompletion
	public static var manifestLen:Int = 0;
	@:noCompletion
	private static var manifestProgress:Int = 0;

	@:noCompletion
	public static function init(?onComplete:Void->Void) {
		onPreloadComplete = onComplete;
		
		#if (js || html5)
		var http:Http = new Http("./manifest.json");
		http.onData = s -> {
			var manifest:Array<String> = Json.parse(s);
			manifestLen = manifest.length;

			if (manifestLen == 0) {
				preloaded = true;
				if (onPreloadComplete != null)
					onPreloadComplete();
				return;
			}

			for (file in manifest) {
				var http:Http = new Http("./" + file);
				http.onBytes = b -> {
					preloadedBytes.set(file, b);
					manifestProgress++;
					trace('Loading: $manifestProgress/$manifestLen');

					if (manifestProgress == manifestLen) {
						preloaded = true;
						trace('All assets loaded!');
						if (onPreloadComplete != null)
							onPreloadComplete();
					}
				}
				http.onError = e -> {
					trace('Error loading $file: $e');
					manifestProgress++;
					if (manifestProgress == manifestLen) {
						preloaded = true;
						if (onPreloadComplete != null)
							onPreloadComplete();
					}
				}
				http.request();
			}
		}
		http.onError = e -> {
			trace('Error loading manifest: $e');
			preloaded = true;
			if (onPreloadComplete != null)
				onPreloadComplete();
		}
		http.request();
		#else
		preloaded = true;
		if (onPreloadComplete != null)
			onPreloadComplete();
		#end
	}

	public static function getProgress():Float {
		if (manifestLen == 0)
			return 1.0;
		return manifestProgress / manifestLen;
	}

	public static function getText(file:String):String {
		if (preloadedBytes.exists(file))
			return preloadedBytes.get(file).toString();

		#if sys
		if (sys.FileSystem.exists(file))
			return sys.io.File.getContent(file);
		#end

		throw 'Couldnt find $file';
	}

	public static function getBytes(file:String):Bytes {
		if (preloadedBytes.exists(file))
			return preloadedBytes.get(file);

		#if sys
		if (sys.FileSystem.exists(file))
			return sys.io.File.getBytes(file);
		#end

		throw 'Couldnt find $file';
	}
}