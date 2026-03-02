package tuna.backend.platform.native;

#if (cpp || hl)
import tuna.input.KeyCode;
import tuna.events.types.MouseEvent;
import tuna.events.types.KeyboardEvent;
import tuna.events.types.Event;
import tuna.events.EventDispatcher;
import tuna.backend.cffi.NativePlatformCFFI;

class NativePlatform implements IPlatform {
	public var window:IWindow;
	public var mainLoop:Void->Void;

	private var quitRequested:Bool = false;

	public function new() {}

	public function init(width:Int, height:Int, title:String):Void {
		NativePlatformCFFI.init();

		window = new NativeWindow(width, height, title);
	}

	public function initLoop() {
		while (!shouldQuit()) {
			NativePlatformCFFI.preLoop();
			if (mainLoop != null)
				mainLoop();
		}
	}

	public function shutdown():Void {
		@:privateAccess
		window.destroy();
		NativePlatformCFFI.quit();
	}

	public function shouldQuit() {
		return quitRequested;
	}

	public function pumpEvents():Void {
		while (NativePlatformCFFI.hasEvent()) {
			var eventType:Int = NativePlatformCFFI.getEventType();

			switch (eventType) {
				case SDLEventType.QUIT:
					var ev:Event = new Event();
					EventDispatcher.dispatch(Event.WINDOW_QUIT, ev);

					if (!ev.cancelled)
						quitRequested = true;
				case SDLEventType.KEYDOWN:
					var keyEv:KeyboardEvent = new KeyboardEvent();
					keyEv.keyId = KeyCode.fromSDL2(NativePlatformCFFI.getKeyboardState().key);

					EventDispatcher.dispatch(Event.KEY_DOWN, keyEv);
				case SDLEventType.KEYUP:
					var keyEv:KeyboardEvent = new KeyboardEvent();
					keyEv.keyId = KeyCode.fromSDL2(NativePlatformCFFI.getKeyboardState().key);

					EventDispatcher.dispatch(Event.KEY_UP, keyEv);
				case SDLEventType.MOUSEMOTION:
					var state = NativePlatformCFFI.getMouseState();
					var ev = new MouseMoveEvent();
					ev.x = state.x;
					ev.y = state.y;
					ev.delX = state.delX;
					ev.delY = state.delY;

					EventDispatcher.dispatch(Event.MOUSE_MOVE, ev);

				case SDLEventType.MOUSEBUTTONDOWN:
					var state = NativePlatformCFFI.getMouseState();
					var ev = new MouseClickEvent();

					ev.button = switch (state.button) {
						case 1: 0;
						case 2: 2;
						case 3: 1; 
						default: state.button;
					};

					EventDispatcher.dispatch(Event.MOUSE_CLICK_DOWN, ev);

				case SDLEventType.MOUSEBUTTONUP:
					var state = NativePlatformCFFI.getMouseState();
					var ev = new MouseClickEvent();

					ev.button = switch (state.button) {
						case 1: 0; 
						case 2: 2;
						case 3: 1;
						default: state.button;
					};

					EventDispatcher.dispatch(Event.MOUSE_CLICK_UP, ev);

				case SDLEventType.MOUSEWHEEL:
					var state = NativePlatformCFFI.getMouseState();
					var ev = new MouseScrollEvent();

					ev.scroll = state.wheel > 0 ? 1 : (state.wheel < 0 ? -1 : 0);

					EventDispatcher.dispatch(Event.MOUSE_SCROLL, ev); 
			}
		}
	}
}

private enum abstract SDLEventType(Int) from Int to Int {
	var QUIT = 0x100;
	var APP_TERMINATING;
	var APP_LOWMEMORY;
	var APP_WILLENTERBACKGROUND;
	var APP_DIDENTERBACKGROUND;
	var APP_WILLENTERFOREGROUND;
	var APP_DIDENTERFOREGROUND;
	var LOCALECHANGED;
	var DISPLAYEVENT = 0x150;
	var WINDOWEVENT = 0x200;
	var SYSWMEVENT;
	var KEYDOWN = 0x300;
	var KEYUP;
	var TEXTEDITING;
	var TEXTINPUT;
	var KEYMAPCHANGED;
	var TEXTEDITING_EXT;
	var MOUSEMOTION = 0x400;
	var MOUSEBUTTONDOWN;
	var MOUSEBUTTONUP;
	var MOUSEWHEEL;
	var JOYAXISMOTION = 0x600;
	var JOYBALLMOTION;
	var JOYHATMOTION;
	var JOYBUTTONDOWN;
	var JOYBUTTONUP;
	var JOYDEVICEADDED;
	var JOYDEVICEREMOVED;
	var JOYBATTERYUPDATED;
	var CONTROLLERAXISMOTION = 0x650;
	var CONTROLLERBUTTONDOWN;
	var CONTROLLERBUTTONUP;
	var CONTROLLERDEVICEADDED;
	var CONTROLLERDEVICEREMOVED;
	var CONTROLLERDEVICEREMAPPED;
	var CONTROLLERTOUCHPADDOWN;
	var CONTROLLERTOUCHPADMOTION;
	var CONTROLLERTOUCHPADUP;
	var CONTROLLERSENSORUPDATE;
	var CONTROLLERUPDATECOMPLETE_RESERVED_FOR_SDL3;
	var CONTROLLERSTEAMHANDLEUPDATED;
	var FINGERDOWN = 0x700;
	var FINGERUP;
	var FINGERMOTION;
	var DOLLARGESTURE = 0x800;
	var DOLLARRECORD;
	var MULTIGESTURE;
	var CLIPBOARDUPDATE = 0x900;
	var DROPFILE = 0x1000;
	var DROPTEXT;
	var DROPBEGIN;
	var DROPCOMPLETE;
	var AUDIODEVICEADDED = 0x1100;
	var AUDIODEVICEREMOVED;
	var SENSORUPDATE = 0x1200;
	var RENDER_TARGETS_RESET = 0x2000;
	var RENDER_DEVICE_RESET;
	var POLLSENTINEL = 0x7F00;
	var USEREVENT = 0x8000;
	var LASTEVENT = 0xFFFF;
}
#end
