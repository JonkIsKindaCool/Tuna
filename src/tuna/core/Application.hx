package tuna.core;

import tuna.events.types.MouseEvent;
import tuna.events.types.KeyboardEvent;
import tuna.events.types.Event;
import tuna.events.EventDispatcher;
import tuna.backend.opengl.GL;
import tuna.backend.IAudioBackend;
import tuna.input.MouseCode;
import tuna.input.KeyCode;
import tuna.utils.Time;
import tuna.backend.IPlatform;
import tuna.backend.platform.native.NativePlatform;

class Application {
	public var platform:IPlatform;
	public var fps:Int = 60;

	public var audioBackend:IAudioBackend;

	public static var instance:Application;

	public function new() {
		instance = this;
		#if cpp
		audioBackend = new tuna.backend.audio.native.NativeAudioBackend();
		#elseif (js || html5)
		audioBackend = new tuna.backend.audio.web.WebAudioBackend();
		#end

		EventDispatcher.addEventListener(Event.KEY_DOWN, onKeyDown);
		EventDispatcher.addEventListener(Event.KEY_UP, onKeyUp);

		EventDispatcher.addEventListener(Event.MOUSE_MOVE, onMouseMove);
		EventDispatcher.addEventListener(Event.MOUSE_CLICK_DOWN, onClickDown);
		EventDispatcher.addEventListener(Event.MOUSE_CLICK_UP, onClickUp);
		EventDispatcher.addEventListener(Event.MOUSE_SCROLL, onScroll);
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

	public function onKeyDown(ev:KeyboardEvent) {}

	public function onKeyUp(ev:KeyboardEvent) {}

	public function onMouseMove(ev:MouseMoveEvent) {}

	public function onClickDown(ev:MouseClickEvent) {}

	public function onClickUp(ev:MouseClickEvent) {}

	public function onScroll(ev:MouseScrollEvent) {}

	public function onResize(width:Int, height:Int) {
		GL.viewport(0, 0, width, height);
	}
}
