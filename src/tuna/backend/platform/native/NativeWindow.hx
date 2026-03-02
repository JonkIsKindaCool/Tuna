package tuna.backend.platform.native;

#if (cpp || hl)
import tuna.backend.cffi.NativeWindowCFFI;
import tuna.utils.Color;

class NativeWindow implements IWindow {
	public var title(get, set):String;
	public var x(get, set):Int;
	public var y(get, set):Int;
	public var width(get, set):Int;
	public var height(get, set):Int;
	public var visibility(get, set):Bool;
	public var resizable(get, set):Bool;
	public var borderless(get, set):Bool;
	public var maximized(get, set):Bool;
	public var fullscreen(get, set):Bool;
	public var background:Color = 0x000000;

	public static var hardware:Bool = false;
	public static var depthBuffer:Bool = false;
	public static var stencilBuffer:Bool = false;
	public static var allowHighDPI:Bool = false;

	public function new(width:Int, height:Int, title:String) {
		NativeWindowCFFI.window_enableDepthBuffer(depthBuffer);
		NativeWindowCFFI.window_enableStencilBuffer(stencilBuffer);
		NativeWindowCFFI.window_init(width, height, title, allowHighDPI);
		this.resizable = true;
		this.borderless = false;
		this.fullscreen = false;
		this.maximized = false;
		this.visibility = true;
	}

	public function clear() {
		NativeWindowCFFI.clear();
	}

	public function render() {
		NativeWindowCFFI.render();
	}

	public function set_fullscreen(value:Bool):Bool {
		return NativeWindowCFFI.set_fullscreen(value);
	}

	public function get_fullscreen():Bool {
		return NativeWindowCFFI.get_fullscreen();
	}

	public function set_maximized(value:Bool):Bool {
		return NativeWindowCFFI.set_maximized(value);
	}

	public function get_maximized():Bool {
		return NativeWindowCFFI.get_maximized();
	}

	public function set_borderless(value:Bool):Bool {
		return NativeWindowCFFI.set_borderless(!value);
	}

	public function get_borderless():Bool {
		return NativeWindowCFFI.get_borderless();
	}

	public function set_resizable(value:Bool):Bool {
		return NativeWindowCFFI.set_resizable(value);
	}

	public function get_resizable():Bool {
		return NativeWindowCFFI.get_resizable();
	}

	public function set_visibility(value:Bool):Bool {
		return NativeWindowCFFI.set_visibility(value);
	}

	public function get_visibility():Bool {
		return NativeWindowCFFI.get_visibility();
	}

	public function set_width(value:Int):Int {
		return NativeWindowCFFI.set_width(value);
	}

	public function get_width():Int {
		return NativeWindowCFFI.get_width();
	}

	public function set_height(value:Int):Int {
		return NativeWindowCFFI.set_height(value);
	}

	public function get_height():Int {
		return NativeWindowCFFI.get_height();
	}

	public function set_x(value:Int):Int {
		return NativeWindowCFFI.set_x(value);
	}

	public function get_x():Int {
		return NativeWindowCFFI.get_x();
	}

	public function set_y(value:Int):Int {
		return NativeWindowCFFI.set_y(value);
	}

	public function get_y():Int {
		return NativeWindowCFFI.get_y();
	}

	public function set_title(value:String):String {
		return NativeWindowCFFI.set_title(value);
	}

	public function get_title():String {
		#if hl
		var bytes:hl.Bytes = NativeWindowCFFI.get_title();
		var len:Int = 0;
		while (bytes[len] != 0)
			len++;

		var haxeBytes = bytes.toBytes(len);
		return haxeBytes.toString();
		#else
		return NativeWindowCFFI.get_title();
		#end
	}

	public function destroy():Void {
		NativeWindowCFFI.window_destroy();
	}
}
#end
