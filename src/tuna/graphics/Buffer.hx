package tuna.graphics;

import haxe.io.Bytes;
import tuna.backend.opengl.GLBuffer;
import tuna.backend.opengl.GL;

class Buffer {
	public var id:GLBuffer;
	public var target:Int;

	public function new(target:Int) {
		this.target = target;
		id = GL.genBuffer();
	}
    
    public function genData(data:Bytes, usage:Int) {
        GL.bufferData(target, data.length, data, usage);        
    }

	public function start() {
		GL.bindBuffer(target, id);
	}

	public function stop() {
		GL.bindBuffer(target, id);
	}
}
