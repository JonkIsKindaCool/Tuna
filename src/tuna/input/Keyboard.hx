package tuna.input;

import tuna.utils.Signal;

class Keyboard {
	public static var keyDown:Signal<KeyCode> = new Signal();
	public static var keyUp:Signal<KeyCode> = new Signal();

	public static function onKeyDown(key:KeyCode) {
		keyDown.dispatch(key);
	}

	public static function onKeyUp(key:KeyCode) {
		keyUp.dispatch(key);
	}
}