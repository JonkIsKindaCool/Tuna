import * as vscode from 'vscode';
import { execFile } from 'child_process';
import { existsSync, promises as fs, mkdirSync, readFileSync, writeFileSync } from 'fs';
import { join } from 'path';
import { promisify } from 'util';

const execFileAsync = promisify(execFile);

let currentTarget = 'cpp';

const output = vscode.window.createOutputChannel('Tuna');
const targetBar = vscode.window.createStatusBarItem(vscode.StatusBarAlignment.Left, 100);
const watcher = vscode.workspace.createFileSystemWatcher('**/config.tuna');

export function activate(context: vscode.ExtensionContext) {
	targetBar.command = "tuna.targetBar";

	context.subscriptions.push(vscode.commands.registerCommand("tuna.targetBar", selectTarget));

	const onChange = () => reload();

	context.subscriptions.push(
		watcher.onDidChange(onChange),
		watcher.onDidCreate(onChange),
		watcher.onDidDelete(onChange),
		watcher,
		output
	);

	var config = vscode.workspace.getConfiguration("tuna");
	currentTarget = config.get("selectedTarget", "cpp");

	reload();
	updateBar();
}

export function deactivate() {
	output.dispose();
}

async function selectTarget() {
	let targets = [
		{ label: "cpp", description: "C++" },
		{ label: "linux", description: "Linux (C++)" },
		{ label: "mac", description: "macOS (C++)" },
		{ label: "windows", description: "Windows (C++)" }
	];

	vscode.window.showQuickPick(targets, { placeHolder: "Select build target for LSP" })
		.then((val) => {
			currentTarget = val?.label ?? "cpp";
			vscode.workspace.getConfiguration("hexagon").update("selectedTarget", currentTarget, vscode.ConfigurationTarget.Workspace);
			updateBar();

			reload();
		});
}

async function updateBar() {
	targetBar.text = `Tuna: ${currentTarget}`;
	targetBar.tooltip = 'Click to change target';
	targetBar.show();
}

async function reload() {
	const folders = vscode.workspace.workspaceFolders;
	if (!folders?.length) { return; };

	const root = folders[0].uri;
	const buildJsonPath = vscode.Uri.joinPath(root, '.tuna', 'build.json').fsPath;

	try {
		const { stdout, stderr } = await execFileAsync(
			'haxelib',
			['--global', 'run', 'tuna', 'build', currentTarget],
			{ cwd: root.fsPath }
		);

		if (stderr) { output.appendLine(`[stderr] ${stderr}`); }
		if (stdout) { output.appendLine(`[stdout] ${stdout}`); }

	} catch (err: any) {
		const msg = `Tuna build failed: ${err.message || err}`;
		output.appendLine(msg);
		vscode.window.showErrorMessage(msg);
		return;
	}

	if (!existsSync(buildJsonPath)) {
		output.appendLine('build.json not found after tuna build');
		vscode.window.showWarningMessage('build.json was not generated');
		return;
	}

	try {
		const content = await fs.readFile(buildJsonPath, 'utf-8');
		const data = JSON.parse(content);
		const exportPath = data.output;

		if (typeof exportPath !== 'string' || !exportPath) {
			throw new Error('Invalid or missing "output" field in build.json');
		}

		const hxmlPath = join(exportPath, 'helpers', `build-${currentTarget}.hxml`);

		if (!existsSync(hxmlPath)) {
			return;
		}

		updateSettings(root, hxmlPath);

		vscode.window.showInformationMessage(`Haxe configuration updated for ${currentTarget}`);

	} catch (err: any) {
		const msg = `Failed to update Haxe settings: ${err.message}`;
		output.appendLine(msg);
		vscode.window.showErrorMessage(msg);
	}
}

function updateSettings(root: vscode.Uri, hxmlPath: string) {
	const vscodeDir = join(root.fsPath, '.vscode');
	const settingsPath = join(vscodeDir, 'settings.json');

	if (!existsSync(vscodeDir)) {
		mkdirSync(vscodeDir, { recursive: true });
	}

	let settings: any = {};
	if (existsSync(settingsPath)) {
		try {
			settings = JSON.parse(readFileSync(settingsPath, 'utf8'));
		} catch {
			settings = {};
		}
	}

	settings['haxe.displayConfigurations'] = [[hxmlPath]];

	writeFileSync(settingsPath, JSON.stringify(settings, null, '\t'), 'utf8');
	output.appendLine(`Updated settings.json with hxml: ${hxmlPath}`);
}