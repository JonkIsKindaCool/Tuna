package tuna.backend.audio.web;

import tuna.backend.audio.web.WebAudioSource;
import js.html.audio.AudioContext;
import haxe.io.Bytes;

class WebAudioBackend implements IAudioBackend {
	public static var context:AudioContext;

	public function new() {
		context = new AudioContext();
	}

	public function destroy() {
		context.close();
	}

	public function createBuffer(data:Bytes):AudioBuffer {
		return new WebAudioBuffer(data);
	}

	public function createSource(buffer:AudioBuffer):AudioSource {
		return new WebAudioSource(buffer);
	}
}
