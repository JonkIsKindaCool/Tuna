package tuna.backend.audio.openal;

import tuna.backend.cffi.NativeOpenALCFFI;
import haxe.io.Bytes;

class AL {
	public static inline final NONE = 0;
	public static inline final FALSE = 0;
	public static inline final TRUE = 1;
	public static inline final SOURCE_RELATIVE = 0x202;
	public static inline final CONE_INNER_ANGLE = 0x1001;
	public static inline final CONE_OUTER_ANGLE = 0x1002;
	public static inline final PITCH = 0x1003;
	public static inline final POSITION = 0x1004;
	public static inline final DIRECTION = 0x1005;
	public static inline final VELOCITY = 0x1006;
	public static inline final LOOPING = 0x1007;
	public static inline final BUFFER = 0x1009;
	public static inline final GAIN = 0x100A;
	public static inline final MIN_GAIN = 0x100D;
	public static inline final MAX_GAIN = 0x100E;
	public static inline final ORIENTATION = 0x100F;
	public static inline final SOURCE_STATE = 0x1010;
	public static inline final INITIAL = 0x1011;
	public static inline final PLAYING = 0x1012;
	public static inline final PAUSED = 0x1013;
	public static inline final STOPPED = 0x1014;
	public static inline final BUFFERS_QUEUED = 0x1015;
	public static inline final BUFFERS_PROCESSED = 0x1016;
	public static inline final REFERENCE_DISTANCE = 0x1020;
	public static inline final ROLLOFF_FACTOR = 0x1021;
	public static inline final CONE_OUTER_GAIN = 0x1022;
	public static inline final MAX_DISTANCE = 0x1023;
	public static inline final SEC_OFFSET = 0x1024;
	public static inline final SAMPLE_OFFSET = 0x1025;
	public static inline final BYTE_OFFSET = 0x1026;
	public static inline final SOURCE_TYPE = 0x1027;
	public static inline final STATIC = 0x1028;
	public static inline final STREAMING = 0x1029;
	public static inline final UNDETERMINED = 0x1030;
	public static inline final FORMAT_MONO8 = 0x1100;
	public static inline final FORMAT_MONO16 = 0x1101;
	public static inline final FORMAT_STEREO8 = 0x1102;
	public static inline final FORMAT_STEREO16 = 0x1103;
	public static inline final FREQUENCY = 0x2001;
	public static inline final BITS = 0x2002;
	public static inline final CHANNELS = 0x2003;
	public static inline final SIZE = 0x2004;
	public static inline final NO_ERROR = 0;
	public static inline final INVALID_NAME = 0xA001;
	public static inline final INVALID_ENUM = 0xA002;
	public static inline final INVALID_VALUE = 0xA003;
	public static inline final INVALID_OPERATION = 0xA004;
	public static inline final OUT_OF_MEMORY = 0xA005;
	public static inline final VENDOR = 0xB001;
	public static inline final VERSION = 0xB002;
	public static inline final RENDERER = 0xB003;
	public static inline final EXTENSIONS = 0xB004;
	public static inline final DOPPLER_FACTOR = 0xC000;
	public static inline final DOPPLER_VELOCITY = 0xC001;
	public static inline final SPEED_OF_SOUND = 0xC003;
	public static inline final DISTANCE_MODEL = 0xD000;
	public static inline final INVERSE_DISTANCE = 0xD001;
	public static inline final INVERSE_DISTANCE_CLAMPED = 0xD002;
	public static inline final LINEAR_DISTANCE = 0xD003;
	public static inline final LINEAR_DISTANCE_CLAMPED = 0xD004;
	public static inline final EXPONENT_DISTANCE = 0xD005;
	public static inline final EXPONENT_DISTANCE_CLAMPED = 0xD006;

	public static inline function getError():Int
		return NativeOpenALCFFI.al_getError();

	public static inline function enable(capability:Int):Void
		NativeOpenALCFFI.al_enable(capability);

	public static inline function disable(capability:Int):Void
		NativeOpenALCFFI.al_disable(capability);

	public static inline function isEnabled(capability:Int):Bool
		return NativeOpenALCFFI.al_isEnabled(capability);

	public static inline function dopplerFactor(value:Float):Void
		NativeOpenALCFFI.al_dopplerFactor(value);

	public static inline function dopplerVelocity(value:Float):Void
		NativeOpenALCFFI.al_dopplerVelocity(value);

	public static inline function speedOfSound(value:Float):Void
		NativeOpenALCFFI.al_speedOfSound(value);

	public static inline function distanceModel(model:Int):Void
		NativeOpenALCFFI.al_distanceModel(model);

	public static inline function getString(param:Int):String
		return NativeOpenALCFFI.al_getString(param);

	public static inline function getBoolean(param:Int):Bool
		return NativeOpenALCFFI.al_getBoolean(param);

