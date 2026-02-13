package tuna.backend.platform.native;

#if cpp
import tuna.input.Keyboard;
import tuna.input.Mouse;
import tuna.input.KeyCode;
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
				case KEYDOWN:
					Keyboard.onKeyDown(KeyCode.fromSDL2(event.ref.key.keysym.sym));
				case KEYUP:
					Keyboard.onKeyUp(KeyCode.fromSDL2(event.ref.key.keysym.sym));
				case MOUSEMOTION:
					var deltaX:Float = event.ref.motion.xRel;
					var deltaY:Float = event.ref.motion.yRel;
					Mouse.onMove(event.ref.motion.x, event.ref.motion.y, deltaX, deltaY);
				case MOUSEBUTTONDOWN:
					Mouse.onClickDown(switch (event.ref.button.button) {
						case 0: 0;
						case 1: 3;
						case 2: 2;
						default: cast event.ref.button.button;
					});
				case MOUSEBUTTONUP:
					Mouse.onClickUp(switch (event.ref.button.button) {
						case 0: 0;
						case 1: 3;
						case 2: 2;
						default: cast event.ref.button.button;
					});
				case MOUSEWHEEL:
					Mouse.onScroll(event.ref.wheel.y);
				default:
			}
		}
	}
}
#end