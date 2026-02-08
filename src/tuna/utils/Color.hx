package tuna.utils;

abstract Color(Int) from Int to Int {

    // Constructor básico desde un Int
    inline public function new(value:Int) {
        this = value;
    }

    // Métodos estáticos para crear colores comunes
    public static inline function fromRGB(r:Int, g:Int, b:Int, a:Int = 255):Color {
        return (a << 24) | (r << 16) | (g << 8) | b;
    }

    public static inline function fromHex(hex:Int):Color {
        return hex;
    }

    // Accesores de componentes (lectura)
    public var a(get, never):Int;
    public var r(get, never):Int;
    public var g(get, never):Int;
    public var b(get, never):Int;

    inline function get_a():Int return (this >>> 24) & 0xFF;
    inline function get_r():Int return (this >>> 16) & 0xFF;
    inline function get_g():Int return (this >>>  8) & 0xFF;
    inline function get_b():Int return  this        & 0xFF;

    // Representación útil para debug
    @:to
    inline public function toString():String {
        return 'Color($r, $g, $b, $a)';
    }

    // Algunos colores predefinidos (opcional pero muy práctico)
    public static var BLACK   :Color = 0xFF000000;
    public static var WHITE   :Color = 0xFFFFFFFF;
    public static var RED     :Color = 0xFFFF0000;
    public static var GREEN   :Color = 0xFF00FF00;
    public static var BLUE    :Color = 0xFF0000FF;
    public static var YELLOW  :Color = 0xFFFFFF00;
    public static var CYAN    :Color = 0xFF00FFFF;
    public static var MAGENTA :Color = 0xFFFF00FF;
    public static var TRANSPARENT :Color = 0x00000000;
}