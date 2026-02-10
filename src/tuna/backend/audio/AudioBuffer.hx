package tuna.backend.audio;

interface AudioBuffer {
	public var data:#if cpp UInt32 #elseif (js || html5) Dynamic #else Dynamic #end;

	public function destroy():Void;
}
