package tuna.backend;

interface IPlatform {
	public var window:IWindow;
	public var mainLoop:Void -> Void;

	public function init(width:Int, height:Int, title:String):Void;
	public function shutdown():Void;
	public function pumpEvents():Void;

	public function shouldQuit():Bool;

	public function initLoop():Void;
}