	public static inline function getInteger(param:Int):Int
		return NativeOpenALCFFI.al_getInteger(param);

	public static inline function getFloat(param:Int):Float
		return NativeOpenALCFFI.al_getFloat(param);

	public static inline function getDouble(param:Int):Float
		return NativeOpenALCFFI.al_getDouble(param);

	public static inline function getBooleanv(param:Int):Bool
		return NativeOpenALCFFI.al_getBooleanv(param);

	public static inline function getIntegerv(param:Int):Int
		return NativeOpenALCFFI.al_getIntegerv(param);

	public static inline function getFloatv(param:Int):Float
		return NativeOpenALCFFI.al_getFloatv(param);

	public static inline function getDoublev(param:Int):Float
		return NativeOpenALCFFI.al_getDoublev(param);

	public static inline function isExtensionPresent(ext:String):Bool
		return NativeOpenALCFFI.al_isExtensionPresent(ext);

	public static inline function getProcAddress(func:String):Dynamic
		return NativeOpenALCFFI.al_getProcAddress(func);

	public static inline function getEnumValue(name:String):Int
		return NativeOpenALCFFI.al_getEnumValue(name);

	public static inline function listenerf(param:Int, value:Float):Void
		NativeOpenALCFFI.al_listenerf(param, value);

	public static inline function listener3f(param:Int, v1:Float, v2:Float, v3:Float):Void
		NativeOpenALCFFI.al_listener3f(param, v1, v2, v3);

	public static inline function listenerfv(param:Int, values:Array<Float>):Void
		NativeOpenALCFFI.al_listenerfv(param, values);

	public static inline function listeneri(param:Int, value:Int):Void
		NativeOpenALCFFI.al_listeneri(param, value);

	public static inline function listener3i(param:Int, v1:Int, v2:Int, v3:Int):Void
		NativeOpenALCFFI.al_listener3i(param, v1, v2, v3);

	public static inline function listeneriv(param:Int, values:Array<Int>):Void
		NativeOpenALCFFI.al_listeneriv(param, values);

	public static inline function getListenerf(param:Int):Float
		return NativeOpenALCFFI.al_getListenerf(param);

	public static inline function getListener3f(param:Int):Array<Float>
		return NativeOpenALCFFI.al_getListener3f(param);

	public static inline function getListenerfv(param:Int, size:Int):Array<Float>
		return NativeOpenALCFFI.al_getListenerfv(param, size);

	public static inline function getListeneri(param:Int):Int
		return NativeOpenALCFFI.al_getListeneri(param);

	public static inline function getListener3i(param:Int):Array<Int>
		return NativeOpenALCFFI.al_getListener3i(param);

	public static inline function getListeneriv(param:Int, size:Int):Array<Int>
		return NativeOpenALCFFI.al_getListeneriv(param, size);

	public static inline function genSource():Int
		return NativeOpenALCFFI.al_genSource();

	public static inline function genSources(n:Int):Array<Int> {
		var arr:Array<Int> = [];
		for (i in 0...n)
			arr.push(genSource());

		return arr;
	}

	public static inline function deleteSource(n:Int):Void
		NativeOpenALCFFI.al_deleteSource(n);

	public static inline function deleteSources(arr:Array<Int>):Void{
		for (v in arr)
			deleteSource(v);
	}

	public static inline function isSource(source:Int):Bool
		return NativeOpenALCFFI.al_isSource(source);

	public static inline function sourcef(source:Int, param:Int, value:Float):Void
		NativeOpenALCFFI.al_sourcef(source, param, value);

	public static inline function source3f(source:Int, param:Int, v1:Float, v2:Float, v3:Float):Void
		NativeOpenALCFFI.al_source3f(source, param, v1, v2, v3);

	public static inline function sourcefv(source:Int, param:Int, values:Array<Float>):Void
		NativeOpenALCFFI.al_sourcefv(source, param, values);

	public static inline function sourcei(source:Int, param:Int, value:Int):Void
		NativeOpenALCFFI.al_sourcei(source, param, value);

	public static inline function source3i(source:Int, param:Int, v1:Int, v2:Int, v3:Int):Void
		NativeOpenALCFFI.al_source3i(source, param, v1, v2, v3);

	public static inline function sourceiv(source:Int, param:Int, values:Array<Int>):Void
		NativeOpenALCFFI.al_sourceiv(source, param, values);

	public static inline function getSourcef(source:Int, param:Int):Float
		return NativeOpenALCFFI.al_getSourcef(source, param);

	public static inline function getSource3f(source:Int, param:Int):Array<Float>
		return NativeOpenALCFFI.al_getSource3f(source, param);

	public static inline function getSourcefv(source:Int, param:Int, size:Int):Array<Float>
		return NativeOpenALCFFI.al_getSourcefv(source, param, size);

