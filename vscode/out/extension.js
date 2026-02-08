"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
exports.activate = activate;
exports.deactivate = deactivate;
const vscode = __importStar(require("vscode"));
const child_process_1 = require("child_process");
const fs_1 = require("fs");
const path_1 = require("path");
const util_1 = require("util");
const execFileAsync = (0, util_1.promisify)(child_process_1.execFile);
let currentTarget = 'cpp';
const output = vscode.window.createOutputChannel('Tuna');
const targetBar = vscode.window.createStatusBarItem(vscode.StatusBarAlignment.Left, 100);
const watcher = vscode.workspace.createFileSystemWatcher('**/config.tuna');
function activate(context) {
    targetBar.command = "tuna.targetBar";
    context.subscriptions.push(vscode.commands.registerCommand("tuna.targetBar", selectTarget));
    const onChange = () => reload();
    context.subscriptions.push(watcher.onDidChange(onChange), watcher.onDidCreate(onChange), watcher.onDidDelete(onChange), watcher, output);
    var config = vscode.workspace.getConfiguration("tuna");
    currentTarget = config.get("selectedTarget", "cpp");
    reload();
    updateBar();
}
function deactivate() {
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
    if (!folders?.length) {
        return;
    }
    ;
    const root = folders[0].uri;
    const buildJsonPath = vscode.Uri.joinPath(root, '.tuna', 'build.json').fsPath;
    try {
        const { stdout, stderr } = await execFileAsync('haxelib', ['--global', 'run', 'tuna', 'build', currentTarget], { cwd: root.fsPath });
        if (stderr) {
            output.appendLine(`[stderr] ${stderr}`);
        }
        if (stdout) {
            output.appendLine(`[stdout] ${stdout}`);
        }
    }
    catch (err) {
        const msg = `Tuna build failed: ${err.message || err}`;
        output.appendLine(msg);
        vscode.window.showErrorMessage(msg);
        return;
    }
    if (!(0, fs_1.existsSync)(buildJsonPath)) {
        output.appendLine('build.json not found after tuna build');
        vscode.window.showWarningMessage('build.json was not generated');
        return;
    }
    try {
        const content = await fs_1.promises.readFile(buildJsonPath, 'utf-8');
        const data = JSON.parse(content);
        const exportPath = data.output;
        if (typeof exportPath !== 'string' || !exportPath) {
            throw new Error('Invalid or missing "output" field in build.json');
        }
        const hxmlPath = (0, path_1.join)(exportPath, 'helpers', `build-${currentTarget}.hxml`);
        if (!(0, fs_1.existsSync)(hxmlPath)) {
            return;
        }
        updateSettings(root, hxmlPath);
        vscode.window.showInformationMessage(`Haxe configuration updated for ${currentTarget}`);
    }
    catch (err) {
        const msg = `Failed to update Haxe settings: ${err.message}`;
        output.appendLine(msg);
        vscode.window.showErrorMessage(msg);
    }
}
function updateSettings(root, hxmlPath) {
    const vscodeDir = (0, path_1.join)(root.fsPath, '.vscode');
    const settingsPath = (0, path_1.join)(vscodeDir, 'settings.json');
    if (!(0, fs_1.existsSync)(vscodeDir)) {
        (0, fs_1.mkdirSync)(vscodeDir, { recursive: true });
    }
    let settings = {};
    if ((0, fs_1.existsSync)(settingsPath)) {
        try {
            settings = JSON.parse((0, fs_1.readFileSync)(settingsPath, 'utf8'));
        }
        catch {
            settings = {};
        }
    }
    settings['haxe.displayConfigurations'] = [[hxmlPath]];
    (0, fs_1.writeFileSync)(settingsPath, JSON.stringify(settings, null, '\t'), 'utf8');
    output.appendLine(`Updated settings.json with hxml: ${hxmlPath}`);
}
//# sourceMappingURL=extension.js.map