package tuna.backend.opengl;

import haxe.Int64;

typedef GLShader = #if (js || html5) js.html.webgl.Shader #else Null<UInt32> #end
