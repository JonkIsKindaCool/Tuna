package commands;

import sys.io.File;
import configuration.Configuration;
import haxe.io.Path;

class BuildCommand {
	public static function build(args:Array<String>, haxelibPath:String, userPath:String) {
		var target:String = args[1];

		var compilePath:String = Path.join([userPath, Configuration.build.output]);
		var hxmlPath:String = Path.join([Configuration.build.output, "helpers", 'build-$target.hxml']);

		Sys.command('haxe', [hxmlPath]);

		switch (target) {}
	}
}
