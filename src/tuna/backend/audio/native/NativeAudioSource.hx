package tuna.backend.audio.native;

#if cpp
import cpp.UInt32;
import cpp.RawPointer;
import native.al.AL;

class NativeAudioSource implements AudioSource {
	public var buffer:AudioBuffer;
	public var volume(get, set):Float;

	public var _alSource:UInt32;

	public function new(buffer:AudioBuffer) {
		this.buffer = buffer;
		_alSource = 0;
		AL.genSources(1, RawPointer.addressOf(_alSource));
		AL.sourcei(_alSource, AL.BUFFER, cast(buffer, NativeAudioBuffer).data);
		volume = 1;
	}

	public function play() {
		AL.sourcePlay(_alSource);
		var state:Int = 0;
		AL.getSourcei(_alSource, AL.SOURCE_STATE, RawPointer.addressOf(state));
	}

	public function destroy() {
		AL.deleteSources(1, RawPointer.addressOf(_alSource));
	}

	public function set_volume(value:Float):Float {
		AL.sourcef(_alSource, AL.GAIN, Math.max(0, Math.min(1, value)));
		return volume;
	}

	public function get_volume():Float {
		var value:Single = 0;
		AL.getSourcef(_alSource, AL.GAIN, RawPointer.addressOf(value));
		return value;
	}
}
#end
