package tuna.backend.cffi;

@:build(tuna.backend.macro.CFFIMacro.build("tuna"))
class NativeOpenGLCFFI {
	public static function gl_cullFace(mode:Int):Void;

	public static function gl_frontFace(mode:Int):Void;

	public static function gl_hint(target:Int, mode:Int):Void;

	public static function gl_lineWidth(width:Float):Void;

	public static function gl_pointSize(size:Float):Void;

	public static function gl_polygonMode(face:Int, mode:Int):Void;

	public static function gl_scissor(x:Int, y:Int, width:Int, height:Int):Void;

	public static function gl_texParameterf(target:Int, pname:Int, param:Float):Void;

	public static function gl_texParameteri(target:Int, pname:Int, param:Int):Void;

	public static function gl_texParameterfv(target:Int, pname:Int, haxeArray:Array<Float>):Void;

	public static function gl_texParameteriv(target:Int, pname:Int, haxeArray:Array<Int>):Void;

	public static function gl_texImage1D(target:Int, level:Int, internalFormat:Int, width:Int, border:Int, format:Int, type:Int, pixels:haxe.io.Bytes):Void;

	public static function gl_texImage2D(target:Int, level:Int, internalFormat:Int, width:Int, height:Int, border:Int, format:Int, type:Int, pixels:haxe.io.Bytes):Void;

	public static function gl_drawBuffer(buf:Int):Void;

	public static function gl_clear(mask:Int):Void;

	public static function gl_clearColor(red:Float, green:Float, blue:Float, alpha:Float):Void;

	public static function gl_clearStencil(s:Int):Void;

	public static function gl_clearDepth(depth:Float):Void;

	public static function gl_stencilMask(mask:Int):Void;

	public static function gl_colorMask(red:Bool, green:Bool, blue:Bool, alpha:Bool):Void;

	public static function gl_depthMask(Bool):Void;

	public static function gl_disable(cap:Int):Void;

	public static function gl_enable(cap:Int):Void;

	public static function gl_finish():Void;

	public static function gl_flush():Void;

	public static function gl_blendFunc(sfactor:Int, dfactor:Int):Void;

	public static function gl_logicOp(opcode:Int):Void;

	public static function gl_stencilFunc(func:Int, ref:Int, mask:Int):Void;

	public static function gl_stencilOp(fail:Int, zfail:Int, zpass:Int):Void;

	public static function gl_depthFunc(func:Int):Void;

	public static function gl_pixelStoref(pname:Int, param:Float):Void;

	public static function gl_pixelStorei(pname:Int, param:Int):Void;

	public static function gl_readBuffer(src:Int):Void;

	public static function gl_readPixels(x:Int, y:Int, width:Int, height:Int, format:Int, type:Int):haxe.io.Bytes;

	public static function gl_getBooleanv(pname:Int):Bool;

	public static function gl_getDoublev(pname:Int):Float;

	public static function gl_getError():Int;

	public static function gl_getFloatv(pname:Int):Float;

	public static function gl_getIntegerv(pname:Int):Int;

	public static function gl_getString(name:Int):String;

	public static function gl_getTexImage(target:Int, level:Int, format:Int, type:Int, width:Int, height:Int):haxe.io.Bytes;

	public static function gl_getTexParameterfv(target:Int, pname:Int):Array<Float>;

	public static function gl_getTexParameteriv(target:Int, pname:Int):Array<Int>;

	public static function gl_getTexLevelParameterfv(target:Int, level:Int, pname:Int):Array<Float>;

	public static function gl_getTexLevelParameteriv(target:Int, level:Int, pname:Int):Array<Int>;

	public static function gl_isEnabled(cap:Int):Bool;

	public static function gl_depthRange(n:Float, f:Float):Void;

	public static function gl_viewport(x:Int, y:Int, width:Int, height:Int):Void;

	public static function gl_drawArrays(mode:Int, first:Int, count:Int):Void;

	public static function gl_drawElements(mode:Int, count:Int, type:Int, offset:Int):Void;

	public static function gl_polygonOffset(factor:Float, units:Float):Void;

	public static function gl_copyTexImage1D(target:Int, level:Int, internalFormat:Int, x:Int, y:Int, width:Int, border:Int):Void;

