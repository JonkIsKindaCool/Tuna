package tuna.math;

@:forward
abstract Vec3(BasicVec3) from BasicVec3 to BasicVec3 {
	public function new(x:Float = 0, y:Float = 0, z:Float = 0) {
		this = {x: x, y: y, z: z};
	}

	@:op(A + B)
	public function add(b:Vec3) {
		return new Vec3(this.x + b.x, this.y + b.y, this.z + b.z);
	}

	@:op(A - B)
	public function subtract(b:Vec3) {
		return new Vec3(this.x - b.x, this.y - b.y, this.z - b.z);
	}

	@:op(A * B)
	public function multiplyScalar(b:Float) {
		return new Vec3(this.x * b, this.y * b, this.z * b);
	}

	@:op(A * B)
	public function multiplyVectors(b:Vec3) {
		return new Vec3(this.x * this.x, this.y * this.y, this.z + b.z);
	}

	@:op(A / B)
	public function divideScalar(b:Float) {
		return new Vec3(this.x / b, this.y / b, this.z / b);
	}

	@:to
	public function toArray():Array<Float32> {
		return [this.x, this.y, this.z];
	}
}

@:structInit
private class BasicVec3 {
	public var x:Float;
	public var y:Float;
	public var z:Float;

	public function new(x:Float = 0, y:Float = 0, z:Float = 0) {
		this.x = x;
		this.y = y;
		this.z = z;
	}

	public function magnitudeSquared():Float {
		return x * x + y * y + z * z;
	}

	public function magnitude():Float {
		return Math.sqrt(magnitudeSquared());
	}

	public function normalize():Vec3 {
		var mag = magnitude();
		if (mag > 1e-8) {
			return new Vec3(x / mag, y / mag, z / mag);
		}
		return new Vec3();
	}

	public function dot(b:Vec3):Float {
		return x * b.x + y * b.y + z * b.z;
	}

	public function cross(b:Vec3):Vec3 {
		return new Vec3(y * b.z - z * b.y, z * b.x - x * b.z, x * b.y - y * b.x);
	}

	public function distanceTo(b:Vec3):Float {
		var dx:Float = x - b.x;
		var dy:Float = y - b.y;
		var dz:Float = z - b.z;
		return Math.sqrt(dx * dx + dy * dy + dz * dz);
	}

	public function distanceSquaredTo(b:Vec3):Float {
		var dx:Float = x - b.x;
		var dy:Float = y - b.y;
		var dz:Float = z - b.z;
		return dx * dx + dy * dy + dz * dz;
	}

	public function angleTo(b:Vec3):Float {
		var magA:Float = magnitude();
		var magB:Float = b.magnitude();
		if (magA == 0 || magB == 0)
			return 0;
		var cosTheta:Float = dot(b) / (magA * magB);
		cosTheta = Math.max(-1, Math.min(1, cosTheta));
		return Math.acos(cosTheta);
	}

	public function lerp(target:Vec3, t:Float):Vec3 {
		t = Math.max(0, Math.min(1, t));
		return new Vec3(x + (target.x - x) * t, y + (target.y - y) * t, z + (target.z - z) * t);
	}

	public function lerpUnclamped(target:Vec3, t:Float):Vec3 {
		return new Vec3(x + (target.x - x) * t, y + (target.y - y) * t, z + (target.z - z) * t);
	}

	public function project(on:Vec3):Vec3 {
		var dotProd:Float = dot(on);
		var lenSq:Float = on.magnitudeSquared();
		if (lenSq == 0)
			return new Vec3();
		var scalar:Float = dotProd / lenSq;
		return new Vec3(on.x * scalar, on.y * scalar, on.z * scalar);
	}

	public function reflect(normal:Vec3):Vec3 {
		var n:Vec3 = normal.normalize();
		var dot2:Float = dot(n) * 2;
		return new Vec3(x - n.x * dot2, y - n.y * dot2, z - n.z * dot2);
	}

	public function limit(maxLength:Float):Vec3 {
		var magSq:Float = magnitudeSquared();
		if (magSq > maxLength * maxLength) {
			var mag:Float = Math.sqrt(magSq);
			return new Vec3(x * maxLength / mag, y * maxLength / mag, z * maxLength / mag);
		}
		return new Vec3(x, y, z);
	}

	public function setMagnitude(length:Float):Vec3 {
		var mag:Float = magnitude();
		if (mag == 0)
			return new Vec3();
		var factor:Float = length / mag;
		return new Vec3(x * factor, y * factor, z * factor);
	}

	public function clone():Vec3 {
		return new Vec3(x, y, z);
	}

	public function set(x:Float, y:Float, z:Float):Void {
		this.x = x;
		this.y = y;
		this.z = z;
	}

	public function equals(other:Vec3):Bool {
		return x == other.x && y == other.y && z == other.z;
	}

	public function nearlyEquals(other:Vec3, epsilon:Float = 0.000001):Bool {
		return Math.abs(x - other.x) < epsilon && Math.abs(y - other.y) < epsilon && Math.abs(z - other.z) < epsilon;
	}

	public function floor():Vec3 {
		return new Vec3(Math.floor(x), Math.floor(y), Math.floor(z));
	}

	public function ceil():Vec3 {
		return new Vec3(Math.ceil(x), Math.ceil(y), Math.ceil(z));
	}

	public function round():Vec3 {
		return new Vec3(Math.round(x), Math.round(y), Math.round(z));
	}

	public function toString():String {
		return 'Vec3($x, $y, $z)';
	}
}
