package tuna.graphics;

import tuna.math.Mat3;
import tuna.math.Mat4;
import tuna.backend.opengl.GLProgram;
import tuna.backend.opengl.GL;
import tuna.backend.opengl.GLShader;

class Shader {
	public var program:GLProgram;

	public function new(vertex:String, fragment:String) {
		var vertexShader:GLShader = createShader(GL.VERTEX_SHADER, vertex);
		var fragmentShader:GLShader = createShader(GL.FRAGMENT_SHADER, fragment);

		program = GL.createProgram();
		GL.attachShader(program, vertexShader);
		GL.attachShader(program, fragmentShader);
		GL.linkProgram(program);

		var linkStatus:Int = GL.getProgramiv(program, GL.LINK_STATUS);

		if (linkStatus == 0) {
			var info:String = GL.getProgramInfoLog(program);
			trace('Program linking failed: $info');
			GL.deleteProgram(program);
			return;
		}

		GL.deleteShader(vertexShader);
		GL.deleteShader(fragmentShader);
	}

	public function start() {
		GL.useProgram(program);
	}

	public function stop() {
		GL.useProgram(null);
	}

	public function setMatrix3(name:String, mat:Mat3) {
		GL.uniformMatrix3fv(GL.getUniformLocation(program, name), false, mat);
	}

	public function setMatrix4(name:String, mat:Mat4) {
		GL.uniformMatrix4fv(GL.getUniformLocation(program, name), false, mat);
	}

	private static function createShader(type:Int, source:String):GLShader {
		var shader:GLShader = GL.createShader(type);
		GL.shaderSource(shader, source);
		GL.compileShader(shader);

		var compileStatus = GL.getShaderiv(shader, GL.COMPILE_STATUS);

		if (compileStatus == 0) {
			var info:String = GL.getShaderInfoLog(shader);
			var shaderType:String = type == GL.VERTEX_SHADER ? "vertex" : "fragment";
			trace('$shaderType shader compilation failed : $info');
			GL.deleteShader(shader);
			return null;
		}

		return shader;
	}
}