	public static function gl_copyTexImage2D(target:Int, level:Int, internalFormat:Int, x:Int, y:Int, width:Int, height:Int, border:Int):Void;

	public static function gl_copyTexSubImage1D(target:Int, level:Int, xoffset:Int, x:Int, y:Int, width:Int):Void;

	public static function gl_copyTexSubImage2D(target:Int, level:Int, xoffset:Int, yoffset:Int, x:Int, y:Int, width:Int, height:Int):Void;

	public static function gl_copyTexSubImage3D(target:Int, level:Int, xoffset:Int, yoffset:Int, zoffset:Int, x:Int, y:Int, width:Int, height:Int):Void;

	public static function gl_texSubImage1D(target:Int, level:Int, xOffset:Int, width:Int, format:Int, type:Int, pixels:haxe.io.Bytes):Void;

	public static function gl_texSubImage2D(target:Int, level:Int, xOffset:Int, yOffset:Int, width:Int, height:Int, format:Int, type:Int, pixels:haxe.io.Bytes):Void;

	public static function gl_bindTexture(target:Int, texture:Int):Void;

	public static function gl_deleteTextures(n:Int, textures:Array<Int>):Void;

	public static function gl_genTextures(n:Int, textures:Array<Int>):Void;

	public static function gl_genTexture():Int;

	public static function gl_isTexture(texture:Int):Bool;

	public static function gl_drawRangeElements(mode:Int, start:Int, end:Int, count:Int, type:Int, indices:Int):Void;

	public static function gl_texImage3D(target:Int, level:Int, internalFormat:Int, width:Int, height:Int, depth:Int, border:Int, format:Int, type:Int, pixels:haxe.io.Bytes):Void;

	public static function gl_texSubImage3D(target:Int, level:Int, xOffset:Int, yOffset:Int, zOffset:Int, width:Int, height:Int, depth:Int, format:Int, type:Int, pixels:haxe.io.Bytes):Void;

	public static function gl_activeTexture(texture:Int):Void;

	public static function gl_sampleCoverage(value:Float, invert:Bool):Void;

	public static function gl_compressedTexImage3D(target:Int, level:Int, internalFormat:Int, width:Int, height:Int, depth:Int, border:Int, imageSize:Int, data:haxe.io.Bytes):Void;

	public static function gl_compressedTexImage2D(target:Int, level:Int, internalFormat:Int, width:Int, height:Int, border:Int, imageSize:Int, data:haxe.io.Bytes):Void;

	public static function gl_compressedTexImage1D(target:Int, level:Int, internalFormat:Int, width:Int, border:Int, imageSize:Int, data:haxe.io.Bytes):Void;

	public static function gl_compressedTexSubImage3D(target:Int, level:Int, xOffset:Int, yOffset:Int, depthOffset:Int, width:Int, height:Int, depth:Int, format:Int, imageSize:Int, data:haxe.io.Bytes):Void;

	public static function gl_compressedTexSubImage2D(target:Int, level:Int, xOffset:Int, yOffset:Int, width:Int, height:Int, format:Int, imageSize:Int, data:haxe.io.Bytes):Void;

	public static function gl_compressedTexSubImage1D(target:Int, level:Int, xOffset:Int, width:Int, format:Int, imageSize:Int, data:haxe.io.Bytes):Void;

	public static function gl_getCompressedTexImage(target:Int, level:Int, pixels:haxe.io.Bytes):Void;

	public static function gl_blendFuncSeparate(sfactorRGB:Int, dfactorRGB:Int, sfactorAlpha:Int, dfactorAlpha:Int):Void;

	public static function gl_multiDrawArrays(mode:Int, first:Array<Int>, count:Array<Int>, drawcount:Int):Void;

	public static function gl_pointParameterf(pname:Int, param:Float):Void;

	public static function gl_pointParameterfv(pname:Int, params:Array<Float>):Void;

	public static function gl_pointParameteri(pname:Int, param:Int):Void;

	public static function gl_pointParameteriv(pname:Int, params:Array<Int>):Void;

	public static function gl_blendColor(red:Float, green:Float, blue:Float, alpha:Float):Void;

	public static function gl_blendEquation(mode:Int):Void;

	public static function gl_genQueries(n:Int, ids:Array<Int>):Void;

