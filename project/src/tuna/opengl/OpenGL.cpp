#include "tuna/cffi/CFFI.hpp"
#include "glad/gl.h"

namespace tuna
{
    void gl_cullFace(int mode)
    {
        glCullFace(mode);
    }

    void gl_frontFace(int mode)
    {
        glFrontFace(mode);
    }

    void gl_hint(int target, int mode)
    {
        glHint(target, mode);
    }

    void gl_lineWidth(float width)
    {
        glLineWidth(width);
    }

    void gl_pointSize(float size)
    {
        glPointSize(size);
    }

    void gl_polygonMode(int face, int mode)
    {
        glPolygonMode(face, mode);
    }

    void gl_scissor(int x, int y, int width, int height)
    {
        glScissor(x, y, width, height);
    }

    void gl_texParameterf(int target, int pname, float param)
    {
        glTexParameterf(target, pname, param);
    }

    void gl_texParameteri(int target, int pname, int param)
    {
        glTexParameteri(target, pname, param);
    }

    void gl_texParameterfv(int target, int pname, value haxeArray)
    {
        int count = val_array_size(haxeArray);
        GLfloat *params = new GLfloat[count];

        for (int i = 0; i < count; i++)
        {
            params[i] = (GLfloat)val_float(val_array_i(haxeArray, i));
        }

        glTexParameterfv(target, pname, params);

        delete[] params;
    }

    void gl_texParameteriv(int target, int pname, value haxeArray)
    {
        int count = val_array_size(haxeArray);
        GLint *params = new GLint[count];

        for (int i = 0; i < count; i++)
        {
            params[i] = (GLint)val_int(val_array_i(haxeArray, i));
        }

        glTexParameteriv(target, pname, params);

        delete[] params;
    }

    void gl_texImage1D(int target, int level, int internalFormat, int width, int border, int format, int type, value pixels)
    {
        const void *ptr = nullptr;
        if (!val_is_null(pixels))
        {
            buffer buf = val_to_buffer(pixels);
            ptr = buffer_data(buf);
        }
        glTexImage1D(target, level, internalFormat, width, border, format, type, ptr);
    }

    void gl_texImage2D(int target, int level, int internalFormat, int width, int height, int border, int format, int type, value pixels)
    {
        const void *ptr = nullptr;
        if (!val_is_null(pixels))
        {
            buffer buf = val_to_buffer(pixels);
            ptr = buffer_data(buf);
        }
        glTexImage2D(target, level, internalFormat, width, height, border, format, type, ptr);
    }

    void gl_drawBuffer(int buf)
    {
        glDrawBuffer(buf);
    }

    void gl_clear(int mask)
    {
        glClear(mask);
    }

    void gl_clearColor(float red, float green, float blue, float alpha)
    {
        glClearColor(red, green, blue, alpha);
    }

    void gl_clearStencil(int s)
    {
        glClearStencil(s);
    }

    void gl_clearDepth(double depth)
    {
        glClearDepth(depth);
    }

    void gl_stencilMask(int mask)
    {
        glStencilMask(mask);
    }

    void gl_colorMask(bool red, bool green, bool blue, bool alpha)
    {
        glColorMask(red, green, blue, alpha);
    }

    void gl_depthMask(bool flag)
    {
        glDepthMask(flag);
    }

    void gl_disable(int cap)
    {
        glDisable(cap);
    }

    void gl_enable(int cap)
    {
        glEnable(cap);
    }

    void gl_finish()
    {
        glFinish();
    }

    void gl_flush()
    {
        glFlush();
    }

    void gl_blendFunc(int sfactor, int dfactor)
    {
        glBlendFunc(sfactor, dfactor);
    }

    void gl_logicOp(int opcode)
    {
        glLogicOp(opcode);
    }

    void gl_stencilFunc(int func, int ref, int mask)
    {
        glStencilFunc(func, ref, mask);
    }

    void gl_stencilOp(int fail, int zfail, int zpass)
    {
        glStencilOp(fail, zfail, zpass);
    }

    void gl_depthFunc(int func)
    {
        glDepthFunc(func);
    }

    void gl_pixelStoref(int pname, float param)
    {
        glPixelStoref(pname, param);
    }

    void gl_pixelStorei(int pname, int param)
    {
        glPixelStorei(pname, param);
    }

    void gl_readBuffer(int src)
    {
        glReadBuffer(src);
    }

    value gl_readPixels(int x, int y, int width, int height, int format, int type)
    {
        int bytesPerPixel = 4;
        switch (format)
        {
        case GL_RGB:
            bytesPerPixel = 3;
            break;
        case GL_RED:
            bytesPerPixel = 1;
            break;
        case GL_RGBA:
            bytesPerPixel = 4;
            break;
        }

        if (type == GL_FLOAT || type == GL_UNSIGNED_INT || type == GL_INT)
        {
            bytesPerPixel *= 4;
        }
        else if (type == GL_UNSIGNED_SHORT || type == GL_SHORT)
        {
            bytesPerPixel *= 2;
        }

        int bufSize = width * height * bytesPerPixel;
        if (bufSize <= 0)
            return alloc_null();

        buffer buf = alloc_buffer_len(bufSize);
        glReadPixels(x, y, width, height, format, type, buffer_data(buf));

        return buffer_val(buf);
    }

    value gl_getBooleanv(int pname)
    {
        GLboolean result = 0;
        glGetBooleanv(pname, &result);
        return alloc_bool(result != 0);
    }

    value gl_getDoublev(int pname)
    {
        GLdouble data = 0;
        glGetDoublev(pname, &data);
        return alloc_float(data);
    }

    value gl_getError()
    {
        return alloc_int(glGetError());
    }

    value gl_getFloatv(int pname)
    {
        GLfloat data = 0;
        glGetFloatv(pname, &data);
        return alloc_float(data);
    }

    value gl_getIntegerv(int pname)
    {
        GLint data = 0;
        glGetIntegerv(pname, &data);
        return alloc_int(data);
    }

    value gl_getString(int name)
    {
        const GLubyte *str = glGetString(name);
        return str ? alloc_string((const char *)str) : alloc_string("");
    }

    value gl_getTexImage(int target, int level, int format, int type, int width, int height)
    {
        int bytesPerPixel = 4;
        switch (format)
        {
        case GL_RGB:
            bytesPerPixel = 3;
            break;
        case GL_RED:
            bytesPerPixel = 1;
            break;
        case GL_RGBA:
            bytesPerPixel = 4;
            break;
        }

        if (type == GL_FLOAT || type == GL_UNSIGNED_INT || type == GL_INT)
        {
            bytesPerPixel *= 4;
        }
        else if (type == GL_UNSIGNED_SHORT || type == GL_SHORT)
        {
            bytesPerPixel *= 2;
        }

        int bufSize = width * height * bytesPerPixel;
        if (bufSize <= 0)
            return alloc_null();

        buffer buf = alloc_buffer_len(bufSize);
        glGetTexImage(target, level, format, type, buffer_data(buf));

        return buffer_val(buf);
    }

