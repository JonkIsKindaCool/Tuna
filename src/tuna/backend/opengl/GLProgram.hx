package tuna.backend.opengl;

abstract GLProgram(Int) to Int {
	public function new(vertex:String, fragment:String) {
		var program:Int = GL.createProgram();

		var vertShader:Int = GL.createShader(GL.VERTEX_SHADER);
		GL.shaderSource(vertShader, vertex);
		GL.compileShader(vertShader);

		var fragShader:Int = GL.createShader(GL.FRAGMENT_SHADER);
		GL.shaderSource(fragShader, fragment);
		GL.compileShader(fragShader);

        GL.attachShader(program, vertShader);
        GL.attachShader(program, fragShader);
        GL.linkProgram(program);

        GL.deleteShader(vertShader);
        GL.deleteShader(fragShader);
        this = program;
	}

    public function activate() {
        GL.useProgram(this);
    }

    public function deactivate() {
        GL.useProgram(0);
    }

    public function destroy() {
        GL.deleteProgram(this);
    }
}
