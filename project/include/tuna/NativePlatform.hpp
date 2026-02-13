#ifndef TUNA_NATIVE_PLATFORM_HPP
#define TUNA_NATIVE_PLATFORM_HPP
#include "tuna/cffi/CFFI.hpp"
#include "SDL3/SDL.h"

namespace tuna
{
    SDL_Event *event;

    void init();
    HL_PRIM void HL_NAME(hl_init)();

    void quit();
    HL_PRIM void HL_NAME(hl_quit)();

    bool hasEvent();
    HL_PRIM bool HL_NAME(hl_hasEvent)();

    int getEventType();
    HL_PRIM int HL_NAME(hl_getEventType)();
}

#endif