    value gl_getTexParameterfv(int target, int pname)
    {
        bool isMulti = (pname == GL_TEXTURE_BORDER_COLOR);
        int allocCount = isMulti ? 4 : 1;

        GLfloat *params = new GLfloat[allocCount];
        glGetTexParameterfv(target, pname, params);

        value arr = alloc_array(allocCount);
        for (int i = 0; i < allocCount; i++)
        {
            val_array_set_i(arr, i, alloc_float(params[i]));
        }

        delete[] params;
        return arr;
    }

    value gl_getTexParameteriv(int target, int pname)
    {
        GLint param = 0;
        glGetTexParameteriv(target, pname, &param);

        value arr = alloc_array(1);
        val_array_set_i(arr, 0, alloc_int(param));

        return arr;
    }

    value gl_getTexLevelParameterfv(int target, int level, int pname)
    {
        GLfloat param = 0;
        glGetTexLevelParameterfv(target, level, pname, &param);

        value arr = alloc_array(1);
        val_array_set_i(arr, 0, alloc_float(param));

        return arr;
    }

    value gl_getTexLevelParameteriv(int target, int level, int pname)
    {
        GLint param = 0;
        glGetTexLevelParameteriv(target, level, pname, &param);

        value arr = alloc_array(1);
        val_array_set_i(arr, 0, alloc_int(param));

        return arr;
    }

    value gl_isEnabled(int cap)
    {
        return alloc_bool(glIsEnabled(cap) != 0);
    }

    void gl_depthRange(double n, double f)
    {
        glDepthRange(n, f);
    }

    void gl_viewport(int x, int y, int width, int height)
    {
        glViewport(x, y, width, height);
    }

    void gl_drawArrays(int mode, int first, int count)
    {
        glDrawArrays(mode, first, count);
    }

    void gl_drawElements(int mode, int count, int type, int offset)
    {
        glDrawElements(mode, count, type, (void *)(uintptr_t)offset);
    }

    void gl_polygonOffset(float factor, float units)
    {
        glPolygonOffset(factor, units);
    }

    void gl_copyTexImage1D(int target, int level, int internalFormat, int x, int y, int width, int border)
    {
        glCopyTexImage1D(target, level, internalFormat, x, y, width, border);
    }

    void gl_copyTexImage2D(int target, int level, int internalFormat, int x, int y, int width, int height, int border)
    {
        glCopyTexImage2D(target, level, internalFormat, x, y, width, height, border);
    }

    void gl_copyTexSubImage1D(int target, int level, int xoffset, int x, int y, int width)
    {
        glCopyTexSubImage1D(target, level, xoffset, x, y, width);
    }

    void gl_copyTexSubImage2D(int target, int level, int xoffset, int yoffset, int x, int y, int width, int height)
    {
        glCopyTexSubImage2D(target, level, xoffset, yoffset, x, y, width, height);
    }

    void gl_copyTexSubImage3D(int target, int level, int xoffset, int yoffset, int zoffset, int x, int y, int width, int height)
    {
        glCopyTexSubImage3D(target, level, xoffset, yoffset, zoffset, x, y, width, height);
    }

    void gl_texSubImage1D(int target, int level, int xOffset, int width, int format, int type, value pixels)
    {
        const void *ptr = nullptr;
        if (!val_is_null(pixels))
        {
            buffer buf = val_to_buffer(pixels);
            ptr = buffer_data(buf);
        }
        glTexSubImage1D(target, level, xOffset, width, format, type, ptr);
    }

    void gl_texSubImage2D(int target, int level, int xOffset, int yOffset, int width, int height, int format, int type, value pixels)
    {
        const void *ptr = nullptr;
        if (!val_is_null(pixels))
        {
            buffer buf = val_to_buffer(pixels);
            ptr = buffer_data(buf);
        }
        glTexSubImage2D(target, level, xOffset, yOffset, width, height, format, type, ptr);
    }

    void gl_bindTexture(int target, int texture)
    {
        glBindTexture(target, texture);
    }

    void gl_deleteTextures(int n, value textures)
    {
        GLuint *tex = new GLuint[n];
        for (int i = 0; i < n; i++)
        {
            tex[i] = val_int(val_array_i(textures, i));
        }
        glDeleteTextures(n, tex);
        delete[] tex;
    }

    void gl_genTextures(int n, value textures)
    {
        GLuint *tex = new GLuint[n];
        glGenTextures(n, tex);

        for (int i = 0; i < n; i++)
        {
            val_array_set_i(textures, i, alloc_int(tex[i]));
        }
        delete[] tex;
    }

    value gl_genTexture()
    {
        GLuint tex = 0;
        glGenTextures(1, &tex);
        return alloc_int(tex);
    }

    value gl_isTexture(int texture)
    {
        return alloc_bool(glIsTexture(texture) != 0);
    }

    void gl_drawRangeElements(int mode, int start, int end, int count, int type, int indices)
    {
        glDrawRangeElements(mode, start, end, count, type, (void *)(uintptr_t)indices);
    }

    void gl_texImage3D(int target, int level, int internalFormat, int width, int height, int depth, int border, int format, int type, value pixels)
    {
        const void *ptr = nullptr;
        if (!val_is_null(pixels))
        {
            buffer buf = val_to_buffer(pixels);
            ptr = buffer_data(buf);
        }
        glTexImage3D(target, level, internalFormat, width, height, depth, border, format, type, ptr);
    }

    void gl_texSubImage3D(int target, int level, int xOffset, int yOffset, int zOffset, int width, int height, int depth, int format, int type, value pixels)
    {
        const void *ptr = nullptr;
        if (!val_is_null(pixels))
        {
            buffer buf = val_to_buffer(pixels);
            ptr = buffer_data(buf);
        }
        glTexSubImage3D(target, level, xOffset, yOffset, zOffset, width, height, depth, format, type, ptr);
    }

    void gl_activeTexture(int texture)
    {
        glActiveTexture(texture);
    }

    void gl_sampleCoverage(float value, bool invert)
    {
        glSampleCoverage(value, invert);
    }

    void gl_compressedTexImage3D(int target, int level, int internalFormat, int width, int height, int depth, int border, int imageSize, value data)
    {
        const void *ptr = nullptr;
        if (!val_is_null(data))
        {
            buffer buf = val_to_buffer(data);
            ptr = buffer_data(buf);
        }
        glCompressedTexImage3D(target, level, internalFormat, width, height, depth, border, imageSize, ptr);
    }

    void gl_compressedTexImage2D(int target, int level, int internalFormat, int width, int height, int border, int imageSize, value data)
    {
        const void *ptr = nullptr;
        if (!val_is_null(data))
        {
            buffer buf = val_to_buffer(data);
            ptr = buffer_data(buf);
        }
        glCompressedTexImage2D(target, level, internalFormat, width, height, border, imageSize, ptr);
    }

