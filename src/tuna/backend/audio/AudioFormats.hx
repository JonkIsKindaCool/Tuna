package tuna.backend.audio;

import stb.format.vorbis.data.Header as OggHeader;
import haxe.io.BytesOutput;
import stb.format.vorbis.Reader as OggReader;
import haxe.Int32;
import haxe.io.Bytes;

class AudioFormats {
	public static function parseWave(bytes:Bytes):AudioData {
		var subchunk1Size:Int32 = bytes.getInt32(16);
		var audioFormat:UInt16 = bytes.getUInt16(20);
		var numChannels:UInt16 = bytes.getUInt16(22);
		var sampleRate:Int32 = bytes.getInt32(24);
		var bitsPerSample:UInt16 = bytes.getUInt16(34);
		var pos:Int = 20 + subchunk1Size;

		var dataOffset:Int = -1;
		var dataSize:Int = 0;

		while (pos + 8 <= bytes.length) {
			var chunkId:String = bytes.getString(pos, 4);

			if (chunkId == "data") {
				dataSize = bytes.getInt32(pos + 4);
				dataOffset = pos + 8;
				break;
			}

			var chunkSize:Int32 = bytes.getInt32(pos + 4);
			pos += 8 + chunkSize;

			if (chunkSize % 2 == 1)
				pos += 1;
		}

		var rawData:Bytes = Bytes.alloc(dataSize);
		rawData.blit(0, bytes, dataOffset, dataSize);

		return {
			audioFormat: audioFormat,
			numChannels: numChannels,
			sampleRate: sampleRate,
			bitsPerSample: bitsPerSample,
			size: dataSize,
			data: rawData
		};
	}

	public static function parseOgg(bytes:Bytes):AudioData {
		var reader:OggReader = OggReader.openFromBytes(bytes);
		if (reader == null || reader.header == null) {
			throw "Couldn't parse ogg file";
		}

		var header:OggHeader = reader.header;

		var output:BytesOutput = new BytesOutput();

		var totalSamplesPerChannel:Int = 0;
		var chunkSamples:Int;

		do {
			chunkSamples = reader.read(output, 65536, header.channel, header.sampleRate, false);
			totalSamplesPerChannel += chunkSamples;
		} while (chunkSamples > 0);

		var pcmBytes:Bytes = output.getBytes();

		var expectedSize = totalSamplesPerChannel * header.channel * 2;
		if (pcmBytes.length != expectedSize) {
			trace('Warning: size mismatch? expected $expectedSize, got ${pcmBytes.length}');
		}

		return {
			audioFormat: 1,
			numChannels: header.channel,
			sampleRate: header.sampleRate,
			bitsPerSample: 16,
			size: pcmBytes.length,
			data: pcmBytes
		};
	}
}

typedef AudioData = {
	var audioFormat:UInt16;
	var numChannels:UInt16;
	var sampleRate:Int32;
	var bitsPerSample:UInt16;
	var size:UInt64;

	var data:Bytes;
}
