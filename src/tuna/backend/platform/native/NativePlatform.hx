package tuna.backend.platform.native;

#if cpp
import native.sdl.Types;
import native.sdl.SDL;
import haxe.io.Bytes;

class NativePlatform implements IPlatform {
	public var window:IWindow;
	public var mainLoop:Void->Void;

	private var quitRequested:Bool = false;
	private var event:SDLEvent;

	public function new() {}

	public function init(width:Int, height:Int, title:String):Void {
		SDL.init(EVERYTHING);
		event = SDL.makeEvent();

		window = new NativeWindow(width, height, title);
	}

	public function initLoop() {
		while (!shouldQuit()) {
			if (mainLoop != null)
				mainLoop();
		}
	}

	public function shutdown():Void {
		@:privateAccess
		SDL.destroyWindow(cast(window, NativeWindow).native);
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
}
#end
