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

    void init(int width, int height, HxString title, bool depthBuffer, bool stencilBuffer, bool allowHighDPI);
    HL_PRIM void HL_NAME(hl_window_init)(int width, int height, vstring *title, bool depthBuffer, bool stencilBuffer, bool allowHighDPI);

    void set_bg(int r, int g, int b);
    HL_PRIM void HL_NAME(hl_window_set_bg)(int r, int g, int b);

    void clear();
    HL_PRIM void HL_NAME(hl_clear)();

    void render();
    HL_PRIM void HL_NAME(hl_render)();

    bool set_fullscreen(bool value);
    HL_PRIM bool HL_NAME(hl_set_fullscreen)(bool value);

    bool get_fullscreen();
    HL_PRIM bool HL_NAME(hl_get_fullscreen)();

    bool set_maximized(bool value);
    HL_PRIM bool HL_NAME(hl_set_maximized)(bool value);

    bool get_maximized();
    HL_PRIM bool HL_NAME(hl_get_maximized)();

    bool set_borderless(bool value);
    HL_PRIM bool HL_NAME(hl_set_borderless)(bool value);

    bool get_borderless();
    HL_PRIM bool HL_NAME(hl_get_borderless)();

    bool set_resizable(bool value);
    HL_PRIM bool HL_NAME(hl_set_resizable)(bool value);

    bool get_resizable();
    HL_PRIM bool HL_NAME(hl_get_resizable)();

    bool set_visibility(bool value);
    HL_PRIM bool HL_NAME(hl_set_visibility)(bool value);

    bool get_visibility();
    HL_PRIM bool HL_NAME(hl_get_visibility)();

    int set_width(int value);
    HL_PRIM int HL_NAME(hl_set_width)(int value);

    int get_width();
    HL_PRIM int HL_NAME(hl_get_width)();

    int set_height(int value);
    HL_PRIM int HL_NAME(hl_set_height)(int value);

    int get_height();
    HL_PRIM int HL_NAME(hl_get_height)();

    int set_x(int value);
    HL_PRIM int HL_NAME(hl_set_x)(int value);

    int get_x();
    HL_PRIM int HL_NAME(hl_get_x)();

    int set_y(int value);
    HL_PRIM int HL_NAME(hl_set_y)(int value);

    int get_y();
    HL_PRIM int HL_NAME(hl_get_y)();

    HxString set_title(HxString value);
    HL_PRIM vstring* HL_NAME(hl_set_title)(vstring *value);

    HxString get_title();
    HL_PRIM vstring* HL_NAME(hl_get_title)();

    void window_destroy();
    HL_PRIM void HL_NAME(hl_window_destroy)();
}

#endif