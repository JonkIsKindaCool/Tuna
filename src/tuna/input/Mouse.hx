package tuna.input;

import tuna.utils.Signal;

class Mouse {
    public static var moveSignal:Signal4<Float, Float, Float, Float> = new Signal4();
    public static var clickDownSignal:Signal<MouseCode> = new Signal();
    public static var clickUpSignal:Signal<MouseCode> = new Signal();
    public static var scrollSignal:Signal<Float> = new Signal();

    public static function onMove(x:Float, y:Float, delX:Float, delY:Float) {
        moveSignal.dispatch(x, y, delX, delY);
    }

    public static function onClickDown(type:MouseCode) {
        clickDownSignal.dispatch(type);
    }

    public static function onClickUp(type:MouseCode) {
        clickUpSignal.dispatch(type);
    }

    public static function onScroll(del:Float) {
        scrollSignal.dispatch(del);
    }
}