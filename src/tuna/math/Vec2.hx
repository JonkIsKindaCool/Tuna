package tuna.math;

import tuna.io.Float32Array;

@:forward
abstract Vec2(BasicVec2) from BasicVec2 to BasicVec2 {
	public function new(x:Float = 0, y:Float = 0) {
		this = {x: x, y: y};
	}

	@:op(A + B)
	public function add(b:Vec2):Vec2 {
		return new Vec2(this.x + b.x, this.y + b.y);
	}

	@:op(A - B)
	public function subtract(b:Vec2):Vec2 {
		return new Vec2(this.x - b.x, this.y - b.y);
	}

	@:op(A * B)
	public function multiplyScalar(b:Float):Vec2 {
		return new Vec2(this.x * b, this.y * b);
	}

	@:op(A * B)
	public static function multiplyVectors(a:Vec2, b:Vec2):Vec2 {
		return new Vec2(a.x * b.x, a.y * b.y);
	}

	@:op(A / B)
	public function divideScalar(b:Float):Vec2 {
		if (b == 0)
			return new Vec2(this.x, this.y);
		return new Vec2(this.x / b, this.y / b);
	}

	@:op(A / B)
	public static function divideVectors(a:Vec2, b:Vec2):Vec2 {
		return new Vec2(b.x != 0 ? a.x / b.x : a.x, b.y != 0 ? a.y / b.y : a.y);
	}

	@:op(-A)
	public function negate():Vec2 {
		return new Vec2(-this.x, -this.y);
	}

	@:op(A == B)
	public function equals(b:Vec2):Bool {
		return Math.abs(this.x - b.x) < 0.000001 && Math.abs(this.y - b.y) < 0.000001;
	}

	@:to
	public function toArray():Array<Float32> {
		return [this.x, this.y];
	}

	@:from
	public static function fromArray(arr:Array<Float>):Vec2 {
		return new Vec2(arr[0] ?? 0, arr[1] ?? 0);
	}

	@:arrayAccess
	public inline function get(index:Int):Float {
		return index == 0 ? this.x : this.y;
	}

	@:arrayAccess
	public inline function set(index:Int, value:Float):Float {
		if (index == 0)
			this.x = value
		else
			this.y = value;
		return value;
	}
}

@:structInit
private class BasicVec2 {
	public var x:Float;
	public var y:Float;

	public function new(x:Float, y:Float) {
		this.x = x;
		this.y = y;
	}

	public inline function magnitude():Float {
		return Math.sqrt(x * x + y * y);
	}

	public inline function magnitudeSq():Float {
		return x * x + y * y;
	}

	public function normalize():Vec2 {
		var mag:Float = magnitude();
		return mag > 0 ? new Vec2(x / mag, y / mag) : new Vec2(0, 0);
	}

	public inline function normalized():Vec2 {
		return normalize();
	}

	public inline function distanceTo(b:Vec2):Float {
		var dx:Float = b.x - x;
		var dy:Float = b.y - y;
		return Math.sqrt(dx * dx + dy * dy);
	}

	public inline function distanceSqTo(b:Vec2):Float {
		var dx:Float = b.x - x;
		var dy:Float = b.y - y;
		return dx * dx + dy * dy;
	}

	public inline function dot(b:Vec2):Float {
		return x * b.x + y * b.y;
	}

	public inline function cross(b:Vec2):Float {
		return x * b.y - y * b.x;
	}

	public inline function angle():Float {
		return Math.atan2(y, x);
	}

	public inline function angleDeg():Float {
		return Math.atan2(y, x) * 180 / Math.PI;
	}

	public function angleTo(b:Vec2):Float {
		var dot:Float = this.dot(b);
		var det:Float = cross(b);
		return Math.atan2(det, dot);
	}

	public inline function angleToDeg(b:Vec2):Float {
		return angleTo(b) * 180 / Math.PI;
	}

	public inline function angleBetween(b:Vec2):Float {
		var cosAngle:Float = dot(b) / (magnitude() * b.magnitude());
		return Math.acos(Math.max(-1, Math.min(1, cosAngle)));
	}

