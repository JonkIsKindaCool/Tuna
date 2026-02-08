package tuna.backend.platform.native;

#if cpp
import native.sdl.Types;
import native.sdl.SDL;
import tuna.backend.window.Window;
import tuna.utils.Color;
import native.glad.Glad;

class NativeWindow implements Window {
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

	private var native:SDLWindow;
	private var context:SDLGlContext;

	public function new(width:Int, height:Int, title:String) {
		untyped __cpp__("SDL_GL_SetAttribute({0}, {1})", untyped __cpp__("SDL_GL_CONTEXT_MAJOR_VERSION"), 3);
		untyped __cpp__("SDL_GL_SetAttribute({0}, {1})", untyped __cpp__("SDL_GL_CONTEXT_MINOR_VERSION"), 3);
		untyped __cpp__("SDL_GL_SetAttribute({0}, {1})", untyped __cpp__("SDL_GL_CONTEXT_PROFILE_MASK"), SDLGlProfile.CORE);

		if (depthBuffer) {
			untyped __cpp__("SDL_GL_SetAttribute({0}, {1})", untyped __cpp__("SDL_GL_DEPTH_SIZE"), 24);
		}
		if (stencilBuffer) {
			untyped __cpp__("SDL_GL_SetAttribute({0}, {1})", untyped __cpp__("SDL_GL_STENCIL_SIZE"), 8);
		}
		untyped __cpp__("SDL_GL_SetAttribute({0}, {1})", untyped __cpp__("SDL_GL_RED_SIZE"), 8);
		untyped __cpp__("SDL_GL_SetAttribute({0}, {1})", untyped __cpp__("SDL_GL_GREEN_SIZE"), 8);
		untyped __cpp__("SDL_GL_SetAttribute({0}, {1})", untyped __cpp__("SDL_GL_BLUE_SIZE"), 8);
		untyped __cpp__("SDL_GL_SetAttribute({0}, {1})", untyped __cpp__("SDL_GL_ALPHA_SIZE"), 8);

		untyped __cpp__("SDL_GL_SetAttribute({0}, {1})", untyped __cpp__("SDL_GL_DOUBLEBUFFER"), 1);

		var flags:UInt = SDLWindowInitFlags.OPENGL | SDLWindowInitFlags.SHOWN;

		if (allowHighDPI) {
			flags |= SDLWindowInitFlags.ALLOW_HIGHDPI;
		}

		native = SDL.createWindow(title, SDLWindowPos.CENTERED, SDLWindowPos.CENTERED, width, height, flags);

		if (native == null) {
			throw 'Couldnt create sdl window: ${SDL.getError()}';
		}

		context = SDL.glCreateContext(native);
		if (context == null) {
			throw 'Couldnt create opengl context: ${SDL.getError()}';
		}

		if (untyped __cpp__("gladLoadGLLoader((GLADloadproc)SDL_GL_GetProcAddress)") != Glad.TRUE) {
			throw "Couldnt load opengl with glad";
		}

		GL.enable(GL.BLEND);
		GL.blendFunc(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA);

		SDL.glMakeCurrent(native, context);

		this.resizable = true;
		this.borderless = false;
		this.fullscreen = false;
		this.maximized = false;
		this.visibility = true;
	}

	public function clear() {
		GL.clearColor(background.r / 255, background.g / 255, background.b / 255, 1);
		GL.clear(GL.COLOR_BUFFER_BIT);
	}

	public function render() {
		SDL.glSwapWindow(native);
	}

	public function set_fullscreen(value:Bool):Bool {
		var flags = value ? SDLWindowInitFlags.FULLSCREEN_DESKTOP : 0;
		SDL.setWindowFullscreen(native, flags);
		return value;
	}

	public function get_fullscreen():Bool {
		var flags = SDL.getWindowFlags(native);
		return (flags & SDLWindowInitFlags.FULLSCREEN) != 0 || (flags & SDLWindowInitFlags.FULLSCREEN_DESKTOP) != 0;
	}

	public function set_maximized(value:Bool):Bool {
		if (value) {
			SDL.maximizeWindow(native);
		} else {
			SDL.restoreWindow(native);
		}
		return value;
	}

	public function get_maximized():Bool {
		var flags = SDL.getWindowFlags(native);
		return (flags & SDLWindowInitFlags.MAXIMIZED) != 0;
	}

	public function set_borderless(value:Bool):Bool {
		SDL.setWindowBordered(native, !value);
		return value;
	}

	public function get_borderless():Bool {
		var flags = SDL.getWindowFlags(native);
		return (flags & SDLWindowInitFlags.BORDERLESS) != 0;
	}

	public function set_resizable(value:Bool):Bool {
		SDL.setWindowResizable(native, value);
		return value;
	}

	public function get_resizable():Bool {
		var flags = SDL.getWindowFlags(native);
		return (flags & SDLWindowInitFlags.RESIZABLE) != 0;
	}

	public function set_visibility(value:Bool):Bool {
		if (value) {
			SDL.showWindow(native);
		} else {
			SDL.hideWindow(native);
		}
		return value;
	}

	public function get_visibility():Bool {
		var flags = SDL.getWindowFlags(native);
		return (flags & SDLWindowInitFlags.HIDDEN) == 0;
	}

	public function set_width(value:Int):Int {
		var h = get_height();
		SDL.setWindowSize(native, value, h);
		return value;
	}

	public function get_width():Int {
		var size:SDLPoint = SDL.getWindowSize(native);
		return size.x;
	}

	public function set_height(value:Int):Int {
		var w = get_width();
		SDL.setWindowSize(native, w, value);
		return value;
	}

	public function get_height():Int {
		var size:SDLPoint = SDL.getWindowSize(native);
		return size.y;
	}

	public function set_x(value:Int):Int {
		var yPos = get_y();
		SDL.setWindowPosition(native, value, yPos);
		return value;
	}

	public function get_x():Int {
		var pos:SDLPoint = SDL.getWindowPosition(native);
		return pos.x;
	}

	public function set_y(value:Int):Int {
		var xPos = get_x();
		SDL.setWindowPosition(native, xPos, value);
		return value;
	}

	public function get_y():Int {
		var pos:SDLPoint = SDL.getWindowPosition(native);
		return pos.y;
	}

	public function set_title(value:String):String {
		SDL.setWindowTitle(native, value);
		return value;
	}

	public function get_title():String {
		return SDL.getWindowTitle(native);
	}
}
#end
