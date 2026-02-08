package tuna.backend.core;

import tuna.backend.platform.native.NativePlatform;
import tuna.backend.platform.Platform;

class Application {
	public var platform:Platform;
	public var fps:Int = 60;

	public function new() {}

	@:noCompletion
	private function _realInit() {
		init();

		loop();
		platform.shutdown();
	}

	public function init() {}

	var prevTime:Float = 0;
	var currentTime:Float = 0;
	var deltaTime:Float = 0;

	public function loop() {
		while (!platform.shouldQuit()) {
			currentTime = platform.getTime();
			deltaTime = (currentTime - prevTime) / 1000.0;

			platform.pumpEvents();
			platform.window.clear();

			update(deltaTime);
			draw();
			platform.window.render();

			prevTime = platform.getTime();
			platform.sleep(1000 / fps);
		}
	}

	public function update(dt:Float) {}

	public function draw() {}
}