	public static function gl_deleteQueries(n:Int, ids:Array<Int>):Void;

	public static function gl_isQuery(id:Int):Bool;

	public static function gl_beginQuery(target:Int, id:Int):Void;

	public static function gl_endQuery(target:Int):Void;

	public static function gl_getQueryiv(target:Int, pname:Int, params:Array<Int>):Void;

	public static function gl_getQueryObjectiv(id:Int, pname:Int, params:Array<Int>):Void;

	public static function gl_getQueryObjectuiv(id:Int, pname:Int, params:Array<Int>):Void;

	public static function gl_bindBuffer(target:Int, buffer:Int):Void;

	public static function gl_deleteBuffers(n:Int, buffers:Array<Int>):Void;

	public static function gl_genBuffer():Int;

	public static function gl_isBuffer(buffer:Int):Bool;

	public static function gl_bufferData(target:Int, size:Int, data:haxe.io.Bytes, usage:Int):Void;

	public static function gl_bufferSubData(target:Int, offset:Int, size:Int, data:haxe.io.Bytes):Void;

	public static function gl_getBufferSubData(target:Int, offset:Int, size:Int):haxe.io.Bytes;

	public static function gl_getBufferParameteriv(target:Int, pname:Int):Int;

	public static function gl_blendEquationSeparate(modeRGB:Int, modeAlpha:Int):Void;

	public static function gl_drawBuffers(n:Int, buffers:Array<Int>):Void;

	public static function gl_stencilOpSeparate(face:Int, sfail:Int, dpfail:Int, dppass:Int):Void;

	public static function gl_stencilFuncSeparate(face:Int, func:Int, ref:Int, mask:Int):Void;

	public static function gl_stencilMaskSeparate(face:Int, mask:Int):Void;

	public static function gl_attachShader(program:Int, shader:Int):Void;

	public static function gl_bindAttribLocation(program:Int, index:Int, name:String):Void;

	public static function gl_compileShader(shader:Int):Void;

	public static function gl_createProgram():Int;

	public static function gl_createShader(type:Int):Int;

	public static function gl_deleteProgram(program:Int):Void;

	public static function gl_deleteShader(shader:Int):Void;

	public static function gl_detachShader(program:Int, shader:Int):Void;

	public static function gl_disableVertexAttribArray(index:Int):Void;

	public static function gl_enableVertexAttribArray(index:Int):Void;

	public static function gl_getActiveAttrib(program:Int, index:Int, bufSize:Int):Dynamic;

	public static function gl_getActiveUniform(program:Int, index:Int, bufSize:Int):Dynamic;

	public static function gl_getAttachedShaders(program:Int, maxCount:Int):Dynamic;

	public static function gl_getAttribLocation(program:Int, name:String):Int;

	public static function gl_getProgramiv(program:Int, pname:Int):Int;

	public static function gl_getProgramInfoLog(program:Int):String;

	public static function gl_getShaderiv(shader:Int, pname:Int):Int;

	public static function gl_getShaderInfoLog(shader:Int):String;

	public static function gl_getShaderSource(shader:Int):String;

	public static function gl_getUniformLocation(program:Int, name:String):Int;

	public static function gl_getUniformfv(program:Int, location:Int):Array<Float>;

	public static function gl_getUniformiv(program:Int, location:Int):Array<Int>;

	public static function gl_getVertexAttribiv(index:Int, pname:Int):Int;

	public static function gl_getVertexAttribfv(index:Int, pname:Int):Array<Float>;

	public static function gl_getVertexAttribdv(index:Int, pname:Int):Array<Float>;

	public static function gl_isProgram(program:Int):Bool;

	public static function gl_isShader(shader:Int):Bool;

	public static function gl_linkProgram(program:Int):Void;

	public static function gl_useProgram(program:Int):Void;

	public static function gl_validateProgram(program:Int):Void;

	public static function gl_shaderSource(shader:Int, source:String):Void;

	public static function gl_uniform1fv(location:Int, values:Array<Float>):Void;

	public static function gl_uniform2fv(location:Int, v:Dynamic):Void;

	public static function gl_uniform3fv(location:Int, v:Dynamic):Void;

	public static function gl_uniform4fv(location:Int, v:Dynamic):Void;

