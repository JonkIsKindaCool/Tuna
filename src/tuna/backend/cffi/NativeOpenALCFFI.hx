package tuna.backend.cffi;

@:build(tuna.backend.macro.CFFIMacro.build("tuna"))
class NativeOpenAL {
    public static function al_getError():Int;
    public static function al_enable(capability:Int):Void;
    public static function al_disable(capability:Int):Void;
    public static function al_isEnabled(capability:Int):Bool;
    public static function al_dopplerFactor(value:Float):Void;
    public static function al_dopplerVelocity(value:Float):Void;
    public static function al_speedOfSound(value:Float):Void;
    public static function al_distanceModel(distanceModel:Int):Void;

    public static function al_getString(parameter:Int):String;
    public static function al_getBooleanv(parameter:Int):Bool;
    public static function al_getIntegerv(parameter:Int):Int;
    public static function al_getFloatv(parameter:Int):Float;
    public static function al_getDoublev(parameter:Int):Float;
    public static function al_getBoolean(parameter:Int):Bool;
    public static function al_getInteger(parameter:Int):Int;
    public static function al_getFloat(parameter:Int):Float;
    public static function al_getDouble(parameter:Int):Float;
    public static function al_isExtensionPresent(extension:String):Bool;
    public static function al_getProcAddress(func:String):Dynamic;
    public static function al_getEnumValue(enumName:String):Int;

    public static function al_listenerf(parameter:Int, value:Float):Void;
    public static function al_listener3f(parameter:Int, v1:Float, v2:Float, v3:Float):Void;
    public static function al_listenerfv(parameter:Int, values:Array<Float>):Void;
    public static function al_listeneri(parameter:Int, value:Int):Void;
    public static function al_listener3i(parameter:Int, v1:Int, v2:Int, v3:Int):Void;
    public static function al_listeneriv(parameter:Int, values:Array<Int>):Void;

    public static function al_getListenerf(parameter:Int):Float;
    public static function al_getListener3f(parameter:Int):Array<Float>;
    public static function al_getListenerfv(parameter:Int, size:Int):Array<Float>;
    public static function al_getListeneri(parameter:Int):Int;
    public static function al_getListener3i(parameter:Int):Array<Int>;
    public static function al_getListeneriv(parameter:Int, size:Int):Array<Int>;

    public static function al_genSources(n:Int):Array<Int>;
    public static function al_deleteSources(n:Int, sources:Array<Int>):Void;
    public static function al_isSource(source:Int):Bool;
    public static function al_sourcef(source:Int, parameter:Int, value:Float):Void;
    public static function al_source3f(source:Int, parameter:Int, v1:Float, v2:Float, v3:Float):Void;
    public static function al_sourcefv(source:Int, parameter:Int, values:Array<Float>):Void;
    public static function al_sourcei(source:Int, parameter:Int, value:Int):Void;
    public static function al_source3i(source:Int, parameter:Int, v1:Int, v2:Int, v3:Int):Void;
    public static function al_sourceiv(source:Int, parameter:Int, values:Array<Int>):Void;

    public static function al_getSourcef(source:Int, parameter:Int):Float;
    public static function al_getSource3f(source:Int, parameter:Int):Array<Float>;
    public static function al_getSourcefv(source:Int, parameter:Int, size:Int):Array<Float>;
    public static function al_getSourcei(source:Int, parameter:Int):Int;
    public static function al_getSource3i(source:Int, parameter:Int):Array<Int>;
    public static function al_getSourceiv(source:Int, parameter:Int, size:Int):Array<Int>;

    public static function al_sourcePlay(source:Int):Void;
    public static function al_sourceStop(source:Int):Void;
    public static function al_sourceRewind(source:Int):Void;
    public static function al_sourcePause(source:Int):Void;
    public static function al_sourcePlayv(n:Int, sources:Array<Int>):Void;
    public static function al_sourceStopv(n:Int, sources:Array<Int>):Void;
    public static function al_sourceRewindv(n:Int, sources:Array<Int>):Void;
    public static function al_sourcePausev(n:Int, sources:Array<Int>):Void;
    public static function al_sourceQueueBuffers(source:Int, nb:Int, buffers:Array<Int>):Void;
    public static function al_sourceUnqueueBuffers(source:Int, nb:Int, buffers:Array<Int>):Void;

    public static function al_genBuffers(n:Int):Array<Int>;
    public static function al_deleteBuffers(n:Int, buffers:Array<Int>):Void;
    public static function al_isBuffer(buffer:Int):Bool;
    public static function al_bufferData(buffer:Int, format:Int, data:Array<Int>, size:Int, sampleRate:Int):Void;
    public static function al_bufferf(buffer:Int, parameter:Int, value:Float):Void;
    public static function al_buffer3f(buffer:Int, parameter:Int, v1:Float, v2:Float, v3:Float):Void;
    public static function al_bufferfv(buffer:Int, parameter:Int, values:Array<Float>):Void;
    public static function al_bufferi(buffer:Int, parameter:Int, value:Int):Void;
    public static function al_buffer3i(buffer:Int, parameter:Int, v1:Int, v2:Int, v3:Int):Void;
    public static function al_bufferiv(buffer:Int, parameter:Int, values:Array<Int>):Void;

    public static function al_getBufferf(buffer:Int, parameter:Int):Float;
    public static function al_getBuffer3f(buffer:Int, parameter:Int):Array<Float>;
    public static function al_getBufferfv(buffer:Int, parameter:Int, size:Int):Array<Float>;
    public static function al_getBufferi(buffer:Int, parameter:Int):Int;
    public static function al_getBuffer3i(buffer:Int, parameter:Int):Array<Int>;
    public static function al_getBufferiv(buffer:Int, parameter:Int, size:Int):Array<Int>;

    public static function alc_open_device(deviceName:String):Dynamic;
    public static function alc_close_device(device:Dynamic):Bool;
    public static function alc_create_context(device:Dynamic, attrList:Array<Int>):Dynamic;
    public static function alc_make_context_current(context:Dynamic):Bool;
    public static function alc_get_error(device:Dynamic):Int;
    public static function alc_get_string(device:Dynamic, parameter:Int):String;
    public static function alc_destroy_context(context:Dynamic):Void;
}