	public static inline function getSourcei(source:Int, param:Int):Int
		return NativeOpenALCFFI.al_getSourcei(source, param);

	public static inline function getSource3i(source:Int, param:Int):Array<Int>
		return NativeOpenALCFFI.al_getSource3i(source, param);

	public static inline function getSourceiv(source:Int, param:Int, size:Int):Array<Int>
		return NativeOpenALCFFI.al_getSourceiv(source, param, size);

	public static inline function sourcePlay(source:Int):Void
		NativeOpenALCFFI.al_sourcePlay(source);

	public static inline function sourceStop(source:Int):Void
		NativeOpenALCFFI.al_sourceStop(source);

	public static inline function sourceRewind(source:Int):Void
		NativeOpenALCFFI.al_sourceRewind(source);

	public static inline function sourcePause(source:Int):Void
		NativeOpenALCFFI.al_sourcePause(source);

	public static inline function sourcePlayv(n:Int, sources:Array<Int>):Void
		NativeOpenALCFFI.al_sourcePlayv(n, sources);

	public static inline function sourceStopv(n:Int, sources:Array<Int>):Void
		NativeOpenALCFFI.al_sourceStopv(n, sources);

	public static inline function sourceRewindv(n:Int, sources:Array<Int>):Void
		NativeOpenALCFFI.al_sourceRewindv(n, sources);

	public static inline function sourcePausev(n:Int, sources:Array<Int>):Void
		NativeOpenALCFFI.al_sourcePausev(n, sources);

	public static inline function sourceQueueBuffers(source:Int, nb:Int, buffers:Array<Int>):Void
		NativeOpenALCFFI.al_sourceQueueBuffers(source, nb, buffers);

	public static inline function sourceUnqueueBuffers(source:Int, nb:Int, buffers:Array<Int>):Void
		NativeOpenALCFFI.al_sourceUnqueueBuffers(source, nb, buffers);

	public static inline function genBuffer():Int
		return NativeOpenALCFFI.al_genBuffer();

	public static inline function genBuffers(n:Int):Array<Int> {
		var arr:Array<Int> = [];
		for (i in 0...n)
			arr.push(genBuffer());

		return arr;
	}

	public static inline function deleteBuffer(n:Int):Void
		NativeOpenALCFFI.al_deleteBuffer(n);

	public static inline function deleteBuffers(arr:Array<Int>):Void{
		for (v in arr)
			deleteBuffer(v);
	}

	public static inline function isBuffer(buffer:Int):Bool
		return NativeOpenALCFFI.al_isBuffer(buffer);

	public static inline function bufferData(buffer:Int, format:Int, data:Bytes, size:Int, sampleRate:Int):Void {
		NativeOpenALCFFI.al_bufferData(buffer, format, data.getData(), size, sampleRate);
	}

	public static inline function bufferf(buffer:Int, param:Int, value:Float):Void
		NativeOpenALCFFI.al_bufferf(buffer, param, value);

	public static inline function buffer3f(buffer:Int, param:Int, v1:Float, v2:Float, v3:Float):Void
		NativeOpenALCFFI.al_buffer3f(buffer, param, v1, v2, v3);

	public static inline function bufferfv(buffer:Int, param:Int, values:Array<Float>):Void
		NativeOpenALCFFI.al_bufferfv(buffer, param, values);

	public static inline function bufferi(buffer:Int, param:Int, value:Int):Void
		NativeOpenALCFFI.al_bufferi(buffer, param, value);

	public static inline function buffer3i(buffer:Int, param:Int, v1:Int, v2:Int, v3:Int):Void
		NativeOpenALCFFI.al_buffer3i(buffer, param, v1, v2, v3);

	public static inline function bufferiv(buffer:Int, param:Int, values:Array<Int>):Void
		NativeOpenALCFFI.al_bufferiv(buffer, param, values);

	public static inline function getBufferf(buffer:Int, param:Int):Float
		return NativeOpenALCFFI.al_getBufferf(buffer, param);

	public static inline function getBuffer3f(buffer:Int, param:Int):Array<Float>
		return NativeOpenALCFFI.al_getBuffer3f(buffer, param);

	public static inline function getBufferfv(buffer:Int, param:Int, size:Int):Array<Float>
		return NativeOpenALCFFI.al_getBufferfv(buffer, param, size);

	public static inline function getBufferi(buffer:Int, param:Int):Int
		return NativeOpenALCFFI.al_getBufferi(buffer, param);

	public static inline function getBuffer3i(buffer:Int, param:Int):Array<Int>
		return NativeOpenALCFFI.al_getBuffer3i(buffer, param);

	public static inline function getBufferiv(buffer:Int, param:Int, size:Int):Array<Int>
		return NativeOpenALCFFI.al_getBufferiv(buffer, param, size);
}
