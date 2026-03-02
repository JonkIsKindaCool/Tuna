#include "tuna/cffi/CFFI.hpp"
#include <AL/alc.h>

namespace tuna
{
    value alc_open_device(value deviceName)
    {
        const char *name = val_is_null(deviceName) ? NULL : val_string(deviceName);
        ALCdevice *device = alcOpenDevice(name);
        if (!device)
            return alloc_null();

        return (value)device;
    }

    value alc_close_device(value device)
    {
        return alloc_bool(alcCloseDevice((ALCdevice *)device));
    }

    value alc_create_context(value device, value attrList)
    {
        ALCcontext *context = alcCreateContext((ALCdevice *)device, NULL);
        return (value)context;
    }

    value alc_make_context_current(value context)
    {
        return alloc_bool(alcMakeContextCurrent((ALCcontext *)context));
    }

    value alc_get_error(value device)
    {
        return alloc_int(alcGetError((ALCdevice *)device));
    }

    value alc_get_string(value device, value param)
    {
        return alloc_string(alcGetString((ALCdevice *)device, val_int(param)));
    }

    void alc_destroy_context(value context)
    {
        alcDestroyContext((ALCcontext *)context);
    }

    DEFINE_PRIM(alc_open_device, 1);
    DEFINE_PRIM(alc_close_device, 1);
    DEFINE_PRIM(alc_create_context, 2);
    DEFINE_PRIM(alc_make_context_current, 1);
    DEFINE_PRIM(alc_get_error, 1);
    DEFINE_PRIM(alc_get_string, 2);
    DEFINE_PRIM(alc_destroy_context, 1);
}