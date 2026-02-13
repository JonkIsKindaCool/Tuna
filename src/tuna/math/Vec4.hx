package tuna.math;

import tuna.utils.Color;

@:forward
abstract Vec4(BasicVec4) from BasicVec4 to BasicVec4 {
	public function new(x:Float = 0, y:Float = 0, z:Float = 0, w:Float = 0) {
		this = {
			x: x,
			y: y,
			z: z,
			w: w
		};
	}

	@:op(A + B)
	public function add(b:Vec4):Vec4 {
		return new Vec4(this.x + b.x, this.y + b.y, this.z + b.z, this.w + b.w);
	}

	@:op(A - B)
	public function subtract(b:Vec4):Vec4 {
		return new Vec4(this.x - b.x, this.y - b.y, this.z - b.z, this.w - b.w);
	}

	@:op(A * B)
	public function multiplyScalar(b:Float):Vec4 {
		return new Vec4(this.x * b, this.y * b, this.z * b, this.w * b);
	}

	@:op(A * B)
	public static function multiplyVectors(a:Vec4, b:Vec4):Vec4 {
		return new Vec4(a.x * b.x, a.y * b.y, a.z * b.z, a.w * b.w);
	}

	@:op(A / B)
	public function divideScalar(b:Float):Vec4 {
		if (b == 0)
			return new Vec4(this.x, this.y, this.z, this.w);
		return new Vec4(this.x / b, this.y / b, this.z / b, this.w / b);
	}

	@:op(A / B)
	public static function divideVectors(a:Vec4, b:Vec4):Vec4 {
		return new Vec4(b.x != 0 ? a.x / b.x : a.x, b.y != 0 ? a.y / b.y : a.y, b.z != 0 ? a.z / b.z : a.z, b.w != 0 ? a.w / b.w : a.w);
	}

	@:op(-A)
	public function negate():Vec4 {
		return new Vec4(-this.x, -this.y, -this.z, -this.w);
	}

	@:op(A == B)
	public function equals(b:Vec4):Bool {
		return Math.abs(this.x - b.x) < 0.000001 && Math.abs(this.y - b.y) < 0.000001 && Math.abs(this.z - b.z) < 0.000001 && Math.abs(this.w - b.w) < 0.000001;
	}

	@:to
	public function toArray():Array<Float32> {
		return [this.x, this.y, this.z, this.w];
	}

	@:from
	public static function fromArray(arr:Array<Float>):Vec4 {
		return new Vec4(arr[0] ?? 0, arr[1] ?? 0, arr[2] ?? 0, arr[3] ?? 0);
	}

	@:arrayAccess
	public inline function get(index:Int):Float {
		return switch (index) {
			case 0: this.x;
			case 1: this.y;
			case 2: this.z;
			case 3: this.w;
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
			case 3:
				this.w = value;
		}
		return value;
	}

	public static inline function zero():Vec4 {
		return new Vec4(0, 0, 0, 0);
	}

	public static inline function one():Vec4 {
		return new Vec4(1, 1, 1, 1);
	}

	public static inline function unitX():Vec4 {
		return new Vec4(1, 0, 0, 0);
	}

	public static inline function unitY():Vec4 {
		return new Vec4(0, 1, 0, 0);
	}

	public static inline function unitZ():Vec4 {
		return new Vec4(0, 0, 1, 0);
	}

	public static inline function unitW():Vec4 {
		return new Vec4(0, 0, 0, 1);
	}

	public static inline function point(v:Vec3):Vec4 {
		return new Vec4(v.x, v.y, v.z, 1);
	}

	public static inline function direction(v:Vec3):Vec4 {
		return new Vec4(v.x, v.y, v.z, 0);
	}

	public static inline function quaternionIdentity():Vec4 {
		return new Vec4(0, 0, 0, 1);
	}
}

@:structInit
private class BasicVec4 {
	public var x:Float;
	public var y:Float;
	public var z:Float;
	public var w:Float;

