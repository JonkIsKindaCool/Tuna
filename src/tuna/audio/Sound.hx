package tuna.audio;

import tuna.io.Assets;
import tuna.core.Application;
import tuna.backend.audio.AudioBuffer;
import tuna.backend.audio.AudioSource;
import haxe.io.Bytes;
import haxe.extern.EitherType;

typedef SoundAsset = EitherType<String, AudioBuffer>;

class Sound {
	public var source:AudioSource;
	public var buffer:AudioBuffer;

	public function new(file:SoundAsset) {
		if (Std.isOfType(file, AudioBuffer)) {
			buffer = cast file;
		} else {
			buffer = Application.audioBackend.createBuffer(Assets.loadBytes(file));
		}
		source = Application.audioBackend.createSource(buffer);
        source.play();
	}
}
