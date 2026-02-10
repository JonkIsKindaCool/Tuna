package tuna.core;

import tuna.backend.IAudioBackend;
import tuna.input.Mouse;
import tuna.input.MouseCode;
import tuna.input.KeyCode;
import tuna.input.Keyboard;
import tuna.utils.Time;
import tuna.backend.IPlatform;
import tuna.backend.platform.native.NativePlatform;

class Application {
	public var platform:IPlatform;
	public var fps:Int = 60;

	public static var audioBackend:IAudioBackend;

	public function new() {
		#if cpp
		audioBackend = new tuna.backend.audio.native.NativeAudioBackend();
		#elseif (js || html5) 
		audioBackend = new tuna.backend.audio.web.WebAudioBackend();
		#end

		Keyboard.keyDown.add(onKeyDown);
		Keyboard.keyUp.add(onKeyUp);

		Mouse.moveSignal.add(onMove);
		Mouse.clickDownSignal.add(onClickDown);
		Mouse.clickUpSignal.add(onClickUp);
		Mouse.scrollSignal.add(onScroll);
	}

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

	public function update(dt:Float) {}

	public function draw() {}

	public function onKeyDown(key:KeyCode) {}

	public function onKeyUp(key:KeyCode) {}

	public function onMove(x:Float, y:Float, delX:Float, delY:Float) {}

	public function onClickDown(type:MouseCode) {}

	public function onClickUp(type:MouseCode) {}

	public function onScroll(del:Float) {}
}
