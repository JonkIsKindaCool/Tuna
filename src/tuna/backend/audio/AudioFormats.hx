package tuna.backend.audio;

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
}

typedef AudioData = {
	var audioFormat:UInt16;
	var numChannels:UInt16;
	var sampleRate:Int32;
	var bitsPerSample:UInt16;
	var size:UInt64;

	var data:Bytes;
}
