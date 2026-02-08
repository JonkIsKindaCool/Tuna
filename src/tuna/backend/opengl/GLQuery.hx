package tuna.backend.opengl;

import haxe.Int64;

typedef GLQuery = #if (js || html5) js.html.webgl.Query #else Null<UInt32> #end