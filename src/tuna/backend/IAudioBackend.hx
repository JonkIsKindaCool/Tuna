package tuna.backend;

import haxe.io.Bytes;
import tuna.backend.audio.AudioBuffer;
import tuna.backend.audio.AudioSource;

interface IAudioBackend {
	//I HATE YOU WEBAUDIO
	public var listenerPositionX(get, set):Float;
	public var listenerPositionY(get, set):Float;
	public var listenerPositionZ(get, set):Float;

	public function destroy():Void;

	public function createBuffer(data:haxe.io.Bytes):AudioBuffer;
	public function createSource(buffer:AudioBuffer):AudioSource;
}
