package tuna.backend.platform.web;

import tuna.backend.opengl.GL;
#if (js || html5)
import tuna.utils.Color;
import js.html.CanvasElement;
import js.Browser;

class WebWindow implements IWindow {
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

	var canvas:CanvasElement;
	var _title:String;
	var _width:Int;
	var _height:Int;
	var _visible:Bool = true;
	var _fullscreen:Bool = false;

	public function new(width:Int, height:Int, title:String) {
		_width = width;
		_height = height;
		_title = title;

		canvas = Browser.document.createCanvasElement();
		canvas.width = width;
		canvas.height = height;
		canvas.style.display = 'block';
		Browser.document.body.appendChild(canvas);

		Browser.document.title = title;

		var contextOptions = {
			alpha: false,
			depth: depthBuffer,
			stencil: stencilBuffer,
			antialias: false,
			premultipliedAlpha: true,
			preserveDrawingBuffer: false
		};

		GL.context = canvas.getContextWebGL2(contextOptions);
		if (GL.context == null) {
			GL.context = canvas.getContext('experimental-webgl', contextOptions);
		}
	}

	public function clear() {
		GL.clearColor(background.r / 255, background.g / 255, background.b / 255, 1);
		GL.clear(GL.COLOR_BUFFER_BIT);
	}

	public function render() {
	}

	public function set_fullscreen(value:Bool):Bool {
		_fullscreen = value;
		if (value) {
			var elem:Dynamic = canvas;
			if (elem.requestFullscreen != null) {
				elem.requestFullscreen();
			} else if (elem.webkitRequestFullscreen != null) {
				elem.webkitRequestFullscreen();
			} else if (elem.mozRequestFullScreen != null) {
				elem.mozRequestFullScreen();
			} else if (elem.msRequestFullscreen != null) {
				elem.msRequestFullscreen();
			}
		} else {
			var doc:Dynamic = Browser.document;
			if (doc.exitFullscreen != null) {
				doc.exitFullscreen();
			} else if (doc.webkitExitFullscreen != null) {
				doc.webkitExitFullscreen();
			} else if (doc.mozCancelFullScreen != null) {
				doc.mozCancelFullScreen();
			} else if (doc.msExitFullscreen != null) {
				doc.msExitFullscreen();
			}
		}
		return value;
	}

	public function get_fullscreen():Bool {
		return _fullscreen;
	}

	public function set_maximized(value:Bool):Bool {
		if (value) {
			canvas.width = Browser.window.innerWidth;
			canvas.height = Browser.window.innerHeight;
			_width = canvas.width;
			_height = canvas.height;
		}
		return value;
	}

	public function get_maximized():Bool {
		return canvas.width == Browser.window.innerWidth && canvas.height == Browser.window.innerHeight;
	}

	public function set_borderless(value:Bool):Bool {
		return value;
	}

	public function get_borderless():Bool {
		return true;
	}

	public function set_resizable(value:Bool):Bool {
		return value;
	}

	public function get_resizable():Bool {
		return false;
	}

	public function set_visibility(value:Bool):Bool {
		_visible = value;
		canvas.style.display = value ? 'block' : 'none';
		return value;
	}

	public function get_visibility():Bool {
		return _visible;
	}

	public function set_width(value:Int):Int {
		_width = value;
		canvas.width = value;
		return value;
	}

	public function get_width():Int {
		return _width;
	}

	public function set_height(value:Int):Int {
		_height = value;
		canvas.height = value;
		return value;
	}

	public function get_height():Int {
		return _height;
	}

	public function set_x(value:Int):Int {
		canvas.style.left = value + 'px';
		canvas.style.position = 'absolute';
		return value;
	}

	public function get_x():Int {
		return Std.parseInt(canvas.style.left);
	}

	public function set_y(value:Int):Int {
		canvas.style.top = value + 'px';
		canvas.style.position = 'absolute';
		return value;
	}

	public function get_y():Int {
		return Std.parseInt(canvas.style.top);
	}

	public function set_title(value:String):String {
		_title = value;
		Browser.document.title = value;
		return value;
	}

	public function get_title():String {
		return _title;
	}
}
#end