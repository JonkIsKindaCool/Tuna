package tuna.math;

abstract Mat3(Array<Float32>) from Array<Float32> to Array<Float32> {
	public function new(?data:Array<Float32>) {
		if (data == null)
			this = identity();
		else
			this = data;
	}

	@:op(A * B)
	public function multiply(b:Mat3):Mat3 {
		return [
			this[0] * b[0], this[1] * b[1], this[2] * b[2],
			this[3] * b[3], this[4] * b[4], this[5] * b[5],
			this[6] * b[6], this[7] * b[7], this[8] * b[8]
		];
	}

    @:op(A * B)
    public function multiplyVec3(v:Vec3):Vec3 {
        return new Vec3(this[0] * v.x + this[1] * v.y + this[2] * v.z,
            this[3] * v.x + this[4] * v.y + this[5] * v.z,
            this[6] * v.x + this[7] * v.y + this[8] * v.z);
    }

    @:op(A * B)
    public function multiplyScalar(f:Float):Mat3 {
        var data:Array<Float32> = this;

        for (i in 0...data.length){
            data[i] = data[i] * f;
        }

        return data;
    }

	public function transpose():Mat3 {
		return [
			this[0], this[3], this[6],
			this[1], this[4], this[7],
			this[2], this[5], this[8]
		];
	}

	public function determinant():Float {
		return this[0] * (this[4] * this[8] - this[5] * this[7])
			- this[1] * (this[3] * this[8] - this[5] * this[6]) - this[2] * (this[3] * this[7] - this[4] * this[6]);
	}

	public static function identity():Mat3 {
		return [
			1, 0, 0,
			0, 1, 0,
			0, 0, 1
		];
	}

	public static function zero():Mat3 {
		return [
			0, 0, 0,
			0, 0, 0,
			0, 0, 0
		];
	}

    public function toString() {
        var string:StringBuf = new StringBuf();
        var data:Array<Float32> = this;

        for (i => v in data){
            string.add(Std.string(v));
            if (i != data.length - 1)
                string.addChar(",".code);
        }
        
        return 'Mat3(${string.toString()})';
    }
}
