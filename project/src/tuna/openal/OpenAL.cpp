#include <vector>
#include "tuna/cffi/CFFI.hpp"
#include "AL/al.h"

namespace tuna
{
    value al_getError() { return alloc_int(alGetError()); }
    void al_enable(int capability) { alEnable(capability); }
    void al_disable(int capability) { alDisable(capability); }
    value al_isEnabled(int capability) { return alloc_bool(alIsEnabled(capability)); }
    void al_dopplerFactor(float value) { alDopplerFactor(value); }
    void al_dopplerVelocity(float value) { alDopplerVelocity(value); }
    void al_speedOfSound(float value) { alSpeedOfSound(value); }
    void al_distanceModel(int distanceModel) { alDistanceModel(distanceModel); }

    value al_getString(int parameter) { return alloc_string(alGetString(parameter)); }

    value al_getBooleanv(int parameter)
    {
        ALboolean v = false;
        alGetBooleanv(parameter, &v);
        return alloc_bool(v);
    }

    value al_getIntegerv(int parameter)
    {
        int v = 0;
        alGetIntegerv(parameter, &v);
        return alloc_int(v);
    }

    value al_getFloatv(int parameter)
    {
        float v = 0;
        alGetFloatv(parameter, &v);
        return alloc_float(v);
    }

    value al_getDoublev(int parameter)
    {
        double v = 0;
        alGetDoublev(parameter, &v);
        return alloc_float(v);
    }

    value al_getBoolean(int parameter) { return alloc_bool(alGetBoolean(parameter)); }
    value al_getInteger(int parameter) { return alloc_int(alGetInteger(parameter)); }
    value al_getFloat(int parameter) { return alloc_float(alGetFloat(parameter)); }
    value al_getDouble(int parameter) { return alloc_float(alGetDouble(parameter)); }
    value al_isExtensionPresent(value extension) { return alloc_bool(alIsExtensionPresent(val_string(extension))); }
    value al_getProcAddress(value func) { return alloc_null(); }
    value al_getEnumValue(value enumName) { return alloc_int(alGetEnumValue(val_string(enumName))); }

    void al_listenerf(int parameter, float value) { alListenerf(parameter, value); }
    void al_listener3f(int parameter, float v1, float v2, float v3) { alListener3f(parameter, v1, v2, v3); }

    void al_listenerfv(int parameter, value values)
    {
        alListenerfv(parameter, (const ALfloat *)val_array_float(values));
    }

    void al_listeneri(int parameter, int value) { alListeneri(parameter, value); }
    void al_listener3i(int parameter, int v1, int v2, int v3) { alListener3i(parameter, v1, v2, v3); }

    void al_listeneriv(int parameter, value values)
    {
        alListeneriv(parameter, (const ALint *)val_array_int(values));
    }

    value al_getListenerf(int parameter)
    {
        float v = 0;
        alGetListenerf(parameter, &v);
        return alloc_float(v);
    }

    value al_getListener3f(int parameter)
    {
        float v[3];
        alGetListenerfv(parameter, v);
        value arr = alloc_array(3);
        val_array_set_i(arr, 0, alloc_float(v[0]));
        val_array_set_i(arr, 1, alloc_float(v[1]));
        val_array_set_i(arr, 2, alloc_float(v[2]));
        return arr;
    }

    value al_getListenerfv(int parameter, int size)
    {
        std::vector<float> v(size);
        alGetListenerfv(parameter, v.data());
        value arr = alloc_array(size);
        for (int i = 0; i < size; i++)
            val_array_set_i(arr, i, alloc_float(v[i]));
        return arr;
    }

    value al_getListeneri(int parameter)
    {
        int v = 0;
        alGetListeneri(parameter, &v);
        return alloc_int(v);
    }

    value al_getListener3i(int parameter)
    {
        int v[3];
        alGetListeneriv(parameter, v);
        value arr = alloc_array(3);
        val_array_set_i(arr, 0, alloc_int(v[0]));
        val_array_set_i(arr, 1, alloc_int(v[1]));
        val_array_set_i(arr, 2, alloc_int(v[2]));
        return arr;
    }

