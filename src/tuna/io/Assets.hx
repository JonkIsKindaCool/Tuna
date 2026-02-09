package tuna.io;

import haxe.Http;
import tuna.async.Promise;
import haxe.io.Bytes;

class Assets {
	public static function loadBytes(path:String):Bytes {
		if (FileSystem.preloadedBytes.exists(path)) {
			return FileSystem.preloadedBytes.get(path);
		}

		#if sys
		if (sys.FileSystem.exists(path)) {
			return sys.io.File.getBytes(path);
		}

		var assetPath = "assets/" + path;
		if (sys.FileSystem.exists(assetPath)) {
			return sys.io.File.getBytes(assetPath);
		}
		#end

		trace('Couldn\'t find bytes for "$path"');
		return Bytes.alloc(0);
	}

	public static function loadText(path:String):String {
		var bytes = loadBytes(path);
		return bytes.toString();
	}

	public static function loadBytesAsync(path:String):Promise<Bytes> {
		return new Promise((resolve:Bytes->Void, reject:Dynamic->Void) -> {
			if (FileSystem.preloadedBytes.exists(path)) {
				resolve(FileSystem.preloadedBytes.get(path));
				return;
			}

			#if sys
			if (sys.FileSystem.exists(path)) {
				try {
					resolve(sys.io.File.getBytes(path));
				} catch (e:Dynamic)
					reject(e);
				return;
			}
			#end

			var http = new Http(path);
			http.onBytes = bytes -> {
				return resolve(bytes);
			};

			http.onError = msg -> reject("Http error: " + msg);

			http.onStatus = status -> {
				if (status < 200 || status >= 400) {
					reject("HTTP " + status + " for " + path);
				}
			}

			http.request(false);
		});
	}

	public static function loadTextAsync(path:String):Promise<String> {
		return new Promise((resolve:String->Void, reject:Dynamic->Void) -> {
			if (FileSystem.preloadedBytes.exists(path)) {
				resolve(FileSystem.preloadedBytes.get(path).toString());
				return;
			}

			#if sys
			if (sys.FileSystem.exists(path)) {
				try {
					resolve(sys.io.File.getContent(path));
				} catch (e:Dynamic)
					reject(e);
				return;
			}
			#end

			var http = new Http(path);
			http.onData = content -> {
				return resolve(content);
			};

			http.onError = msg -> reject("Http error: " + msg);

			http.onStatus = status -> {
				if (status < 200 || status >= 400) {
					reject("HTTP " + status + " for " + path);
				}
			}

			http.request(false);
		});
	}
}
