package tuna.math;

abstract Mat4(Array<Float32>) from Array<Float32> to Array<Float32> {
	public function new(?data:Array<Float32>) {
		if (data == null)
			this = identity();
		else
			this = data;
	}

	@:op(A * B)
	public function multiply(m:Mat4) {
		var data:Array<Float32> = this;

		for (i => v in data) {
			data[i] = data[i] * m[i];
		}

		return data;
	}

	public static function perspective(field:Float, aspectRatio:Float, near:Float, far:Float) {
		var data:Mat4 = identity();
		data[0] = 1 / (aspectRatio * Math.tan(field / 2));
		data[5] = 1 / Math.tan(field / 2);
		data[10] = -(far + near / far - near);
		data[11] = -(2 * far * near / far - near);
		data[14] = -1;

		return data;
	}

	public static function ortho(left:Float, right:Float, bottom:Float, top:Float, near:Float, far:Float):Mat4 {
		var rl:Float = right - left;
		var tb:Float = top - bottom;
		var fn:Float32 = far - near;

		if (rl == 0 || tb == 0 || fn == 0) {
			return identity(); 
		}

		var data:Mat4 = identity();

		data[0] = 2.0 / rl;
		data[5] = 2.0 / tb;
		data[10] = -2.0 / fn; 

		data[12] = -(right + left) / rl; 
		data[13] = -(top + bottom) / tb; 
		data[14] = -(far + near) / fn; 
		data[15] = 1.0; 

		return data;
	}

	public static function identity():Mat4 {
		return [
			1, 0, 0, 0,
			0, 1, 0, 0,
			0, 0, 1, 0,
			0, 0, 0, 1
		];
	}

	public static function zero():Mat4 {
		return [
			0, 0, 0, 0,
			0, 0, 0, 0,
			0, 0, 0, 0,
			0, 0, 0, 0
		];
	}
}
