package tuna.backend.platform;

import tuna.backend.window.Window;
import tuna.input.InputState;

interface Platform {
	public var window:Window;

	public function init(width:Int, height:Int, title:String):Void;
	public function shutdown():Void;
	public function pumpEvents():Void;
	public function getTime():Float;
	public function sleep(seconds:Float):Void;

	public function shouldQuit():Bool;
	public function setClipboardText(text:String):Void;
	public function getClipboardText():String;
}
