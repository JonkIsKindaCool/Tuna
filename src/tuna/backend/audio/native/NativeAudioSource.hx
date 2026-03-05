package tuna.backend.audio.native;

import tuna.backend.audio.openal.AL;
#if cpp
import cpp.UInt32;
import cpp.RawPointer;

class NativeAudioSource implements AudioSource {
	public var buffer:AudioBuffer;
	public var volume(get, set):Float;
	public var pitch(get, set):Float;
	public var loop(get, set):Bool;
	public var playing(get, never):Bool;
	public var time(get, set):Float;
	public var duration(get, never):Float;

	@:isVar public var positionX(get, set):Float;
	@:isVar public var positionY(get, set):Float;
	@:isVar public var positionZ(get, set):Float;

	private var _alSource:Int;

	public function new(buffer:AudioBuffer) {
		this.buffer = buffer;
		_alSource = 0;
		_alSource = AL.genSource();
		AL.sourcei(_alSource, AL.BUFFER, cast(buffer, NativeAudioBuffer).data);
		AL.source3f(_alSource, AL.POSITION, 0, 0, 0);

		AL.sourcef(_alSource, AL.REFERENCE_DISTANCE, 1.0);
		AL.sourcef(_alSource, AL.MAX_DISTANCE, 50.0);
		AL.sourcef(_alSource, AL.ROLLOFF_FACTOR, 3.0);
		volume = 1;
		pitch = 1;
		loop = false;
	}

	public function play() {
		AL.sourcePlay(_alSource);
	}

	public function pause() {
		AL.sourcePause(_alSource);
	}

	public function stop() {
		AL.sourceStop(_alSource);
	}

	public function destroy() {
		AL.sourcei(_alSource, AL.BUFFER, 0);
		AL.deleteSource(_alSource);
	}

	private function set_volume(value:Float):Float {
		AL.sourcef(_alSource, AL.GAIN, Math.max(0, Math.min(1, value)));
		return value;
	}

	private function get_volume():Float {
		var value:Single = 0;
		value = AL.getSourcef(_alSource, AL.GAIN);
		return value;
	}

	private function set_pitch(value:Float):Float {
		AL.sourcef(_alSource, AL.PITCH, Math.max(0.5, Math.min(2.0, value)));
		return value;
	}

	private function get_pitch():Float {
		var value:Single = 0;
		value = AL.getSourcef(_alSource, AL.PITCH);
		return value;
	}

	private function set_loop(value:Bool):Bool {
		AL.sourcei(_alSource, AL.LOOPING, value ? AL.TRUE : AL.FALSE);
		return value;
	}

	private function get_loop():Bool {
		var value:Int = 0;
		value = AL.getSourcei(_alSource, AL.LOOPING);
		return value == AL.TRUE;
	}

	private function get_playing():Bool {
		var state:Int = 0;
		state = AL.getSourcei(_alSource, AL.SOURCE_STATE);
		return state == AL.PLAYING;
	}

	private function set_time(value:Float):Float {
		AL.sourcef(_alSource, AL.SEC_OFFSET, value / 1000);
		return value;
	}

	private function get_time():Float {
		var value:Single = 0;
		value = AL.getSourcef(_alSource, AL.SEC_OFFSET);
		return value * 1000;
	}

	private function get_duration():Float {
		return buffer.duration;
	}

	public function set_positionX(value:Float):Float {
		positionX = value;
		AL.source3f(_alSource, AL.POSITION, positionX, positionY, positionZ);
		return value;
	}

	public function get_positionX():Float {
		return positionX;
	}

	public function set_positionY(value:Float):Float {
		positionY = value;
		AL.source3f(_alSource, AL.POSITION, positionX, positionY, positionZ);
		return value;
	}

	public function get_positionY():Float {
		return positionY;
	}

	public function set_positionZ(value:Float):Float {
		positionZ = value;
		AL.source3f(_alSource, AL.POSITION, positionX, positionY, positionZ);
		return value;
	}

	public function get_positionZ():Float {
		return positionZ;
	}
}
#end
