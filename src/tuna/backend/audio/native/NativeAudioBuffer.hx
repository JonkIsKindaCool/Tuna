package tuna.backend.audio.native;

#if cpp
import cpp.RawPointer;
import native.al.AL;
import tuna.backend.audio.AudioFormats.AudioData;
import haxe.io.Bytes;

class NativeAudioBuffer implements AudioBuffer{
	public var data:UInt32;

	public function new(bytes:Bytes) {
		var audioData:AudioData = null;
		if (bytes.getString(0, 4) == "RIFF" || bytes.getString(8, 4) == "WAVE" || bytes.getString(12, 4) == "fmt ") {
			audioData = AudioFormats.parseWave(bytes);
		}

		if (audioData == null)
			throw "Unsopported audio format.";

		#if cpp
		data = 0;
		AL.genBuffers(1, RawPointer.addressOf(data));
		var arr:Array<UInt8> = audioData.data.getData();
		var ptr:cpp.Star<cpp.Void> = untyped __cpp__("(void*) {0}", cpp.Pointer.ofArray(arr));
		AL.bufferData(data, getOpenALFormat(audioData.numChannels, audioData.bitsPerSample), ptr, audioData.size, audioData.sampleRate);
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
}
#end