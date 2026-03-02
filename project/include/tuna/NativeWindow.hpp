#ifndef TUNA_NATIVE_WINDOW_HPP
#define TUNA_NATIVE_WINDOW_HPP
#include "tuna/cffi/CFFI.hpp"
#include "SDL3/SDL.h"
#include "glad/gl.h"

#include <string>
#include <iostream>

namespace tuna
{
    SDL_Window *window;
    SDL_GLContext context;

    int bgR = 0;
    int bgG = 0;
    int bgB = 0;

    void window_enableDepthBuffer(value val);
    void window_enableStencilBuffer(value val);

    void window_init(value width, value height, value title, value allowHighDPI);

    void set_bg(value r, value g, value b);

    void clear();

    void render();

    value set_fullscreen(value value);

    value get_fullscreen();

    value set_maximized(value value);

    value get_maximized();

    value set_borderless(value value);

    value get_borderless();

    value set_resizable(value value);

    value get_resizable();

    value set_visibility(value value);

    value get_visibility();

    value set_width(value value);

    value get_width();

    value set_height(value value);

    value get_height();

    value set_x(value value);

    value get_x();

    value set_y(value value);

    value get_y();

    value set_title(value value);

    value get_title();

    void window_destroy();
}

#endif