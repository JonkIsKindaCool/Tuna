package tuna.backend.audio;

import tuna.backend.audio.AudioFormats.AudioData;

interface AudioBuffer {
	public var data:#if cpp Int #elseif (js || html5) js.html.audio.AudioBuffer #else Dynamic #end;
    public var information:AudioData;

	public var duration(get, never):Float;
	public function destroy():Void;
}
