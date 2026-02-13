package tuna.backend.audio.web;

import js.html.audio.PannerNode;
import js.html.audio.AudioBufferSourceNode;
import js.html.audio.GainNode;

#if js
class WebAudioSource implements AudioSource {
	public var buffer:AudioBuffer;

	public var volume(get, set):Float;
	public var pitch(get, set):Float;
	public var loop(get, set):Bool;
	public var playing(get, never):Bool;
	public var time(get, set):Float;
	public var duration(get, never):Float;

	private var _source:AudioBufferSourceNode;
	private var _gain:GainNode;
	private var _panner:PannerNode;

	private var _volume:Float = 1;
	private var _pitch:Float = 1;
	private var _loop:Bool = false;

	private var _startTime:Float = 0;
	private var _offset:Float = 0;
	private var _playing:Bool = false;

	public var positionX(get, set):Float;
	public var positionY(get, set):Float;
	public var positionZ(get, set):Float;

	public function new(buffer:AudioBuffer) {
		this.buffer = buffer;

		_gain = WebAudioBackend.context.createGain();
		_gain.connect(WebAudioBackend.context.destination);

		_panner = WebAudioBackend.context.createPanner();
		_panner.panningModel = HRTF;
		_panner.distanceModel = INVERSE;
		_panner.refDistance = 2.0; 
		_panner.maxDistance = 200.0; 
		_panner.rolloffFactor = 2.0;
		_panner.positionX.value = 0;
		_panner.positionY.value = 0;
		_panner.positionZ.value = 0;
		_panner.connect(WebAudioBackend.context.destination);

		volume = 1;
		pitch = 1;
		loop = false;
	}

	private function createSource() {
		_source = WebAudioBackend.context.createBufferSource();
		_source.buffer = buffer.data;
		_source.loop = _loop;
		_source.playbackRate.value = _pitch;
		_source.connect(_gain).connect(_panner);

		_source.onended = function(_) {
			if (!_loop) {
				_playing = false;
				_offset = 0;
			}
		};
	}

	public function play() {
		if (_playing)
			return;

		createSource();
		_startTime = WebAudioBackend.context.currentTime;
		_source.start(0, _offset);
		_playing = true;
	}

	public function pause() {
		if (!_playing)
			return;

		_offset += WebAudioBackend.context.currentTime - _startTime;
		_source.stop();
		_playing = false;
	}

	public function stop() {
		if (_playing) {
			_source.stop();
		}
		_offset = 0;
		_playing = false;
	}

	public function destroy() {
		stop();
		_source = null;
		_gain.disconnect();
		_gain = null;
	}

	private function set_volume(value:Float):Float {
		_volume = Math.max(0, Math.min(1, value));
		_gain.gain.value = _volume;
		return _volume;
	}

	private function get_volume():Float {
		return _volume;
	}

	private function set_pitch(value:Float):Float {
		_pitch = Math.max(0.5, Math.min(2.0, value));
		if (_source != null)
			_source.playbackRate.value = _pitch;
		return _pitch;
	}

	private function get_pitch():Float {
		return _pitch;
	}

	private function set_loop(value:Bool):Bool {
		_loop = value;
		if (_source != null)
			_source.loop = value;
		return value;
	}

	private function get_loop():Bool {
		return _loop;
	}

	private function get_playing():Bool {
		return _playing;
	}

	private function set_time(value:Float):Float {
		_offset = Math.max(0, value / 1000);
		if (_playing) {
			stop();
			play();
		}
		return value;
	}

	private function get_time():Float {
		if (_playing) {
			return (_offset + (WebAudioBackend.context.currentTime - _startTime)) * 1000;
		}
		return _offset * 1000;
	}

	private function get_duration():Float {
		return buffer.duration * 1000;
	}

	public function set_positionX(value:Float):Float {
		return _panner.positionX.value = value;
	}

	public function get_positionX():Float {
		return _panner.positionX.value;
	}

	public function set_positionY(value:Float):Float {
		return _panner.positionY.value = value;
	}

	public function get_positionY():Float {
		return _panner.positionY.value;
	}

	public function set_positionZ(value:Float):Float {
		return _panner.positionZ.value = value;
	}

	public function get_positionZ():Float {
		return _panner.positionZ.value;
	}
}
#end
