package tuna.events.types;

class Event {
    public static var WINDOW_QUIT:Int = 0;
    public static var WINDOW_MOVE:Int = 1;
    public static var WINDOW_RESIZE:Int = 2;
    
    public static var KEY_DOWN:Int = 3;
    public static var KEY_UP:Int = 4;

    public static var MOUSE_MOVE:Int = 5;
    public static var MOUSE_SCROLL:Int = 6;
    public static var MOUSE_CLICK_DOWN:Int = 7;
    public static var MOUSE_CLICK_UP:Int = 7;

    public var cancelled:Bool;

	public function new() {}

    public inline function cancel() {
        cancelled = true;
    }
}
