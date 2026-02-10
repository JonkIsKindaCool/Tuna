package tuna.backend.audio.native;

#if cpp
import haxe.io.Bytes;
import native.al.ALC;

class NativeAudioBackend implements IAudioBackend {
	public static var device:Device;
	public static var context:Context;

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
}
#end
