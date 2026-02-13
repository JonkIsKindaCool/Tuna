package commands;

import sys.io.File;
import haxe.io.Path;
import sys.FileSystem;
import configuration.Configuration;

using StringTools;

class DisplayCommand {
	public static function display(args:Array<String>, haxelibPath:String, userPath:String) {
		var target:String = args[1];
		Configuration.init(userPath, args);
		
		var configurationFile:StringBuf = new StringBuf();

		if (Configuration.meta.defines != null) {
			for (d in Configuration.meta.defines) {
				configurationFile.add("-D " + d + "\n");
			}
		}

		if (Configuration.meta.haxeflags != null) {
			for (f in Configuration.meta.haxeflags) {
				configurationFile.add(f + "\n");
			}
		}

		configurationFile.add("--main ApplicationMain\n");

		configurationFile.add("--class-path " + '${Configuration.build.output + '/helpers'}' + "\n");
		if (Configuration.source.sources != null) {
			for (s in Configuration.source.sources) {
				configurationFile.add("--class-path " + s + "\n");
			}
		}

		configurationFile.add("--library tuna\n");
		if (Configuration.source.libraries != null) {
			for (lib in Configuration.source.libraries) {
				if (Std.isOfType(lib, String)) {
					configurationFile.add("--library " + lib + "\n");
				} else {
					configurationFile.add("--library " + lib.name + "\n");
				}
			}
		}

		if (Configuration.build.dce != null) {
			configurationFile.add("-dce " + Configuration.build.dce + "\n");
		}

		if (Configuration.build.targetFlags != null) {
			for (flag in Configuration.build.targetFlags) {
				configurationFile.add(flag + "\n");
			}
		}

		if (Configuration.build.optimize != null && Configuration.build.optimize) {
			configurationFile.add("-D analyzer-optimize\n");
		}

		if (Configuration.build.verbose != null && Configuration.build.verbose) {
			configurationFile.add("-v\n");
		}

		switch (target) {
			case "cpp", "linux", "mac", "windows":
				configurationFile.add("--cpp " + Path.join([userPath, Configuration.build.output, target, "native"]) + "\n");
			case "html5":
				configurationFile.add("-D html5\n");
				configurationFile.add("--js " + Path.join([userPath, Configuration.build.output, target, "main.js"]) + "\n");
			default:
				throw 'Target $target isnt supported';
		}

		if (!FileSystem.exists(Path.join([userPath, Configuration.build.output])))
			FileSystem.createDirectory(Path.join([userPath, Configuration.build.output]));

		if (!FileSystem.exists(Path.join([userPath, Configuration.build.output, "helpers"])))
			FileSystem.createDirectory(Path.join([userPath, Configuration.build.output, "helpers"]));

		File.saveContent(Path.join([userPath, Configuration.build.output, "helpers", 'build-$target.hxml']), configurationFile.toString());

		var templatePath = Path.join([haxelibPath, "cli", "templates", "ApplicationMain.hx"]);
		var mainTemplate = File.getContent(templatePath);

		var mainContent = mainTemplate;
		mainContent = mainContent.replace("{{width}}", Std.string(Configuration.window.width ?? 1280));
		mainContent = mainContent.replace("{{height}}", Std.string(Configuration.window.height ?? 720));
		mainContent = mainContent.replace("{{title}}", Configuration.window.title ?? "Tuna Game");
		mainContent = mainContent.replace("{{fps}}", Std.string(Configuration.window.fps ?? 60));
		mainContent = mainContent.replace("{{background}}", Std.string(Configuration.window.background ?? 0));
		mainContent = mainContent.replace("{{resizable}}", Std.string(Configuration.window.resizable ?? true));
		mainContent = mainContent.replace("{{borderless}}", Std.string(Configuration.window.borderless ?? false));
		mainContent = mainContent.replace("{{fullscreen}}", Std.string(Configuration.window.fullscreen ?? false));
		mainContent = mainContent.replace("{{hardware}}", Std.string(Configuration.window.hardware ?? false));
		mainContent = mainContent.replace("{{depthBuffer}}", Std.string(Configuration.window.depthBuffer ?? false));
		mainContent = mainContent.replace("{{stencilBuffer}}", Std.string(Configuration.window.stencilBuffer ?? false));
		mainContent = mainContent.replace("{{allowHighDPI}}", Std.string(Configuration.window.allowHighDPI ?? true));

		mainContent = mainContent.replace("new Main(", "new " + Configuration.app.main + "(");

		var outputPath = Path.join([userPath, Configuration.build.output, "helpers", "ApplicationMain.hx"]);
		File.saveContent(outputPath, mainContent);
	}
}
