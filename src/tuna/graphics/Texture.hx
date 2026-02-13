package tuna.graphics;

import format.png.Tools;
import haxe.io.BytesInput;
import tuna.backend.opengl.GL;
import tuna.backend.opengl.GLTexture;
import haxe.io.Bytes;

class Texture {
	private var _glTexture:GLTexture;

	public var rawData:Bytes;
	public var width:Int;
	public var height:Int;

	public function new(bytes:Bytes, ?properties:TextureProperties) {
		var input:BytesInput = new BytesInput(bytes);
		if (bytes.length >= 8 && bytes.get(0) == 0x89 && bytes.get(1) == 0x50 && bytes.get(2) == 0x4E && bytes.get(3) == 0x47 && bytes.get(4) == 0x0D
			&& bytes.get(5) == 0x0A && bytes.get(6) == 0x1A && bytes.get(7) == 0x0A) {
			// png
			var reader:format.png.Reader = new format.png.Reader(input);
			var png:format.png.Data = reader.read();
			var header:format.png.Data.Header = format.png.Tools.getHeader(png);

			width = header.width;
			height = header.height;

			rawData = format.png.Tools.extract32(png);
			//i hate this
			var i:Int = 0;
			while (i < rawData.length) {
				var b:Int = rawData.get(i + 0);
				var g:Int = rawData.get(i + 1);
				var r:Int = rawData.get(i + 2);
				var a:Int = rawData.get(i + 3);

				rawData.set(i + 0, r);
				rawData.set(i + 1, g);
				rawData.set(i + 2, b);
				rawData.set(i + 3, a);

				i += 4;
			}
		} else if (bytes.length >= 2 && bytes.get(0) == 0x42 && bytes.get(1) == 0x4D) {
			var reader:format.bmp.Reader = new format.bmp.Reader(input);
			var bmp:format.bmp.Data = reader.read();

			width = bmp.header.width;
			height = bmp.header.height;

			var src:Bytes = bmp.pixels;
			var bpp:Int = bmp.header.bpp;
			var dst:Bytes = Bytes.alloc(width * height * 4);

			var rowSize = Std.int(Math.ceil((bpp * width) / 32)) * 4;

			for (y in 0...height) {
				var srcY = height - 1 - y;
				for (x in 0...width) {
					var srcIndex = srcY * rowSize + x * (bpp >> 3);
					var dstIndex = (y * width + x) * 4;

					var b = src.get(srcIndex);
					var g = src.get(srcIndex + 1);
					var r = src.get(srcIndex + 2);
					var a = (bpp == 32) ? src.get(srcIndex + 3) : 255;

					dst.set(dstIndex + 0, r);
					dst.set(dstIndex + 1, g);
					dst.set(dstIndex + 2, b);
					dst.set(dstIndex + 3, a);
				}
			}

			rawData = dst;
		} else {
			throw "Unsopported image type";
		}

		_glTexture = GL.genTexture();
		start();
		if (properties != null) {
			if (properties.mirroredX ?? false)
				GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, GL.MIRRORED_REPEAT);
			if (properties.mirroredY ?? false)
				GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, GL.MIRRORED_REPEAT);

			if (properties.antialiasing) {
				if (properties.mipmap)
					GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.LINEAR_MIPMAP_LINEAR);
				else
					GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.NEAREST_MIPMAP_LINEAR);
			} else {
				if (properties.mipmap)
					GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.NEAREST_MIPMAP_NEAREST);
				else
					GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.NEAREST_MIPMAP_NEAREST);
			}
			GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.NEAREST);
		} else {
			GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.NEAREST);
			GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.NEAREST);
		}
		GL.texImage2D(GL.TEXTURE_2D, 0, GL.RGBA, width, height, 0, GL.RGBA, GL.UNSIGNED_BYTE, rawData);
		stop();
	}

	public function start() {
		GL.bindTexture(GL.TEXTURE_2D, _glTexture);
	}

	public function stop() {
		GL.bindTexture(GL.TEXTURE_2D, null);
	}
}

typedef TextureProperties = {
	?antialiasing:Bool,
	?mipmap:Bool,
	?mirroredX:Bool,
	?mirroredY:Bool
}
