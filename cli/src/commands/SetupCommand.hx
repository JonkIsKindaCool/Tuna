package commands;

import haxe.io.Path;
import sys.io.File;

using StringTools;

class SetupCommand {
    private static var systemName:String;
	public static function setup():Void {
        systemName = Sys.systemName();
		try {
			if (systemName.indexOf('Win') != -1)
				installWindowsAlias();
			else if (systemName.indexOf('Linux') != -1)
				installUnixAlias(true);
			else if (systemName.indexOf('Mac') != -1)
				installUnixAlias(false);
			else {
				Sys.println('Unsupported OS for alias installation');
				Sys.exit(1);
			}

			Sys.println('Installed command-line alias "tuna"');
		} catch (e:Dynamic) {
			Sys.println('Failed to install command-line alias');
			Sys.exit(1);
		}
	}

	private static function installWindowsAlias():Void {
		var haxePath = Sys.getEnv('HAXEPATH');
		if (haxePath == null || haxePath.trim() == '') {
			haxePath = 'C:\\HaxeToolkit\\haxe';
		} else {
			haxePath = haxePath.trim();
		}

		File.saveContent(Path.join([haxePath, 'tuna.bat']), '@echo off\nhaxelib --global run tuna %*');
	}

	private static function installUnixAlias(useSudo:Bool):Void {
		var sudo = useSudo ? 'sudo ' : '';
		var dest = '/usr/local/bin/tuna';

		var scriptContent = '#!/bin/bash\nhaxelib --global run tuna "$@"';
		var tempFile = '/tmp/tuna_install.sh';

		File.saveContent(tempFile, scriptContent);
		Sys.command('${sudo}mv $tempFile $dest');
		Sys.command('${sudo}chmod 755 $dest');
	}
}
