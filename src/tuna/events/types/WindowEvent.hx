package tuna.events.types;

class WindowResizeEvent extends Event {
    public var width:Int;
    public var height:Int;
}

class WindowMoveEvent {
    public var x:Int;
    public var y:Int;
}

class WindowQuitEvent extends Event {}
