package tuna.math;

@:forward
abstract Vec2(BasicVec2) from BasicVec2 to BasicVec2 {
	public function new(x:Float = 0, y:Float = 0) {
		this = {x: x, y: y};
	}

	@:op(A + B)
	public function add(b:Vec2) {
		return new Vec2(this.x + b.x, this.y + b.y);
	}

	@:op(A - B)
	public function subtract(b:Vec2) {
		return new Vec2(this.x - b.x, this.y - b.y);
	}

	@:op(A * B)
	public function multiplyScalar(b:Float) {
		return new Vec2(this.x * b, this.y * b);
	}

	@:op(A * B)
	public static function multiplyVectors(a:Vec2, b:Vec2):Vec2 {
		return new Vec2(a.x * b.x, a.y * b.y);
	}

	@:op(A / B)
	public function divideScalar(b:Float):Vec2 {
		return new Vec2(this.x / b, this.y / b);
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

	public function magnitude():Float {
		return Math.sqrt(Math.pow(this.x, 2) + Math.pow(this.y, 2));
	}

	public function normalize():Vec2 {
		var mag:Float = magnitude();
		return mag > 0 ? new Vec2(this.x / magnitude(), this.y / magnitude()) : new Vec2();
	}

	public function distanceTo(b:Vec2):Float {
		var dif:Vec2 = new Vec2(b.x - this.x, b.y - this.y);
		dif = new Vec2(Math.pow(dif.x, 2), Math.pow(dif.y, 2));

		return Math.sqrt(dif.x + dif.y);
	}

	public static function fromAngle(angle:Float) {
		return new Vec2(Math.cos(angle * Math.PI / 180), Math.sin(angle * Math.PI / 180));
	}

	public function angleTo(b:Vec2) {
		var dot:Float = this.x * b.x + this.y * b.y;
		var det:Float = this.x * b.x - this.y * b.y;

		return Math.atan2(det, dot) * 180 / Math.PI;
	}

	public function rotate(angle:Float) {
		return new Vec2(this.x * Math.cos(angle * Math.PI / 180) - this.y * Math.sin(angle * Math.PI / 180),
			this.x * Math.sin(angle * Math.PI / 180) + this.y * Math.cos(angle * Math.PI / 180));
	}

	public function rotateAround(angle:Float, pivot:Vec2) {
		return new Vec2((this.x - pivot.x) * Math.cos(angle * Math.PI / 180)
			- (this.y - pivot.y) * Math.sin(angle * Math.PI / 180)
			+ pivot.x,
			(this.x - pivot.x) * Math.sin(angle * Math.PI / 180)
			- (this.y - pivot.y) * Math.cos(angle * Math.PI / 180)
			+ pivot.x);
	}

	public function toString() {
		return 'Vec2(${this.x}, ${this.y})';
	}
}
