package tuna.backend.cffi;

@:build(tuna.backend.macro.CFFIMacro.build("tuna"))
class NativePlatformCFFI {
    public static function platform_init():Void;
}