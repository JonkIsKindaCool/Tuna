package tuna.backend.audio;

interface AudioSource {
    public var buffer:AudioBuffer;
    public var volume(get, set):Float;

    public function play():Void;
    public function destroy():Void;
}