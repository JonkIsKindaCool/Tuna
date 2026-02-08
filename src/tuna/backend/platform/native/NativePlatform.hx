package tuna.backend.platform.native;

import tuna.utils.Color;
#if cpp
import tuna.backend.window.Window;
import tuna.input.InputState;
import tuna.backend.platform.Platform;
import native.sdl.Types;
import native.sdl.SDL;
import haxe.io.Bytes;

class NativePlatform implements Platform {
	public var window:Window;

	private var quitRequested:Bool = false;
	private var event:SDLEvent;

	public function new(width:Int, height:Int, title:String) {
		init(width, height, title);
	}

	public function init(width:Int, height:Int, title:String):Void {
		SDL.init(EVERYTHING);
		event = SDL.makeEvent();

		window = new NativeWindow(width, height, title);
	}

	public function shutdown():Void {
		@:privateAccess
		SDL.destroyWindow(cast (window, NativeWindow).native);
		SDL.quit();
	}

	public function shouldQuit() {
		return quitRequested;
	}

	public function pumpEvents():Void {
		while (SDL.pollEvent(event) != SDLBoolean.FALSE) {
			switch (event.ref.type) {
				case QUIT:
					quitRequested = true;
				case WINDOWEVENT:
				default:
			}
		}
	}

	public function getTime():Float {
		return SDL.getTicks64().toInt();
	}

	public function sleep(ms:Float):Void {
		SDL.delay(Std.int(ms));
	}

	public function readBytes(path:String):Bytes {
		throw "not implemented: readBytes";
	}

	public function writeBytes(path:String, data:Bytes):Void {
		throw "not implemented: writeBytes";
	}

	public function fileExists(path:String):Bool {
		return false; // placeholder
	}

	public function isDirectory(path:String):Bool {
		return false; // placeholder
	}

	public function listDirectory(path:String):Array<String> {
		return []; // placeholder
	}

	public function getStorageDirectory():String {
		return ""; // placeholder
	}

	public function getAssetBasePath():String {
		return ""; // placeholder
	}

	public function getScreenWidth():Int {
		return 1920; // placeholder
	}

	public function getScreenHeight():Int {
		return 1080; // placeholder
	}

	public function getDisplaysCount():Int {
		return 1; // placeholder
	}

	public function getDisplayBounds(index:Int):{
		x:Int,
		y:Int,
		width:Int,
		height:Int
	} {
		return {
			x: 0,
			y: 0,
			width: 1920,
			height: 1080
		}; // placeholder
	}

	public function requestFullscreen():Bool {
		return false; // placeholder
	}

	public function exitFullscreen():Void {
		// placeholder
	}

	public function setClipboardText(text:String):Void {
		// placeholder
	}

	public function getClipboardText():String {
		return ""; // placeholder
	}

	public function openURL(url:String):Void {
		// placeholder
	}
}
#end