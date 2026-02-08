package tuna.backend.opengl;

import haxe.Int64;

typedef GLTexture = #if (js || html5) js.html.webgl.Texture #else Null<UInt32> #end 