    value al_getListeneriv(int parameter, int size)
    {
        std::vector<int> v(size);
        alGetListeneriv(parameter, v.data());
        value arr = alloc_array(size);
        for (int i = 0; i < size; i++)
            val_array_set_i(arr, i, alloc_int(v[i]));
        return arr;
    }

    value al_genSource()
    {
        ALuint n = 0;
        alGenSources(1, &n);
        return alloc_int(n);
    }

    void al_deleteSource(ALuint n)
    {
        alDeleteSources(1, &n);
    }

    value al_isSource(unsigned int source) { return alloc_bool(alIsSource(source)); }
    void al_sourcef(unsigned int source, int parameter, float value) { alSourcef(source, parameter, value); }
    void al_source3f(unsigned int source, int parameter, float v1, float v2, float v3) { alSource3f(source, parameter, v1, v2, v3); }

    void al_sourcefv(unsigned int source, int parameter, value values)
    {
        alSourcefv(source, parameter, (const ALfloat *)val_array_float(values));
    }

    void al_sourcei(unsigned int source, int parameter, int value) { alSourcei(source, parameter, value); }
    void al_source3i(unsigned int source, int parameter, int v1, int v2, int v3) { alSource3i(source, parameter, v1, v2, v3); }

    void al_sourceiv(unsigned int source, int parameter, value values)
    {
        alSourceiv(source, parameter, (const ALint *)val_array_int(values));
    }

    value al_getSourcef(unsigned int source, int parameter)
    {
        float v = 0;
        alGetSourcef(source, parameter, &v);
        return alloc_float(v);
    }

    value al_getSource3f(unsigned int source, int parameter)
    {
        float v[3];
        alGetSource3f(source, parameter, &v[0], &v[1], &v[2]);
        value arr = alloc_array(3);
        val_array_set_i(arr, 0, alloc_float(v[0]));
        val_array_set_i(arr, 1, alloc_float(v[1]));
        val_array_set_i(arr, 2, alloc_float(v[2]));
        return arr;
    }

    value al_getSourcefv(unsigned int source, int parameter, int size)
    {
        std::vector<float> v(size);
        alGetSourcefv(source, parameter, v.data());
        value arr = alloc_array(size);
        for (int i = 0; i < size; i++)
            val_array_set_i(arr, i, alloc_float(v[i]));
        return arr;
    }

    value al_getSourcei(unsigned int source, int parameter)
    {
        int v = 0;
        alGetSourcei(source, parameter, &v);
        return alloc_int(v);
    }

    value al_getSource3i(unsigned int source, int parameter)
    {
        int v[3];
        alGetSource3i(source, parameter, &v[0], &v[1], &v[2]);
        value arr = alloc_array(3);
        val_array_set_i(arr, 0, alloc_int(v[0]));
        val_array_set_i(arr, 1, alloc_int(v[1]));
        val_array_set_i(arr, 2, alloc_int(v[2]));
        return arr;
    }

    value al_getSourceiv(unsigned int source, int parameter, int size)
    {
        std::vector<int> v(size);
        alGetSourceiv(source, parameter, v.data());
        value arr = alloc_array(size);
        for (int i = 0; i < size; i++)
            val_array_set_i(arr, i, alloc_int(v[i]));
        return arr;
    }

    void al_sourcePlay(unsigned int source) { alSourcePlay(source); }
    void al_sourceStop(unsigned int source) { alSourceStop(source); }
    void al_sourceRewind(unsigned int source) { alSourceRewind(source); }
    void al_sourcePause(unsigned int source) { alSourcePause(source); }

    void al_sourcePlayv(int n, value sources)
    {
        alSourcePlayv(n, (const ALuint *)val_array_int(sources));
    }
    void al_sourceStopv(int n, value sources)
    {
        alSourceStopv(n, (const ALuint *)val_array_int(sources));
    }
    void al_sourceRewindv(int n, value sources)
    {
        alSourceRewindv(n, (const ALuint *)val_array_int(sources));
    }
    void al_sourcePausev(int n, value sources)
    {
        alSourcePausev(n, (const ALuint *)val_array_int(sources));
    }

