package tuna.backend.opengl;

typedef GLVertexArray = #if (js || html5) js.html.webgl.VertexArrayObject #else Null<Int> #end