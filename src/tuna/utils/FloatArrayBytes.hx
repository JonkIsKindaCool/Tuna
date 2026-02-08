package tuna.utils;

import haxe.io.Bytes;

@:forward
abstract FloatArrayBytes(Bytes) to Bytes {
    public static inline var FLOAT_SIZE:Int = 4;
    public function new(data:Array<Float>) {
        var bytes:Bytes = Bytes.alloc(FLOAT_SIZE * data.length);
        var bc:Int = 0;
        for (d in data){
            bytes.setFloat(bc, d);
            bc += FLOAT_SIZE;
        }

        this = bytes;
    }
}