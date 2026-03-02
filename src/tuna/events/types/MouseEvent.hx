package tuna.events.types;

class MouseMoveEvent extends Event {
	public var x:Int;
	public var y:Int;
	public var delX:Int;
	public var delY:Int;
}

class MouseScrollEvent extends Event {
	public var scroll:Int;
}

class MouseClickEvent extends Event {
	public var button:Int;
}
