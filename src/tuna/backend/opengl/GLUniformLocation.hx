package tuna.backend.opengl;


typedef GLUniformLocation = #if (js || html5) js.html.webgl.UniformLocation #else Null<Int> #end