package tuna.backend.opengl;

typedef GLBuffer = #if (js || html5) js.html.webgl.Buffer #else Null<UInt32> #end; 