	public function new(x:Float = 0, y:Float = 0, z:Float = 0, w:Float = 0) {
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
	}

	public inline function magnitudeSquared():Float {
		return x * x + y * y + z * z + w * w;
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

	public function normalize():Vec4 {
		var mag = magnitude();
		return mag > 1e-8 ? new Vec4(x / mag, y / mag, z / mag, w / mag) : new Vec4(0, 0, 0, 0);
	}

	public inline function normalized():Vec4 {
		return normalize();
	}

	public inline function dot(b:Vec4):Float {
		return x * b.x + y * b.y + z * b.z + w * b.w;
	}

	public inline function distanceTo(b:Vec4):Float {
		var dx = x - b.x;
		var dy = y - b.y;
		var dz = z - b.z;
		var dw = w - b.w;
		return Math.sqrt(dx * dx + dy * dy + dz * dz + dw * dw);
	}

	public inline function distanceSquaredTo(b:Vec4):Float {
		var dx = x - b.x;
		var dy = y - b.y;
		var dz = z - b.z;
		var dw = w - b.w;
		return dx * dx + dy * dy + dz * dz + dw * dw;
	}

	public inline function distanceSqTo(b:Vec4):Float {
		return distanceSquaredTo(b);
	}

	public function angleTo(b:Vec4):Float {
		var magA = magnitude();
		var magB = b.magnitude();
		if (magA < 1e-8 || magB < 1e-8)
			return 0;

		var cosTheta = dot(b) / (magA * magB);
		cosTheta = Math.max(-1, Math.min(1, cosTheta));
		return Math.acos(cosTheta);
	}

	public inline function angleToDeg(b:Vec4):Float {
		return angleTo(b) * 180 / Math.PI;
	}

	public function lerp(target:Vec4, t:Float):Vec4 {
		t = Math.max(0, Math.min(1, t));
		return new Vec4(x + (target.x - x) * t, y + (target.y - y) * t, z + (target.z - z) * t, w + (target.w - w) * t);
	}

	public function lerpUnclamped(target:Vec4, t:Float):Vec4 {
		return new Vec4(x + (target.x - x) * t, y + (target.y - y) * t, z + (target.z - z) * t, w + (target.w - w) * t);
	}

	public function slerp(target:Vec4, t:Float):Vec4 {
		var angle = angleTo(target);
		if (angle < 1e-8)
			return lerp(target, t);

		var sin = Math.sin(angle);
		if (Math.abs(sin) < 1e-8)
			return lerp(target, t);

		var a = Math.sin((1 - t) * angle) / sin;
		var b = Math.sin(t * angle) / sin;
		return new Vec4(x * a + target.x * b, y * a + target.y * b, z * a + target.z * b, w * a + target.w * b);
	}

	public function project(on:Vec4):Vec4 {
		var dotProd = dot(on);
		var lenSq = on.magnitudeSquared();
		if (lenSq < 1e-8)
			return new Vec4(0, 0, 0, 0);

		var scalar = dotProd / lenSq;
		return new Vec4(on.x * scalar, on.y * scalar, on.z * scalar, on.w * scalar);
	}

	public function limit(maxLength:Float):Vec4 {
		var magSq = magnitudeSquared();
		if (magSq > maxLength * maxLength) {
			var mag = Math.sqrt(magSq);
			return new Vec4(x * maxLength / mag, y * maxLength / mag, z * maxLength / mag, w * maxLength / mag);
		}
		return new Vec4(x, y, z, w);
	}

	public function setMagnitude(length:Float):Vec4 {
		var mag = magnitude();
		if (mag < 1e-8)
			return new Vec4(0, 0, 0, 0);

		var factor = length / mag;
		return new Vec4(x * factor, y * factor, z * factor, w * factor);
	}

	public function clampMagnitude(minLength:Float, maxLength:Float):Vec4 {
		var magSq = magnitudeSquared();
		var mag = Math.sqrt(magSq);

		if (mag < 1e-8)
			return new Vec4(0, 0, 0, 0);
		if (mag < minLength)
			return setMagnitude(minLength);
		if (mag > maxLength)
			return setMagnitude(maxLength);
		return new Vec4(x, y, z, w);
	}

	public function clamp(min:Vec4, max:Vec4):Vec4 {
		return new Vec4(Math.max(min.x, Math.min(max.x, x)), Math.max(min.y, Math.min(max.y, y)), Math.max(min.z, Math.min(max.z, z)),
			Math.max(min.w, Math.min(max.w, w)));
	}

	public inline function abs():Vec4 {
		return new Vec4(Math.abs(x), Math.abs(y), Math.abs(z), Math.abs(w));
	}

	public inline function floor():Vec4 {
		return new Vec4(Math.floor(x), Math.floor(y), Math.floor(z), Math.floor(w));
	}

	public inline function ceil():Vec4 {
		return new Vec4(Math.ceil(x), Math.ceil(y), Math.ceil(z), Math.ceil(w));
	}

	public inline function round():Vec4 {
		return new Vec4(Math.round(x), Math.round(y), Math.round(z), Math.round(w));
	}

	public function min(b:Vec4):Vec4 {
		return new Vec4(Math.min(x, b.x), Math.min(y, b.y), Math.min(z, b.z), Math.min(w, b.w));
	}

	public function max(b:Vec4):Vec4 {
		return new Vec4(Math.max(x, b.x), Math.max(y, b.y), Math.max(z, b.z), Math.max(w, b.w));
	}

	public inline function exactEquals(other:Vec4):Bool {
		return x == other.x && y == other.y && z == other.z && w == other.w;
	}

	public inline function nearlyEquals(other:Vec4, epsilon:Float = 0.000001):Bool {
		return Math.abs(x - other.x) < epsilon && Math.abs(y - other.y) < epsilon && Math.abs(z - other.z) < epsilon && Math.abs(w - other.w) < epsilon;
	}

	public inline function isZero():Bool {
		return x == 0 && y == 0 && z == 0 && w == 0;
	}

	public inline function isNearlyZero(epsilon:Float = 0.000001):Bool {
		return Math.abs(x) < epsilon && Math.abs(y) < epsilon && Math.abs(z) < epsilon && Math.abs(w) < epsilon;
	}

	public inline function clone():Vec4 {
		return new Vec4(x, y, z, w);
	}

	public inline function copy():Vec4 {
		return clone();
	}

	public function set(nx:Float, ny:Float, nz:Float, nw:Float):Vec4 {
		x = nx;
		y = ny;
		z = nz;
		w = nw;
		return this;
	}

	public function copyFrom(other:Vec4):Vec4 {
		x = other.x;
		y = other.y;
		z = other.z;
		w = other.w;
		return this;
	}

	public inline function maxComponent():Float {
		return Math.max(Math.max(x, y), Math.max(z, w));
	}

	public inline function minComponent():Float {
		return Math.min(Math.min(x, y), Math.min(z, w));
	}

	public inline function sum():Float {
		return x + y + z + w;
	}

	public inline function average():Float {
		return (x + y + z + w) / 4;
	}

	public inline function toVec2XY():Vec2 {
		return new Vec2(x, y);
	}

	public inline function toVec2ZW():Vec2 {
		return new Vec2(z, w);
	}

	public inline function toVec3XYZ():Vec3 {
		return new Vec3(x, y, z);
	}

	public inline function toVec3():Vec3 {
		return toVec3XYZ();
	}

	public function perspectiveDivide():Vec3 {
		if (Math.abs(w) < 1e-8)
			return new Vec3(x, y, z);
		return new Vec3(x / w, y / w, z / w);
	}

	public inline function toColor():Color {
		return Color.fromRGB(Std.int(Math.max(0, Math.min(1, x)) * 255), Std.int(Math.max(0, Math.min(1, y)) * 255),
			Std.int(Math.max(0, Math.min(1, z)) * 255), Std.int(Math.max(0, Math.min(1, w)) * 255));
	}

	public static inline function fromColor(r:Float, g:Float, b:Float, a:Float = 1):Vec4 {
		return new Vec4(r, g, b, a);
	}

	public static inline function fromColorInt(r:Int, g:Int, b:Int, a:Int = 255):Vec4 {
		return new Vec4(r / 255, g / 255, b / 255, a / 255);
	}

	public function quaternionConjugate():Vec4 {
		return new Vec4(-x, -y, -z, w);
	}

	public function quaternionMultiply(q:Vec4):Vec4 {
		return new Vec4(w * q.x
			+ x * q.w
			+ y * q.z
			- z * q.y, w * q.y
			- x * q.z
			+ y * q.w
			+ z * q.x, w * q.z
			+ x * q.y
			- y * q.x
			+ z * q.w,
			w * q.w
			- x * q.x
			- y * q.y
			- z * q.z);
	}

	public function quaternionRotateVec3(v:Vec3):Vec3 {
		var qv = new Vec4(v.x, v.y, v.z, 0);
		var qConj = quaternionConjugate();
		var result = quaternionMultiply(qv).quaternionMultiply(qConj);
		return new Vec3(result.x, result.y, result.z);
	}

	public static function quaternionFromAxisAngle(axis:Vec3, angleRad:Float):Vec4 {
		var halfAngle = angleRad * 0.5;
		var s = Math.sin(halfAngle);
		var n = axis.normalize();
		return new Vec4(n.x * s, n.y * s, n.z * s, Math.cos(halfAngle));
	}

	public static inline function quaternionFromAxisAngleDeg(axis:Vec3, angleDeg:Float):Vec4 {
		return quaternionFromAxisAngle(axis, angleDeg * Math.PI / 180);
	}

	public function quaternionToAxisAngle():{axis:Vec3, angle:Float} {
		var angle = 2 * Math.acos(w);
		var s = Math.sqrt(1 - w * w);

		if (s < 1e-8) {
			return {axis: new Vec3(1, 0, 0), angle: 0};
		}

		return {
			axis: new Vec3(x / s, y / s, z / s),
			angle: angle
		};
	}

	public static function quaternionFromEuler(pitch:Float, yaw:Float, roll:Float):Vec4 {
		var cy = Math.cos(yaw * 0.5);
		var sy = Math.sin(yaw * 0.5);
		var cp = Math.cos(pitch * 0.5);
		var sp = Math.sin(pitch * 0.5);
		var cr = Math.cos(roll * 0.5);
		var sr = Math.sin(roll * 0.5);

		return new Vec4(sr * cp * cy - cr * sp * sy, cr * sp * cy + sr * cp * sy, cr * cp * sy - sr * sp * cy, cr * cp * cy + sr * sp * sy);
	}

	public function quaternionToEuler():{pitch:Float, yaw:Float, roll:Float} {
		var sinr_cosp = 2 * (w * x + y * z);
		var cosr_cosp = 1 - 2 * (x * x + y * y);
		var roll = Math.atan2(sinr_cosp, cosr_cosp);

		var sinp = 2 * (w * y - z * x);
		var pitch = Math.abs(sinp) >= 1 ? (sinp >= 0 ? Math.PI / 2 : -Math.PI / 2) : Math.asin(sinp);

		var siny_cosp = 2 * (w * z + x * y);
		var cosy_cosp = 1 - 2 * (y * y + z * z);
		var yaw = Math.atan2(siny_cosp, cosy_cosp);

		return {pitch: pitch, yaw: yaw, roll: roll};
	}

	public function toString():String {
		return 'Vec4($x, $y, $z, $w)';
	}
}
