package ;

import tuna.backend.core.Application;
import tuna.backend.platform.native.NativePlatform;

class ApplicationMain {

    static var window:Dynamic;

    static function main() {

        window = {
            width:       {{width}},
            height:      {{height}},
            title:       "{{title}}",
            fps:         {{fps}},
            background:  {{background}},
            resizable:   {{resizable}},
            borderless:  {{borderless}},
            fullscreen:  {{fullscreen}},
            hardware:    {{hardware}},
            depthBuffer: {{depthBuffer}},
            stencilBuffer: {{stencilBuffer}},
            allowHighDPI: {{allowHighDPI}}
        };

        var main = initApp();
        #if cpp
        tuna.backend.platform.native.NativeWindow.hardware     = window.hardware;
        tuna.backend.platform.native.NativeWindow.depthBuffer  = window.depthBuffer;
        tuna.backend.platform.native.NativeWindow.stencilBuffer = window.stencilBuffer;
        tuna.backend.platform.native.NativeWindow.allowHighDPI = window.allowHighDPI;

        main.platform = new NativePlatform(window.width, window.height, window.title);
        #end
        
        main.platform.window.background  = window.background;
        main.platform.window.resizable    = window.resizable;
        main.platform.window.borderless   = window.borderless;
        main.platform.window.fullscreen   = window.fullscreen;

        @:privateAccess
        main._realInit();
    }

    static function initApp():Application {
        return new Main();
    }
}