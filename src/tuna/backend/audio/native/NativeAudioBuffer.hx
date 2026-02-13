package tuna.backend.audio.native;

#if cpp
import cpp.RawPointer;
import native.al.AL;
import tuna.backend.audio.AudioFormats.AudioData;
import haxe.io.Bytes;

class NativeAudioBuffer implements AudioBuffer {
	public var data:UInt32;
	public var duration(get, never):Float;
	public var information:AudioData;

	public function new(bytes:Bytes) {
		var information:AudioData = null;
		if (bytes.getString(0, 4) == "RIFF" || bytes.getString(8, 4) == "WAVE" || bytes.getString(12, 4) == "fmt ") {
			information = AudioFormats.parseWave(bytes);
		}

		if (bytes.getString(0, 4).toLowerCase().indexOf("ogg") != -1) {
			information = AudioFormats.parseOgg(bytes);
		}

		if (information == null)
			throw "Unsopported audio format.";

		#if cpp
		data = 0;
		AL.genBuffers(1, RawPointer.addressOf(data));
		var arr:Array<UInt8> = information.data.getData();
		var ptr:cpp.Star<cpp.Void> = untyped __cpp__("(void*) {0}", cpp.Pointer.ofArray(arr));
		AL.bufferData(data, getOpenALFormat(information.numChannels, information.bitsPerSample), ptr, information.size, information.sampleRate);
		#end
	}

	public function destroy() {
		AL.deleteBuffers(1, RawPointer.addressOf(data));
	}

	public static function getOpenALFormat(channels:Int, bitsPerSample:Int):Int {
		if (channels == 1) {
			if (bitsPerSample == 8)
				return native.al.AL.FORMAT_MONO8;
			if (bitsPerSample == 16)
				return native.al.AL.FORMAT_MONO16;
		} else if (channels == 2) {
			if (bitsPerSample == 8)
				return native.al.AL.FORMAT_STEREO8;
			if (bitsPerSample == 16)
				return native.al.AL.FORMAT_STEREO16;
		}

		return 0;
	}

	public function get_duration():Float {
		var sizeInBytes:Int = 0;
		var channels:Int = 0;
		var bits:Int = 0;
		var frequency:Int = 0;

		AL.getBufferi(data, AL.SIZE, RawPointer.addressOf(sizeInBytes));
		AL.getBufferi(data, AL.CHANNELS, RawPointer.addressOf(channels));
		AL.getBufferi(data, AL.BITS, RawPointer.addressOf(bits));
		AL.getBufferi(data, AL.FREQUENCY, RawPointer.addressOf(frequency));

		var lengthInSamples:Float = sizeInBytes * 8 / (channels * bits);
		return (lengthInSamples / frequency) * 1000;
	}
}
#end
