package tuna.backend;

import tuna.utils.Color;

interface IWindow {
	public var title(get, set):String;

	public var x(get, set):Int;
	public var y(get, set):Int;

	public var width(get, set):Int;
	public var height(get, set):Int;

	public var visibility(get, set):Bool;
	public var resizable(get, set):Bool;
	public var borderless(get, set):Bool;
	public var maximized(get, set):Bool;
	public var fullscreen(get, set):Bool;
	
	public var background:Color;

	public function clear():Void;
	public function render():Void;
}