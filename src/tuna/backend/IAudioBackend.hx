package tuna.backend;

import haxe.io.Bytes;
import tuna.backend.audio.AudioBuffer;
import tuna.backend.audio.AudioSource;

interface IAudioBackend {
	public function destroy():Void;

	public function createBuffer(data:haxe.io.Bytes):AudioBuffer;
	public function createSource(buffer:AudioBuffer):AudioSource;
}
