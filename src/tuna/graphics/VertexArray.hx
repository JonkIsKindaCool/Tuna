package tuna.graphics;

import tuna.backend.opengl.GL;
import tuna.backend.opengl.GLVertexArray;

class VertexArray {
    public var id:GLVertexArray;
    public function new() {
        id = GL.genVertexArray();
    }

    public function vertexAttrib(index:UInt, size:Int, type:Int, normalized:Bool, stride:Int, offset:Int) {
        GL.vertexAttribPointer(index, size, type, normalized, stride, offset);
		GL.enableVertexAttribArray(index);
    }

    public function start() {
        GL.bindVertexArray(id);
    }

    public function stop() {
        GL.bindVertexArray(null);
    }
}