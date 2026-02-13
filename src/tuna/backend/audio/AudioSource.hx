package tuna.backend.audio;

import tuna.math.Vec3;

interface AudioSource {
	public var buffer:AudioBuffer;
	public var volume(get, set):Float;
	public var pitch(get, set):Float;
	public var loop(get, set):Bool;
	public var playing(get, never):Bool;
	public var time(get, set):Float;
	public var duration(get, never):Float;
	public var positionX(get, set):Float;
	public var positionY(get, set):Float;
	public var positionZ(get, set):Float;

	public function play():Void;
	public function pause():Void;
	public function stop():Void;
	public function destroy():Void;
}
