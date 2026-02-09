package tuna.io;

import haxe.io.Bytes;
import tuna.io.ByteArray;

@:forward
abstract Float32Array(ByteArray) from ByteArray to ByteArray {
    public static final FLOAT_SIZE:Int = 4;
    public function new(data:Array<Float>) {
        var bytes:ByteArray = new ByteArray(data.length * FLOAT_SIZE);
        var bc:Int = 0;

        for (float in data){
            cast(bytes, Bytes).setFloat(bc, float);
            bc += FLOAT_SIZE;
        }

        this = bytes;
    }

    @:from
    public static function fromFloatArray(data:Array<Float>):Float32Array {
        return new Float32Array(data);
    }

    @:to
    public function toBytes():Bytes {
        return this;
    }
}