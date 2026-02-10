package tuna.backend.platform.web;

#if (js || html5)
import tuna.input.Keyboard;
import tuna.input.KeyCode;
import js.Browser;
import js.html.KeyboardEvent;
import tuna.backend.audio.web.WebAudioBackend;
import js.html.WheelEvent;
import tuna.input.Mouse;
import js.html.MouseEvent;

enum BootState {
	WAIT_INPUT;
	RUNNING;
}

class WebPlatform implements IPlatform {
	public var window:IWindow;
	public var mainLoop:Void->Void;

	private var quitRequested:Bool = false;
	private var animationFrameId:Int = -1;

	private var bootState:BootState = WAIT_INPUT;

	public function new() {}

	public function initLoop() {
		function loop(_) {
			if (shouldQuit())
				return;

			pumpEvents();

			if (bootState == WAIT_INPUT) {
				WebWindow.drawBootScreen(cast(window, WebWindow), cast(window, WebWindow).ctx2d);
			} else {
				if (mainLoop != null)
					mainLoop();
			}

			animationFrameId = Browser.window.requestAnimationFrame(loop);
		}

		animationFrameId = Browser.window.requestAnimationFrame(loop);
	}

	public function init(width:Int, height:Int, title:String) {
		window = new WebWindow(width, height, title);
		var wWindow:WebWindow = cast window;

		wWindow.canvas.addEventListener("keydown", (ev:KeyboardEvent) -> {
			if (WebAudioBackend.context.state != RUNNING) {
				WebAudioBackend.context.resume();
			}
			
			Keyboard.onKeyDown(ev.code);
		});

		wWindow.canvas.addEventListener("keyup", (ev:KeyboardEvent) -> {
			if (WebAudioBackend.context.state != RUNNING) {
				WebAudioBackend.context.resume();
			}

			Keyboard.onKeyUp(ev.code);
		});

		wWindow.canvas.addEventListener("mousemove", function(e:MouseEvent) {
			if (WebAudioBackend.context.state != RUNNING) {
				WebAudioBackend.context.resume();
			}

			Mouse.onMove(e.x, e.y, e.movementX, e.movementY);
		});

		wWindow.preCanvas.addEventListener("mousedown", _ -> {
			if (bootState == WAIT_INPUT) {
				if (WebAudioBackend.context.state != RUNNING) {
					WebAudioBackend.context.resume();
				}

				bootState = RUNNING;
			}
			Browser.document.body.removeChild(wWindow.preCanvas);
			Browser.document.body.appendChild(wWindow.canvas);
		});

		wWindow.canvas.addEventListener('mousedown', function(e:MouseEvent) {
			if (WebAudioBackend.context.state != RUNNING) {
				WebAudioBackend.context.resume();
			}

			if (bootState == WAIT_INPUT) {
				bootState = RUNNING;
			}
			Mouse.onClickDown(switch (e.button) {
				case 0: 0;
				case 1: 3;
				case 2: 2;
				default: e.button;
			});
		});

		wWindow.canvas.addEventListener('mouseup', function(e:MouseEvent) {
			if (WebAudioBackend.context.state != RUNNING) {
				WebAudioBackend.context.resume();
			}

			Mouse.onClickUp(switch (e.button) {
				case 0: 0;
				case 1: 3;
				case 2: 2;
				default: e.button;
			});
		});

		wWindow.canvas.addEventListener('wheel', function(e:WheelEvent) {
			if (WebAudioBackend.context.state != RUNNING) {
				WebAudioBackend.context.resume();
			}

			var normalizedY:Int = 0;
			if (e.deltaY > 0)
				normalizedY = 1;
			else if (e.deltaY < 0)
				normalizedY = -1;

			Mouse.onScroll(normalizedY);
			e.preventDefault();
		});
	}

	public function shutdown() {
		quitRequested = true;
		if (animationFrameId != -1) {
			Browser.window.cancelAnimationFrame(animationFrameId);
			animationFrameId = -1;
		}
	}

	public function pumpEvents() {}

	public function shouldQuit():Bool {
		return quitRequested;
	}
}
#end
