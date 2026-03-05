#include "tuna/cffi/CFFI.hpp"
#include <AL/alc.h>

namespace tuna
{
    DEFINE_KIND(k_ALCdevice);
    DEFINE_KIND(k_ALCcontext);
    DEFINE_KIND(k_ALuint);

    value alc_open_device(value name)
    {
        const char *devName = val_is_null(name) ? nullptr : val_string(name);
        ALCdevice *dev = alcOpenDevice(devName);
        printf("[AL] alcOpenDevice ptr: %p\n", dev);
        if (!dev)
            return alloc_null();
        value result = alloc_abstract(k_ALCdevice, dev);
        printf("[AL] abstract value: %p\n", result);
        return result;
    }

    value alc_create_context(value device, value attrs)
    {
        printf("[AL] device value recibido: %p\n", device);
        printf("[AL] val_is_null: %d\n", val_is_null(device));
        printf("[AL] val_is_kind: %d\n", val_is_kind(device, k_ALCdevice));
        ALCdevice *dev = (ALCdevice *)val_data(device);
        printf("[AL] dev ptr extraído: %p\n", dev);
        ALCcontext *ctx = alcCreateContext(dev, nullptr);
        printf("[AL] ctx ptr: %p\n", ctx);
        if (!ctx)
            return alloc_null();
        return alloc_abstract(k_ALCcontext, ctx);
    }
    
    value alc_make_context_current(value context)
    {
        ALCcontext *ctx = val_is_null(context) ? nullptr
                                               : (ALCcontext *)val_data(context);
        return alloc_bool(alcMakeContextCurrent(ctx));
    }

    void alc_destroy_context(value context)
    {
        alcDestroyContext((ALCcontext *)val_data(context));
    }

    value alc_close_device(value device)
    {
        return alloc_bool(alcCloseDevice((ALCdevice *)val_data(device)));
    }

    value alc_get_error(value device)
    {
        return alloc_int(alcGetError((ALCdevice *)device));
    }

    value alc_get_string(value device, value param)
    {
        return alloc_string(alcGetString((ALCdevice *)device, val_int(param)));
    }

    DEFINE_PRIM(alc_open_device, 1);
    DEFINE_PRIM(alc_close_device, 1);
    DEFINE_PRIM(alc_create_context, 2);
    DEFINE_PRIM(alc_make_context_current, 1);
    DEFINE_PRIM(alc_get_error, 1);
    DEFINE_PRIM(alc_get_string, 2);
    DEFINE_PRIM(alc_destroy_context, 1);
}