    void gl_compressedTexImage1D(int target, int level, int internalFormat, int width, int border, int imageSize, value data)
    {
        const void *ptr = nullptr;
        if (!val_is_null(data))
        {
            buffer buf = val_to_buffer(data);
            ptr = buffer_data(buf);
        }
        glCompressedTexImage1D(target, level, internalFormat, width, border, imageSize, ptr);
    }

    void gl_compressedTexSubImage3D(int target, int level, int xOffset, int yOffset, int depthOffset, int width, int height, int depth, int format, int imageSize, value data)
    {
        const void *ptr = nullptr;
        if (!val_is_null(data))
        {
            buffer buf = val_to_buffer(data);
            ptr = buffer_data(buf);
        }
        glCompressedTexSubImage3D(target, level, xOffset, yOffset, depthOffset, width, height, depth, format, imageSize, ptr);
    }

    void gl_compressedTexSubImage2D(int target, int level, int xOffset, int yOffset, int width, int height, int format, int imageSize, value data)
    {
        const void *ptr = nullptr;
        if (!val_is_null(data))
        {
            buffer buf = val_to_buffer(data);
            ptr = buffer_data(buf);
        }
        glCompressedTexSubImage2D(target, level, xOffset, yOffset, width, height, format, imageSize, ptr);
    }

    void gl_compressedTexSubImage1D(int target, int level, int xOffset, int width, int format, int imageSize, value data)
    {
        const void *ptr = nullptr;
        if (!val_is_null(data))
        {
            buffer buf = val_to_buffer(data);
            ptr = buffer_data(buf);
        }
        glCompressedTexSubImage1D(target, level, xOffset, width, format, imageSize, ptr);
    }

    void gl_getCompressedTexImage(int target, int level, value pixels)
    {
        if (!val_is_null(pixels))
        {
            buffer buf = val_to_buffer(pixels);
            glGetCompressedTexImage(target, level, buffer_data(buf));
        }
    }

    void gl_blendFuncSeparate(int sfactorRGB, int dfactorRGB, int sfactorAlpha, int dfactorAlpha)
    {
        glBlendFuncSeparate(sfactorRGB, dfactorRGB, sfactorAlpha, dfactorAlpha);
    }

    void gl_multiDrawArrays(int mode, value first, value count, int drawcount)
    {
        GLint *firstArr = new GLint[drawcount];
        GLsizei *countArr = new GLsizei[drawcount];

        for (int i = 0; i < drawcount; i++)
        {
            firstArr[i] = val_int(val_array_i(first, i));
            countArr[i] = val_int(val_array_i(count, i));
        }

        glMultiDrawArrays(mode, firstArr, countArr, drawcount);

        delete[] firstArr;
        delete[] countArr;
    }

    void gl_pointParameterf(int pname, float param)
    {
        glPointParameterf(pname, param);
    }

    void gl_pointParameterfv(int pname, value params)
    {
        int count = val_array_size(params);
        GLfloat *arr = new GLfloat[count];

        for (int i = 0; i < count; i++)
        {
            arr[i] = (GLfloat)val_float(val_array_i(params, i));
        }

        glPointParameterfv(pname, arr);
        delete[] arr;
    }

    void gl_pointParameteri(int pname, int param)
    {
        glPointParameteri(pname, param);
    }

    void gl_pointParameteriv(int pname, value params)
    {
        int count = val_array_size(params);
        GLint *arr = new GLint[count];

        for (int i = 0; i < count; i++)
        {
            arr[i] = val_int(val_array_i(params, i));
        }

        glPointParameteriv(pname, arr);
        delete[] arr;
    }

    void gl_blendColor(float red, float green, float blue, float alpha)
    {
        glBlendColor(red, green, blue, alpha);
    }

    void gl_blendEquation(int mode)
    {
        glBlendEquation(mode);
    }

    void gl_genQueries(int n, value ids)
    {
        GLuint *queries = new GLuint[n];
        glGenQueries(n, queries);

        for (int i = 0; i < n; i++)
        {
            val_array_set_i(ids, i, alloc_int(queries[i]));
        }
        delete[] queries;
    }

    void gl_deleteQueries(int n, value ids)
    {
        GLuint *queries = new GLuint[n];
        for (int i = 0; i < n; i++)
        {
            queries[i] = val_int(val_array_i(ids, i));
        }

        glDeleteQueries(n, queries);
        delete[] queries;
    }

    value gl_isQuery(int id)
    {
        return alloc_bool(glIsQuery(id) != 0);
    }

    void gl_beginQuery(int target, int id)
    {
        glBeginQuery(target, id);
    }

    void gl_endQuery(int target)
    {
        glEndQuery(target);
    }

    void gl_getQueryiv(int target, int pname, value params)
    {
        int count = val_array_size(params);
        GLint *arr = new GLint[count];

        glGetQueryiv(target, pname, arr);

        for (int i = 0; i < count; i++)
        {
            val_array_set_i(params, i, alloc_int(arr[i]));
        }
        delete[] arr;
    }

    void gl_getQueryObjectiv(int id, int pname, value params)
    {
        int count = val_array_size(params);
        GLint *arr = new GLint[count];

        glGetQueryObjectiv(id, pname, arr);

        for (int i = 0; i < count; i++)
        {
            val_array_set_i(params, i, alloc_int(arr[i]));
        }
        delete[] arr;
    }

    void gl_getQueryObjectuiv(int id, int pname, value params)
    {
        int count = val_array_size(params);
        GLuint *arr = new GLuint[count];

        glGetQueryObjectuiv(id, pname, arr);

        for (int i = 0; i < count; i++)
        {
            val_array_set_i(params, i, alloc_int(arr[i]));
        }
        delete[] arr;
    }

    void gl_bindBuffer(int target, int buffer)
    {
        glBindBuffer(target, buffer);
    }

    void gl_deleteBuffers(int n, value buffers)
    {
        GLuint *buf = new GLuint[n];
        for (int i = 0; i < n; i++)
        {
            buf[i] = val_int(val_array_i(buffers, i));
        }
        glDeleteBuffers(n, buf);
        delete[] buf;
    }

    value gl_genBuffer()
    {
        GLuint buffer = 0;
        glGenBuffers(1, &buffer);
        return alloc_int(buffer);
    }

    value gl_isBuffer(int buffer)
    {
        return alloc_bool(glIsBuffer(buffer) != 0);
    }

    void gl_bufferData(int target, int size, value data, int usage)
    {
        const void *ptr = nullptr;
        if (!val_is_null(data))
        {
            buffer buf = val_to_buffer(data);
            ptr = buffer_data(buf);
        }
        glBufferData(target, (GLsizeiptr)size, ptr, usage);
    }