	public function rotate(angleRad:Float):Vec2 {
		var cos:Float = Math.cos(angleRad);
		var sin:Float = Math.sin(angleRad);
		return new Vec2(x * cos - y * sin, x * sin + y * cos);
	}

	public inline function rotateDeg(angleDeg:Float):Vec2 {
		return rotate(angleDeg * Math.PI / 180);
	}

	public function rotateAround(angleRad:Float, pivot:Vec2):Vec2 {
		var dx:Float = x - pivot.x;
		var dy:Float = y - pivot.y;
		var cos:Float = Math.cos(angleRad);
		var sin:Float = Math.sin(angleRad);
		return new Vec2(dx * cos - dy * sin + pivot.x, dx * sin + dy * cos + pivot.y);
	}

	public inline function rotateAroundDeg(angleDeg:Float, pivot:Vec2):Vec2 {
		return rotateAround(angleDeg * Math.PI / 180, pivot);
	}

	public function lerp(b:Vec2, t:Float):Vec2 {
		return new Vec2(x + (b.x - x) * t, y + (b.y - y) * t);
	}

	public function slerp(b:Vec2, t:Float):Vec2 {
		var angle:Float = angleTo(b);
		var sin:Float = Math.sin(angle);
		if (Math.abs(sin) < 0.001)
			return lerp(b, t);

		var a:Float = Math.sin((1 - t) * angle) / sin;
		var c:Float = Math.sin(t * angle) / sin;
		return new Vec2(x * a + b.x * c, y * a + b.y * c);
	}

	public function clamp(min:Vec2, max:Vec2):Vec2 {
		return new Vec2(Math.max(min.x, Math.min(max.x, x)), Math.max(min.y, Math.min(max.y, y)));
	}

	public function limit(maxLength:Float):Vec2 {
		var magSq:Float = magnitudeSq();
		if (magSq > maxLength * maxLength) {
			return normalize() * maxLength;
		}
		return new Vec2(x, y);
	}

	public inline function abs():Vec2 {
		return new Vec2(Math.abs(x), Math.abs(y));
	}

	public inline function floor():Vec2 {
		return new Vec2(Math.floor(x), Math.floor(y));
	}

	public inline function ceil():Vec2 {
		return new Vec2(Math.ceil(x), Math.ceil(y));
	}

	public inline function round():Vec2 {
		return new Vec2(Math.round(x), Math.round(y));
	}

	public function reflect(normal:Vec2):Vec2 {
		var d:Float = 2 * dot(normal);
		return new Vec2(x - d * normal.x, y - d * normal.y);
	}

	public function project(onto:Vec2):Vec2 {
		var d:Float = dot(onto) / onto.magnitudeSq();
		return onto * d;
	}

	public inline function perpendicular():Vec2 {
		return new Vec2(-y, x);
	}

	public inline function copy():Vec2 {
		return new Vec2(x, y);
	}

	public inline function set(nx:Float, ny:Float):Vec2 {
		x = nx;
		y = ny;
		return this;
	}

	public static inline function fromAngle(angleRad:Float):Vec2 {
		return new Vec2(Math.cos(angleRad), Math.sin(angleRad));
	}

	public static inline function fromAngleDeg(angleDeg:Float):Vec2 {
		return fromAngle(angleDeg * Math.PI / 180);
	}

	public static inline function zero():Vec2 {
		return new Vec2(0, 0);
	}

	public static inline function one():Vec2 {
		return new Vec2(1, 1);
	}

	public static inline function up():Vec2 {
		return new Vec2(0, -1);
	}

	public static inline function down():Vec2 {
		return new Vec2(0, 1);
	}

	public static inline function left():Vec2 {
		return new Vec2(-1, 0);
	}

	public static inline function right():Vec2 {
		return new Vec2(1, 0);
	}

	public function toString():String {
		return 'Vec2(${x}, ${y})';
	}
}
