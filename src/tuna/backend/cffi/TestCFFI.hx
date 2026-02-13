package tuna.backend.cffi;

@:build(tuna.backend.macro.CFFIMacro.build("tuna"))
class TestCFFI {
    public static function test_ndll():Void;
}