package tuna.backend.platform.web;

#if (js || html5)
import js.Browser;

class WebPlatform implements IPlatform {
	public var window:IWindow;
	public var mainLoop:Void->Void;

	private var quitRequested:Bool = false;
	private var animationFrameId:Int = -1;

	public function new() {}

	public function initLoop() {
		function loop(_) {
			if (!shouldQuit()) {
				pumpEvents();
				if (mainLoop != null)
					mainLoop();
				animationFrameId = Browser.window.requestAnimationFrame(loop);
			}
		}

		animationFrameId = Browser.window.requestAnimationFrame(loop);
	}

	public function init(width:Int, height:Int, title:String) {
		window = new WebWindow(width, height, title);
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
