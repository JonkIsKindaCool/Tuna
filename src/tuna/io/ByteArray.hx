package tuna.io;

import haxe.io.Bytes;

@:forward(length, blit, sub, toHex, toString)
abstract ByteArray(Bytes) from Bytes to Bytes {
	public inline function new(?size:Int = 0) {
		this = Bytes.alloc(size);
	}

	@:from
	public static inline function fromArray(arr:Array<Int>):ByteArray {
		var b = Bytes.alloc(arr.length);
		for (i in 0...arr.length) {
			b.set(i, arr[i]);
		}
		return b;
	}

	@:from
	public static inline function fromString(s:String):ByteArray {
		return Bytes.ofString(s);
	}

	@:arrayAccess
	public inline function get(index:Int):Int {
		return this.get(index);
	}

	@:arrayAccess
	public inline function set(index:Int, value:Int):Int {
		this.set(index, value); 
		return value;
	}

	public inline function resize(newLength:Int):Void {
		var old = this;
		this = Bytes.alloc(newLength);
		if (old.length > 0 && newLength > 0) {
			var len = Std.int(Math.min(old.length, newLength));
			this.blit(0, old, 0, len);
		}
	}

	public inline function pushByte(b:Int):Void {
		var old = this;
		resize(old.length + 1);
		this.set(old.length, b);
	}
}