    void al_sourceQueueBuffers(unsigned int source, int nb, value buffers)
    {
        alSourceQueueBuffers(source, nb, (const ALuint *)val_array_int(buffers));
    }

    void al_sourceUnqueueBuffers(unsigned int source, int nb, value buffers)
    {
        alSourceUnqueueBuffers(source, nb, (ALuint *)val_array_int(buffers));
    }

    value al_genBuffer()
    {
        ALuint n = 0;
        alGenBuffers(1, &n);
        return alloc_int(n);
    }

    void al_deleteBuffer(ALuint n)
    {
        alDeleteBuffers(1, &n);
    }

    value al_isBuffer(unsigned int buffer) { return alloc_bool(alIsBuffer(buffer)); }

    void al_bufferData(unsigned int buffer, int format, value data, int size, int sampleRate)
    {
        int len = val_array_size(data);

        std::vector<char> native(size);
        memcpy(native.data(), val_array_int(data), size);

        alBufferData(buffer, format, native.data(), size, sampleRate);
    }

    void al_bufferf(unsigned int buffer, int parameter, float value) { alBufferf(buffer, parameter, value); }
    void al_buffer3f(unsigned int buffer, int parameter, float v1, float v2, float v3) { alBuffer3f(buffer, parameter, v1, v2, v3); }

    void al_bufferfv(unsigned int buffer, int parameter, value values)
    {
        alBufferfv(buffer, parameter, (const ALfloat *)val_array_float(values));
    }

    void al_bufferi(unsigned int buffer, int parameter, int value) { alBufferi(buffer, parameter, value); }
    void al_buffer3i(unsigned int buffer, int parameter, int v1, int v2, int v3) { alBuffer3i(buffer, parameter, v1, v2, v3); }

    void al_bufferiv(unsigned int buffer, int parameter, value values)
    {
        alBufferiv(buffer, parameter, (const ALint *)val_array_int(values));
    }

    value al_getBufferf(unsigned int buffer, int parameter)
    {
        float v = 0;
        alGetBufferf(buffer, parameter, &v);
        return alloc_float(v);
    }

    value al_getBuffer3f(unsigned int buffer, int parameter)
    {
        float v[3];
        alGetBuffer3f(buffer, parameter, &v[0], &v[1], &v[2]);
        value arr = alloc_array(3);
        val_array_set_i(arr, 0, alloc_float(v[0]));
        val_array_set_i(arr, 1, alloc_float(v[1]));
        val_array_set_i(arr, 2, alloc_float(v[2]));
        return arr;
    }

    value al_getBufferfv(unsigned int buffer, int parameter, int size)
    {
        std::vector<float> v(size);
        alGetBufferfv(buffer, parameter, v.data());
        value arr = alloc_array(size);
        for (int i = 0; i < size; i++)
            val_array_set_i(arr, i, alloc_float(v[i]));
        return arr;
    }

    value al_getBufferi(unsigned int buffer, int parameter)
    {
        int v = 0;
        alGetBufferi(buffer, parameter, &v);
        return alloc_int(v);
    }

    value al_getBuffer3i(unsigned int buffer, int parameter)
    {
        int v[3];
        alGetBuffer3i(buffer, parameter, &v[0], &v[1], &v[2]);
        value arr = alloc_array(3);
        val_array_set_i(arr, 0, alloc_int(v[0]));
        val_array_set_i(arr, 1, alloc_int(v[1]));
        val_array_set_i(arr, 2, alloc_int(v[2]));
        return arr;
    }

    value al_getBufferiv(unsigned int buffer, int parameter, int size)
    {
        std::vector<int> v(size);
        alGetBufferiv(buffer, parameter, v.data());
        value arr = alloc_array(size);
        for (int i = 0; i < size; i++)
            val_array_set_i(arr, i, alloc_int(v[i]));
        return arr;
    }