    void gl_bufferSubData(int target, int offset, int size, value data)
    {
        const void *ptr = nullptr;
        if (!val_is_null(data))
        {
            buffer buf = val_to_buffer(data);
            ptr = buffer_data(buf);
        }
        glBufferSubData(target, offset, (GLsizeiptr)size, ptr);
    }

    value gl_getBufferSubData(int target, int offset, int size)
    {
        buffer buf = alloc_buffer_len(size);
        glGetBufferSubData(target, offset, (GLsizeiptr)size, buffer_data(buf));
        return buffer_val(buf);
    }

    value gl_getBufferParameteriv(int target, int pname)
    {
        GLint value = 0;
        glGetBufferParameteriv(target, pname, &value);
        return alloc_int(value);
    }

    void gl_blendEquationSeparate(int modeRGB, int modeAlpha)
    {
        glBlendEquationSeparate(modeRGB, modeAlpha);
    }

    void gl_drawBuffers(int n, value buffers)
    {
        GLenum *buf = new GLenum[n];
        for (int i = 0; i < n; i++)
        {
            buf[i] = val_int(val_array_i(buffers, i));
        }
        glDrawBuffers(n, buf);
        delete[] buf;
    }

    void gl_stencilOpSeparate(int face, int sfail, int dpfail, int dppass)
    {
        glStencilOpSeparate(face, sfail, dpfail, dppass);
    }

    void gl_stencilFuncSeparate(int face, int func, int ref, int mask)
    {
        glStencilFuncSeparate(face, func, ref, mask);
    }

    void gl_stencilMaskSeparate(int face, int mask)
    {
        glStencilMaskSeparate(face, mask);
    }

    void gl_attachShader(int program, int shader)
    {
        glAttachShader(program, shader);
    }

    void gl_bindAttribLocation(int program, int index, value name)
    {
        const char *str = val_string(name);
        glBindAttribLocation(program, index, str);
    }

    void gl_compileShader(int shader)
    {
        glCompileShader(shader);
    }

    value gl_createProgram()
    {
        return alloc_int(glCreateProgram());
    }
    
    value gl_createShader(int type)
    {
        return alloc_int(glCreateShader(type));
    }

    void gl_deleteProgram(int program)
    {
        glDeleteProgram(program);
    }

    void gl_deleteShader(int shader)
    {
        glDeleteShader(shader);
    }
    
    void gl_detachShader(int program, int shader)
    {
        glDetachShader(program, shader);
    }

    void gl_disableVertexAttribArray(int index)
    {
        glDisableVertexAttribArray(index);
    }

    void gl_enableVertexAttribArray(int index)
    {
        glEnableVertexAttribArray(index);
    }

    value gl_getActiveAttrib(int program, int index, int bufSize)
    {
        GLsizei length = 0;
        GLint size = 0;
        GLenum type = 0;
        char *name = new char[bufSize];

        glGetActiveAttrib(program, index, bufSize, &length, &size, &type, name);

        value result = alloc_empty_object();
        alloc_field(result, val_id("length"), alloc_int(length));
        alloc_field(result, val_id("size"), alloc_int(size));
        alloc_field(result, val_id("type"), alloc_int(type));
        alloc_field(result, val_id("name"), alloc_string(name));

        delete[] name;
        return result;
    }

    value gl_getActiveUniform(int program, int index, int bufSize)
    {
        GLsizei length = 0;
        GLint size = 0;
        GLenum type = 0;
        char *name = new char[bufSize];

        glGetActiveUniform(program, index, bufSize, &length, &size, &type, name);

        value result = alloc_empty_object();
        alloc_field(result, val_id("length"), alloc_int(length));
        alloc_field(result, val_id("size"), alloc_int(size));
        alloc_field(result, val_id("type"), alloc_int(type));
        alloc_field(result, val_id("name"), alloc_string(name));

        delete[] name;
        return result;
    }

    value gl_getAttachedShaders(int program, int maxCount)
    {
        GLsizei count = 0;
        GLuint *shaders = new GLuint[maxCount];

        glGetAttachedShaders(program, maxCount, &count, shaders);

        value result = alloc_empty_object();
        alloc_field(result, val_id("count"), alloc_int(count));

        value shadersArr = alloc_array(count);
        for (int i = 0; i < count; i++)
        {
            val_array_set_i(shadersArr, i, alloc_int(shaders[i]));
        }
        alloc_field(result, val_id("shaders"), shadersArr);

        delete[] shaders;
        return result;
    }

    value gl_getAttribLocation(int program, value name)
    {
        const char *str = val_string(name);
        return alloc_int(glGetAttribLocation(program, str));
    }

    value gl_getProgramiv(int program, int pname)
    {
        GLint value = 0;
        glGetProgramiv(program, pname, &value);
        return alloc_int(value);
    }

    value gl_getProgramInfoLog(int program)
    {
        GLint length = 0;
        glGetProgramiv(program, GL_INFO_LOG_LENGTH, &length);

        if (length <= 0)
            return alloc_string("");

        char *buffer = new char[length];
        glGetProgramInfoLog(program, length, nullptr, buffer);

        value result = alloc_string(buffer);
        delete[] buffer;

        return result;
    }

    value gl_getShaderiv(int shader, int pname)
    {
        GLint value = 0;
        glGetShaderiv(shader, pname, &value);
        return alloc_int(value);
    }

    value gl_getShaderInfoLog(int shader)
    {
        GLint length = 0;
        glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &length);

        if (length <= 0)
            return alloc_string("");

        char *buffer = new char[length];
        glGetShaderInfoLog(shader, length, nullptr, buffer);

        value result = alloc_string(buffer);
        delete[] buffer;

