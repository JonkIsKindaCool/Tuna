package commands;

import configuration.ManifestData;
import sys.FileSystem;
import sys.io.File;
import configuration.Configuration;
import haxe.io.Path;
import haxe.Json;

class BuildCommand {
	static var manifest:ManifestData = [];
	static var targetPath:String;

	public static function build(args:Array<String>, haxelibPath:String, userPath:String) {
		var target = args[1];

		var compilePath = Path.join([userPath, Configuration.build.output]);
		var hxmlPath = Path.join([Configuration.build.output, "helpers", 'build-$target.hxml']);

		var exitCode = Sys.command("haxe", [hxmlPath]);
		if (exitCode != 0) {
			Sys.println("→ Compilation failed");
			Sys.exit(exitCode);
		}

		targetPath = Path.join([userPath, Configuration.build.output, target]);

		switch target {
			case "cpp":
				targetPath = Path.join([targetPath, "bin"]);
			case "hl", "hashlink":
				targetPath = Path.join([targetPath, "native"]);
			default:
		}

		if (!FileSystem.exists(targetPath)) {
			FileSystem.createDirectory(targetPath);
		}

		manifest = [];

		if (target == "cpp") {
			var os = Sys.systemName();
			var isWindows = (new EReg("window", "i")).match(os);
			var isMac = (new EReg("mac", "i")).match(os);
			var isLinux = (new EReg("linux", "i")).match(os);

			var srcBinary:String = Path.join([userPath, Configuration.build.output, target, "native", "ApplicationMain"]);
			var destBinary:String = Path.join([targetPath, Configuration.app.name]);

			var srcNdll:String = Path.join([
				haxelibPath,
				"ndll",
				isWindows ? "Windows64" : isMac ? "Mac64" : isLinux ? "Linux64" : null,
				"tuna.ndll"
			]);
			var destNdll:String = Path.join([targetPath, "tuna.ndll"]);

			if (!FileSystem.exists(srcNdll)) {
				Sys.println('Binary not found: $srcNdll');
				Sys.exit(1);
			}

			if (!FileSystem.exists(srcBinary)) {
				Sys.println('Binary not found: $srcBinary');
				Sys.exit(1);
			}

			File.saveBytes(destNdll, File.getBytes(srcNdll));
			File.saveBytes(destBinary, File.getBytes(srcBinary));
		} else if (target == "hashlink" || target == "hl") {
			var os = Sys.systemName();
			var isWindows = (new EReg("window", "i")).match(os);
			var isMac = (new EReg("mac", "i")).match(os);
			var isLinux = (new EReg("linux", "i")).match(os);

			var srcNdll:String = Path.join([
				haxelibPath,
				"hdll",
				isWindows ? "Windows64" : isMac ? "Mac64" : isLinux ? "Linux64" : null,
				"tuna.hdll"
			]);
			var destNdll:String = Path.join([targetPath, "tuna.hdll"]);

			if (!FileSystem.exists(srcNdll)) {
				Sys.println('Binary not found: $srcNdll');
				Sys.exit(1);
			}

			File.saveBytes(destNdll, File.getBytes(srcNdll));
		} else if (target == "html5") {
			File.saveContent(Path.join([targetPath, "index.html"]), File.getContent(Path.join([haxelibPath, "cli", "templates", "index.html"])));
		}

		for (asset in Configuration.assets) {
			var src:String = Path.join([userPath, asset.path]);
			var dest:String = Path.join([targetPath, asset.path]);

			createPath(dest);

			copyDirectory(src, dest, asset.preload, asset.exclude, asset.include, asset.rename, asset.path);
		}

		saveManifest(targetPath);
	}

	static function createPath(path:String) {
		if (!FileSystem.exists(path)) {
			FileSystem.createDirectory(path);
		}
	}

	public static function copyDirectory(source:String, target:String, ?preload:Bool = false, ?exclude:Array<String>, ?include:Array<String>, ?rename:String,
			?basePath:String) {
		var files:Array<String> = FileSystem.readDirectory(source);

		for (file in files) {
			var filePath:String = Path.join([source, file]);
			var targetPath:String = Path.join([target, rename ?? file]);

			if (FileSystem.isDirectory(filePath)) {
				if (!FileSystem.exists(targetPath))
					FileSystem.createDirectory(targetPath);
				copyDirectory(filePath, targetPath, preload, exclude, include, null, basePath);
			} else {
				if (exclude != null) {
					if (exclude.contains(Path.extension(filePath))) {
						continue;
					}
				}

				var shouldCopy = false;
				if (include == null) {
					shouldCopy = true;
				} else if (include.contains(Path.extension(filePath))) {
					shouldCopy = true;
				}

				if (shouldCopy) {
					#if TEST_CLI_DEBUG
					Sys.println('Copying file $filePath to $targetPath');
					#end

					File.saveBytes(targetPath, File.getBytes(filePath));

					if (preload)
						addToManifest(basePath ?? Path.directory(targetPath), targetPath);
				}
			}
		}
	}

	static function addToManifest(folderPath:String, filePath:String) {
		manifest.push(filePath.substr(targetPath.length + 1));
	}

	static function saveManifest(targetPath:String) {
		var manifestPath:String = Path.join([targetPath, "manifest.json"]);
		var jsonContent:String = Json.stringify(manifest, null, "");

		File.saveContent(manifestPath, jsonContent);

		#if TEST_CLI_DEBUG
		Sys.println('Manifest saved to $manifestPath');
		Sys.println('Total folders: ${manifest.length}');
		var totalFiles = 0;
		for (folder in manifest) {
			totalFiles += folder.files.length;
		}
		Sys.println('Total files: $totalFiles');
		#end
	}
}
