#include "tuna/NativePlatform.hpp"

namespace tuna
{
    void init()
    {
        SDL_Init(SDL_INIT_AUDIO | SDL_INIT_CAMERA | SDL_INIT_CAMERA | SDL_INIT_EVENTS | SDL_INIT_GAMEPAD | SDL_INIT_HAPTIC | SDL_INIT_JOYSTICK | SDL_INIT_SENSOR);
    }

    HL_PRIM void HL_NAME(hl_init)()
    {
        init();
    }

    void quit()
    {
        SDL_Quit();
    }
    HL_PRIM void HL_NAME(hl_quit)()
    {
        SDL_Quit();
    }

    bool hasEvent() {
        return SDL_PollEvent(event);
    }

    HL_PRIM bool HL_NAME(hl_hasEvent)()
    {
        return SDL_PollEvent(event);
    }

    int getEventType() {
        return event->type;
    }
    HL_PRIM int HL_NAME(hl_getEventType)() {
        return event->type;
    }

    DEFINE_PRIM(init, 0);
    DEFINE_PRIM(quit, 0);
    DEFINE_PRIM(hasEvent, 0);
    DEFINE_PRIM(getEventType, 0);

    DEFINE_HL_PRIM(_VOID, hl_init, _NO_ARG);
    DEFINE_HL_PRIM(_VOID, hl_quit, _NO_ARG);
    DEFINE_HL_PRIM(_BOOL, hl_hasEvent, _NO_ARG);
    DEFINE_HL_PRIM(_I32, hl_getEventType, _NO_ARG);
}