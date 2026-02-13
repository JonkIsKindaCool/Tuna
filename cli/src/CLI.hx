package;

import commands.SetupCommand;
import commands.BuildCommand;
import commands.DisplayCommand;
import configuration.Configuration;
import commands.HelpCommand;
import haxe.io.Path;
import sys.io.File;
import sys.io.Process;

using StringTools;

class CLI {
	public var path:String;

	public function new() {
		var oldPath:String = Sys.getCwd();
		var args:Array<String> = Sys.args();
		path = args.pop();

		Sys.setCwd(path);
		switch (args[0]) {
			case "build":
				DisplayCommand.display(args, getHaxelibPath(), path);
				BuildCommand.build(args, getHaxelibPath(), path);
			case "test":
				DisplayCommand.display(args, getHaxelibPath(), path);
				BuildCommand.build(args, getHaxelibPath(), path);
			case "help":
				HelpCommand.command();
			case "setup":
				SetupCommand.setup();
			case "display":
				DisplayCommand.display(args, getHaxelibPath(), path);
			default:
				var logo:String = File.getContent(Path.join([getHaxelibPath(), "cli", "logo.txt"]));
				var lineBuf:StringBuf = new StringBuf();
				for (i in 0...Std.int(Math.max(logo.split("\n")[0].length, "Try using tuna help for more info".length)))
					lineBuf.addChar("=".code);

				Sys.println(lineBuf.toString());
				Sys.println(logo);
				Sys.println(lineBuf.toString());
				Sys.println("Try using tuna help for more info");
				Sys.println(lineBuf.toString());
		}

		Sys.setCwd(oldPath);
	}

	static function getHaxelibPath():String {
		try {
			var proc = new sys.io.Process("haxelib", ["path", "tuna"]);
			var lines = proc.stdout.readAll().toString().split("\n");
			proc.close();

			for (line in lines) {
				line = line.trim();
				if (line == "" || line.startsWith("-D") || line.startsWith("--"))
					continue;
				if (line.toLowerCase().contains("tuna") && !line.toLowerCase().contains("ndll")  && !line.toLowerCase().contains("hdll")  && !line.toLowerCase().contains("cli")) {
					if (line.endsWith("src/") || line.endsWith("src")) {
						line = line.substr(0, line.length - (line.endsWith("/") ? 4 : 3));
					}
					return line.trim();
				}
			}

			return Path.join([Sys.getCwd(), ""]);
		} catch (e:Dynamic) {
			Sys.println("error getting tuna path: " + e);
			return Sys.getCwd(); 
		}
	}

	static function main() {
		new CLI();
	}
}