	public static function gl_uniformMatrix3fv(location:Int, transpose:Bool, mat:Array<Float>):Void;

	public static function gl_uniformMatrix4fv(location:Int, transpose:Bool, mat:Array<Float>):Void;

	public static function gl_vertexAttrib1f(index:Int, x:Float):Void;

	public static function gl_vertexAttrib2f(index:Int, v:Dynamic):Void;

	public static function gl_vertexAttrib3f(index:Int, v:Dynamic):Void;

	public static function gl_vertexAttrib4f(index:Int, v:Dynamic):Void;

	public static function gl_vertexAttrib1fv(index:Int, values:Array<Float>):Void;

	public static function gl_vertexAttrib2fv(index:Int, v:Dynamic):Void;

	public static function gl_vertexAttrib3fv(index:Int, v:Dynamic):Void;

	public static function gl_vertexAttrib4fv(index:Int, v:Dynamic):Void;

	public static function gl_vertexAttrib4d(index:Int, x:Float, y:Float, z:Float, w:Float):Void;

	public static function gl_vertexAttrib4dv(index:Int, v:Dynamic):Void;

	public static function gl_vertexAttrib4s(index:Int, x:Int, y:Int, z:Int, w:Int):Void;

	public static function gl_vertexAttrib4sv(index:Int, values:Array<Int>):Void;

	public static function gl_vertexAttrib4Nbv(index:Int, values:Array<Int>):Void;

	public static function gl_vertexAttrib4Nsv(index:Int, values:Array<Int>):Void;

	public static function gl_vertexAttrib4Niv(index:Int, values:Array<Int>):Void;

	public static function gl_vertexAttrib4Nub(index:Int, x:Int, y:Int, z:Int, w:Int):Void;

	public static function gl_vertexAttrib4Nubv(index:Int, values:Array<Int>):Void;

	public static function gl_vertexAttrib4Nuiv(index:Int, values:Array<Int>):Void;

	public static function gl_vertexAttrib4Nusv(index:Int, values:Array<Int>):Void;

	public static function gl_vertexAttrib4bv(index:Int, values:Array<Int>):Void;

	public static function gl_vertexAttrib4iv(index:Int, values:Array<Int>):Void;

	public static function gl_vertexAttrib4ubv(index:Int, values:Array<Int>):Void;

	public static function gl_vertexAttrib4uiv(index:Int, values:Array<Int>):Void;

	public static function gl_vertexAttrib4usv(index:Int, values:Array<Int>):Void;

	public static function gl_vertexAttribPointer(index:Int, size:Int, type:Int, normalized:Bool, stride:Int, offset:Int):Void;

	public static function gl_uniformMatrix2x3fv(location:Int, transpose:Bool, values:Array<Float>):Void;

	public static function gl_uniformMatrix3x2fv(location:Int, transpose:Bool, values:Array<Float>):Void;

	public static function gl_uniformMatrix2x4fv(location:Int, transpose:Bool, values:Array<Float>):Void;

	public static function gl_uniformMatrix4x2fv(location:Int, transpose:Bool, values:Array<Float>):Void;

	public static function gl_uniformMatrix3x4fv(location:Int, transpose:Bool, values:Array<Float>):Void;

	public static function gl_uniformMatrix4x3fv(location:Int, transpose:Bool, values:Array<Float>):Void;

	public static function gl_colorMaski(index:Int, r:Bool, g:Bool, b:Bool, a:Bool):Void;

	public static function gl_getBooleani_v(target:Int, index:Int):Bool;

	public static function gl_getIntegeri_v(target:Int, index:Int):Int;

	public static function gl_enablei(target:Int, index:Int):Void;

	public static function gl_disablei(target:Int, index:Int):Void;

	public static function gl_isEnabledi(target:Int, index:Int):Bool;

	public static function gl_beginTransformFeedback(primitiveMode:Int):Void;

	public static function gl_endTransformFeedback():Void;

	public static function gl_bindBufferRange(target:Int, index:Int, buffer:Int, offset:Int, size:haxe.Int64):Void;

	public static function gl_bindBufferBase(target:Int, index:Int, buffer:Int):Void;

	public static function gl_genVertexArray():Int;

	public static function gl_bindVertexArray(vao:Int):Void;
}