    DEFINE_PRIM(al_getError, 0);
    DEFINE_PRIM(al_enable, 1);
    DEFINE_PRIM(al_disable, 1);
    DEFINE_PRIM(al_isEnabled, 1);
    DEFINE_PRIM(al_dopplerFactor, 1);
    DEFINE_PRIM(al_dopplerVelocity, 1);
    DEFINE_PRIM(al_speedOfSound, 1);
    DEFINE_PRIM(al_distanceModel, 1);
    DEFINE_PRIM(al_getString, 1);
    DEFINE_PRIM(al_getBooleanv, 1);
    DEFINE_PRIM(al_getIntegerv, 1);
    DEFINE_PRIM(al_getFloatv, 1);
    DEFINE_PRIM(al_getDoublev, 1);
    DEFINE_PRIM(al_getBoolean, 1);
    DEFINE_PRIM(al_getInteger, 1);
    DEFINE_PRIM(al_getFloat, 1);
    DEFINE_PRIM(al_getDouble, 1);
    DEFINE_PRIM(al_isExtensionPresent, 1);
    DEFINE_PRIM(al_getProcAddress, 1);
    DEFINE_PRIM(al_getEnumValue, 1);
    DEFINE_PRIM(al_listenerf, 2);
    DEFINE_PRIM(al_listener3f, 4);
    DEFINE_PRIM(al_listenerfv, 2);
    DEFINE_PRIM(al_listeneri, 2);
    DEFINE_PRIM(al_listener3i, 4);
    DEFINE_PRIM(al_listeneriv, 2);
    DEFINE_PRIM(al_getListenerf, 1);
    DEFINE_PRIM(al_getListener3f, 1);
    DEFINE_PRIM(al_getListenerfv, 2);
    DEFINE_PRIM(al_getListeneri, 1);
    DEFINE_PRIM(al_getListener3i, 1);
    DEFINE_PRIM(al_getListeneriv, 2);
    DEFINE_PRIM(al_genSource, 0);
    DEFINE_PRIM(al_deleteSource, 1);
    DEFINE_PRIM(al_isSource, 1);
    DEFINE_PRIM(al_sourcef, 3);
    DEFINE_PRIM(al_source3f, 5);
    DEFINE_PRIM(al_sourcefv, 3);
    DEFINE_PRIM(al_sourcei, 3);
    DEFINE_PRIM(al_source3i, 5);
    DEFINE_PRIM(al_sourceiv, 3);
    DEFINE_PRIM(al_getSourcef, 2);
    DEFINE_PRIM(al_getSource3f, 2);
    DEFINE_PRIM(al_getSourcefv, 3);
    DEFINE_PRIM(al_getSourcei, 2);
    DEFINE_PRIM(al_getSource3i, 2);
    DEFINE_PRIM(al_getSourceiv, 3);
    DEFINE_PRIM(al_sourcePlay, 1);
    DEFINE_PRIM(al_sourceStop, 1);
    DEFINE_PRIM(al_sourceRewind, 1);
    DEFINE_PRIM(al_sourcePause, 1);
    DEFINE_PRIM(al_sourcePlayv, 2);
    DEFINE_PRIM(al_sourceStopv, 2);
    DEFINE_PRIM(al_sourceRewindv, 2);
    DEFINE_PRIM(al_sourcePausev, 2);
    DEFINE_PRIM(al_sourceQueueBuffers, 3);
    DEFINE_PRIM(al_sourceUnqueueBuffers, 3);
    DEFINE_PRIM(al_genBuffer, 0);
    DEFINE_PRIM(al_deleteBuffer, 1);
    DEFINE_PRIM(al_isBuffer, 1);
    DEFINE_PRIM(al_bufferData, 5);
    DEFINE_PRIM(al_bufferf, 3);
    DEFINE_PRIM(al_buffer3f, 5);
    DEFINE_PRIM(al_bufferfv, 3);
    DEFINE_PRIM(al_bufferi, 3);
    DEFINE_PRIM(al_buffer3i, 5);
    DEFINE_PRIM(al_bufferiv, 3);
    DEFINE_PRIM(al_getBufferf, 2);
    DEFINE_PRIM(al_getBuffer3f, 2);
    DEFINE_PRIM(al_getBufferfv, 3);
    DEFINE_PRIM(al_getBufferi, 2);
    DEFINE_PRIM(al_getBuffer3i, 2);
    DEFINE_PRIM(al_getBufferiv, 3);
}