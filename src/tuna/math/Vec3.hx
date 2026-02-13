package tuna.math;

@:forward
abstract Vec3(BasicVec3) from BasicVec3 to BasicVec3 {
	public function new(x:Float = 0, y:Float = 0, z:Float = 0) {
		this = {x: x, y: y, z: z};
	}

	@:op(A + B)
	public function add(b:Vec3):Vec3 {
		return new Vec3(this.x + b.x, this.y + b.y, this.z + b.z);
	}

	@:op(A - B)
	public function subtract(b:Vec3):Vec3 {
		return new Vec3(this.x - b.x, this.y - b.y, this.z - b.z);
	}

	@:op(A * B)
	public function multiplyScalar(b:Float):Vec3 {
		return new Vec3(this.x * b, this.y * b, this.z * b);
	}

	@:op(A * B)
	public static function multiplyVectors(a:Vec3, b:Vec3):Vec3 {
		return new Vec3(a.x * b.x, a.y * b.y, a.z * b.z);
	}

	@:op(A / B)
	public function divideScalar(b:Float):Vec3 {
		if (b == 0)
			return new Vec3(this.x, this.y, this.z);
		return new Vec3(this.x / b, this.y / b, this.z / b);
	}

	@:op(A / B)
	public static function divideVectors(a:Vec3, b:Vec3):Vec3 {
		return new Vec3(b.x != 0 ? a.x / b.x : a.x, b.y != 0 ? a.y / b.y : a.y, b.z != 0 ? a.z / b.z : a.z);
	}

	@:op(-A)
	public function negate():Vec3 {
		return new Vec3(-this.x, -this.y, -this.z);
	}

	@:op(A == B)
	public function equals(b:Vec3):Bool {
		return Math.abs(this.x - b.x) < 0.000001 && Math.abs(this.y - b.y) < 0.000001 && Math.abs(this.z - b.z) < 0.000001;
	}

	@:to
	public function toArray():Array<Float32> {
		return [this.x, this.y, this.z];
	}

	@:from
	public static function fromArray(arr:Array<Float>):Vec3 {
		return new Vec3(arr[0] ?? 0, arr[1] ?? 0, arr[2] ?? 0);
	}

	@:arrayAccess
	public inline function get(index:Int):Float {
		return switch (index) {
			case 0: this.x;
			case 1: this.y;
			case 2: this.z;
			default: 0;
		}
	}

	@:arrayAccess
	public inline function set(index:Int, value:Float):Float {
		switch (index) {
			case 0:
				this.x = value;
			case 1:
				this.y = value;
			case 2:
				this.z = value;
		}
		return value;
	}

	public static inline function zero():Vec3 {
		return new Vec3(0, 0, 0);
	}

	public static inline function one():Vec3 {
		return new Vec3(1, 1, 1);
	}

	public static inline function up():Vec3 {
		return new Vec3(0, 1, 0);
	}

	public static inline function down():Vec3 {
		return new Vec3(0, -1, 0);
	}

	public static inline function left():Vec3 {
		return new Vec3(-1, 0, 0);
	}

	public static inline function right():Vec3 {
		return new Vec3(1, 0, 0);
	}

	public static inline function forward():Vec3 {
		return new Vec3(0, 0, 1);
	}

	public static inline function back():Vec3 {
		return new Vec3(0, 0, -1);
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

	public inline function magnitudeSquared():Float {
		return x * x + y * y + z * z;
	}

	public inline function magnitude():Float {
		return Math.sqrt(magnitudeSquared());
	}

	public inline function length():Float {
		return magnitude();
	}

	public inline function lengthSq():Float {
		return magnitudeSquared();
	}

	public function normalize():Vec3 {
		var mag:Float = magnitude();
		return mag > 1e-8 ? new Vec3(x / mag, y / mag, z / mag) : new Vec3(0, 0, 0);
	}

	public inline function normalized():Vec3 {
		return normalize();
	}

	public inline function dot(b:Vec3):Float {
		return x * b.x + y * b.y + z * b.z;
	}

	public inline function cross(b:Vec3):Vec3 {
		return new Vec3(y * b.z - z * b.y, z * b.x - x * b.z, x * b.y - y * b.x);
	}

	public inline function distanceTo(b:Vec3):Float {
		var dx:Float = x - b.x;
		var dy:Float = y - b.y;
		var dz:Float = z - b.z;
		return Math.sqrt(dx * dx + dy * dy + dz * dz);
	}

	public inline function distanceSquaredTo(b:Vec3):Float {
		var dx:Float = x - b.x;
		var dy:Float = y - b.y;
		var dz:Float = z - b.z;
		return dx * dx + dy * dy + dz * dz;
	}

	public inline function distanceSqTo(b:Vec3):Float {
		return distanceSquaredTo(b);
	}

	public function angleTo(b:Vec3):Float {
		var magA:Float = magnitude();
		var magB:Float = b.magnitude();
		if (magA < 1e-8 || magB < 1e-8)
			return 0;

		var cosTheta:Float = dot(b) / (magA * magB);
		cosTheta = Math.max(-1, Math.min(1, cosTheta));
		return Math.acos(cosTheta);
	}

	public inline function angleToDeg(b:Vec3):Float {
		return angleTo(b) * 180 / Math.PI;
	}

	public function signedAngleTo(b:Vec3, axis:Vec3):Float {
		var angle:Float = angleTo(b);
		var c = cross(b);
		if (c.dot(axis) < 0)
			angle = -angle;
		return angle;
	}

	public function lerp(target:Vec3, t:Float):Vec3 {
		t = Math.max(0, Math.min(1, t));
		return new Vec3(x + (target.x - x) * t, y + (target.y - y) * t, z + (target.z - z) * t);
	}

	public function lerpUnclamped(target:Vec3, t:Float):Vec3 {
		return new Vec3(x + (target.x - x) * t, y + (target.y - y) * t, z + (target.z - z) * t);
	}

	public function slerp(target:Vec3, t:Float):Vec3 {
		var angle:Float = angleTo(target);
		if (angle < 1e-8)
			return lerp(target, t);

		var sin:Float = Math.sin(angle);
		if (Math.abs(sin) < 1e-8)
			return lerp(target, t);

		var a:Float = Math.sin((1 - t) * angle) / sin;
		var b:Float = Math.sin(t * angle) / sin;
		return new Vec3(x * a + target.x * b, y * a + target.y * b, z * a + target.z * b);
	}

	public function slerpUnclamped(target:Vec3, t:Float):Vec3 {
		return slerp(target, Math.max(0, Math.min(1, t)));
	}

	public function project(on:Vec3):Vec3 {
		var dotProd:Float = dot(on);
		var lenSq:Float = on.magnitudeSquared();
		if (lenSq < 1e-8)
			return new Vec3(0, 0, 0);

		var scalar:Float = dotProd / lenSq;
		return new Vec3(on.x * scalar, on.y * scalar, on.z * scalar);
	}

	public function projectOnPlane(normal:Vec3):Vec3 {
		var projected:Vec3 = project(normal);
		return new Vec3(x - projected.x, y - projected.y, z - projected.z);
	}

	public function reflect(normal:Vec3):Vec3 {
		var n:Vec3 = normal.normalize();
		var dot2:Float = dot(n) * 2;
		return new Vec3(x - n.x * dot2, y - n.y * dot2, z - n.z * dot2);
	}

	public function refract(normal:Vec3, eta:Float):Vec3 {
		var nDotI:Float = dot(normal);
		var k:Float = 1 - eta * eta * (1 - nDotI * nDotI);
		if (k < 0)
			return new Vec3(0, 0, 0);

		var scalar:Float = eta * nDotI + Math.sqrt(k);
		return new Vec3(eta * x - scalar * normal.x, eta * y - scalar * normal.y, eta * z - scalar * normal.z);
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
		if (mag < 1e-8)
			return new Vec3(0, 0, 0);

		var factor:Float = length / mag;
		return new Vec3(x * factor, y * factor, z * factor);
	}

	public function clampMagnitude(minLength:Float, maxLength:Float):Vec3 {
		var magSq:Float = magnitudeSquared();
		var mag:Float = Math.sqrt(magSq);

		if (mag < 1e-8)
			return new Vec3(0, 0, 0);
		if (mag < minLength)
			return setMagnitude(minLength);
		if (mag > maxLength)
			return setMagnitude(maxLength);
		return new Vec3(x, y, z);
	}

	public function clamp(min:Vec3, max:Vec3):Vec3 {
		return new Vec3(Math.max(min.x, Math.min(max.x, x)), Math.max(min.y, Math.min(max.y, y)), Math.max(min.z, Math.min(max.z, z)));
	}

	public inline function abs():Vec3 {
		return new Vec3(Math.abs(x), Math.abs(y), Math.abs(z));
	}

	public inline function floor():Vec3 {
		return new Vec3(Math.floor(x), Math.floor(y), Math.floor(z));
	}

	public inline function ceil():Vec3 {
		return new Vec3(Math.ceil(x), Math.ceil(y), Math.ceil(z));
	}

	public inline function round():Vec3 {
		return new Vec3(Math.round(x), Math.round(y), Math.round(z));
	}

	public function min(b:Vec3):Vec3 {
		return new Vec3(Math.min(x, b.x), Math.min(y, b.y), Math.min(z, b.z));
	}

	public function max(b:Vec3):Vec3 {
		return new Vec3(Math.max(x, b.x), Math.max(y, b.y), Math.max(z, b.z));
	}

	public function rotateX(angleRad:Float):Vec3 {
		var cos:Float = Math.cos(angleRad);
		var sin:Float = Math.sin(angleRad);
		return new Vec3(x, y * cos - z * sin, y * sin + z * cos);
	}

	public function rotateY(angleRad:Float):Vec3 {
		var cos:Float = Math.cos(angleRad);
		var sin:Float = Math.sin(angleRad);
		return new Vec3(x * cos + z * sin, y, -x * sin + z * cos);
	}

	public function rotateZ(angleRad:Float):Vec3 {
		var cos:Float = Math.cos(angleRad);
		var sin:Float = Math.sin(angleRad);
		return new Vec3(x * cos - y * sin, x * sin + y * cos, z);
	}

	public function rotateXDeg(angleDeg:Float):Vec3 {
		return rotateX(angleDeg * Math.PI / 180);
	}

	public function rotateYDeg(angleDeg:Float):Vec3 {
		return rotateY(angleDeg * Math.PI / 180);
	}

	public function rotateZDeg(angleDeg:Float):Vec3 {
		return rotateZ(angleDeg * Math.PI / 180);
	}

	public function rotateAround(axis:Vec3, angleRad:Float):Vec3 {
		var n:Vec3 = axis.normalize();
		var cos:Float = Math.cos(angleRad);
		var sin:Float = Math.sin(angleRad);
		var oneMinusCos:Float = 1 - cos;

		return new Vec3((cos + n.x * n.x * oneMinusCos) * x
			+ (n.x * n.y * oneMinusCos - n.z * sin) * y
			+ (n.x * n.z * oneMinusCos + n.y * sin) * z,
			(n.y * n.x * oneMinusCos + n.z * sin) * x
			+ (cos + n.y * n.y * oneMinusCos) * y
			+ (n.y * n.z * oneMinusCos - n.x * sin) * z,
			(n.z * n.x * oneMinusCos - n.y * sin) * x
			+ (n.z * n.y * oneMinusCos + n.x * sin) * y
			+ (cos + n.z * n.z * oneMinusCos) * z);
	}

	public inline function rotateAroundDeg(axis:Vec3, angleDeg:Float):Vec3 {
		return rotateAround(axis, angleDeg * Math.PI / 180);
	}

	public inline function exactEquals(other:Vec3):Bool {
		return x == other.x && y == other.y && z == other.z;
	}

	public inline function nearlyEquals(other:Vec3, epsilon:Float = 0.000001):Bool {
		return Math.abs(x - other.x) < epsilon && Math.abs(y - other.y) < epsilon && Math.abs(z - other.z) < epsilon;
	}

	public inline function isZero():Bool {
		return x == 0 && y == 0 && z == 0;
	}

	public inline function isNearlyZero(epsilon:Float = 0.000001):Bool {
		return Math.abs(x) < epsilon && Math.abs(y) < epsilon && Math.abs(z) < epsilon;
	}

	public inline function clone():Vec3 {
		return new Vec3(x, y, z);
	}

	public inline function copy():Vec3 {
		return clone();
	}

	public function set(nx:Float, ny:Float, nz:Float):Vec3 {
		x = nx;
		y = ny;
		z = nz;
		return this;
	}

	public function copyFrom(other:Vec3):Vec3 {
		x = other.x;
		y = other.y;
		z = other.z;
		return this;
	}

	public inline function maxComponent():Float {
		return Math.max(x, Math.max(y, z));
	}

	public inline function minComponent():Float {
		return Math.min(x, Math.min(y, z));
	}

	public inline function sum():Float {
		return x + y + z;
	}

	public inline function average():Float {
		return (x + y + z) / 3;
	}

	public inline function toVec2XY():Vec2 {
		return new Vec2(x, y);
	}

	public inline function toVec2XZ():Vec2 {
		return new Vec2(x, z);
	}

	public inline function toVec2YZ():Vec2 {
		return new Vec2(y, z);
	}

	public static function fromSpherical(radius:Float, theta:Float, phi:Float):Vec3 {
		var sinPhi:Float = Math.sin(phi);
		return new Vec3(radius * sinPhi * Math.cos(theta), radius * Math.cos(phi), radius * sinPhi * Math.sin(theta));
	}

	public function toSpherical():{radius:Float, theta:Float, phi:Float} {
		var radius:Float = magnitude();
		if (radius < 1e-8)
			return {radius: 0, theta: 0, phi: 0};

		return {
			radius: radius,
			theta: Math.atan2(z, x),
			phi: Math.acos(y / radius)
		};
	}

	public function toString():String {
		return 'Vec3($x, $y, $z)';
	}
}
