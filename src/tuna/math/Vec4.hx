package tuna.math;

@:forward
abstract Vec4(BasicVec4) from BasicVec4 to BasicVec4 {
	public function new(x:Float, y:Float, z:Float, w:Float) {
		this = {
			x: x,
			y: y,
			z: z,
			w: w
		};
	}

	@:to
	public function toBasicArray():Array<Float> {
		return [this.x, this.y, this.z, this.w];
	} /*  */

	@:to
	public function toArray():Array<Float32> {
		return [this.x, this.y, this.z, this.w];
	} /*  */
}

@:structInit
private class BasicVec4 {
	public var x:Float;
	public var y:Float;
	public var z:Float;
	public var w:Float;

	public function new(x:Float, y:Float, z:Float, w:Float) {
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
	}

	public function toString() {
		return 'Vec2(${this.x}, ${this.y})';
	}
}
