#include "tuna/NativePlatform.hpp"
#include <stdio.h>

namespace tuna
{
    static int lastMouseX = 0;
    static int lastMouseY = 0;
    static int mouseDeltaX = 0;
    static int mouseDeltaY = 0;
    static int lastMouseButton = 0;
    static int lastMouseWheel = 0;

    static SDL_Event event;
    static bool sdl_initialized = false;

    static void updateMouseState()
    {
        float currentX, currentY;
        SDL_GetMouseState(&currentX, &currentY);

        mouseDeltaX = currentX - lastMouseX;
        mouseDeltaY = currentY - lastMouseY;

        lastMouseX = currentX;
        lastMouseY = currentY;
    }

    static void updateMouseEvents(SDL_Event *evt)
    {
        if (evt->type == SDL_EVENT_MOUSE_BUTTON_DOWN || evt->type == SDL_EVENT_MOUSE_BUTTON_UP)
        {
            lastMouseButton = evt->button.button;
        }
        if (evt->type == SDL_EVENT_MOUSE_WHEEL)
        {
            lastMouseWheel = evt->wheel.y;
        }
    }

    void init()
    {
        if (!SDL_Init(SDL_INIT_VIDEO | SDL_INIT_CAMERA | SDL_INIT_EVENTS | SDL_INIT_GAMEPAD | SDL_INIT_HAPTIC | SDL_INIT_JOYSTICK | SDL_INIT_SENSOR))
        {
            fprintf(stderr, "[C++] SDL_Init Error: %s\n", SDL_GetError());
            fflush(stderr);
            exit(0);
            return;
        }

        sdl_initialized = true;
    }

    void quit()
    {
        SDL_Quit();
        sdl_initialized = false;
    }

    void preLoop(){
        updateMouseState();
    } 

    value hasEvent()
    {
        if (!sdl_initialized)
        {
            return alloc_bool(false);
        }

        int result = SDL_PollEvent(&event);
        if (result != 0)
        {
            updateMouseEvents(&event);
        }
        return alloc_bool(result != 0);
    }

    value getEventType()
    {
        return alloc_int(event.type);
    }

    value getKeyboardState()
    {
        value val = alloc_empty_object();
        alloc_field(val, val_id("key"), alloc_int(event.key.key));

        return val;
    }

    value getMouseState()
    {
        float x, y;
        Uint32 mouseState = SDL_GetMouseState(&x, &y);

        value val = alloc_empty_object();
        alloc_field(val, val_id("x"), alloc_int(x));
        alloc_field(val, val_id("y"), alloc_int(y));
        alloc_field(val, val_id("delX"), alloc_int(mouseDeltaX));
        alloc_field(val, val_id("delY"), alloc_int(mouseDeltaY));
        alloc_field(val, val_id("button"), alloc_int(lastMouseButton));
        alloc_field(val, val_id("wheel"), alloc_int(lastMouseWheel));
        alloc_field(val, val_id("leftButton"), alloc_bool(mouseState & SDL_BUTTON_MASK(SDL_BUTTON_LEFT)));
        alloc_field(val, val_id("rightButton"), alloc_bool(mouseState & SDL_BUTTON_MASK(SDL_BUTTON_RIGHT)));
        alloc_field(val, val_id("middleButton"), alloc_bool(mouseState & SDL_BUTTON_MASK(SDL_BUTTON_MIDDLE)));

        return val;
    }

    DEFINE_PRIM(init, 0);
    DEFINE_PRIM(quit, 0);
    DEFINE_PRIM(preLoop, 0);
    DEFINE_PRIM(hasEvent, 0);
    DEFINE_PRIM(getEventType, 0);
    DEFINE_PRIM(getKeyboardState, 0);
    DEFINE_PRIM(getMouseState, 0);
}