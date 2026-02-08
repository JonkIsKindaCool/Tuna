package tuna.core;

import tuna.utils.Time;
import tuna.backend.IPlatform;
import tuna.backend.platform.native.NativePlatform;

class Application {
	public var platform:IPlatform;
	public var fps:Int = 60;

	public function new() {}

	public function init() {}

	var prevTime:Float = 0;
	var currentTime:Float = 0;
	var deltaTime:Float = 0;

	public function loop() {
		currentTime = Time.getTime();
		deltaTime = (currentTime - prevTime) / 1000.0;

		platform.pumpEvents();
		platform.window.clear();

		update(deltaTime);
		draw();
		platform.window.render();

		prevTime = Time.getTime();
		Time.sleep(1000 / fps);
	}

	public function update(dt:Float) {
	}

	public function draw() {}
}
