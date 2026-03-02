#include "tuna/NativeWindow.hpp"

namespace tuna
{
    void window_enableDepthBuffer(value val)
    {
        if (val_bool(val))
            SDL_GL_SetAttribute(SDL_GL_DEPTH_SIZE, 24);
    }

    void window_enableStencilBuffer(value val)
    {
        if (val_bool(val))
            SDL_GL_SetAttribute(SDL_GL_STENCIL_SIZE, 8);
    }

    void window_init(value width, value height, value title, value allowHighDPI)
    {
        // 1. Configurar atributos de OpenGL (Igual que antes)
        SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3);
        SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 3);
        SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE);
        SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);

        // 2. Crear la ventana usando Propiedades (Más robusto en SDL3)
        SDL_PropertiesID props = SDL_CreateProperties();
        SDL_SetStringProperty(props, SDL_PROP_WINDOW_CREATE_TITLE_STRING, val_string(title));
        SDL_SetNumberProperty(props, SDL_PROP_WINDOW_CREATE_WIDTH_NUMBER, val_int(width));
        SDL_SetNumberProperty(props, SDL_PROP_WINDOW_CREATE_HEIGHT_NUMBER, val_int(height));
        SDL_SetBooleanProperty(props, SDL_PROP_WINDOW_CREATE_OPENGL_BOOLEAN, true);

        if (val_bool(allowHighDPI))
        {
            SDL_SetBooleanProperty(props, SDL_PROP_WINDOW_CREATE_HIGH_PIXEL_DENSITY_BOOLEAN, true);
        }

        window = SDL_CreateWindowWithProperties(props);
        SDL_DestroyProperties(props); // Limpiar las propiedades tras crear la ventana

        if (!window)
        {
            // Esto te dirá exactamente qué falló (ej. "Direct3D not available" o "GL context fail")
            std::cout << "SDL3 Window Error: " << SDL_GetError() << std::endl;
            exit(0);
        }

        // 3. Crear el contexto
        context = SDL_GL_CreateContext(window);
        if (!context)
        {
            std::cout << "SDL3 OpenGL Context Error: " << SDL_GetError() << std::endl;
            exit(0);
        }

        // Cargar GLAD
        if (!gladLoadGL((GLADloadfunc)SDL_GL_GetProcAddress))
        {
            std::cout << "Error initializing opengl con GLAD." << std::endl;
            exit(0);
        }

        SDL_GL_MakeCurrent(window, context);
    }

    void set_bg(value r, value g, value b)
    {
        bgR = val_int(r);
        bgG = val_int(g);
        bgB = val_int(b);
    }

    void clear()
    {
        glClearColor(bgR / 255, bgG / 255, bgB / 255, 1);
        glClear(GL_COLOR_BUFFER_BIT);
    }

    void render()
    {
        SDL_GL_SwapWindow(window);
    }

    value set_fullscreen(value value)
    {
        SDL_SetWindowFullscreen(window, val_bool(value));
        return value;
    }

    value get_fullscreen()
    {
        return alloc_bool((SDL_GetWindowFlags(window) & SDL_WINDOW_FULLSCREEN) != 0);
    }

    value set_maximized(value value)
    {
        if (val_bool(value))
            SDL_MaximizeWindow(window);
        else
            SDL_RestoreWindow(window);
        return value;
    }

    value get_maximized()
    {
        return alloc_bool((SDL_GetWindowFlags(window) & SDL_WINDOW_MAXIMIZED) != 0);
    }

    value set_borderless(value value)
    {
        SDL_SetWindowBordered(window, val_bool(value));
        return value;
    }

    value get_borderless()
    {
        return alloc_bool((SDL_GetWindowFlags(window) & SDL_WINDOW_BORDERLESS) != 0);
    }

    value set_resizable(value value)
    {
        SDL_SetWindowResizable(window, val_bool(value));
        return value;
    }

    value get_resizable()
    {
        return alloc_bool((SDL_GetWindowFlags(window) & SDL_WINDOW_RESIZABLE) != 0);
    }

    value set_visibility(value value)
    {
        if (val_bool(value))
            SDL_ShowWindow(window);
        else
            SDL_HideWindow(window);
        return value;
    }

    value get_visibility()
    {
        return alloc_bool((SDL_GetWindowFlags(window) & SDL_WINDOW_HIDDEN) == 0);
    }

    value set_width(value value)
    {
        int w, h;
        SDL_GetWindowSize(window, &w, &h);
        SDL_SetWindowSize(window, val_int(value), h);
        return value;
    }

    value get_width()
    {
        int w, h;
        SDL_GetWindowSize(window, &w, &h);
        return alloc_int(w);
    }

    value set_height(value value)
    {
        int w, h;
        SDL_GetWindowSize(window, &w, &h);
        SDL_SetWindowSize(window, w, val_int(value));
        return value;
    }

    value get_height()
    {
        int w, h;
        SDL_GetWindowSize(window, &w, &h);
        return alloc_int(h);
    }

    value set_x(value value)
    {
        int x, y;
        SDL_GetWindowPosition(window, &x, &y);
        SDL_SetWindowPosition(window, val_int(value), y);
        return value;
    }

    value get_x()
    {
        int x, y;
        SDL_GetWindowPosition(window, &x, &y);
        return alloc_int(x);
    }

    value set_y(value value)
    {
        int x, y;
        SDL_GetWindowPosition(window, &x, &y);
        SDL_SetWindowPosition(window, x, val_int(value));
        return value;
    }

    value get_y()
    {
        int x, y;
        SDL_GetWindowPosition(window, &x, &y);
        return alloc_int(y);
    }

    value set_title(value value)
    {
        SDL_SetWindowTitle(window, val_string(value));
        return value;
    }

    value get_title()
    {
        const char *title = SDL_GetWindowTitle(window);
        return alloc_string(title);
    }

    void window_destroy()
    {
        SDL_GL_DestroyContext(context);
        SDL_DestroyWindow(window);
    }

    DEFINE_PRIM(window_enableDepthBuffer, 1);
    DEFINE_PRIM(window_enableStencilBuffer, 1);
    DEFINE_PRIM(window_init, 4);
    DEFINE_PRIM(set_bg, 3);
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
}