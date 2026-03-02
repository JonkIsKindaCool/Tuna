package tuna.backend.audio.openal;

import tuna.backend.cffi.NativeOpenALCFFI;

class ALC {
	public static inline final FREQUENCY = 0x1007;
	public static inline final REFRESH = 0x1008;
	public static inline final SYNC = 0x1009;
	public static inline final MONO_SOURCES = 0x1010;
	public static inline final STEREO_SOURCES = 0x1011;
	public static inline final NO_ERROR = 0;
	public static inline final INVALID_DEVICE = 0xA001;
	public static inline final INVALID_CONTEXT = 0xA002;
	public static inline final INVALID_ENUM = 0xA003;
	public static inline final INVALID_VALUE = 0xA004;
	public static inline final OUT_OF_MEMORY = 0xA005;
	public static inline final MAJOR_VERSION = 0x1000;
	public static inline final MINOR_VERSION = 0x1001;
	public static inline final ATTRIBUTES_SIZE = 0x1002;
	public static inline final ALL_ATTRIBUTES = 0x1003;
	public static inline final DEFAULT_DEVICE_SPECIFIER = 0x1004;
	public static inline final DEVICE_SPECIFIER = 0x1005;
	public static inline final EXTENSIONS = 0x1006;
	public static inline final DEFAULT_ALL_DEVICES_SPECIFIER = 0x1012;
	public static inline final ALL_DEVICES_SPECIFIER = 0x1013;

	public static inline function openDevice(deviceName:String):Dynamic
		return NativeOpenALCFFI.alc_open_device(deviceName);

	public static inline function closeDevice(device:Dynamic):Bool
		return NativeOpenALCFFI.alc_close_device(device);

	public static inline function createContext(device:Dynamic, attrList:Array<Int>):Dynamic
		return NativeOpenALCFFI.alc_create_context(device, attrList);

	public static inline function makeContextCurrent(context:Dynamic):Bool
		return NativeOpenALCFFI.alc_make_context_current(context);

	public static inline function getError(device:Dynamic):Int
		return NativeOpenALCFFI.alc_get_error(device);

	public static inline function getString(device:Dynamic, parameter:Int):String
		return NativeOpenALCFFI.alc_get_string(device, parameter);

	public static inline function destroyContext(context:Dynamic):Void
		NativeOpenALCFFI.alc_destroy_context(context);

	public static inline function defaultDeviceName():String
		return getString(null, DEFAULT_DEVICE_SPECIFIER);

	public static inline function allDevicesSpecifier():String
		return getString(null, ALL_DEVICES_SPECIFIER);
}
