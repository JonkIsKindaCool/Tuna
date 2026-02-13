package tuna.io;

import haxe.io.Bytes;
import tuna.io.ByteArray;

@:forward
abstract UInt16Array(ByteArray) from ByteArray to ByteArray {
    public static final UInt16Size:Int = 2;
    public function new(data:Array<UInt>) {
        var bytes:ByteArray = new ByteArray(data.length * UInt16Size);
        var bc:Int = 0;

        for (float in data){
            cast(bytes, Bytes).setUInt16(bc, float);
            bc += UInt16Size;
        }

        this = bytes;
    }

    @:from
    public static function fromFloatArray(data:Array<UInt>):UInt16Array {
        return new UInt16Array(data);
    }

    @:to
    public function toBytes():Bytes {
        return this;
    }
}