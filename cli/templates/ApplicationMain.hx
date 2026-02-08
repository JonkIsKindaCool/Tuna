package;

import tuna.fs.FileSystem;
import tuna.core.Application;

class ApplicationMain {
	static var window:Dynamic;

	static function main() {
		window = {
			width: {{width}},
			height: {{height}},
			title: "{{title}}",
			fps: {{fps}},
			background: {{background}},
			resizable: {{resizable}},
			borderless: {{borderless}},
			fullscreen: {{fullscreen}},
			hardware: {{hardware}},
			depthBuffer: {{depthBuffer}},
			stencilBuffer: {{stencilBuffer}},
			allowHighDPI: {{allowHighDPI}}
		};

		#if (js || html5)
		FileSystem.init(onAssetsLoaded);
		#else
		FileSystem.init();
		onAssetsLoaded();
		#end
	}

	static function onAssetsLoaded() {
		var main = initApp();

		#if cpp
		tuna.backend.platform.native.NativeWindow.hardware = window.hardware;
		tuna.backend.platform.native.NativeWindow.depthBuffer = window.depthBuffer;
		tuna.backend.platform.native.NativeWindow.stencilBuffer = window.stencilBuffer;
		tuna.backend.platform.native.NativeWindow.allowHighDPI = window.allowHighDPI;

		main.platform = new tuna.backend.platform.native.NativePlatform();
		#elseif (js || html5)
		tuna.backend.platform.web.WebWindow.hardware = window.hardware;
		tuna.backend.platform.web.WebWindow.depthBuffer = window.depthBuffer;
		tuna.backend.platform.web.WebWindow.stencilBuffer = window.stencilBuffer;
		tuna.backend.platform.web.WebWindow.allowHighDPI = window.allowHighDPI;

		main.platform = new tuna.backend.platform.web.WebPlatform();
		#end

		main.platform.init(window.width, window.height, window.title);
		main.platform.mainLoop = main.loop;

		#if !(js || html5)
		main.platform.window.background = window.background;
		main.platform.window.resizable = window.resizable;
		main.platform.window.borderless = window.borderless;
		main.platform.window.fullscreen = window.fullscreen;
		#end

		main.init();
		main.platform.initLoop();
	}

	static function initApp():Application {
		return new Main();
	}
}