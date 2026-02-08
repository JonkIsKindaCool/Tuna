package tuna.backend.opengl;

import haxe.Int64;

typedef GLProgram = #if (js || html5) js.html.webgl.Program #else Null<UInt32> #end