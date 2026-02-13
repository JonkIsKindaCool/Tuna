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

	@:op(A * B)
	public function multiplyVec4(v:Vec4):Vec4 {
		return new Vec4(this[0] * v.x + this[4] * v.y + this[8] * v.z + this[12] * v.w, this[1] * v.x + this[5] * v.y + this[9] * v.z + this[13] * v.w,
			this[2] * v.x + this[6] * v.y + this[10] * v.z + this[14] * v.w, this[3] * v.x + this[7] * v.y + this[11] * v.z + this[15] * v.w);
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

	public function setPosition(x:Float, y:Float, ?z:Float = 0.0):Mat4 {
		this[12] = x;
		this[13] = y;
		this[14] = z;
		return this;
	}

	public function setScale(x:Float, ?y:Float = null, ?z:Float = null):Mat4 {
		var scaleX = x;
		var scaleY = (y != null) ? y : x;
		var scaleZ = (z != null) ? z : x;
		recompose(this[12], this[13], this[14], scaleX, scaleY, scaleZ, 0, 0, 0);
		return this;
	}

	public function setRotationZ(radians:Float):Mat4 {
		recompose(this[12], this[13], this[14], 1, 1, 1, 0, 0, radians);
		return this;
	}

	public function setRotationX(radians:Float):Mat4 {
		recompose(this[12], this[13], this[14], 1, 1, 1, radians, 0, 0);
		return this;
	}

	public function setRotationY(radians:Float):Mat4 {
		recompose(this[12], this[13], this[14], 1, 1, 1, 0, radians, 0);
		return this;
	}

	public function setEuler(rX:Float, rY:Float, rZ:Float):Mat4 {
		recompose(this[12], this[13], this[14], 1, 1, 1, rX, rY, rZ);
		return this;
	}

	function recompose(posX:Float, posY:Float, posZ:Float, scaleX:Float, scaleY:Float, scaleZ:Float, rotX:Float, rotY:Float, rotZ:Float):Void {
		var cX:Float = Math.cos(rotX);
		var sX:Float = Math.sin(rotX);
		var cY:Float = Math.cos(rotY);
		var sY:Float = Math.sin(rotY);
		var cZ:Float = Math.cos(rotZ);
		var sZ:Float = Math.sin(rotZ);

		var r00:Float = cY * cZ;
		var r01:Float = -cY * sZ;
		var r02:Float = sY;
		var r10:Float = cX * sZ + sX * sY * cZ;
		var r11:Float = cX * cZ - sX * sY * sZ;
		var r12:Float = -sX * cY;
		var r20:Float = sX * sZ - cX * sY * cZ;
		var r21:Float = sX * cZ + cX * sY * sZ;
		var r22:Float = cX * cY;

		this[0] = scaleX * r00;
		this[1] = scaleX * r10;
		this[2] = scaleX * r20;
		this[3] = 0;

		this[4] = scaleY * r01;
		this[5] = scaleY * r11;
		this[6] = scaleY * r21;
		this[7] = 0;

		this[8] = scaleZ * r02;
		this[9] = scaleZ * r12;
		this[10] = scaleZ * r22;
		this[11] = 0;

		this[12] = posX;
		this[13] = posY;
		this[14] = posZ;
		this[15] = 1.0;
	}
}