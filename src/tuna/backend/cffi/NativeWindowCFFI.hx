package tuna.backend.cffi;

@:build(tuna.backend.macro.CFFIMacro.build("tuna"))
class NativeWindowCFFI {
	public static function window_enableDepthBuffer(val:Bool):Void;
	public static function window_enableStencilBuffer(val:Bool):Void;

	public static function window_init(width:Int, height:Int, title:String, dpi:Bool):Void;

	public static function window_destroy():Void;

	public static function set_bg(r:Int, g:Int, b:Int):Void;

	public static function clear():Void;

	public static function render():Void;

	public static function set_fullscreen(fullscreen:Bool):Bool;

	public static function get_fullscreen():Bool;

	public static function set_maximized(maximized:Bool):Bool;

	public static function get_maximized():Bool;

	public static function set_borderless(borderless:Bool):Bool;

	public static function get_borderless():Bool;

	public static function set_resizable(resizable:Bool):Bool;

	public static function get_resizable():Bool;

	public static function set_visibility(visible:Bool):Bool;

	public static function get_visibility():Bool;

	public static function set_width(width:Int):Int;

	public static function get_width():Int;

	public static function set_height(height:Int):Int;

	public static function get_height():Int;

	public static function set_x(x:Int):Int;

	public static function get_x():Int;

	public static function set_y(y:Int):Int;

	public static function get_y():Int;

	public static function set_title(title:String):String;

	#if hl
	public static function get_title():hl.Bytes;
	#else 
	public static function get_title():String; 
	#end 
}
