package tuna.backend.cffi;

@:build(tuna.backend.macro.CFFIMacro.build("tuna"))
class NativePlatformCFFI {
	public static function init():Void;

	public static function quit():Void;

	public static function preLoop():Void;

	public static function hasEvent():Bool;

	public static function getEventType():Int;

	public static function getKeyboardState():Dynamic;

	public static function getMouseState():Dynamic;
}