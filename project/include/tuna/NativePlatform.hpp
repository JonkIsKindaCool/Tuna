#ifndef TUNA_NATIVE_PLATFORM_HPP
#define TUNA_NATIVE_PLATFORM_HPP
#include "tuna/cffi/CFFI.hpp"
#include "SDL3/SDL.h"

namespace tuna
{
    void init();

    void quit();

    void preLoop();

    value hasEvent();

    value getEventType();

    value getKeyboardState();

    value getMouseState();
}

#endif