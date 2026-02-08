package configuration;

import haxe.Json;
import sys.FileSystem;
import haxe.io.Path;
import configuration.ConfigurationData;
import sys.io.File;
import hscript.*;

using StringTools;

class Configuration {
	public static var meta:Meta = {
		description: "Application Placeholder",
		version: "1.0.0",
		defines: [],
		haxeflags: [],
		companyId: "com.placeholder",
		company: "placeholder"
	};
	public static var app:App = {
		main: "Main",
		name: "Placeholder"
	};
	public static var window:Window = {
		width: 800,
		height: 600,
		fps: 60,
		title: "Placeholder"
	};
	public static var build:Build = {
		output: "out"
	};
	public static var source:Source = {
		sources: [],
		libraries: []
	};
	public static var assets:Assets = [];
	public static var android:Android = {};
	public static var androidGradle:AndroidGradle = {};
	public static var ios:IOS = {};

	public static function init(userPath:String, args:Array<String>) {
		if (!FileSystem.exists(Path.join([userPath, "config.tuna"])))
			throw 'You need a config.tuna in this folder';

		var parser:Parser = new Parser();
		var ast:Expr = parser.parseString(File.getContent(Path.join([userPath, "config.tuna"])));

		for (arg in args) {
			if (arg.startsWith("-")) {
				meta.defines.push(arg.substr(1));
			}
		}

		var interp:Interp = new Interp();

		interp.variables.set("setTitle", function(value:String) {
			window.title = value;
		});
		interp.variables.set("setDescription", function(value:String) {
			meta.description = value;
		});
		interp.variables.set("setVersion", function(value:String) {
			meta.version = value;
		});
		interp.variables.set("setCompany", function(value:String) {
			meta.company = value;
		});
		interp.variables.set("setCompanyId", function(value:String) {
			meta.companyId = value;
		});
		interp.variables.set("setDefines", function(value:Array<String>) {
			meta.defines = value;
		});
		interp.variables.set("addDefine", function(value:String) {
			meta.defines.push(value);
		});
		interp.variables.set("setHaxeflags", function(value:Array<String>) {
			meta.haxeflags = value;
		});
		interp.variables.set("addHaxeflag", function(value:String) {
			if (meta.haxeflags == null)
				meta.haxeflags = [];
			meta.haxeflags.push(value);
		});

		interp.variables.set("setMain", function(value:String) {
			app.main = value;
		});
		interp.variables.set("setName", function(value:String) {
			app.name = value;
		});
		interp.variables.set("setIcon", function(value:String) {
			app.icon = value;
		});

		interp.variables.set("setWidth", function(value:Int) {
			window.width = value;
		});
		interp.variables.set("setHeight", function(value:Int) {
			window.height = value;
		});
		interp.variables.set("setFps", function(value:Int) {
			window.fps = value;
		});
		interp.variables.set("setBackground", function(value:Int) {
			window.background = value;
		});
		interp.variables.set("setResizable", function(value:Bool) {
			window.resizable = value;
		});
		interp.variables.set("setBorderless", function(value:Bool) {
			window.borderless = value;
		});
		interp.variables.set("setFullscreen", function(value:Bool) {
			window.fullscreen = value;
		});
		interp.variables.set("setHardware", function(value:Bool) {
			window.hardware = value;
		});
		interp.variables.set("setDepthBuffer", function(value:Bool) {
			window.depthBuffer = value;
		});
		interp.variables.set("setStencilBuffer", function(value:Bool) {
			window.stencilBuffer = value;
		});
		interp.variables.set("setAllowHighDPI", function(value:Bool) {
			window.allowHighDPI = value;
		});

		interp.variables.set("setOutput", function(value:String) {
			build.output = value;
		});
		interp.variables.set("setVerbose", function(value:Bool) {
			build.verbose = value;
		});
		interp.variables.set("setOptimize", function(value:Bool) {
			build.optimize = value;
		});
		interp.variables.set("setDce", function(value:String) {
			build.dce = value;
		});
		interp.variables.set("setTargetFlags", function(value:Array<String>) {
			build.targetFlags = value;
		});
		interp.variables.set("addTargetFlag", function(value:String) {
			if (build.targetFlags == null)
				build.targetFlags = [];
			build.targetFlags.push(value);
		});

		interp.variables.set("setSources", function(value:Array<String>) {
			source.sources = value;
		});
		interp.variables.set("addSource", function(value:String) {
			if (source.sources == null)
				source.sources = [];
			source.sources.push(value);
		});
		interp.variables.set("setLibraries", function(value:Array<Dynamic>) {
			source.libraries = value;
		});
		interp.variables.set("addLibrary", function(value:Dynamic) {
			if (source.libraries == null)
				source.libraries = [];
			source.libraries.push(value);
		});

		interp.variables.set("setAssets", function(value:Array<Asset>) {
			assets = value;
		});
		interp.variables.set("addAsset", function(asset:Asset) {
			assets.push(asset);
		});

		interp.variables.set("setAndroidTargetSdkVersion", function(value:Int) {
			android.targetSdkVersion = value;
		});
		interp.variables.set("setAndroidMinSdkVersion", function(value:Int) {
			android.minSdkVersion = value;
		});
		interp.variables.set("setAndroidInstallLocation", function(value:String) {
			android.installLocation = value;
		});
		interp.variables.set("setAndroidPermissions", function(value:Array<String>) {
			android.permissions = value;
		});
		interp.variables.set("addAndroidPermission", function(value:String) {
			if (android.permissions == null)
				android.permissions = [];
			android.permissions.push(value);
		});
		interp.variables.set("setAndroidExtensions", function(value:Array<String>) {
			android.extensions = value;
		});
		interp.variables.set("addAndroidExtension", function(value:String) {
			if (android.extensions == null)
				android.extensions = [];
			android.extensions.push(value);
		});
		interp.variables.set("setAndroidTemplate", function(value:String) {
			android.template = value;
		});

		interp.variables.set("setGradleBuildToolsVersion", function(value:String) {
			androidGradle.buildToolsVersion = value;
		});
		interp.variables.set("setGradleCompileSdkVersion", function(value:Int) {
			androidGradle.compileSdkVersion = value;
		});
		interp.variables.set("setGradleDependencies", function(value:Array<String>) {
			androidGradle.dependencies = value;
		});
		interp.variables.set("addGradleDependency", function(value:String) {
			if (androidGradle.dependencies == null)
				androidGradle.dependencies = [];
			androidGradle.dependencies.push(value);
		});
		interp.variables.set("setGradleRepositories", function(value:Array<String>) {
			androidGradle.repositories = value;
		});
		interp.variables.set("addGradleRepository", function(value:String) {
			if (androidGradle.repositories == null)
				androidGradle.repositories = [];
			androidGradle.repositories.push(value);
		});

		interp.variables.set("setIOSDeployment", function(value:Float) {
			ios.deployment = value;
		});
		interp.variables.set("setIOSDevices", function(value:String) {
			ios.devices = value;
		});
		interp.variables.set("setIOSPrerenderedIcon", function(value:Bool) {
			ios.prerenderedIcon = value;
		});
		interp.variables.set("setIOSCompiler", function(value:String) {
			ios.compiler = value;
		});
		interp.variables.set("setIOSLinkerFlags", function(value:Array<String>) {
			ios.linkerFlags = value;
		});
		interp.variables.set("addIOSLinkerFlag", function(value:String) {
			if (ios.linkerFlags == null)
				ios.linkerFlags = [];
			ios.linkerFlags.push(value);
		});
		interp.variables.set("setIOSTeamId", function(value:String) {
			ios.teamId = value;
		});
		interp.variables.set("setIOSProvisioning", function(value:String) {
			ios.provisioning = value;
		});
		interp.variables.set("setIOSFrameworks", function(value:Array<String>) {
			ios.frameworks = value;
		});
		interp.variables.set("addIOSFramework", function(value:String) {
			if (ios.frameworks == null)
				ios.frameworks = [];
			ios.frameworks.push(value);
		});

		interp.variables.set("hasDefine", function(define:String) {
			return meta.defines.contains(define);
		});

		interp.execute(ast);

		if (!FileSystem.exists(Path.join([userPath, ".tuna"]))){
			FileSystem.createDirectory(Path.join([userPath, ".tuna"]));
		}

		File.saveContent(Path.join([userPath, ".tuna", "app.json"]), Json.stringify(app));
		File.saveContent(Path.join([userPath, ".tuna", "meta.json"]), Json.stringify(meta));
		File.saveContent(Path.join([userPath, ".tuna", "build.json"]), Json.stringify(build));
	}
}
