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

	public var volume(get, set):Float;
	public var pitch(get, set):Float;
	public var loop(get, set):Bool;
	public var playing(get, never):Bool;
	public var time(get, set):Float;
	public var duration(get, never):Float;

	public function new(file:SoundAsset) {
		if (Std.isOfType(file, AudioBuffer)) {
			buffer = cast file;
		} else {
			buffer = Application.audioBackend.createBuffer(Assets.loadBytes(file));
		}
		source = Application.audioBackend.createSource(buffer);
		source.play();
	}

	public function play():Void {
		source.play();
	}

	public function pause():Void {
		source.pause();
	}

	public function stop():Void {
		source.stop();
	}

	public function destroy():Void {
		source.destroy();
	}

	inline function get_volume():Float
		return source.volume;

	inline function set_volume(value:Float):Float
		return source.volume = value;

	inline function get_pitch():Float
		return source.pitch;

	inline function set_pitch(value:Float):Float
		return source.pitch = value;

	inline function get_loop():Bool
		return source.loop;

	inline function set_loop(value:Bool):Bool
		return source.loop = value;

	inline function get_playing():Bool
		return source.playing;

	inline function get_time():Float
		return source.time;

	inline function set_time(value:Float):Float
		return source.time = value;

	inline function get_duration():Float
		return source.duration;
}
