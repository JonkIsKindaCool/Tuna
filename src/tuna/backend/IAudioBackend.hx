package tuna.backend;

import haxe.io.Bytes;
import tuna.backend.audio.AudioBuffer;
import tuna.backend.audio.AudioSource;

interface IAudioBackend {
	public function init():Void;

	public function destroy():Void;

	public function createSource(b:AudioBuffer):AudioSource;
	public function createBuffer(b:Bytes):AudioBuffer;
}
