package cpp;

import cpp.RawConstPointer;
import cpp.RawPointer;
import cpp.UInt64;

typedef CArray<T> = RawPointer<T>;

typedef CConstArray<T> = RawConstPointer<T>;

@:include("stdio.h")
extern class Helpers {
    static inline function lengthOfArray<T>(array:CArray<T>):Int {
        return untyped __cpp__("(int)(sizeof({0}) / sizeof({0}[0]))", array);
    }

    static inline function malloc<T>(count:Int, starClass:Any):T {
        return cast untyped __cpp__("malloc({0} * sizeof({1}))", count, starClass);
    }

    static inline function sizeof(a:Any):Int {
        return untyped __cpp__("(int)sizeof({0})", a);
    }

    static inline function lengthOfConstArray<T>(array:CConstArray<T>):Int {
        return untyped __cpp__("(int)(sizeof({0}) / sizeof({0}[0]))", array);
    }

    static inline function free(ptr:Any) {
        return untyped __cpp__("free({0})", ptr);
    }

    static inline function nativeTrace(toTrace:ConstCharStar, formatParams:cpp.Rest<Any>):Void {
        return untyped __cpp__("printf({0}, {1})", toTrace, formatParams);
    }

    static inline function tempPointer<T>(value:Any):T {
        return untyped __cpp__("&{0}", value);
    }

    static inline function arrayToVoid<T>(arr:Array<T>):RawPointer<cpp.Void> {
        var pointer:Pointer<T> = Pointer.ofArray(arr);
        var star:RawPointer<cpp.Void> = untyped __cpp__("(void *) {0}", pointer);

        return star;
    }
}