#include "tuna/NativeWindow.hpp"

namespace tuna
{
    void init(int width, int height, HxString title, bool depthBuffer, bool stencilBuffer, bool allowHighDPI)
    {
        SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3);
        SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 3);
        SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE);

        if (depthBuffer)
            SDL_GL_SetAttribute(SDL_GL_DEPTH_SIZE, 24);

        if (stencilBuffer)
            SDL_GL_SetAttribute(SDL_GL_STENCIL_SIZE, 8);

        SDL_GL_SetAttribute(SDL_GL_RED_SIZE, 8);
        SDL_GL_SetAttribute(SDL_GL_GREEN_SIZE, 8);
        SDL_GL_SetAttribute(SDL_GL_BLUE_SIZE, 8);
        SDL_GL_SetAttribute(SDL_GL_ALPHA_SIZE, 8);

        SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);

        int flags = SDL_WINDOW_OPENGL;

        if (allowHighDPI)
            flags |= SDL_WINDOW_HIGH_PIXEL_DENSITY;

        window = SDL_CreateWindow(title.c_str(), width, height, flags);

        if (!window)
        {
            std::cout << "Couldn't create the window " << SDL_GetError() << std::endl;
            exit(0);
        }

        context = SDL_GL_CreateContext(window);
        if (!context)
        {
            std::cout << "Couldn't create opengl context " << SDL_GetError() << std::endl;
            exit(0);
        }

        if (!gladLoadGL(SDL_GL_GetProcAddress))
        {
            std::cout << "Error initializing opengl." << std::endl;
            exit(0);
        }

        glEnable(GL_BLEND);
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

        SDL_GL_MakeCurrent(window, context);
    }

    HL_PRIM void HL_NAME(hl_init)(int width, int height, vstring *title, bool depthBuffer, bool stencilBuffer, bool allowHighDPI)
    {
        SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3);
        SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 3);
        SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE);

        if (depthBuffer)
            SDL_GL_SetAttribute(SDL_GL_DEPTH_SIZE, 24);

        if (stencilBuffer)
            SDL_GL_SetAttribute(SDL_GL_STENCIL_SIZE, 8);

        SDL_GL_SetAttribute(SDL_GL_RED_SIZE, 8);
        SDL_GL_SetAttribute(SDL_GL_GREEN_SIZE, 8);
        SDL_GL_SetAttribute(SDL_GL_BLUE_SIZE, 8);
        SDL_GL_SetAttribute(SDL_GL_ALPHA_SIZE, 8);

        SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);

        int flags = SDL_WINDOW_OPENGL;

        if (allowHighDPI)
            flags |= SDL_WINDOW_HIGH_PIXEL_DENSITY;

        window = SDL_CreateWindow(hl_to_utf8(title->bytes), width, height, flags);

        if (!window)
        {
            std::cout << "Couldn't create the window " << SDL_GetError() << std::endl;
            exit(0);
        }

        context = SDL_GL_CreateContext(window);
        if (!context)
        {
            std::cout << "Couldn't create opengl context " << SDL_GetError() << std::endl;
            exit(0);
        }

        if (!gladLoadGL(SDL_GL_GetProcAddress))
        {
            std::cout << "Error initializing opengl." << std::endl;
            exit(0);
        }

        glEnable(GL_BLEND);
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

        SDL_GL_MakeCurrent(window, context);
    }

    void set_bg(int r, int g, int b)
    {
        bgR = r;
        bgG = g;
        bgB = b;
    }

    HL_PRIM void HL_NAME(hl_set_bg)(int r, int g, int b)
    {
        set_bg(r, g, b);
    }

    void clear()
    {
        glClearColor(bgR / 255, bgG / 255, bgB / 255, 1);
        glClear(GL_COLOR_BUFFER_BIT);
    }

    HL_PRIM void HL_NAME(hl_clear)()
    {
        clear();
    }

    void render()
    {
        SDL_GL_SwapWindow(window);
    }

    HL_PRIM void HL_NAME(hl_render)()
    {
        render();
    }

    bool set_fullscreen(bool value)
    {
        SDL_SetWindowFullscreen(window, value);
        return value;
    }

    HL_PRIM bool HL_NAME(hl_set_fullscreen)(bool value)
    {
        return set_fullscreen(value);
    }

    bool get_fullscreen()
    {
        return (SDL_GetWindowFlags(window) & SDL_WINDOW_FULLSCREEN) != 0;
    }

    HL_PRIM bool HL_NAME(hl_get_fullscreen)()
    {
        return get_fullscreen();
    }

    bool set_maximized(bool value)
    {
        if (value)
            SDL_MaximizeWindow(window);
        else
            SDL_RestoreWindow(window);
        return value;
    }

    HL_PRIM bool HL_NAME(hl_set_maximized)(bool value)
    {
        return set_maximized(value);
    }

    bool get_maximized()
    {
        return (SDL_GetWindowFlags(window) & SDL_WINDOW_MAXIMIZED) != 0;
    }

    HL_PRIM bool HL_NAME(hl_get_maximized)()
    {
        return get_maximized();
    }

    bool set_borderless(bool value)
    {
        SDL_SetWindowBordered(window, !value);
        return value;
    }

    HL_PRIM bool HL_NAME(hl_set_borderless)(bool value)
    {
        return set_borderless(value);
    }

    bool get_borderless()
    {
        return (SDL_GetWindowFlags(window) & SDL_WINDOW_BORDERLESS) != 0;
    }

    HL_PRIM bool HL_NAME(hl_get_borderless)()
    {
        return get_borderless();
    }

    bool set_resizable(bool value)
    {
        SDL_SetWindowResizable(window, value);
        return value;
    }

    HL_PRIM bool HL_NAME(hl_set_resizable)(bool value)
    {
        return set_resizable(value);
    }

    bool get_resizable()
    {
        return (SDL_GetWindowFlags(window) & SDL_WINDOW_RESIZABLE) != 0;
    }

    HL_PRIM bool HL_NAME(hl_get_resizable)()
    {
        return get_resizable();
    }

    bool set_visibility(bool value)
    {
        if (value)
            SDL_ShowWindow(window);
        else
            SDL_HideWindow(window);
        return value;
    }

    HL_PRIM bool HL_NAME(hl_set_visibility)(bool value)
    {
        return set_visibility(value);
    }

    bool get_visibility()
    {
        return (SDL_GetWindowFlags(window) & SDL_WINDOW_HIDDEN) == 0;
    }

    HL_PRIM bool HL_NAME(hl_get_visibility)()
    {
        return get_visibility();
    }

    int set_width(int value)
    {
        int h = get_height();
        SDL_SetWindowSize(window, value, h);
        return value;
    }

    HL_PRIM int HL_NAME(hl_set_width)(int value)
    {
        return set_width(value);
    }

    int get_width()
    {
        int w, h;
        SDL_GetWindowSize(window, &w, &h);
        return w;
    }

    HL_PRIM int HL_NAME(hl_get_width)()
    {
        return get_width();
    }

    int set_height(int value)
    {
        int w = get_width();
        SDL_SetWindowSize(window, w, value);
        return value;
    }

    HL_PRIM int HL_NAME(hl_set_height)(int value)
    {
        return set_height(value);
    }

    int get_height()
    {
        int w, h;
        SDL_GetWindowSize(window, &w, &h);
        return h;
    }

    HL_PRIM int HL_NAME(hl_get_height)()
    {
        return get_height();
    }

    int set_x(int value)
    {
        int yPos = get_y();
        SDL_SetWindowPosition(window, value, yPos);
        return value;
    }

    HL_PRIM int HL_NAME(hl_set_x)(int value)
    {
        return set_x(value);
    }

    int get_x()
    {
        int x, y;
        SDL_GetWindowPosition(window, &x, &y);
        return x;
    }

    HL_PRIM int HL_NAME(hl_get_x)()
    {
        return get_x();
    }

    int set_y(int value)
    {
        int xPos = get_x();
        SDL_SetWindowPosition(window, xPos, value);
        return value;
    }

    HL_PRIM int HL_NAME(hl_set_y)(int value)
    {
        return set_y(value);
    }

    int get_y()
    {
        int x, y;
        SDL_GetWindowPosition(window, &x, &y);
        return y;
    }

    HL_PRIM int HL_NAME(hl_get_y)()
    {
        return get_y();
    }

    HxString set_title(HxString value)
    {
        SDL_SetWindowTitle(window, value.c_str());
        return value;
    }

    HL_PRIM vstring *HL_NAME(hl_set_title)(vstring *value)
    {
        SDL_SetWindowTitle(window, hl_to_utf8(value->bytes));
        return value;
    }

    HxString get_title()
    {
        const char *title = SDL_GetWindowTitle(window);
        return HxString(title);
    }

    HL_PRIM vstring *HL_NAME(hl_get_title)()
    {
        const char *title = SDL_GetWindowTitle(window);
        return (vstring *)hl_to_utf16(title);
    }

    void window_destroy()
    {
        SDL_GL_DestroyContext(context);
        SDL_DestroyWindow(window);
    }

    HL_PRIM void HL_NAME(hl_window_destroy)()
    {
        SDL_GL_DestroyContext(context);
        SDL_DestroyWindow(window);
    }

    DEFINE_PRIM(init, 6);
    DEFINE_PRIM(set_bg, 6);
    DEFINE_PRIM(clear, 0);
    DEFINE_PRIM(render, 0);
    DEFINE_PRIM(set_fullscreen, 1);
    DEFINE_PRIM(get_fullscreen, 0);
    DEFINE_PRIM(set_maximized, 1);
    DEFINE_PRIM(get_maximized, 0);
    DEFINE_PRIM(set_borderless, 1);
    DEFINE_PRIM(get_borderless, 0);
    DEFINE_PRIM(set_resizable, 1);
    DEFINE_PRIM(get_resizable, 0);
    DEFINE_PRIM(set_visibility, 1);
    DEFINE_PRIM(get_visibility, 0);
    DEFINE_PRIM(set_width, 1);
    DEFINE_PRIM(get_width, 0);
    DEFINE_PRIM(set_height, 1);
    DEFINE_PRIM(get_height, 0);
    DEFINE_PRIM(set_x, 1);
    DEFINE_PRIM(get_x, 0);
    DEFINE_PRIM(set_y, 1);
    DEFINE_PRIM(get_y, 0);
    DEFINE_PRIM(set_title, 1);
    DEFINE_PRIM(get_title, 0);
    DEFINE_PRIM(window_destroy, 0);

    DEFINE_HL_PRIM(_VOID, hl_init, _I32 _I32 _STRING _BOOL _BOOL _BOOL);
    DEFINE_HL_PRIM(_VOID, hl_set_bg, _I32 _I32 _I32);
    DEFINE_HL_PRIM(_VOID, hl_clear, _NO_ARG);
    DEFINE_HL_PRIM(_VOID, hl_render, _NO_ARG);
    DEFINE_HL_PRIM(_BOOL, hl_set_fullscreen, _BOOL);
    DEFINE_HL_PRIM(_BOOL, hl_get_fullscreen, _NO_ARG);
    DEFINE_HL_PRIM(_BOOL, hl_set_maximized, _BOOL);
    DEFINE_HL_PRIM(_BOOL, hl_get_maximized, _NO_ARG);
    DEFINE_HL_PRIM(_BOOL, hl_set_borderless, _BOOL);
    DEFINE_HL_PRIM(_BOOL, hl_get_borderless, _NO_ARG);
    DEFINE_HL_PRIM(_BOOL, hl_set_resizable, _BOOL);
    DEFINE_HL_PRIM(_BOOL, hl_get_resizable, _NO_ARG);
    DEFINE_HL_PRIM(_BOOL, hl_set_visibility, _BOOL);
    DEFINE_HL_PRIM(_BOOL, hl_get_visibility, _NO_ARG);
    DEFINE_HL_PRIM(_I32, hl_set_width, _I32);
    DEFINE_HL_PRIM(_I32, hl_get_width, _NO_ARG);
    DEFINE_HL_PRIM(_I32, hl_set_height, _I32);
    DEFINE_HL_PRIM(_I32, hl_get_height, _NO_ARG);
    DEFINE_HL_PRIM(_I32, hl_set_x, _I32);
    DEFINE_HL_PRIM(_I32, hl_get_x, _NO_ARG);
    DEFINE_HL_PRIM(_I32, hl_set_y, _I32);
    DEFINE_HL_PRIM(_I32, hl_get_y, _NO_ARG);
    DEFINE_HL_PRIM(_STRING, hl_set_title, _STRING);
    DEFINE_HL_PRIM(_STRING, hl_get_title, _NO_ARG);
    DEFINE_HL_PRIM(_VOID, hl_window_destroy, _NO_ARG);
}