        return result;
    }

    value gl_getShaderSource(int shader)
    {
        GLint length = 0;
        glGetShaderiv(shader, GL_SHADER_SOURCE_LENGTH, &length);

        if (length <= 0)
            return alloc_string("");

        char *buffer = new char[length];
        glGetShaderSource(shader, length, nullptr, buffer);

        value result = alloc_string(buffer);
        delete[] buffer;

        return result;
    }

    value gl_getUniformLocation(int program, value name)
    {
        const char *str = val_string(name);
        return alloc_int(glGetUniformLocation(program, str));
    }

    value gl_getUniformfv(int program, int location)
    {
        GLfloat arr[4] = {0.0f, 0.0f, 0.0f, 0.0f};
        glGetUniformfv(program, location, arr);

        value result = alloc_array(4);
        for (int i = 0; i < 4; i++)
        {
            val_array_set_i(result, i, alloc_float(arr[i]));
        }
        return result;
    }

    value gl_getUniformiv(int program, int location)
    {
        GLint arr[4] = {0, 0, 0, 0};
        glGetUniformiv(program, location, arr);

        value result = alloc_array(4);
        for (int i = 0; i < 4; i++)
        {
            val_array_set_i(result, i, alloc_int(arr[i]));
        }
        return result;
    }

    value gl_getVertexAttribiv(int index, int pname)
    {
        GLint value = 0;
        glGetVertexAttribiv(index, pname, &value);
        return alloc_int(value);
    }

    value gl_getVertexAttribfv(int index, int pname)
    {
        GLfloat arr[4] = {0.0f, 0.0f, 0.0f, 0.0f};
        glGetVertexAttribfv(index, pname, arr);

        value result = alloc_array(4);
        for (int i = 0; i < 4; i++)
        {
            val_array_set_i(result, i, alloc_float(arr[i]));
        }
        return result;
    }

    value gl_getVertexAttribdv(int index, int pname)
    {
        GLdouble arr[4] = {0.0, 0.0, 0.0, 0.0};
        glGetVertexAttribdv(index, pname, arr);

        value result = alloc_array(4);
        for (int i = 0; i < 4; i++)
        {
            val_array_set_i(result, i, alloc_float(arr[i]));
        }
        return result;
    }

    value gl_isProgram(int program)
    {
        return alloc_bool(glIsProgram(program) != 0);
    }

    value gl_isShader(int shader)
    {
        return alloc_bool(glIsShader(shader) != 0);
    }

    void gl_linkProgram(int program)
    {
        glLinkProgram(program);
    }

    void gl_useProgram(int program)
    {
        glUseProgram(program);
    }

    void gl_validateProgram(int program)
    {
        glValidateProgram(program);
    }

    void gl_shaderSource(int shader, value source)
    {
        const char *src = val_string(source);
        glShaderSource(shader, 1, &src, nullptr);
    }

    void gl_uniform1fv(int location, value values)
    {
        int count = val_array_size(values);
        GLfloat *arr = new GLfloat[count];

        for (int i = 0; i < count; i++)
        {
            arr[i] = (GLfloat)val_float(val_array_i(values, i));
        }

        glUniform1fv(location, count, arr);
        delete[] arr;
    }

    void gl_uniform2fv(int location, value v)
    {
        float x = (float)val_float(val_field(v, val_id("x")));
        float y = (float)val_float(val_field(v, val_id("y")));

        GLfloat data[2] = {x, y};
        glUniform2fv(location, 1, data);
    }

    void gl_uniform3fv(int location, value v)
    {
        float x = (float)val_float(val_field(v, val_id("x")));
        float y = (float)val_float(val_field(v, val_id("y")));
        float z = (float)val_float(val_field(v, val_id("z")));

        GLfloat data[3] = {x, y, z};
        glUniform3fv(location, 1, data);
    }

    void gl_uniform4fv(int location, value v)
    {
        float x = (float)val_float(val_field(v, val_id("x")));
        float y = (float)val_float(val_field(v, val_id("y")));
        float z = (float)val_float(val_field(v, val_id("z")));
        float w = (float)val_float(val_field(v, val_id("w")));

        GLfloat data[4] = {x, y, z, w};
        glUniform4fv(location, 1, data);
    }

    void gl_uniformMatrix3fv(int location, bool transpose, value mat)
    {
        GLfloat data[9];
        for (int i = 0; i < 9; i++)
        {
            data[i] = (GLfloat)val_float(val_array_i(mat, i));
        }
        glUniformMatrix3fv(location, 1, transpose, data);
    }

    void gl_uniformMatrix4fv(int location, int transpose, value mat)
    {
        GLfloat data[16];
        for (int i = 0; i < 16; i++)
        {
            data[i] = (GLfloat)val_float(val_array_i(mat, i));
        }
        glUniformMatrix4fv(location, 1, transpose, data);
    }

    void gl_vertexAttrib1f(int index, float x)
    {
        glVertexAttrib1f(index, x);
    }

    void gl_vertexAttrib2f(int index, value v)
    {
        float x = (float)val_float(val_field(v, val_id("x")));
        float y = (float)val_float(val_field(v, val_id("y")));
        glVertexAttrib2f(index, x, y);
    }

    void gl_vertexAttrib3f(int index, value v)
    {
        float x = (float)val_float(val_field(v, val_id("x")));
        float y = (float)val_float(val_field(v, val_id("y")));
        float z = (float)val_float(val_field(v, val_id("z")));
        glVertexAttrib3f(index, x, y, z);
    }

    void gl_vertexAttrib4f(int index, value v)
    {
        float x = (float)val_float(val_field(v, val_id("x")));
        float y = (float)val_float(val_field(v, val_id("y")));
        float z = (float)val_float(val_field(v, val_id("z")));
        float w = (float)val_float(val_field(v, val_id("w")));
        glVertexAttrib4f(index, x, y, z, w);
    }

    void gl_vertexAttrib1fv(int index, value values)
    {
        int count = val_array_size(values);
        GLfloat *arr = new GLfloat[count];
        for (int i = 0; i < count; i++)
        {
            arr[i] = (GLfloat)val_float(val_array_i(values, i));
        }
        glVertexAttrib1fv(index, arr);
        delete[] arr;
    }

    void gl_vertexAttrib2fv(int index, value v)
    {
        float x = (float)val_float(val_field(v, val_id("x")));
        float y = (float)val_float(val_field(v, val_id("y")));
        GLfloat data[2] = {x, y};
        glVertexAttrib2fv(index, data);
    }

    void gl_vertexAttrib3fv(int index, value v)
    {
        float x = (float)val_float(val_field(v, val_id("x")));
        float y = (float)val_float(val_field(v, val_id("y")));
        float z = (float)val_float(val_field(v, val_id("z")));
        GLfloat data[3] = {x, y, z};
        glVertexAttrib3fv(index, data);
    }

    void gl_vertexAttrib4fv(int index, value v)
    {
        float x = (float)val_float(val_field(v, val_id("x")));
        float y = (float)val_float(val_field(v, val_id("y")));
        float z = (float)val_float(val_field(v, val_id("z")));
        float w = (float)val_float(val_field(v, val_id("w")));
        GLfloat data[4] = {x, y, z, w};
        glVertexAttrib4fv(index, data);
    }

    void gl_vertexAttrib4d(int index, double x, double y, double z, double w)
    {
        glVertexAttrib4d(index, x, y, z, w);
    }

    void gl_vertexAttrib4dv(int index, value v)
    {
        double x = val_float(val_field(v, val_id("x")));
        double y = val_float(val_field(v, val_id("y")));
        double z = val_float(val_field(v, val_id("z")));
        double w = val_float(val_field(v, val_id("w")));
        GLdouble data[4] = {x, y, z, w};
        glVertexAttrib4dv(index, data);
    }

    void gl_vertexAttrib4s(int index, int x, int y, int z, int w)
    {
        glVertexAttrib4s(index, x, y, z, w);
    }

    void gl_vertexAttrib4sv(int index, value values)
    {
        int count = val_array_size(values);
        GLshort *arr = new GLshort[count];
        for (int i = 0; i < count; i++)
        {
            arr[i] = (GLshort)val_int(val_array_i(values, i));
        }
        glVertexAttrib4sv(index, arr);
        delete[] arr;
    }

    void gl_vertexAttrib4Nbv(int index, value values)
    {
        int count = val_array_size(values);
        GLbyte *arr = new GLbyte[count];
        for (int i = 0; i < count; i++)
        {
            arr[i] = (GLbyte)val_int(val_array_i(values, i));
        }
        glVertexAttrib4Nbv(index, arr);
        delete[] arr;
    }

    void gl_vertexAttrib4Nsv(int index, value values)
    {
        int count = val_array_size(values);
        GLshort *arr = new GLshort[count];
        for (int i = 0; i < count; i++)
        {
            arr[i] = (GLshort)val_int(val_array_i(values, i));
        }
        glVertexAttrib4Nsv(index, arr);
        delete[] arr;
    }

    void gl_vertexAttrib4Niv(int index, value values)
    {
        int count = val_array_size(values);
        GLint *arr = new GLint[count];
        for (int i = 0; i < count; i++)
        {
            arr[i] = (GLint)val_int(val_array_i(values, i));
        }
        glVertexAttrib4Niv(index, arr);
        delete[] arr;
    }

    void gl_vertexAttrib4Nub(int index, int x, int y, int z, int w)
    {
        glVertexAttrib4Nub(index, x, y, z, w);
    }

    void gl_vertexAttrib4Nubv(int index, value values)
    {
        int count = val_array_size(values);
        GLubyte *arr = new GLubyte[count];
        for (int i = 0; i < count; i++)
        {
            arr[i] = (GLubyte)val_int(val_array_i(values, i));
        }
        glVertexAttrib4Nubv(index, arr);
        delete[] arr;
    }

    void gl_vertexAttrib4Nuiv(int index, value values)
    {
        int count = val_array_size(values);
        GLuint *arr = new GLuint[count];
        for (int i = 0; i < count; i++)
        {
            arr[i] = (GLuint)val_int(val_array_i(values, i));
        }
        glVertexAttrib4Nuiv(index, arr);
        delete[] arr;
    }

    void gl_vertexAttrib4Nusv(int index, value values)
    {
        int count = val_array_size(values);
        GLushort *arr = new GLushort[count];
        for (int i = 0; i < count; i++)
        {
            arr[i] = (GLushort)val_int(val_array_i(values, i));
        }
        glVertexAttrib4Nusv(index, arr);
        delete[] arr;
    }

    void gl_vertexAttrib4bv(int index, value values)
    {
        int count = val_array_size(values);
        GLbyte *arr = new GLbyte[count];
        for (int i = 0; i < count; i++)
        {
            arr[i] = (GLbyte)val_int(val_array_i(values, i));
        }
        glVertexAttrib4bv(index, arr);
        delete[] arr;
    }

    void gl_vertexAttrib4iv(int index, value values)
    {
        int count = val_array_size(values);
        GLint *arr = new GLint[count];
        for (int i = 0; i < count; i++)
        {
            arr[i] = (GLint)val_int(val_array_i(values, i));
        }
        glVertexAttrib4iv(index, arr);
        delete[] arr;
    }

    void gl_vertexAttrib4ubv(int index, value values)
    {
        int count = val_array_size(values);
        GLubyte *arr = new GLubyte[count];
        for (int i = 0; i < count; i++)
        {
            arr[i] = (GLubyte)val_int(val_array_i(values, i));
        }
        glVertexAttrib4ubv(index, arr);
        delete[] arr;
    }

    void gl_vertexAttrib4uiv(int index, value values)
    {
        int count = val_array_size(values);
        GLuint *arr = new GLuint[count];
        for (int i = 0; i < count; i++)
        {
            arr[i] = (GLuint)val_int(val_array_i(values, i));
        }
        glVertexAttrib4uiv(index, arr);
        delete[] arr;
    }

    void gl_vertexAttrib4usv(int index, value values)
    {
        int count = val_array_size(values);
        GLushort *arr = new GLushort[count];
        for (int i = 0; i < count; i++)
        {
            arr[i] = (GLushort)val_int(val_array_i(values, i));
        }
        glVertexAttrib4usv(index, arr);
        delete[] arr;
    }

    void gl_vertexAttribPointer(int index, int size, int type, bool normalized, int stride, int offset)
    {
        glVertexAttribPointer(index, size, type, normalized, stride, (void *)(uintptr_t)offset);
    }

    void gl_uniformMatrix2x3fv(int location, bool transpose, value values)
    {
        int count = val_array_size(values);
        GLfloat *arr = new GLfloat[count];
        for (int i = 0; i < count; i++)
        {
            arr[i] = (GLfloat)val_float(val_array_i(values, i));
        }
        glUniformMatrix2x3fv(location, 1, transpose, arr);
        delete[] arr;
    }

    void gl_uniformMatrix3x2fv(int location, bool transpose, value values)
    {
        int count = val_array_size(values);
        GLfloat *arr = new GLfloat[count];
        for (int i = 0; i < count; i++)
        {
            arr[i] = (GLfloat)val_float(val_array_i(values, i));
        }
        glUniformMatrix3x2fv(location, 1, transpose, arr);
        delete[] arr;
    }

    void gl_uniformMatrix2x4fv(int location, bool transpose, value values)
    {
        int count = val_array_size(values);
        GLfloat *arr = new GLfloat[count];
        for (int i = 0; i < count; i++)
        {
            arr[i] = (GLfloat)val_float(val_array_i(values, i));
        }
        glUniformMatrix2x4fv(location, 1, transpose, arr);
        delete[] arr;
    }

    void gl_uniformMatrix4x2fv(int location, bool transpose, value values)
    {
        int count = val_array_size(values);
        GLfloat *arr = new GLfloat[count];
        for (int i = 0; i < count; i++)
        {
            arr[i] = (GLfloat)val_float(val_array_i(values, i));
        }
        glUniformMatrix4x2fv(location, 1, transpose, arr);
        delete[] arr;
    }

    void gl_uniformMatrix3x4fv(int location, bool transpose, value values)
    {
        int count = val_array_size(values);
        GLfloat *arr = new GLfloat[count];
        for (int i = 0; i < count; i++)
        {
            arr[i] = (GLfloat)val_float(val_array_i(values, i));
        }
        glUniformMatrix3x4fv(location, 1, transpose, arr);
        delete[] arr;
    }

    void gl_uniformMatrix4x3fv(int location, bool transpose, value values)
    {
        int count = val_array_size(values);
        GLfloat *arr = new GLfloat[count];
        for (int i = 0; i < count; i++)
        {
            arr[i] = (GLfloat)val_float(val_array_i(values, i));
        }
        glUniformMatrix4x3fv(location, 1, transpose, arr);
        delete[] arr;
    }

    void gl_colorMaski(int index, bool r, bool g, bool b, bool a)
    {
        glColorMaski(index, r, g, b, a);
    }

    value gl_getBooleani_v(int target, int index)
    {
        GLboolean v = 0;
        glGetBooleani_v(target, index, &v);
        return alloc_bool(v != 0);
    }

    value gl_getIntegeri_v(int target, int index)
    {
        GLint v = 0;
        glGetIntegeri_v(target, index, &v);
        return alloc_int(v);
    }

    void gl_enablei(int target, int index)
    {
        glEnablei(target, index);
    }

    void gl_disablei(int target, int index)
    {
        glDisablei(target, index);
    }

    value gl_isEnabledi(int target, int index)
    {
        return alloc_bool(glIsEnabledi(target, index) != 0);
    }

    void gl_beginTransformFeedback(int primitiveMode)
    {
        glBeginTransformFeedback(primitiveMode);
    }

    void gl_endTransformFeedback()
    {
        glEndTransformFeedback();
    }

    void gl_bindBufferRange(int target, int index, int buffer, int offset, int64_t size)
    {
        glBindBufferRange(target, index, buffer, offset, (GLsizeiptr)size);
    }

    void gl_bindBufferBase(int target, int index, int buffer)
    {
        glBindBufferBase(target, index, buffer);
    }

    value gl_genVertexArray()
    {
        GLuint vao = 0;
        glGenVertexArrays(1, &vao);
        return alloc_int(vao);
    }

    void gl_bindVertexArray(int vao)
    {
        glBindVertexArray(vao);
    }

    DEFINE_PRIM(gl_cullFace, 1);
    DEFINE_PRIM(gl_frontFace, 1);
    DEFINE_PRIM(gl_hint, 2);
    DEFINE_PRIM(gl_lineWidth, 1);
    DEFINE_PRIM(gl_pointSize, 1);
    DEFINE_PRIM(gl_polygonMode, 2);
    DEFINE_PRIM(gl_scissor, 4);

    DEFINE_PRIM(gl_texParameterf, 3);
    DEFINE_PRIM(gl_texParameteri, 3);
    DEFINE_PRIM(gl_texParameterfv, 3);
    DEFINE_PRIM(gl_texParameteriv, 3);
    DEFINE_PRIM_MULT(gl_texImage1D);
    DEFINE_PRIM_MULT(gl_texImage2D);
    DEFINE_PRIM(gl_drawBuffer, 1);
    DEFINE_PRIM(gl_clear, 1);
    DEFINE_PRIM(gl_clearColor, 4);
    DEFINE_PRIM(gl_clearStencil, 1);
    DEFINE_PRIM(gl_clearDepth, 1);
    DEFINE_PRIM(gl_stencilMask, 1);
    DEFINE_PRIM(gl_colorMask, 4);
    DEFINE_PRIM(gl_depthMask, 1);
    DEFINE_PRIM(gl_disable, 1);
    DEFINE_PRIM(gl_enable, 1);
    DEFINE_PRIM(gl_finish, 0);
    DEFINE_PRIM(gl_flush, 0);
    DEFINE_PRIM(gl_blendFunc, 2);
    DEFINE_PRIM(gl_logicOp, 1);
    DEFINE_PRIM(gl_stencilFunc, 3);
    DEFINE_PRIM(gl_stencilOp, 3);
    DEFINE_PRIM(gl_depthFunc, 1);
    DEFINE_PRIM(gl_pixelStoref, 2);
    DEFINE_PRIM(gl_pixelStorei, 2);
    DEFINE_PRIM(gl_readBuffer, 1);
    DEFINE_PRIM_MULT(gl_readPixels);
    DEFINE_PRIM(gl_getBooleanv, 1);
    DEFINE_PRIM(gl_getDoublev, 1);
    DEFINE_PRIM(gl_getError, 0);
    DEFINE_PRIM(gl_getFloatv, 1);
    DEFINE_PRIM(gl_getIntegerv, 1);
    DEFINE_PRIM(gl_getString, 1);
    DEFINE_PRIM_MULT(gl_getTexImage);
    DEFINE_PRIM(gl_getTexParameterfv, 2);
    DEFINE_PRIM(gl_getTexParameteriv, 2);
    DEFINE_PRIM(gl_getTexLevelParameterfv, 3);
    DEFINE_PRIM(gl_getTexLevelParameteriv, 3);
    DEFINE_PRIM(gl_isEnabled, 1);
    DEFINE_PRIM(gl_depthRange, 2);
    DEFINE_PRIM(gl_viewport, 4);
    DEFINE_PRIM(gl_drawArrays, 3);
    DEFINE_PRIM(gl_drawElements, 4);
    DEFINE_PRIM(gl_polygonOffset, 2);
    DEFINE_PRIM_MULT(gl_copyTexImage1D);
    DEFINE_PRIM_MULT(gl_copyTexImage2D);
    DEFINE_PRIM_MULT(gl_copyTexSubImage1D);
    DEFINE_PRIM_MULT(gl_copyTexSubImage2D);
    DEFINE_PRIM_MULT(gl_copyTexSubImage3D);
    DEFINE_PRIM_MULT(gl_texSubImage1D);
    DEFINE_PRIM_MULT(gl_texSubImage2D);
    DEFINE_PRIM(gl_bindTexture, 2);
    DEFINE_PRIM(gl_deleteTextures, 2);
    DEFINE_PRIM(gl_genTextures, 2);
    DEFINE_PRIM(gl_genTexture, 0);
    DEFINE_PRIM(gl_isTexture, 1);
    DEFINE_PRIM_MULT(gl_drawRangeElements);
    DEFINE_PRIM_MULT(gl_texImage3D);
    DEFINE_PRIM_MULT(gl_texSubImage3D);
    DEFINE_PRIM(gl_activeTexture, 1);
    DEFINE_PRIM(gl_sampleCoverage, 2);
    DEFINE_PRIM_MULT(gl_compressedTexImage3D);
    DEFINE_PRIM_MULT(gl_compressedTexImage2D);
    DEFINE_PRIM_MULT(gl_compressedTexImage1D);
    DEFINE_PRIM_MULT(gl_compressedTexSubImage3D);
    DEFINE_PRIM_MULT(gl_compressedTexSubImage2D);
    DEFINE_PRIM_MULT(gl_compressedTexSubImage1D);
    DEFINE_PRIM(gl_getCompressedTexImage, 3);
    DEFINE_PRIM(gl_blendFuncSeparate, 4);
    DEFINE_PRIM(gl_multiDrawArrays, 4);
    DEFINE_PRIM(gl_pointParameterf, 2);
    DEFINE_PRIM(gl_pointParameterfv, 2);
    DEFINE_PRIM(gl_pointParameteri, 2);
    DEFINE_PRIM(gl_pointParameteriv, 2);
    DEFINE_PRIM(gl_blendColor, 4);
    DEFINE_PRIM(gl_blendEquation, 1);
    DEFINE_PRIM(gl_genQueries, 2);
    DEFINE_PRIM(gl_deleteQueries, 2);
    DEFINE_PRIM(gl_isQuery, 1);
    DEFINE_PRIM(gl_beginQuery, 2);
    DEFINE_PRIM(gl_endQuery, 1);
    DEFINE_PRIM(gl_getQueryiv, 3);
    DEFINE_PRIM(gl_getQueryObjectiv, 3);
    DEFINE_PRIM(gl_getQueryObjectuiv, 3);
    DEFINE_PRIM(gl_bindBuffer, 2);
    DEFINE_PRIM(gl_deleteBuffers, 2);
    DEFINE_PRIM(gl_genBuffer, 0);
    DEFINE_PRIM(gl_isBuffer, 1);
    DEFINE_PRIM(gl_bufferData, 4);
    DEFINE_PRIM(gl_bufferSubData, 4);
    DEFINE_PRIM(gl_getBufferSubData, 3);
    DEFINE_PRIM(gl_getBufferParameteriv, 2);
    DEFINE_PRIM(gl_blendEquationSeparate, 2);
    DEFINE_PRIM(gl_drawBuffers, 2);
    DEFINE_PRIM(gl_stencilOpSeparate, 4);
    DEFINE_PRIM(gl_stencilFuncSeparate, 4);
    DEFINE_PRIM(gl_stencilMaskSeparate, 2);
    DEFINE_PRIM(gl_attachShader, 2);
    DEFINE_PRIM(gl_bindAttribLocation, 3);
    DEFINE_PRIM(gl_compileShader, 1);
    DEFINE_PRIM(gl_createProgram, 0);
    DEFINE_PRIM(gl_createShader, 1);
    DEFINE_PRIM(gl_deleteProgram, 1);
    DEFINE_PRIM(gl_deleteShader, 1);
    DEFINE_PRIM(gl_detachShader, 2);
    DEFINE_PRIM(gl_disableVertexAttribArray, 1);
    DEFINE_PRIM(gl_enableVertexAttribArray, 1);
    DEFINE_PRIM(gl_getActiveAttrib, 3);
    DEFINE_PRIM(gl_getActiveUniform, 3);
    DEFINE_PRIM(gl_getAttachedShaders, 2);
    DEFINE_PRIM(gl_getAttribLocation, 2);
    DEFINE_PRIM(gl_getProgramiv, 2);
    DEFINE_PRIM(gl_getProgramInfoLog, 1);
    DEFINE_PRIM(gl_getShaderiv, 2);
    DEFINE_PRIM(gl_getShaderInfoLog, 1);
    DEFINE_PRIM(gl_getShaderSource, 1);
    DEFINE_PRIM(gl_getUniformLocation, 2);
    DEFINE_PRIM(gl_getUniformfv, 2);
    DEFINE_PRIM(gl_getUniformiv, 2);
    DEFINE_PRIM(gl_getVertexAttribiv, 2);
    DEFINE_PRIM(gl_getVertexAttribfv, 2);
    DEFINE_PRIM(gl_getVertexAttribdv, 2);
    DEFINE_PRIM(gl_isProgram, 1);
    DEFINE_PRIM(gl_isShader, 1);
    DEFINE_PRIM(gl_linkProgram, 1);
    DEFINE_PRIM(gl_useProgram, 1);
    DEFINE_PRIM(gl_validateProgram, 1);
    DEFINE_PRIM(gl_shaderSource, 2);
    DEFINE_PRIM(gl_uniform1fv, 2);
    DEFINE_PRIM(gl_uniform2fv, 2);
    DEFINE_PRIM(gl_uniform3fv, 2);
    DEFINE_PRIM(gl_uniform4fv, 2);
    DEFINE_PRIM(gl_uniformMatrix3fv, 3);
    DEFINE_PRIM(gl_uniformMatrix4fv, 3);
    DEFINE_PRIM(gl_vertexAttrib1f, 2);
    DEFINE_PRIM(gl_vertexAttrib2f, 2);
    DEFINE_PRIM(gl_vertexAttrib3f, 2);
    DEFINE_PRIM(gl_vertexAttrib4f, 2);
    DEFINE_PRIM(gl_vertexAttrib1fv, 2);
    DEFINE_PRIM(gl_vertexAttrib2fv, 2);
    DEFINE_PRIM(gl_vertexAttrib3fv, 2);
    DEFINE_PRIM(gl_vertexAttrib4fv, 2);
    DEFINE_PRIM(gl_vertexAttrib4d, 5);
    DEFINE_PRIM(gl_vertexAttrib4dv, 2);
    DEFINE_PRIM(gl_vertexAttrib4s, 5);
    DEFINE_PRIM(gl_vertexAttrib4sv, 2);
    DEFINE_PRIM(gl_vertexAttrib4Nbv, 2);
    DEFINE_PRIM(gl_vertexAttrib4Nsv, 2);
    DEFINE_PRIM(gl_vertexAttrib4Niv, 2);
    DEFINE_PRIM(gl_vertexAttrib4Nub, 5);
    DEFINE_PRIM(gl_vertexAttrib4Nubv, 2);
    DEFINE_PRIM(gl_vertexAttrib4Nuiv, 2);
    DEFINE_PRIM(gl_vertexAttrib4Nusv, 2);
    DEFINE_PRIM(gl_vertexAttrib4bv, 2);
    DEFINE_PRIM(gl_vertexAttrib4iv, 2);
    DEFINE_PRIM(gl_vertexAttrib4ubv, 2);
    DEFINE_PRIM(gl_vertexAttrib4uiv, 2);
    DEFINE_PRIM(gl_vertexAttrib4usv, 2);
    DEFINE_PRIM_MULT(gl_vertexAttribPointer);
    DEFINE_PRIM(gl_uniformMatrix2x3fv, 3);
    DEFINE_PRIM(gl_uniformMatrix3x2fv, 3);
    DEFINE_PRIM(gl_uniformMatrix2x4fv, 3);
    DEFINE_PRIM(gl_uniformMatrix4x2fv, 3);
    DEFINE_PRIM(gl_uniformMatrix3x4fv, 3);
    DEFINE_PRIM(gl_uniformMatrix4x3fv, 3);
    DEFINE_PRIM(gl_colorMaski, 5);
    DEFINE_PRIM(gl_getBooleani_v, 2);
    DEFINE_PRIM(gl_getIntegeri_v, 2);
    DEFINE_PRIM(gl_enablei, 2);
    DEFINE_PRIM(gl_disablei, 2);
    DEFINE_PRIM(gl_isEnabledi, 2);
    DEFINE_PRIM(gl_beginTransformFeedback, 1);
    DEFINE_PRIM(gl_endTransformFeedback, 0);
    DEFINE_PRIM(gl_bindBufferRange, 5);
    DEFINE_PRIM(gl_bindBufferBase, 3);
    DEFINE_PRIM(gl_genVertexArray, 0);
    DEFINE_PRIM(gl_bindVertexArray, 1);
}