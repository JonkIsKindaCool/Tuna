package tuna.backend.audio.web;

import js.lib.Float32Array;
import tuna.backend.audio.AudioFormats;
import haxe.io.Bytes;

class WebAudioBuffer implements AudioBuffer {
	public var data:js.html.audio.AudioBuffer;
	public var information:AudioData;
	public var duration(get, never):Float;

	public function new(bytes:Bytes) {
		information = null;
		if (bytes.getString(0, 4) == "RIFF" || bytes.getString(8, 4) == "WAVE" || bytes.getString(12, 4) == "fmt ") {
			information = AudioFormats.parseWave(bytes);
		}

		if (information == null)
			throw "Unsopported audio format.";

		var numSamples:Int = Std.int(information.size / (information.bitsPerSample / 8) / information.numChannels);
		data = WebAudioBackend.context.createBuffer(information.numChannels, numSamples, information.sampleRate);

		for (ch in 0...information.numChannels) {
			var channelData:Float32Array = data.getChannelData(ch);

			for (i in 0...numSamples) {
				var pcm:Bytes = information.data;

				var sampleIndex:Int = (i * information.numChannels + ch) * 2;

				var sample = pcm.get(sampleIndex) | (pcm.get(sampleIndex + 1) << 8);

				if (sample >= 0x8000)
					sample -= 0x10000;

				channelData[i] = sample / 32768.0;

				if (sample >= 0x8000)
					sample -= 0x10000;

				channelData[i] = sample / 32768.0;
			}
		}
	}

	public function destroy() {
		for (ch in 0...data.numberOfChannels) {
			var channelData:Float32Array = data.getChannelData(ch);
			channelData = null;
		}
	}

	public function get_duration():Float {
		return data.duration * 1000;
	}
}
