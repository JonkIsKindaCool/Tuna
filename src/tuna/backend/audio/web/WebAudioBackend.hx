package tuna.backend.audio.web;

#if js 
import tuna.backend.audio.web.WebAudioSource;
import js.html.audio.AudioContext;
import haxe.io.Bytes;

class WebAudioBackend implements IAudioBackend {
	public static var context:AudioContext;

	@:isVar public var listenerPositionX(get, set):Float;
	@:isVar public var listenerPositionY(get, set):Float;
	@:isVar public var listenerPositionZ(get, set):Float;

	public function new() {
		context = new AudioContext();
		listenerPositionX = 0;
		listenerPositionY = 0;
		listenerPositionZ = 0;
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

	public function set_listenerPositionX(value:Float):Float {
		context.listener.setPosition(value, listenerPositionY ?? 0, listenerPositionZ ?? 0);
		return listenerPositionX = value;
	}

	public function get_listenerPositionX():Float {
		return listenerPositionX;
	}

	public function set_listenerPositionY(value:Float):Float {
		context.listener.setPosition(listenerPositionX ?? 0, value, listenerPositionZ ?? 0);
		return listenerPositionY = value;
	}

	public function get_listenerPositionY():Float {
		return listenerPositionY;
	}

	public function set_listenerPositionZ(value:Float):Float {
		context.listener.setPosition(listenerPositionX ?? 0, listenerPositionY ?? 0, value);
		return listenerPositionY = value;
	}

	public function get_listenerPositionZ():Float {
		return listenerPositionZ;
	}
}
#end