package tuna.backend.audio.native;

import native.al.AL;
#if cpp
import haxe.io.Bytes;
import native.al.ALC;

class NativeAudioBackend implements IAudioBackend {
	public static var device:Device;
	public static var context:Context;

	@:isVar public var listenerPositionX(get, set):Float;
	@:isVar public var listenerPositionY(get, set):Float;
	@:isVar public var listenerPositionZ(get, set):Float;

	public function new() {
		device = ALC.openDevice(null);
		if (device == null)
			trace("No device");

		context = ALC.createContext(device);
		var err:Int = ALC.getError(device);
		if (err != ALC.NO_ERROR)
			trace("ALC error: " + err);

		ALC.makeContextCurrent(context);
		err = ALC.getError(device);
		if (err != ALC.NO_ERROR)
			trace("ALC error: " + err);

		AL.distanceModel(AL.INVERSE_DISTANCE_CLAMPED);
		AL.dopplerFactor(1.0);
		AL.dopplerVelocity(343.3);
	}

	public function destroy() {
		ALC.destroyContext(context);
		ALC.closeDevice(device);
	}

	public function createSource(b:AudioBuffer):AudioSource {
		return new NativeAudioSource(b);
	}

	public function createBuffer(b:Bytes):AudioBuffer {
		return new NativeAudioBuffer(b);
	}

	public function set_listenerPositionX(value:Float):Float {
		listenerPositionX = value;
		AL.listener3f(AL.POSITION, listenerPositionX, listenerPositionY, listenerPositionZ);
		return value;
	}

	public function set_listenerPositionY(value:Float):Float {
		listenerPositionY = value;
		AL.listener3f(AL.POSITION, listenerPositionX, listenerPositionY, listenerPositionZ);
		return value;
	}

	public function set_listenerPositionZ(value:Float):Float {
		listenerPositionZ = value;
		AL.listener3f(AL.POSITION, listenerPositionX, listenerPositionY, listenerPositionZ);
		return value;
	}

	public function get_listenerPositionX():Float {
		return listenerPositionX;
	}

	public function get_listenerPositionY():Float {
		return listenerPositionY;
	}

	public function get_listenerPositionZ():Float {
		return listenerPositionZ;
	}
}
#end
