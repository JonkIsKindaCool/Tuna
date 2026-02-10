package tuna.backend.opengl;

import haxe.Int64;
import tuna.math.Mat4;
import tuna.math.Mat3;
import tuna.math.Vec3;
import tuna.math.Vec2;
import tuna.math.Vec4;
import haxe.io.Bytes;
#if cpp
import cpp.NativeString;
import cpp.CastCharStar;
import cpp.RawPointer;
import cpp.ConstCharStar;
import cpp.Helpers;
import cpp.Star;
import cpp.Pointer;
import cpp.ConstStar;
import native.glad.Glad;
#end
#if (js || html5)
import js.lib.Uint8Array;
import js.lib.Int8Array;
import js.html.webgl.WebGL2RenderingContext;
#end

class GL {
	#if (js || html5)
	public static var context:WebGL2RenderingContext;
	#end

	public static inline var READ_BUFFER:Int = 3074;
	public static inline var UNPACK_ROW_LENGTH:Int = 3314;
	public static inline var UNPACK_SKIP_ROWS:Int = 3315;
	public static inline var UNPACK_SKIP_PIXELS:Int = 3316;
	public static inline var PACK_ROW_LENGTH:Int = 3330;
	public static inline var PACK_SKIP_ROWS:Int = 3331;
	public static inline var PACK_SKIP_PIXELS:Int = 3332;
	public static inline var COLOR:Int = 6144;
	public static inline var DEPTH:Int = 6145;
	public static inline var STENCIL:Int = 6146;
	public static inline var RED:Int = 6403;
	public static inline var RGB8:Int = 32849;
	public static inline var RGBA8:Int = 32856;
	public static inline var RGB10_A2:Int = 32857;
	public static inline var TEXTURE_BINDING_3D:Int = 32874;
	public static inline var UNPACK_SKIP_IMAGES:Int = 32877;
	public static inline var UNPACK_IMAGE_HEIGHT:Int = 32878;
	public static inline var TEXTURE_3D:Int = 32879;
	public static inline var TEXTURE_WRAP_R:Int = 32882;
	public static inline var MAX_3D_TEXTURE_SIZE:Int = 32883;
	public static inline var UNSIGNED_INT_2_10_10_10_REV:Int = 33640;
	public static inline var MAX_ELEMENTS_VERTICES:Int = 33000;
	public static inline var MAX_ELEMENTS_INDICES:Int = 33001;
	public static inline var TEXTURE_MIN_LOD:Int = 33082;
	public static inline var TEXTURE_MAX_LOD:Int = 33083;
	public static inline var TEXTURE_BASE_LEVEL:Int = 33084;
	public static inline var TEXTURE_MAX_LEVEL:Int = 33085;
	public static inline var MIN:Int = 32775;
	public static inline var MAX:Int = 32776;
	public static inline var DEPTH_COMPONENT24:Int = 33190;
	public static inline var MAX_TEXTURE_LOD_BIAS:Int = 34045;
	public static inline var TEXTURE_COMPARE_MODE:Int = 34892;
	public static inline var TEXTURE_COMPARE_FUNC:Int = 34893;
	public static inline var CURRENT_QUERY:Int = 34917;
	public static inline var QUERY_RESULT:Int = 34918;
	public static inline var QUERY_RESULT_AVAILABLE:Int = 34919;
	public static inline var STREAM_READ:Int = 35041;
	public static inline var STREAM_COPY:Int = 35042;
	public static inline var STATIC_READ:Int = 35045;
	public static inline var STATIC_COPY:Int = 35046;
	public static inline var DYNAMIC_READ:Int = 35049;
	public static inline var DYNAMIC_COPY:Int = 35050;
	public static inline var MAX_DRAW_BUFFERS:Int = 34852;
	public static inline var DRAW_BUFFER0:Int = 34853;
	public static inline var DRAW_BUFFER1:Int = 34854;
	public static inline var DRAW_BUFFER2:Int = 34855;
	public static inline var DRAW_BUFFER3:Int = 34856;
	public static inline var DRAW_BUFFER4:Int = 34857;
	public static inline var DRAW_BUFFER5:Int = 34858;
	public static inline var DRAW_BUFFER6:Int = 34859;
	public static inline var DRAW_BUFFER7:Int = 34860;
	public static inline var DRAW_BUFFER8:Int = 34861;
	public static inline var DRAW_BUFFER9:Int = 34862;
	public static inline var DRAW_BUFFER10:Int = 34863;
	public static inline var DRAW_BUFFER11:Int = 34864;
	public static inline var DRAW_BUFFER12:Int = 34865;
	public static inline var DRAW_BUFFER13:Int = 34866;
	public static inline var DRAW_BUFFER14:Int = 34867;
	public static inline var DRAW_BUFFER15:Int = 34868;
	public static inline var MAX_FRAGMENT_UNIFORM_COMPONENTS:Int = 35657;
	public static inline var MAX_VERTEX_UNIFORM_COMPONENTS:Int = 35658;
	public static inline var SAMPLER_3D:Int = 35679;
	public static inline var SAMPLER_2D_SHADOW:Int = 35682;
	public static inline var FRAGMENT_SHADER_DERIVATIVE_HINT:Int = 35723;
	public static inline var PIXEL_PACK_BUFFER:Int = 35051;
	public static inline var PIXEL_UNPACK_BUFFER:Int = 35052;
	public static inline var PIXEL_PACK_BUFFER_BINDING:Int = 35053;
	public static inline var PIXEL_UNPACK_BUFFER_BINDING:Int = 35055;
	public static inline var FLOAT_MAT2x3:Int = 35685;
	public static inline var FLOAT_MAT2x4:Int = 35686;
	public static inline var FLOAT_MAT3x2:Int = 35687;
	public static inline var FLOAT_MAT3x4:Int = 35688;
	public static inline var FLOAT_MAT4x2:Int = 35689;
	public static inline var FLOAT_MAT4x3:Int = 35690;
	public static inline var SRGB:Int = 35904;
	public static inline var SRGB8:Int = 35905;
	public static inline var SRGB8_ALPHA8:Int = 35907;
	public static inline var COMPARE_REF_TO_TEXTURE:Int = 34894;
	public static inline var RGBA32F:Int = 34836;
	public static inline var RGB32F:Int = 34837;
	public static inline var RGBA16F:Int = 34842;
	public static inline var RGB16F:Int = 34843;
	public static inline var VERTEX_ATTRIB_ARRAY_INTEGER:Int = 35069;
	public static inline var MAX_ARRAY_TEXTURE_LAYERS:Int = 35071;
	public static inline var MIN_PROGRAM_TEXEL_OFFSET:Int = 35076;
	public static inline var MAX_PROGRAM_TEXEL_OFFSET:Int = 35077;
	public static inline var MAX_VARYING_COMPONENTS:Int = 35659;
	public static inline var TEXTURE_2D_ARRAY:Int = 35866;
	public static inline var TEXTURE_BINDING_2D_ARRAY:Int = 35869;
	public static inline var R11F_G11F_B10F:Int = 35898;
	public static inline var UNSIGNED_INT_10F_11F_11F_REV:Int = 35899;
	public static inline var RGB9_E5:Int = 35901;
	public static inline var UNSIGNED_INT_5_9_9_9_REV:Int = 35902;
	public static inline var TRANSFORM_FEEDBACK_BUFFER_MODE:Int = 35967;
	public static inline var MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS:Int = 35968;
	public static inline var TRANSFORM_FEEDBACK_VARYINGS:Int = 35971;
	public static inline var TRANSFORM_FEEDBACK_BUFFER_START:Int = 35972;
	public static inline var TRANSFORM_FEEDBACK_BUFFER_SIZE:Int = 35973;
	public static inline var TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN:Int = 35976;
	public static inline var RASTERIZER_DISCARD:Int = 35977;
	public static inline var MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS:Int = 35978;
	public static inline var MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS:Int = 35979;
	public static inline var INTERLEAVED_ATTRIBS:Int = 35980;
	public static inline var SEPARATE_ATTRIBS:Int = 35981;
	public static inline var TRANSFORM_FEEDBACK_BUFFER:Int = 35982;
	public static inline var TRANSFORM_FEEDBACK_BUFFER_BINDING:Int = 35983;
	public static inline var RGBA32UI:Int = 36208;
	public static inline var RGB32UI:Int = 36209;
	public static inline var RGBA16UI:Int = 36214;
	public static inline var RGB16UI:Int = 36215;
	public static inline var RGBA8UI:Int = 36220;
	public static inline var RGB8UI:Int = 36221;
	public static inline var RGBA32I:Int = 36226;
	public static inline var RGB32I:Int = 36227;
	public static inline var RGBA16I:Int = 36232;
	public static inline var RGB16I:Int = 36233;
	public static inline var RGBA8I:Int = 36238;
	public static inline var RGB8I:Int = 36239;
	public static inline var RED_INTEGER:Int = 36244;
	public static inline var RGB_INTEGER:Int = 36248;
	public static inline var RGBA_INTEGER:Int = 36249;
	public static inline var SAMPLER_2D_ARRAY:Int = 36289;
	public static inline var SAMPLER_2D_ARRAY_SHADOW:Int = 36292;
	public static inline var SAMPLER_CUBE_SHADOW:Int = 36293;
	public static inline var UNSIGNED_INT_VEC2:Int = 36294;
	public static inline var UNSIGNED_INT_VEC3:Int = 36295;
	public static inline var UNSIGNED_INT_VEC4:Int = 36296;
	public static inline var INT_SAMPLER_2D:Int = 36298;
	public static inline var INT_SAMPLER_3D:Int = 36299;
	public static inline var INT_SAMPLER_CUBE:Int = 36300;
	public static inline var INT_SAMPLER_2D_ARRAY:Int = 36303;
	public static inline var UNSIGNED_INT_SAMPLER_2D:Int = 36306;
	public static inline var UNSIGNED_INT_SAMPLER_3D:Int = 36307;
	public static inline var UNSIGNED_INT_SAMPLER_CUBE:Int = 36308;
	public static inline var UNSIGNED_INT_SAMPLER_2D_ARRAY:Int = 36311;
	public static inline var DEPTH_COMPONENT32F:Int = 36012;
	public static inline var DEPTH32F_STENCIL8:Int = 36013;
	public static inline var FLOAT_32_UNSIGNED_INT_24_8_REV:Int = 36269;
	public static inline var FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING:Int = 33296;
	public static inline var FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE:Int = 33297;
	public static inline var FRAMEBUFFER_ATTACHMENT_RED_SIZE:Int = 33298;
	public static inline var FRAMEBUFFER_ATTACHMENT_GREEN_SIZE:Int = 33299;
	public static inline var FRAMEBUFFER_ATTACHMENT_BLUE_SIZE:Int = 33300;
	public static inline var FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE:Int = 33301;
	public static inline var FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE:Int = 33302;
	public static inline var FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE:Int = 33303;
	public static inline var FRAMEBUFFER_DEFAULT:Int = 33304;
	public static inline var UNSIGNED_INT_24_8:Int = 34042;
	public static inline var DEPTH24_STENCIL8:Int = 35056;
	public static inline var UNSIGNED_NORMALIZED:Int = 35863;
	public static inline var DRAW_FRAMEBUFFER_BINDING:Int = 36006;
	public static inline var READ_FRAMEBUFFER:Int = 36008;
	public static inline var DRAW_FRAMEBUFFER:Int = 36009;
	public static inline var READ_FRAMEBUFFER_BINDING:Int = 36010;
	public static inline var RENDERBUFFER_SAMPLES:Int = 36011;
	public static inline var FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER:Int = 36052;
	public static inline var MAX_COLOR_ATTACHMENTS:Int = 36063;
	public static inline var COLOR_ATTACHMENT1:Int = 36065;
	public static inline var COLOR_ATTACHMENT2:Int = 36066;
	public static inline var COLOR_ATTACHMENT3:Int = 36067;
	public static inline var COLOR_ATTACHMENT4:Int = 36068;
	public static inline var COLOR_ATTACHMENT5:Int = 36069;
	public static inline var COLOR_ATTACHMENT6:Int = 36070;
	public static inline var COLOR_ATTACHMENT7:Int = 36071;
	public static inline var COLOR_ATTACHMENT8:Int = 36072;
	public static inline var COLOR_ATTACHMENT9:Int = 36073;
	public static inline var COLOR_ATTACHMENT10:Int = 36074;
	public static inline var COLOR_ATTACHMENT11:Int = 36075;
	public static inline var COLOR_ATTACHMENT12:Int = 36076;
	public static inline var COLOR_ATTACHMENT13:Int = 36077;
	public static inline var COLOR_ATTACHMENT14:Int = 36078;
	public static inline var COLOR_ATTACHMENT15:Int = 36079;
	public static inline var FRAMEBUFFER_INCOMPLETE_MULTISAMPLE:Int = 36182;
	public static inline var MAX_SAMPLES:Int = 36183;
	public static inline var HALF_FLOAT:Int = 5131;
	public static inline var RG:Int = 33319;
	public static inline var RG_INTEGER:Int = 33320;
	public static inline var R8:Int = 33321;
	public static inline var RG8:Int = 33323;
	public static inline var R16F:Int = 33325;
	public static inline var R32F:Int = 33326;
	public static inline var RG16F:Int = 33327;
	public static inline var RG32F:Int = 33328;
	public static inline var R8I:Int = 33329;
	public static inline var R8UI:Int = 33330;
	public static inline var R16I:Int = 33331;
	public static inline var R16UI:Int = 33332;
	public static inline var R32I:Int = 33333;
	public static inline var R32UI:Int = 33334;
	public static inline var RG8I:Int = 33335;
	public static inline var RG8UI:Int = 33336;
	public static inline var RG16I:Int = 33337;
	public static inline var RG16UI:Int = 33338;
	public static inline var RG32I:Int = 33339;
	public static inline var RG32UI:Int = 33340;
	public static inline var VERTEX_ARRAY_BINDING:Int = 34229;
	public static inline var R8_SNORM:Int = 36756;
	public static inline var RG8_SNORM:Int = 36757;
	public static inline var RGB8_SNORM:Int = 36758;
	public static inline var RGBA8_SNORM:Int = 36759;
	public static inline var SIGNED_NORMALIZED:Int = 36764;
	public static inline var COPY_READ_BUFFER:Int = 36662;
	public static inline var COPY_WRITE_BUFFER:Int = 36663;
	public static inline var COPY_READ_BUFFER_BINDING:Int = 36662;
	public static inline var COPY_WRITE_BUFFER_BINDING:Int = 36663;
	public static inline var UNIFORM_BUFFER:Int = 35345;
	public static inline var UNIFORM_BUFFER_BINDING:Int = 35368;
	public static inline var UNIFORM_BUFFER_START:Int = 35369;
	public static inline var UNIFORM_BUFFER_SIZE:Int = 35370;
	public static inline var MAX_VERTEX_UNIFORM_BLOCKS:Int = 35371;
	public static inline var MAX_FRAGMENT_UNIFORM_BLOCKS:Int = 35373;
	public static inline var MAX_COMBINED_UNIFORM_BLOCKS:Int = 35374;
	public static inline var MAX_UNIFORM_BUFFER_BINDINGS:Int = 35375;
	public static inline var MAX_UNIFORM_BLOCK_SIZE:Int = 35376;
	public static inline var MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS:Int = 35377;
	public static inline var MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS:Int = 35379;
	public static inline var UNIFORM_BUFFER_OFFSET_ALIGNMENT:Int = 35380;
	public static inline var ACTIVE_UNIFORM_BLOCKS:Int = 35382;
	public static inline var UNIFORM_TYPE:Int = 35383;
	public static inline var UNIFORM_SIZE:Int = 35384;
	public static inline var UNIFORM_BLOCK_INDEX:Int = 35386;
	public static inline var UNIFORM_OFFSET:Int = 35387;
	public static inline var UNIFORM_ARRAY_STRIDE:Int = 35388;
	public static inline var UNIFORM_MATRIX_STRIDE:Int = 35389;
	public static inline var UNIFORM_IS_ROW_MAJOR:Int = 35390;
	public static inline var UNIFORM_BLOCK_BINDING:Int = 35391;
	public static inline var UNIFORM_BLOCK_DATA_SIZE:Int = 35392;
	public static inline var UNIFORM_BLOCK_ACTIVE_UNIFORMS:Int = 35394;
	public static inline var UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES:Int = 35395;
	public static inline var UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER:Int = 35396;
	public static inline var UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER:Int = 35398;
	public static inline var INVALID_INDEX:Int = cast 4294967295;
	public static inline var MAX_VERTEX_OUTPUT_COMPONENTS:Int = 37154;
	public static inline var MAX_FRAGMENT_INPUT_COMPONENTS:Int = 37157;
	public static inline var MAX_SERVER_WAIT_TIMEOUT:Int = 37137;
	public static inline var OBJECT_TYPE:Int = 37138;
	public static inline var SYNC_CONDITION:Int = 37139;
	public static inline var SYNC_STATUS:Int = 37140;
	public static inline var SYNC_FLAGS:Int = 37141;
	public static inline var SYNC_FENCE:Int = 37142;
	public static inline var SYNC_GPU_COMMANDS_COMPLETE:Int = 37143;
	public static inline var UNSIGNALED:Int = 37144;
	public static inline var SIGNALED:Int = 37145;
	public static inline var ALREADY_SIGNALED:Int = 37146;
	public static inline var TIMEOUT_EXPIRED:Int = 37147;
	public static inline var CONDITION_SATISFIED:Int = 37148;
	public static inline var WAIT_FAILED:Int = 37149;
	public static inline var SYNC_FLUSH_COMMANDS_BIT:Int = 1;
	public static inline var VERTEX_ATTRIB_ARRAY_DIVISOR:Int = 35070;
	public static inline var ANY_SAMPLES_PASSED:Int = 35887;
	public static inline var ANY_SAMPLES_PASSED_CONSERVATIVE:Int = 36202;
	public static inline var SAMPLER_BINDING:Int = 35097;
	public static inline var RGB10_A2UI:Int = 36975;
	public static inline var INT_2_10_10_10_REV:Int = 36255;
	public static inline var TRANSFORM_FEEDBACK:Int = 36386;
	public static inline var TRANSFORM_FEEDBACK_PAUSED:Int = 36387;
	public static inline var TRANSFORM_FEEDBACK_ACTIVE:Int = 36388;
	public static inline var TRANSFORM_FEEDBACK_BINDING:Int = 36389;
	public static inline var TEXTURE_IMMUTABLE_FORMAT:Int = 37167;
	public static inline var MAX_ELEMENT_INDEX:Int = 36203;
	public static inline var TEXTURE_IMMUTABLE_LEVELS:Int = 33503;
	public static inline var TIMEOUT_IGNORED:Int = -1;
	public static inline var MAX_CLIENT_WAIT_TIMEOUT_WEBGL:Int = 37447;
	public static inline var DEPTH_BUFFER_BIT:Int = 256;
	public static inline var STENCIL_BUFFER_BIT:Int = 1024;
	public static inline var COLOR_BUFFER_BIT:Int = 16384;
	public static inline var POINTS:Int = 0;
	public static inline var LINES:Int = 1;
	public static inline var LINE_LOOP:Int = 2;
	public static inline var LINE_STRIP:Int = 3;
	public static inline var TRIANGLES:Int = 4;
	public static inline var TRIANGLE_STRIP:Int = 5;
	public static inline var TRIANGLE_FAN:Int = 6;
	public static inline var ZERO:Int = 0;
	public static inline var ONE:Int = 1;
	public static inline var SRC_COLOR:Int = 768;
	public static inline var ONE_MINUS_SRC_COLOR:Int = 769;
	public static inline var SRC_ALPHA:Int = 770;
	public static inline var ONE_MINUS_SRC_ALPHA:Int = 771;
	public static inline var DST_ALPHA:Int = 772;
	public static inline var ONE_MINUS_DST_ALPHA:Int = 773;
	public static inline var DST_COLOR:Int = 774;
	public static inline var ONE_MINUS_DST_COLOR:Int = 775;
	public static inline var SRC_ALPHA_SATURATE:Int = 776;
	public static inline var FUNC_ADD:Int = 32774;
	public static inline var BLEND_EQUATION:Int = 32777;
	public static inline var BLEND_EQUATION_RGB:Int = 32777;
	public static inline var BLEND_EQUATION_ALPHA:Int = 34877;
	public static inline var FUNC_SUBTRACT:Int = 32778;
	public static inline var FUNC_REVERSE_SUBTRACT:Int = 32779;
	public static inline var BLEND_DST_RGB:Int = 32968;
	public static inline var BLEND_SRC_RGB:Int = 32969;
	public static inline var BLEND_DST_ALPHA:Int = 32970;
	public static inline var BLEND_SRC_ALPHA:Int = 32971;
	public static inline var CONSTANT_COLOR:Int = 32769;
	public static inline var ONE_MINUS_CONSTANT_COLOR:Int = 32770;
	public static inline var CONSTANT_ALPHA:Int = 32771;
	public static inline var ONE_MINUS_CONSTANT_ALPHA:Int = 32772;
	public static inline var BLEND_COLOR:Int = 32773;
	public static inline var ARRAY_BUFFER:Int = 34962;
	public static inline var ELEMENT_ARRAY_BUFFER:Int = 34963;
	public static inline var ARRAY_BUFFER_BINDING:Int = 34964;
	public static inline var ELEMENT_ARRAY_BUFFER_BINDING:Int = 34965;
	public static inline var STREAM_DRAW:Int = 35040;
	public static inline var STATIC_DRAW:Int = 35044;
	public static inline var DYNAMIC_DRAW:Int = 35048;
	public static inline var BUFFER_SIZE:Int = 34660;
	public static inline var BUFFER_USAGE:Int = 34661;
	public static inline var CURRENT_VERTEX_ATTRIB:Int = 34342;
	public static inline var FRONT:Int = 1028;
	public static inline var BACK:Int = 1029;
	public static inline var FRONT_AND_BACK:Int = 1032;
	public static inline var CULL_FACE:Int = 2884;
	public static inline var BLEND:Int = 3042;
	public static inline var DITHER:Int = 3024;
	public static inline var STENCIL_TEST:Int = 2960;
	public static inline var DEPTH_TEST:Int = 2929;
	public static inline var SCISSOR_TEST:Int = 3089;
	public static inline var POLYGON_OFFSET_FILL:Int = 32823;
	public static inline var SAMPLE_ALPHA_TO_COVERAGE:Int = 32926;
	public static inline var SAMPLE_COVERAGE:Int = 32928;
	public static inline var NO_ERROR:Int = 0;
	public static inline var INVALID_ENUM:Int = 1280;
	public static inline var INVALID_VALUE:Int = 1281;
	public static inline var INVALID_OPERATION:Int = 1282;
	public static inline var OUT_OF_MEMORY:Int = 1285;
	public static inline var CW:Int = 2304;
	public static inline var CCW:Int = 2305;
	public static inline var LINE_WIDTH:Int = 2849;
	public static inline var ALIASED_POINT_SIZE_RANGE:Int = 33901;
	public static inline var ALIASED_LINE_WIDTH_RANGE:Int = 33902;
	public static inline var CULL_FACE_MODE:Int = 2885;
	public static inline var FRONT_FACE:Int = 2886;
	public static inline var DEPTH_RANGE:Int = 2928;
	public static inline var DEPTH_WRITEMASK:Int = 2930;
	public static inline var DEPTH_CLEAR_VALUE:Int = 2931;
	public static inline var DEPTH_FUNC:Int = 2932;
	public static inline var STENCIL_CLEAR_VALUE:Int = 2961;
	public static inline var STENCIL_FUNC:Int = 2962;
	public static inline var STENCIL_FAIL:Int = 2964;
	public static inline var STENCIL_PASS_DEPTH_FAIL:Int = 2965;
	public static inline var STENCIL_PASS_DEPTH_PASS:Int = 2966;
	public static inline var STENCIL_REF:Int = 2967;
	public static inline var STENCIL_VALUE_MASK:Int = 2963;
	public static inline var STENCIL_WRITEMASK:Int = 2968;
	public static inline var STENCIL_BACK_FUNC:Int = 34816;
	public static inline var STENCIL_BACK_FAIL:Int = 34817;
	public static inline var STENCIL_BACK_PASS_DEPTH_FAIL:Int = 34818;
	public static inline var STENCIL_BACK_PASS_DEPTH_PASS:Int = 34819;
	public static inline var STENCIL_BACK_REF:Int = 36003;
	public static inline var STENCIL_BACK_VALUE_MASK:Int = 36004;
	public static inline var STENCIL_BACK_WRITEMASK:Int = 36005;
	public static inline var VIEWPORT:Int = 2978;
	public static inline var SCISSOR_BOX:Int = 3088;
	public static inline var COLOR_CLEAR_VALUE:Int = 3106;
	public static inline var COLOR_WRITEMASK:Int = 3107;
	public static inline var UNPACK_ALIGNMENT:Int = 3317;
	public static inline var PACK_ALIGNMENT:Int = 3333;
	public static inline var MAX_TEXTURE_SIZE:Int = 3379;
	public static inline var MAX_VIEWPORT_DIMS:Int = 3386;
	public static inline var SUBPIXEL_BITS:Int = 3408;
	public static inline var RED_BITS:Int = 3410;
	public static inline var GREEN_BITS:Int = 3411;
	public static inline var BLUE_BITS:Int = 3412;
	public static inline var ALPHA_BITS:Int = 3413;
	public static inline var DEPTH_BITS:Int = 3414;
	public static inline var STENCIL_BITS:Int = 3415;
	public static inline var POLYGON_OFFSET_UNITS:Int = 10752;
	public static inline var POLYGON_OFFSET_FACTOR:Int = 32824;
	public static inline var TEXTURE_BINDING_2D:Int = 32873;
	public static inline var SAMPLE_BUFFERS:Int = 32936;
	public static inline var SAMPLES:Int = 32937;
	public static inline var SAMPLE_COVERAGE_VALUE:Int = 32938;
	public static inline var SAMPLE_COVERAGE_INVERT:Int = 32939;
	public static inline var COMPRESSED_TEXTURE_FORMATS:Int = 34467;
	public static inline var DONT_CARE:Int = 4352;
	public static inline var FASTEST:Int = 4353;
	public static inline var NICEST:Int = 4354;
	public static inline var GENERATE_MIPMAP_HINT:Int = 33170;
	public static inline var BYTE:Int = 5120;
	public static inline var UNSIGNED_BYTE:Int = 5121;
	public static inline var SHORT:Int = 5122;
	public static inline var UNSIGNED_SHORT:Int = 5123;
	public static inline var INT:Int = 5124;
	public static inline var UNSIGNED_INT:Int = 5125;
	public static inline var FLOAT:Int = 5126;
	public static inline var DEPTH_COMPONENT:Int = 6402;
	public static inline var ALPHA:Int = 6406;
	public static inline var RGB:Int = 6407;
	public static inline var RGBA:Int = 6408;
	public static inline var LUMINANCE:Int = 6409;
	public static inline var LUMINANCE_ALPHA:Int = 6410;
	public static inline var UNSIGNED_SHORT_4_4_4_4:Int = 32819;
	public static inline var UNSIGNED_SHORT_5_5_5_1:Int = 32820;
	public static inline var UNSIGNED_SHORT_5_6_5:Int = 33635;
	public static inline var FRAGMENT_SHADER:Int = 35632;
	public static inline var VERTEX_SHADER:Int = 35633;
	public static inline var MAX_VERTEX_ATTRIBS:Int = 34921;
	public static inline var MAX_VERTEX_UNIFORM_VECTORS:Int = 36347;
	public static inline var MAX_VARYING_VECTORS:Int = 36348;
	public static inline var MAX_COMBINED_TEXTURE_IMAGE_UNITS:Int = 35661;
	public static inline var MAX_VERTEX_TEXTURE_IMAGE_UNITS:Int = 35660;
	public static inline var MAX_TEXTURE_IMAGE_UNITS:Int = 34930;
	public static inline var MAX_FRAGMENT_UNIFORM_VECTORS:Int = 36349;
	public static inline var SHADER_TYPE:Int = 35663;
	public static inline var DELETE_STATUS:Int = 35712;
	public static inline var LINK_STATUS:Int = 35714;
	public static inline var VALIDATE_STATUS:Int = 35715;
	public static inline var ATTACHED_SHADERS:Int = 35717;
	public static inline var ACTIVE_UNIFORMS:Int = 35718;
	public static inline var ACTIVE_ATTRIBUTES:Int = 35721;
	public static inline var SHADING_LANGUAGE_VERSION:Int = 35724;
	public static inline var CURRENT_PROGRAM:Int = 35725;
	public static inline var NEVER:Int = 512;
	public static inline var LESS:Int = 513;
	public static inline var EQUAL:Int = 514;
	public static inline var LEQUAL:Int = 515;
	public static inline var GREATER:Int = 516;
	public static inline var NOTEQUAL:Int = 517;
	public static inline var GEQUAL:Int = 518;
	public static inline var ALWAYS:Int = 519;
	public static inline var KEEP:Int = 7680;
	public static inline var REPLACE:Int = 7681;
	public static inline var INCR:Int = 7682;
	public static inline var DECR:Int = 7683;
	public static inline var INVERT:Int = 5386;
	public static inline var INCR_WRAP:Int = 34055;
	public static inline var DECR_WRAP:Int = 34056;
	public static inline var VENDOR:Int = 7936;
	public static inline var RENDERER:Int = 7937;
	public static inline var VERSION:Int = 7938;
	public static inline var NEAREST:Int = 9728;
	public static inline var LINEAR:Int = 9729;
	public static inline var NEAREST_MIPMAP_NEAREST:Int = 9984;
	public static inline var LINEAR_MIPMAP_NEAREST:Int = 9985;
	public static inline var NEAREST_MIPMAP_LINEAR:Int = 9986;
	public static inline var LINEAR_MIPMAP_LINEAR:Int = 9987;
	public static inline var TEXTURE_MAG_FILTER:Int = 10240;
	public static inline var TEXTURE_MIN_FILTER:Int = 10241;
	public static inline var TEXTURE_WRAP_S:Int = 10242;
	public static inline var TEXTURE_WRAP_T:Int = 10243;
	public static inline var TEXTURE_2D:Int = 3553;
	public static inline var TEXTURE:Int = 5890;
	public static inline var TEXTURE_CUBE_MAP:Int = 34067;
	public static inline var TEXTURE_BINDING_CUBE_MAP:Int = 34068;
	public static inline var TEXTURE_CUBE_MAP_POSITIVE_X:Int = 34069;
	public static inline var TEXTURE_CUBE_MAP_NEGATIVE_X:Int = 34070;
	public static inline var TEXTURE_CUBE_MAP_POSITIVE_Y:Int = 34071;
	public static inline var TEXTURE_CUBE_MAP_NEGATIVE_Y:Int = 34072;
	public static inline var TEXTURE_CUBE_MAP_POSITIVE_Z:Int = 34073;
	public static inline var TEXTURE_CUBE_MAP_NEGATIVE_Z:Int = 34074;
	public static inline var MAX_CUBE_MAP_TEXTURE_SIZE:Int = 34076;
	public static inline var TEXTURE0:Int = 33984;
	public static inline var TEXTURE1:Int = 33985;
	public static inline var TEXTURE2:Int = 33986;
	public static inline var TEXTURE3:Int = 33987;
	public static inline var TEXTURE4:Int = 33988;
	public static inline var TEXTURE5:Int = 33989;
	public static inline var TEXTURE6:Int = 33990;
	public static inline var TEXTURE7:Int = 33991;
	public static inline var TEXTURE8:Int = 33992;
	public static inline var TEXTURE9:Int = 33993;
	public static inline var TEXTURE10:Int = 33994;
	public static inline var TEXTURE11:Int = 33995;
	public static inline var TEXTURE12:Int = 33996;
	public static inline var TEXTURE13:Int = 33997;
	public static inline var TEXTURE14:Int = 33998;
	public static inline var TEXTURE15:Int = 33999;
	public static inline var TEXTURE16:Int = 34000;
	public static inline var TEXTURE17:Int = 34001;
	public static inline var TEXTURE18:Int = 34002;
	public static inline var TEXTURE19:Int = 34003;
	public static inline var TEXTURE20:Int = 34004;
	public static inline var TEXTURE21:Int = 34005;
	public static inline var TEXTURE22:Int = 34006;
	public static inline var TEXTURE23:Int = 34007;
	public static inline var TEXTURE24:Int = 34008;
	public static inline var TEXTURE25:Int = 34009;
	public static inline var TEXTURE26:Int = 34010;
	public static inline var TEXTURE27:Int = 34011;
	public static inline var TEXTURE28:Int = 34012;
	public static inline var TEXTURE29:Int = 34013;
	public static inline var TEXTURE30:Int = 34014;
	public static inline var TEXTURE31:Int = 34015;
	public static inline var ACTIVE_TEXTURE:Int = 34016;
	public static inline var REPEAT:Int = 10497;
	public static inline var CLAMP_TO_EDGE:Int = 33071;
	public static inline var MIRRORED_REPEAT:Int = 33648;
	public static inline var FLOAT_VEC2:Int = 35664;
	public static inline var FLOAT_VEC3:Int = 35665;
	public static inline var FLOAT_VEC4:Int = 35666;
	public static inline var INT_VEC2:Int = 35667;
	public static inline var INT_VEC3:Int = 35668;
	public static inline var INT_VEC4:Int = 35669;
	public static inline var BOOL:Int = 35670;
	public static inline var BOOL_VEC2:Int = 35671;
	public static inline var BOOL_VEC3:Int = 35672;
	public static inline var BOOL_VEC4:Int = 35673;
	public static inline var FLOAT_MAT2:Int = 35674;
	public static inline var FLOAT_MAT3:Int = 35675;
	public static inline var FLOAT_MAT4:Int = 35676;
	public static inline var SAMPLER_2D:Int = 35678;
	public static inline var SAMPLER_CUBE:Int = 35680;
	public static inline var VERTEX_ATTRIB_ARRAY_ENABLED:Int = 34338;
	public static inline var VERTEX_ATTRIB_ARRAY_SIZE:Int = 34339;
	public static inline var VERTEX_ATTRIB_ARRAY_STRIDE:Int = 34340;
	public static inline var VERTEX_ATTRIB_ARRAY_TYPE:Int = 34341;
	public static inline var VERTEX_ATTRIB_ARRAY_NORMALIZED:Int = 34922;
	public static inline var VERTEX_ATTRIB_ARRAY_POINTER:Int = 34373;
	public static inline var VERTEX_ATTRIB_ARRAY_BUFFER_BINDING:Int = 34975;
	public static inline var IMPLEMENTATION_COLOR_READ_TYPE:Int = 35738;
	public static inline var IMPLEMENTATION_COLOR_READ_FORMAT:Int = 35739;
	public static inline var COMPILE_STATUS:Int = 35713;
	public static inline var LOW_FLOAT:Int = 36336;
	public static inline var MEDIUM_FLOAT:Int = 36337;
	public static inline var HIGH_FLOAT:Int = 36338;
	public static inline var LOW_INT:Int = 36339;
	public static inline var MEDIUM_INT:Int = 36340;
	public static inline var HIGH_INT:Int = 36341;
	public static inline var FRAMEBUFFER:Int = 36160;
	public static inline var RENDERBUFFER:Int = 36161;
	public static inline var RGBA4:Int = 32854;
	public static inline var RGB5_A1:Int = 32855;
	public static inline var RGB565:Int = 36194;
	public static inline var DEPTH_COMPONENT16:Int = 33189;
	public static inline var STENCIL_INDEX8:Int = 36168;
	public static inline var DEPTH_STENCIL:Int = 34041;
	public static inline var RENDERBUFFER_WIDTH:Int = 36162;
	public static inline var RENDERBUFFER_HEIGHT:Int = 36163;
	public static inline var RENDERBUFFER_INTERNAL_FORMAT:Int = 36164;
	public static inline var RENDERBUFFER_RED_SIZE:Int = 36176;
	public static inline var RENDERBUFFER_GREEN_SIZE:Int = 36177;
	public static inline var RENDERBUFFER_BLUE_SIZE:Int = 36178;
	public static inline var RENDERBUFFER_ALPHA_SIZE:Int = 36179;
	public static inline var RENDERBUFFER_DEPTH_SIZE:Int = 36180;
	public static inline var RENDERBUFFER_STENCIL_SIZE:Int = 36181;
	public static inline var FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE:Int = 36048;
	public static inline var FRAMEBUFFER_ATTACHMENT_OBJECT_NAME:Int = 36049;
	public static inline var FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL:Int = 36050;
	public static inline var FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE:Int = 36051;
	public static inline var COLOR_ATTACHMENT0:Int = 36064;
	public static inline var DEPTH_ATTACHMENT:Int = 36096;
	public static inline var STENCIL_ATTACHMENT:Int = 36128;
	public static inline var DEPTH_STENCIL_ATTACHMENT:Int = 33306;
	public static inline var NONE:Int = 0;
	public static inline var FRAMEBUFFER_COMPLETE:Int = 36053;
	public static inline var FRAMEBUFFER_INCOMPLETE_ATTACHMENT:Int = 36054;
	public static inline var FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT:Int = 36055;
	public static inline var FRAMEBUFFER_INCOMPLETE_DIMENSIONS:Int = 36057;
	public static inline var FRAMEBUFFER_UNSUPPORTED:Int = 36061;
	public static inline var FRAMEBUFFER_BINDING:Int = 36006;
	public static inline var RENDERBUFFER_BINDING:Int = 36007;
	public static inline var MAX_RENDERBUFFER_SIZE:Int = 34024;
	public static inline var INVALID_FRAMEBUFFER_OPERATION:Int = 1286;
	public static inline var UNPACK_FLIP_Y_WEBGL:Int = 37440;
	public static inline var UNPACK_PREMULTIPLY_ALPHA_WEBGL:Int = 37441;
	public static inline var CONTEXT_LOST_WEBGL:Int = 37442;
	public static inline var UNPACK_COLORSPACE_CONVERSION_WEBGL:Int = 37443;
	public static inline var BROWSER_DEFAULT_WEBGL:Int = 37444;

	public static function cullFace(mode:Int) {
		#if cpp
		Glad.cullFace(mode);
		#elseif (js || html5)
		context.cullFace(mode);
		#end
	}

	public static function frontFace(mode:Int) {
		#if cpp
		Glad.frontFace(mode);
		#elseif (js || html5)
		context.frontFace(mode);
		#end
	}

	public static function hint(target:Int, mode:Int) {
		#if cpp
		Glad.hint(target, mode);
		#elseif (js || html5)
		context.hint(target, mode);
		#end
	}

	public static function lineWidth(width:Float) {
		#if cpp
		Glad.lineWidth(width);
		#elseif (js || html5)
		context.lineWidth(width);
		#end
	}

	public static function pointSize(size:Float) {
		#if cpp
		Glad.pointSize(size);
		#elseif (js || html5)
		throw "pointSize is not supported in WebGL/WebGL2. Set gl_PointSize in the vertex shader.";
		#end
	}

	public static function polygonMode(face:Int, mode:Int) {
		#if cpp
		Glad.polygonMode(face, mode);
		#elseif (js || html5)
		throw "polygonMode is not supported in WebGL/WebGL2.";
		#end
	}

	public static function scissor(x:Int, y:Int, width:Int, height:Int) {
		#if cpp
		Glad.scissor(x, y, width, height);
		#elseif (js || html5)
		context.scissor(x, y, width, height);
		#end
	}

	public static function texParameterf(target:Int, pname:Int, param:Float) {
		#if cpp
		Glad.texParameterf(target, pname, param);
		#elseif (js || html5)
		context.texParameterf(target, pname, param);
		#end
	}

	public static function texParameteri(target:Int, pname:Int, param:Int) {
		#if cpp
		Glad.texParameteri(target, pname, param);
		#elseif (js || html5)
		context.texParameteri(target, pname, param);
		#end
	}

	public static function texParameterfv(target:Int, pname:Int):Array<Float> {
		#if cpp
		var arr:Array<GlFloat> = [];
		Glad.texParameterfv(target, pname, untyped __cpp__("(const float*) {0}", RawPointer.addressOf(arr)));
		return cast arr;
		#elseif (js || html5)
		return [];
		#end
	}

	public static function texParameteriv(target:Int, pname:Int, params:Array<Int>) {
		#if cpp
		var ptr:ConstStar<Int> = Pointer.ofArray(params).ptr;
		Glad.texParameteriv(target, pname, ptr);
		#elseif (js || html5)
		throw "texParameteriv is not supported in WebGL. Use texParameteri individually.";
		#end
	}

	public static function texImage1D(target:Int, level:Int, internalFormat:Int, width:Int, border:Int, format:Int, type:Int, pixels:Bytes) {
		#if cpp
		var pixelsPointer:Pointer<UInt8> = Pointer.ofArray(pixels.getData());
		var ptr:ConstStar<cpp.Void> = untyped __cpp__("(const void*) {0}", pixelsPointer);
		Glad.texImage1D(target, level, internalFormat, width, border, format, type, ptr);
		#elseif (js || html5)
		throw "texImage1D is not supported in WebGL/WebGL2.";
		#end
	}

	public static function texImage2D(target:Int, level:Int, internalFormat:Int, width:Int, height:Int, border:Int, format:Int, type:Int, pixels:Bytes) {
		#if cpp
		var pixelsPointer:Pointer<UInt8> = Pointer.ofArray(pixels.getData());
		var ptr:ConstStar<cpp.Void> = untyped __cpp__("(const void*) {0}", pixelsPointer);
		Glad.texImage2D(target, level, internalFormat, width, height, border, format, type, ptr);
		#elseif (js || html5)
		if (pixels == null || pixels.length == 0) {
			context.texImage2D(target, level, internalFormat, width, height, border, format, type, null);
		} else {
			var data = new Int8Array(pixels.length);
			for (i in 0...pixels.length)
				data[i] = pixels.get(i);
			context.texImage2D(target, level, internalFormat, width, height, border, format, type, data);
		}
		#end
	}

	public static function drawBuffer(buf:Int) {
		#if cpp
		Glad.drawBuffer(buf);
		#elseif (js || html5)
		context.drawBuffers([buf]);
		#end
	}

	public static function clear(mask:Int) {
		#if cpp
		Glad.clear(mask);
		#elseif (js || html5)
		context.clear(mask);
		#end
	}

	public static function clearColor(red:Float, green:Float, blue:Float, alpha:Float):Void {
		#if cpp
		Glad.clearColor(red, green, blue, alpha);
		#elseif (js || html5)
		context.clearColor(red, green, blue, alpha);
		#end
	}

	public static function clearStencil(s:Int):Void {
		#if cpp
		Glad.clearStencil(s);
		#elseif (js || html5)
		context.clearStencil(s);
		#end
	}

	public static function clearDepth(depth:Float):Void {
		#if cpp
		Glad.clearDepth(depth);
		#elseif (js || html5)
		context.clearDepth(depth);
		#end
	}

	public static function stencilMask(mask:UInt):Void {
		#if cpp
		Glad.stencilMask(mask);
		#elseif (js || html5)
		context.stencilMask(mask);
		#end
	}

	public static function colorMask(red:Bool, green:Bool, blue:Bool, alpha:Bool):Void {
		#if cpp
		Glad.colorMask(boolToInt(red), boolToInt(green), boolToInt(blue), boolToInt(alpha));
		#elseif (js || html5)
		context.colorMask(red, green, blue, alpha);
		#end
	}

	public static function depthMask(flag:Bool):Void {
		#if cpp
		Glad.depthMask(boolToInt(flag));
		#elseif (js || html5)
		context.depthMask(flag);
		#end
	}

	public static function disable(cap:Int):Void {
		#if cpp
		Glad.disable(cap);
		#elseif (js || html5)
		context.disable(cap);
		#end
	}

	public static function enable(cap:Int):Void {
		#if cpp
		Glad.enable(cap);
		#elseif (js || html5)
		context.enable(cap);
		#end
	}

	public static function finish():Void {
		#if cpp
		Glad.finish();
		#elseif (js || html5)
		context.finish();
		#end
	}

	public static function flush():Void {
		#if cpp
		Glad.flush();
		#elseif (js || html5)
		context.flush();
		#end
	}

	public static function blendFunc(sfactor:Int, dfactor:Int):Void {
		#if cpp
		Glad.blendFunc(sfactor, dfactor);
		#elseif (js || html5)
		context.blendFunc(sfactor, dfactor);
		#end
	}

	public static function logicOp(opcode:Int):Void {
		#if cpp
		Glad.logicOp(opcode);
		#elseif (js || html5)
		throw "logicOp is not supported in WebGL/WebGL2.";
		#end
	}

	public static function stencilFunc(func:Int, ref:Int, mask:UInt):Void {
		#if cpp
		Glad.stencilFunc(func, ref, mask);
		#elseif (js || html5)
		context.stencilFunc(func, ref, mask);
		#end
	}

	public static function stencilOp(fail:Int, zfail:Int, zpass:Int):Void {
		#if cpp
		Glad.stencilOp(fail, zfail, zpass);
		#elseif (js || html5)
		context.stencilOp(fail, zfail, zpass);
		#end
	}

	public static function depthFunc(func:Int):Void {
		#if cpp
		Glad.depthFunc(func);
		#elseif (js || html5)
		context.depthFunc(func);
		#end
	}

	public static function pixelStoref(pname:Int, param:Float):Void {
		#if cpp
		Glad.pixelStoref(pname, param);
		#elseif (js || html5)
		throw 'pixelStoref is not supported in WebGL/WebGL2.';
		#end
	}

	public static function pixelStorei(pname:Int, param:Int):Void {
		#if cpp
		Glad.pixelStorei(pname, param);
		#elseif (js || html5)
		context.pixelStorei(pname, param);
		#end
	}

	public static function readBuffer(src:Int):Void {
		#if cpp
		Glad.readBuffer(src);
		#elseif (js || html5)
		context.readBuffer(src);
		#end
	}

	public static function readPixels(x:Int, y:Int, width:Int, height:Int, format:Int, type:Int):Bytes {
		#if cpp
		var bytesPerPixel:Int = switch (format) {
			case RGBA: 4;
			case RGB: 3;
			case RED: 1 | 2;
			default: 4;
		};

		if (type == FLOAT || type == UNSIGNED_INT || type == INT) {
			bytesPerPixel *= 4;
		} else if (type == UNSIGNED_SHORT || type == SHORT) {
			bytesPerPixel *= 2;
		}

		var bufSize:Int = width * height * bytesPerPixel;

		if (bufSize <= 0)
			return Bytes.alloc(0);

		var bytes:Bytes = Bytes.alloc(bufSize);
		var ptr:RawPointer<cpp.Void> = Helpers.arrayToVoid(bytes.getData());

		Glad.readPixels(x, y, width, height, format, type, ptr);

		return bytes;
		#elseif (js || html5)
		var data = new js.lib.Uint8Array(width * height * 4);
		context.readPixels(x, y, width, height, format, type, data);

		var bytes = Bytes.alloc(data.length);
		for (i in 0...data.length)
			bytes.set(i, data[i]);

		return bytes;
		#else
		return Bytes.alloc(0);
		#end
	}

	public static function getBooleanv(pname:Int):Bool {
		#if cpp
		var result:GlBool = 0;
		Glad.getBooleanv(pname, cpp.RawPointer.addressOf(result));
		return result != 0;
		#elseif (js || html5)
		return context.getParameter(pname) != 0;
		#else
		return false;
		#end
	}

	public static function getDoublev(pname:Int):Float {
		#if cpp
		var data:Float = 0;
		Glad.getDoublev(pname, Pointer.addressOf(data));
		return data;
		#elseif (js || html5)
		return context.getParameter(pname);
		#else
		return 0;
		#end
	}

	public static function getError():Int {
		#if cpp
		return Glad.getError();
		#elseif (js || html5)
		return context.getError();
		#else
		return 0;
		#end
	}

	public static function getFloatv(pname:Int):Float {
		#if cpp
		var data:GlFloat = 0;
		Glad.getFloatv(pname, Pointer.addressOf(data));
		return data;
		#elseif (js || html5)
		return context.getParameter(pname);
		#else
		return 0;
		#end
	}

	public static function getIntegerv(pname:Int):Int {
		#if cpp
		var data:Int = 0;
		Glad.getIntegerv(pname, Pointer.addressOf(data));
		return data;
		#elseif (js || html5)
		return context.getParameter(pname);
		#else
		return 0;
		#end
	}

	public static function getString(name:Int):String {
		#if cpp
		var cstr:ConstStar<GlUByte> = Glad.getString(name);
		return cstr != null ? ConstCharStar.fromString(cast cstr) : "";
		#elseif (js || html5)
		return context.getParameter(name);
		#else
		return "";
		#end
	}

	public static function getTexImage(target:Int, level:Int, format:Int, type:Int, width:Int, height:Int):Bytes {
		#if cpp
		var bytesPerPixel:Int = switch (format) {
			case RGBA: 4;
			case RGB: 3;
			case RED: 1 | 2;
			default: 4;
		};

		if (type == FLOAT || type == UNSIGNED_INT || type == INT) {
			bytesPerPixel *= 4;
		} else if (type == UNSIGNED_SHORT || type == SHORT) {
			bytesPerPixel *= 2;
		}

		var bufSize = width * height * bytesPerPixel;

		if (bufSize <= 0)
			return Bytes.alloc(0);

		var bytes = Bytes.alloc(bufSize);

		var ptr:RawPointer<UInt8> = cpp.Pointer.arrayElem(bytes.getData(), 0).raw;
		var star:Star<cpp.Void> = untyped __cpp__("(void *) {0}", ptr);

		Glad.getTextureImage(target, level, format, type, bufSize, star);

		return bytes;
		#elseif (js || html5)
		throw "getTexImage is not supported in WebGL/WebGL2.";
		#else
		return Bytes.alloc(0);
		#end
	}

	public static function getTexParameterfv(target:Int, pname:Int):Array<Float> {
		#if cpp
		final isMulti:Bool = (pname == Glad.TEXTURE_BORDER_COLOR || pname == Glad.TEXTURE_SWIZZLE_RGBA);
		final floatSize:Int = Helpers.sizeof(GlFloat);
		final allocCount:Int = isMulti ? 4 : 1;
		final bytes:Int = allocCount * floatSize;

		var ptr:cpp.RawPointer<GlFloat> = Helpers.malloc(bytes, GlFloat);
		Glad.getTexParameterfv(target, pname, ptr);

		var result:Array<Float> = [];

		if (isMulti) {
			result.push(ptr[0]);
			result.push(ptr[1]);
			result.push(ptr[2]);
			result.push(ptr[3]);
		} else {
			result.push(ptr[0]);
		}

		Helpers.free(ptr);

		return result;
		#elseif (js || html5)
		var val = context.getTexParameter(target, pname);
		return (val != null) ? [val] : [];
		#else
		return [];
		#end
	}

	public static function getTexParameteriv(target:Int, pname:Int):Array<Int> {
		#if cpp
		final isMulti:Bool = false;
		final intSize:Int = Helpers.sizeof(Int);
		final allocCount:Int = isMulti ? 4 : 1;
		final bytes:Int = allocCount * intSize;

		var ptr:cpp.RawPointer<Int> = Helpers.malloc(bytes, Int);
		Glad.getTexParameteriv(target, pname, ptr);

		var result:Array<Int> = [];

		if (isMulti) {
			result.push(ptr[0]);
			result.push(ptr[1]);
			result.push(ptr[2]);
			result.push(ptr[3]);
		} else {
			result.push(ptr[0]);
		}

		Helpers.free(ptr);

		return result;
		#elseif (js || html5)
		var val = context.getTexParameter(target, pname);
		return (val != null) ? [val] : [];
		#else
		return [];
		#end
	}

	public static function getTexLevelParameterfv(target:Int, level:Int, pname:Int):Array<Float> {
		#if cpp
		final floatSize:Int = Helpers.sizeof(GlFloat);
		final allocCount:Int = 1;
		final bytes:Int = allocCount * floatSize;

		var ptr:cpp.RawPointer<GlFloat> = Helpers.malloc(bytes, GlFloat);
		Glad.getTexLevelParameterfv(target, level, pname, ptr);

		var result:Array<Float> = [ptr[0]];

		Helpers.free(ptr);

		return result;
		#elseif (js || html5)
		throw "getTexLevelParameterfv is not supported in WebGL/WebGL2.";
		#else
		return [];
		#end
	}

	public static function getTexLevelParameteriv(target:Int, level:Int, pname:Int):Array<Int> {
		#if cpp
		final intSize:Int = Helpers.sizeof(Int);
		final allocCount:Int = 1;
		final bytes:Int = allocCount * intSize;

		var ptr:cpp.RawPointer<Int> = Helpers.malloc(bytes, Int);
		Glad.getTexLevelParameteriv(target, level, pname, ptr);

		var result:Array<Int> = [ptr[0]];

		Helpers.free(ptr);

		return result;
		#elseif (js || html5)
		throw "getTexLevelParameteriv is not supported in WebGL/WebGL2.";
		#else
		return [];
		#end
	}

	public static function isEnabled(cap:Int):Bool {
		#if cpp
		return Glad.isEnabled(cap) != 0;
		#elseif (js || html5)
		return context.isEnabled(cap);
		#else
		return false;
		#end
	}

	public static function depthRange(n:Float, f:Float):Void {
		#if cpp
		Glad.depthRange(n, f);
		#elseif (js || html5)
		context.depthRange(n, f);
		#end
	}

	public static function viewport(x:Int, y:Int, width:Int, height:Int):Void {
		#if cpp
		Glad.viewport(x, y, width, height);
		#elseif (js || html5)
		context.viewport(x, y, width, height);
		#end
	}

	public static function drawArrays(mode:Int, first:Int, count:Int):Void {
		#if cpp
		Glad.drawArrays(mode, first, count);
		#elseif (js || html5)
		context.drawArrays(mode, first, count);
		#end
	}

	public static function drawElements(mode:Int, count:Int, type:Int, offset:Int):Void {
		#if cpp
		Glad.drawElements(mode, count, type, untyped __cpp__("(void*)(uintptr_t)({0})", offset));
		#elseif (js || html5)
		context.drawElements(mode, count, type, offset);
		#end
	}

	public static function polygonOffset(factor:Float, units:Float):Void {
		#if cpp
		Glad.polygonOffset(factor, units);
		#elseif (js || html5)
		context.polygonOffset(factor, units);
		#end
	}

	public static function copyTexImage1D(target:Int, level:Int, internalFormat:Int, x:Int, y:Int, width:Int, border:Int):Void {
		#if cpp
		Glad.copyTexImage1D(target, level, internalFormat, x, y, width, border);
		#elseif (js || html5)
		throw "copyTexImage1D is not supported in WebGL/WebGL2.";
		#end
	}

	public static function copyTexImage2D(target:Int, level:Int, internalFormat:Int, x:Int, y:Int, width:Int, height:Int, border:Int):Void {
		#if cpp
		Glad.copyTexImage2D(target, level, internalFormat, x, y, width, height, border);
		#elseif (js || html5)
		context.copyTexImage2D(target, level, internalFormat, x, y, width, height, border);
		#end
	}

	public static function copyTexSubImage1D(target:Int, level:Int, xoffset:Int, x:Int, y:Int, width:Int):Void {
		#if cpp
		Glad.copyTexSubImage1D(target, level, xoffset, x, y, width);
		#elseif (js || html5)
		throw "copyTexSubImage1D is not supported in WebGL/WebGL2.";
		#end
	}

	public static function copyTexSubImage2D(target:Int, level:Int, xoffset:Int, yoffset:Int, x:Int, y:Int, width:Int, height:Int):Void {
		#if cpp
		Glad.copyTexSubImage2D(target, level, xoffset, yoffset, x, y, width, height);
		#elseif (js || html5)
		context.copyTexSubImage2D(target, level, xoffset, yoffset, x, y, width, height);
		#end
	}

	public static function copyTexSubImage3D(target:Int, level:Int, xoffset:Int, yoffset:Int, zoffset:Int, x:Int, y:Int, width:Int, height:Int):Void {
		#if cpp
		Glad.copyTexSubImage3D(target, level, xoffset, yoffset, zoffset, x, y, width, height);
		#elseif (js || html5)
		context.copyTexSubImage3D(target, level, xoffset, yoffset, zoffset, x, y, width, height);
		#end
	}

	public static function texSubImage1D(target:Int, level:Int, xOffset:Int, width:Int, format:Int, type:Int, pixels:Bytes) {
		#if cpp
		var ptr:RawPointer<cpp.Void> = Helpers.arrayToVoid(pixels.getData());
		Glad.texSubImage1D(target, level, xOffset, width, format, type, ptr);
		#elseif (js || html5)
		throw "texSubImage1D is not supported in WebGL/WebGL2.";
		#end
	}

	public static function texSubImage2D(target:Int, level:Int, xOffset:Int, yOffset:Int, width:Int, height:Int, format:Int, type:Int, pixels:Bytes) {
		#if cpp
		var ptr:RawPointer<cpp.Void> = Helpers.arrayToVoid(pixels.getData());
		Glad.texSubImage2D(target, level, xOffset, yOffset, width, height, format, type, ptr);
		#elseif (js || html5)
		if (pixels == null || pixels.length == 0) {
			context.texSubImage2D(target, level, xOffset, yOffset, width, height, format, type, null);
		} else {
			var data = new js.lib.Uint8Array(pixels.length);
			for (i in 0...pixels.length)
				data[i] = pixels.get(i);
			context.texSubImage2D(target, level, xOffset, yOffset, width, height, format, type, data);
		}
		#end
	}

	public static function bindTexture(target:Int, texture:GLTexture) {
		#if cpp
		Glad.bindTexture(target, texture);
		#elseif (js || html5)
		context.bindTexture(target, texture);
		#end
	}

	public static function deleteTextures(n:Int, textures:Array<GLTexture>) {
		#if cpp
		var t:Array<UInt32> = [];
		for (i in 0...textures.length)
			t[i] = textures[i] ?? 0;

		Glad.deleteTextures(n, Pointer.ofArray(t));
		#elseif (js || html5)
		for (tex in textures) {
			context.deleteTexture(tex);
		}
		#end
	}

	public static function genTextures(n:Int, textures:Array<UInt32>) {
		#if cpp
		Glad.genTextures(n, Pointer.ofArray(textures));
		#end
	}

	public static function isTexture(texture:UInt32):Bool {
		#if cpp
		return Glad.isTexture(texture) != 0;
		#end

		return false;
	}

	public static function drawRangeElements(mode:Int, start:Int, end:UInt32, count:Int, type:Int, indices:Int):Void {
		#if cpp
		Glad.drawRangeElements(mode, start, end, count, type, untyped __cpp__("(void*)(uintptr_t)({0})", indices));
		#end
	}

	public static function texImage3D(target:Int, level:Int, internalFormat:Int, width:Int, height:Int, depth:Int, border:Int, format:Int, type:Int,
			pixels:Bytes) {
		#if cpp
		var pointer:RawPointer<cpp.Void> = Helpers.arrayToVoid(pixels.getData());
		var ptr:ConstStar<cpp.Void> = untyped __cpp__("(const void*) {0}", pointer);
		Glad.texImage3D(target, level, internalFormat, width, height, depth, border, format, type, ptr);
		#end
	}

	public static function texSubImage3D(target:Int, level:Int, xOffset:Int, yOffset:Int, zOffset:Int, width:Int, height:Int, depth:Int, format:Int, type:Int,
			pixels:Bytes) {
		#if cpp
		var pointer:RawPointer<cpp.Void> = Helpers.arrayToVoid(pixels.getData());
		var ptr:ConstStar<cpp.Void> = untyped __cpp__("(const void*) {0}", pointer);
		Glad.texSubImage3D(target, level, xOffset, yOffset, zOffset, width, height, depth, format, type, ptr);
		#end
	}

	public static function activeTexture(texture:Int) {
		#if cpp
		Glad.activeTexture(texture);
		#elseif (js || html5)
		context.activeTexture(texture);
		#end
	}

	public static function sampleCoverage(value:Float, invert:Bool):Void {
		#if cpp
		Glad.sampleCoverage(value, boolToInt(invert));
		#elseif (js || html5)
		context.sampleCoverage(value, invert);
		#end
	}

	public static function compressedTexImage3D(target:Int, level:Int, internalFormat:Int, width:Int, height:Int, depth:Int, border:Int, imageSize:Int,
			data:Bytes):Void {
		#if cpp
		var pointer:RawPointer<cpp.Void> = Helpers.arrayToVoid(data.getData());
		var ptr:ConstStar<cpp.Void> = untyped __cpp__("(const void*) {0}", pointer);
		Glad.compressedTexImage3D(target, level, internalFormat, width, height, depth, border, imageSize, ptr);
		#elseif (js || html5)
		var jsData:Uint8Array = new Uint8Array(data.getData());
		context.compressedTexImage3D(target, level, internalFormat, width, height, depth, border, jsData);
		#end
	}

	public static function compressedTexImage2D(target:Int, level:Int, internalFormat:Int, width:Int, height:Int, border:Int, imageSize:Int, data:Bytes):Void {
		#if cpp
		var pointer:RawPointer<cpp.Void> = Helpers.arrayToVoid(data.getData());
		var ptr:ConstStar<cpp.Void> = untyped __cpp__("(const void*) {0}", pointer);
		Glad.compressedTexImage2D(target, level, internalFormat, width, height, border, imageSize, ptr);
		#elseif (js || html5)
		var jsData:Uint8Array = new Uint8Array(data.getData());
		context.compressedTexImage2D(target, level, internalFormat, width, height, border, jsData);
		#end
	}

	public static function compressedTexImage1D(target:Int, level:Int, internalFormat:Int, width:Int, border:Int, imageSize:Int, data:Bytes):Void {
		#if cpp
		var pointer:RawPointer<cpp.Void> = Helpers.arrayToVoid(data.getData());
		var ptr:ConstStar<cpp.Void> = untyped __cpp__("(const void*) {0}", pointer);
		Glad.compressedTexImage1D(target, level, internalFormat, width, border, imageSize, ptr);
		#elseif (js || html5)
		throw "compressedTexImage1D is not supported in WebGL/WebGL2.";
		#end
	}

	public static function compressedTexSubImage3D(target:Int, level:Int, xOffset:Int, yOffset:Int, depthOffset:Int, width:Int, height:Int, depth:Int,
			format:Int, imageSize:Int, data:Bytes):Void {
		#if cpp
		var pointer:RawPointer<cpp.Void> = Helpers.arrayToVoid(data.getData());
		var ptr:ConstStar<cpp.Void> = untyped __cpp__("(const void*) {0}", pointer);
		Glad.compressedTexSubImage3D(target, level, xOffset, yOffset, depthOffset, width, height, depth, format, imageSize, ptr);
		#elseif (js || html5)
		var jsData:Uint8Array = new Uint8Array(data.getData());
		context.compressedTexSubImage3D(target, level, xOffset, yOffset, depthOffset, width, height, depth, format, jsData);
		#end
	}

	public static function compressedTexSubImage2D(target:Int, level:Int, xOffset:Int, yOffset:Int, width:Int, height:Int, format:Int, imageSize:Int,
			data:Bytes):Void {
		#if cpp
		var pointer:RawPointer<cpp.Void> = Helpers.arrayToVoid(data.getData());
		var ptr:ConstStar<cpp.Void> = untyped __cpp__("(const void*) {0}", pointer);
		Glad.compressedTexSubImage2D(target, level, xOffset, yOffset, width, height, format, imageSize, ptr);
		#elseif (js || html5)
		var jsData:Uint8Array = new Uint8Array(data.getData());
		context.compressedTexSubImage2D(target, level, xOffset, yOffset, width, height, format, jsData);
		#end
	}

	public static function compressedTexSubImage1D(target:Int, level:Int, xOffset:Int, width:Int, format:Int, imageSize:Int, data:Bytes):Void {
		#if cpp
		var pointer:RawPointer<cpp.Void> = Helpers.arrayToVoid(data.getData());
		var ptr:ConstStar<cpp.Void> = untyped __cpp__("(const void*) {0}", pointer);
		Glad.compressedTexSubImage1D(target, level, xOffset, width, format, imageSize, ptr);
		#elseif (js || html5)
		throw "compressedTexSubImage1D is not supported in WebGL/WebGL2.";
		#end
	}

	public static function getCompressedTexImage(target:Int, level:Int, pixels:Bytes):Void {
		#if cpp
		var pointer:RawPointer<cpp.Void> = Helpers.arrayToVoid(pixels.getData());
		var ptr:Star<cpp.Void> = untyped __cpp__("(void*) {0}", pointer);
		Glad.getCompressedTexImage(target, level, ptr);
		#elseif (js || html5)
		throw "getCompressedTexImage is not supported in WebGL/WebGL2.";
		#end
	}

	public static function blendFuncSeparate(sfactorRGB:Int, dfactorRGB:Int, sfactorAlpha:Int, dfactorAlpha:Int):Void {
		#if cpp
		Glad.blendFuncSeparate(sfactorRGB, dfactorRGB, sfactorAlpha, dfactorAlpha);
		#elseif (js || html5)
		context.blendFuncSeparate(sfactorRGB, dfactorRGB, sfactorAlpha, dfactorAlpha);
		#end
	}

	public static function multiDrawArrays(mode:Int, first:Array<Int>, count:Array<Int>, drawcount:Int):Void {
		#if cpp
		Glad.multiDrawArrays(mode, untyped __cpp__("(const int*) {0}", Pointer.ofArray(first).constRaw),
			untyped __cpp__("(const int*) {0}", Pointer.ofArray(count).constRaw), drawcount);
		#elseif (js || html5)
		throw "multiDrawArrays is not supported in WebGL/WebGL2 (requires extension or WebGL2 multiDraw extension).";
		#end
	}

	public static function pointParameterf(pname:Int, param:Float):Void {
		#if cpp
		Glad.pointParameterf(pname, param);
		#elseif (js || html5)
		throw "pointParameterf is not supported in WebGL/WebGL2.";
		#end
	}

	public static function pointParameterfv(pname:Int, params:Array<Float>):Void {
		#if cpp
		var pointer:RawPointer<cpp.Void> = Helpers.arrayToVoid(params);
		var ptr:ConstStar<cpp.Float32> = untyped __cpp__("(const GLfloat*) {0}", pointer);
		Glad.pointParameterfv(pname, ptr);
		#elseif (js || html5)
		throw "pointParameterfv is not supported in WebGL/WebGL2.";
		#end
	}

	public static function pointParameteri(pname:Int, param:Int):Void {
		#if cpp
		Glad.pointParameteri(pname, param);
		#elseif (js || html5)
		throw "pointParameteri is not supported in WebGL/WebGL2.";
		#end
	}

	public static function pointParameteriv(pname:Int, params:Array<Int>):Void {
		#if cpp
		Glad.pointParameteriv(pname, untyped __cpp__("(const int*) {0}", Pointer.ofArray(params).constRaw));
		#elseif (js || html5)
		throw "pointParameteriv is not supported in WebGL/WebGL2.";
		#end
	}

	public static function blendColor(red:Float, green:Float, blue:Float, alpha:Float):Void {
		#if cpp
		Glad.blendColor(red, green, blue, alpha);
		#elseif (js || html5)
		context.blendColor(red, green, blue, alpha);
		#end
	}

	public static function blendEquation(mode:Int):Void {
		#if cpp
		Glad.blendEquation(mode);
		#elseif (js || html5)
		context.blendEquation(mode);
		#end
	}

	public static function genQueries(n:Int, ids:Array<GLQuery>):Void {
		#if cpp
		Glad.genQueries(n, untyped __cpp__("(const int*) {0}", Pointer.ofArray(ids).constRaw));
		#elseif (js || html5)
		for (i in 0...n) {
			ids[i] = context.createQuery();
		}
		#end
	}

	public static function deleteQueries(n:Int, ids:Array<GLQuery>):Void {
		#if cpp
		Glad.deleteQueries(n, untyped __cpp__("(const int*) {0}", Pointer.ofArray(ids).constRaw));
		#elseif (js || html5)
		for (id in ids) {
			context.deleteQuery(id);
		}
		#end
	}

	public static function isQuery(id:GLQuery):Bool {
		#if cpp
		return Glad.isQuery(id) != 0;
		#elseif (js || html5)
		return context.isQuery(id);
		#else
		return false;
		#end
	}

	public static function beginQuery(target:Int, id:GLQuery):Void {
		#if cpp
		Glad.beginQuery(target, id);
		#elseif (js || html5)
		context.beginQuery(target, id);
		#end
	}

	public static function endQuery(target:Int):Void {
		#if cpp
		Glad.endQuery(target);
		#elseif (js || html5)
		context.endQuery(target);
		#end
	}

	public static function getQueryiv(target:Int, pname:Int, params:Array<Int>):Void {
		#if cpp
		Glad.getQueryiv(target, pname, Pointer.ofArray(params));
		#elseif (js || html5)
		params[0] = context.getQuery(target, pname);
		#end
	}

	public static function getQueryObjectiv(id:GLQuery, pname:Int, params:Array<Int>):Void {
		#if cpp
		Glad.getQueryObjectiv(id, pname, Pointer.ofArray(params));
		#elseif (js || html5)
		params[0] = context.getQueryParameter(id, pname);
		#end
	}

	public static function getQueryObjectuiv(id:GLQuery, pname:Int, params:Array<GLBuffer>):Void {
		#if cpp
		Glad.getQueryObjectuiv(id, pname, untyped __cpp__("(const int*) {0}", Pointer.ofArray(params).constRaw));
		#elseif (js || html5)
		params[0] = context.getQueryParameter(id, pname);
		#end
	}

	public static function bindBuffer(target:Int, buffer:GLBuffer):Void {
		#if cpp
		Glad.bindBuffer(target, buffer);
		#elseif (js || html5)
		context.bindBuffer(target, buffer);
		#end
	}

	public static function deleteBuffers(n:Int, buffers:Array<GLBuffer>):Void {
		#if cpp
		Glad.deleteBuffers(n, untyped __cpp__("(const int*) {0}", Pointer.ofArray(buffers).constRaw));
		#elseif (js || html5)
		for (buf in buffers) {
			context.deleteBuffer(buf);
		}
		#end
	}

	public static function genBuffer():GLBuffer {
		#if cpp
		var buffer:Int = 0;
		Glad.genBuffers(1, untyped __cpp__("(const int*) {0}", RawPointer.addressOf(buffer)));
		return buffer;
		#elseif (js || html5)
		return context.createBuffer();
		#else
		return -1;
		#end
	}

	public static function isBuffer(buffer:GLBuffer):Bool {
		#if cpp
		return Glad.isBuffer(buffer) != 0;
		#elseif (js || html5)
		return context.isBuffer(buffer);
		#else
		return false;
		#end
	}

	public static function bufferData(target:Int, size:Int, data:Bytes, usage:Int):Void {
		#if cpp
		var pointer:RawPointer<cpp.Void> = Helpers.arrayToVoid(data.getData());
		var star:ConstStar<cpp.Void> = untyped __cpp__("(const void*) {0}", pointer);
		untyped __cpp__("glBufferData({0}, {1}, {2}, {3})", target, untyped __cpp__("(GLsizeiptr) {0}", size), star, usage);
		#elseif (js || html5)
		var jsData = data != null ? new js.lib.Uint8Array(data.getData()) : null;
		context.bufferData(target, jsData, usage);
		#end
	}

	public static function bufferSubData(target:Int, offset:Int, size:Int, data:Bytes):Void {
		#if cpp
		var pointer:RawPointer<cpp.Void> = Helpers.arrayToVoid(data.getData());
		var star:ConstStar<cpp.Void> = untyped __cpp__("(const void*) {0}", pointer);
		untyped __cpp__("glBufferSubData({0}, {1}, {2}, {3})", target, offset, cast(size, GlSizeIPointer), star);
		#elseif (js || html5)
		var jsData = data != null ? new js.lib.Uint8Array(data.getData()) : null;
		context.bufferSubData(target, offset, jsData);
		#end
	}

	public static function getBufferSubData(target:Int, offset:Int, size:Int):Bytes {
		#if cpp
		var data:Bytes = Bytes.alloc(size);
		var pointer:RawPointer<cpp.Void> = Helpers.arrayToVoid(data.getData());
		var star:Star<cpp.Void> = untyped __cpp__("(void*) {0}", pointer);
		untyped __cpp__("glGetBufferSubData({0}, {1}, {2}, {3})", target, offset, cast(size, GlSizeIPointer), star);
		return data;
		#elseif (js || html5)
		throw "getBufferSubData is not supported in WebGL/WebGL2.";
		#else
		return Bytes.alloc(0);
		#end
	}

	public static function getBufferParameteriv(target:Int, pname:Int):Int {
		#if cpp
		var i:Int = 0;
		Glad.getBufferParameteriv(target, pname, Pointer.addressOf(i));
		return i;
		#elseif (js || html5)
		return context.getBufferParameter(target, pname);
		#else
		return 0;
		#end
	}

	public static function blendEquationSeparate(modeRGB:Int, modeAlpha:Int) {
		#if cpp
		Glad.blendEquationSeparate(modeRGB, modeAlpha);
		#elseif (js || html5)
		context.blendEquationSeparate(modeRGB, modeAlpha);
		#end
	}

	public static function drawBuffers(n:Int, buffers:Array<UInt>) {
		#if cpp
		var ptr:Pointer<GlEnum> = Pointer.ofArray(buffers);
		untyped __cpp__("glDrawBuffers({0}, {1})", n, untyped __cpp__("(const unsigned int*) {0}", ptr.constRaw));
		#elseif (js || html5)
		context.drawBuffers(buffers);
		#end
	}

	public static function stencilOpSeparate(face:Int, sfail:Int, dpfail:Int, dppass:Int) {
		#if cpp
		Glad.stencilOpSeparate(face, sfail, dpfail, dppass);
		#elseif (js || html5)
		context.stencilOpSeparate(face, sfail, dpfail, dppass);
		#end
	}

	public static function stencilFuncSeparate(face:Int, func:Int, ref:Int, mask:Int) {
		#if cpp
		Glad.stencilFuncSeparate(face, func, ref, mask);
		#elseif (js || html5)
		context.stencilFuncSeparate(face, func, ref, mask);
		#end
	}

	public static function stencilMaskSeparate(face:Int, mask:UInt32) {
		#if cpp
		Glad.stencilMaskSeparate(face, mask);
		#elseif (js || html5)
		context.stencilMaskSeparate(face, mask);
		#end
	}

	public static function attachShader(program:GLProgram, shader:GLShader) {
		#if cpp
		Glad.attachShader(program, shader);
		#elseif (js || html5)
		context.attachShader(program, shader);
		#end
	}

	public static function bindAttribLocation(program:GLProgram, index:UInt32, name:String) {
		#if cpp
		Glad.bindAttribLocation(program, index, ConstCharStar.fromString(name));
		#elseif (js || html5)
		context.bindAttribLocation(program, index, name);
		#end
	}

	public static function compileShader(shader:GLShader) {
		#if cpp
		Glad.compileShader(shader);
		#elseif (js || html5)
		context.compileShader(shader);
		#end
	}

	public static function createProgram():GLProgram {
		#if cpp
		return Glad.createProgram();
		#elseif (js || html5)
		return context.createProgram();
		#else
		return 0;
		#end
	}

	public static function createShader(type:Int):GLShader {
		#if cpp
		return Glad.createShader(type);
		#elseif (js || html5)
		return context.createShader(type);
		#else
		return 0;
		#end
	}

	public static function deleteProgram(program:GLProgram) {
		#if cpp
		Glad.deleteProgram(program);
		#elseif (js || html5)
		context.deleteProgram(program);
		#end
	}

	public static function deleteShader(shader:GLShader) {
		#if cpp
		Glad.deleteShader(shader);
		#elseif (js || html5)
		context.deleteShader(shader);
		#end
	}

	public static function detachShader(program:GLProgram, shader:GLShader):Void {
		#if cpp
		Glad.detachShader(program, shader);
		#elseif (js || html5)
		context.detachShader(program, shader);
		#end
	}

	public static function disableVertexAttribArray(index:UInt):Void {
		#if cpp
		Glad.disableVertexAttribArray(index);
		#elseif (js || html5)
		context.disableVertexAttribArray(index);
		#end
	}

	public static function enableVertexAttribArray(index:UInt32) {
		#if cpp
		Glad.enableVertexAttribArray(index);
		#elseif (js || html5)
		context.enableVertexAttribArray(index);
		#end
	}

	/* need to rework
		public static function getActiveAttrib(program:Int, index:Int, bufSize:Int):GLAttribute {
			#if cpp
			var attrib:GLAttribute = {
				length: 0,
				size: 0,
				type: 0,
				name: null
			}
			var name:RawPointer<GlChar> = Helpers.malloc(bufSize, GlChar);

			Glad.getActiveAttrib(program, index, bufSize, Pointer.addressOf(attrib.length), Pointer.addressOf(attrib.size), Pointer.addressOf(attrib.type), name);
			attrib.name = NativeString.fromPointer(untyped __cpp__("(const char*) {0}", name));

			Helpers.free(name);

			return attrib;
			#end
			return null;
		}

		public static function getActiveUniform(program:Int, index:Int, bufSize:Int):GLUniform {
			#if cpp
			var attrib:GLUniform = {
				length: 0,
				size: 0,
				type: 0,
				name: null
			}
			var name:RawPointer<GlChar> = Helpers.malloc(bufSize, GlChar);

			Glad.getActiveUniform(program, index, bufSize, Pointer.addressOf(attrib.length), Pointer.addressOf(attrib.size), Pointer.addressOf(attrib.type), name);
			attrib.name = NativeString.fromPointer(untyped __cpp__("(const char*) {0}", name));

			Helpers.free(name);

			return attrib;
			#end
			return null;
		}

		public static function getAttachedShaders(program:Int, maxCount:Int):GLAttachedShaders {
			#if cpp
			var attached:GLAttachedShaders = {
				count: 0,
				shaders: []
			}

			Glad.getAttachedShaders(program, maxCount, Pointer.addressOf(attached.count), Pointer.ofArray(attached.shaders));

			return attached;
			#end
			return null;
		}
	 */
	public static function getAttribLocation(program:GLProgram, name:String):Int {
		#if cpp
		return Glad.getAttribLocation(program, ConstCharStar.fromString(name));
		#elseif (js || html5)
		return context.getAttribLocation(program, name);
		#else
		return -1;
		#end
	}

	public static function getProgramiv(program:GLProgram, pname:Int):Int {
		#if cpp
		var value:Int = 0;
		Glad.getProgramiv(program, pname, Pointer.addressOf(value));
		return value;
		#elseif (js || html5)
		return context.getProgramParameter(program, pname);
		#else
		return 0;
		#end
	}

	public static function getProgramInfoLog(program:GLProgram):String {
		#if cpp
		var length:Int = 0;
		Glad.getProgramiv(program, Glad.INFO_LOG_LENGTH, Pointer.addressOf(length));

		if (length <= 0)
			return "";

		var buffer:Star<GlChar> = Helpers.malloc(length, GlChar);
		Glad.getProgramInfoLog(program, length, null, buffer);

		var log:String = NativeString.fromPointer(untyped __cpp__("(const char*) {0}", buffer));
		Helpers.free(buffer);
		return log;
		#elseif (js || html5)
		return context.getProgramInfoLog(program);
		#else
		return "";
		#end
	}

	public static function getShaderiv(shader:GLShader, pname:Int):Int {
		#if cpp
		var value:Int = 0;
		Glad.getShaderiv(shader, pname, Pointer.addressOf(value));
		return value;
		#elseif (js || html5)
		return context.getShaderParameter(shader, pname);
		#else
		return 0;
		#end
	}

	public static function getShaderInfoLog(shader:GLShader):String {
		#if cpp
		var length:Int = 0;
		Glad.getShaderiv(shader, Glad.INFO_LOG_LENGTH, Pointer.addressOf(length));

		if (length <= 0)
			return "";

		var buffer:Star<GlChar> = Helpers.malloc(length, GlChar);
		Glad.getShaderInfoLog(shader, length, null, buffer);

		var log:String = NativeString.fromPointer(untyped __cpp__("(const char*) {0}", buffer));
		Helpers.free(buffer);
		return log;
		#elseif (js || html5)
		return context.getShaderInfoLog(shader);
		#else
		return "";
		#end
	}

	public static function getShaderSource(shader:GLShader):String {
		#if cpp
		var length:Int = 0;
		Glad.getShaderiv(shader, Glad.SHADER_SOURCE_LENGTH, Pointer.addressOf(length));

		if (length <= 0)
			return "";

		var buffer:Star<GlChar> = Helpers.malloc(length, GlChar);
		Glad.getShaderSource(shader, length, null, buffer);

		var source:String = NativeString.fromPointer(untyped __cpp__("(const char*) {0}", buffer));
		Helpers.free(buffer);
		return source;
		#elseif (js || html5)
		return context.getShaderSource(shader);
		#else
		return "";
		#end
	}

	public static function getUniformLocation(program:GLProgram, name:String):GLUniformLocation {
		#if cpp
		return Glad.getUniformLocation(program, ConstCharStar.fromString(name));
		#elseif (js || html5)
		return context.getUniformLocation(program, name);
		#else
		return -1;
		#end
	}

	public static function getUniformfv(program:GLProgram, location:GLUniformLocation):Array<Float> {
		#if cpp
		var arr:Array<GlFloat> = [0.0, 0.0, 0.0, 0.0];
		Glad.getUniformfv(program, location, Pointer.ofArray(arr));
		return cast arr;
		#elseif (js || html5)
		var val = context.getUniform(program, location);
		return Std.isOfType(val, Array) ? cast val : [val];
		#else
		return [];
		#end
	}

	public static function getUniformiv(program:GLProgram, location:GLUniformLocation):Array<Int> {
		#if cpp
		var arr:Array<Int> = [0, 0, 0, 0];
		Glad.getUniformiv(program, location, Pointer.ofArray(arr));
		return arr;
		#elseif (js || html5)
		var val = context.getUniform(program, location);
		return Std.isOfType(val, Array) ? cast val : [val];
		#else
		return [];
		#end
	}

	public static function getVertexAttribiv(index:UInt, pname:Int):Int {
		#if cpp
		var value:Int = 0;
		Glad.getVertexAttribiv(index, pname, Pointer.addressOf(value));
		return value;
		#elseif (js || html5)
		return context.getVertexAttrib(index, pname);
		#else
		return 0;
		#end
	}

	public static function getVertexAttribfv(index:UInt, pname:Int):Array<Float> {
		#if cpp
		var arr:Array<GlFloat> = [0.0, 0.0, 0.0, 0.0];
		Glad.getVertexAttribfv(index, pname, Pointer.ofArray(arr));
		return cast arr;
		#elseif (js || html5)
		var val = context.getVertexAttrib(index, pname);
		return Std.isOfType(val, Array) ? cast val : [val];
		#else
		return [];
		#end
	}

	public static function getVertexAttribdv(index:UInt, pname:Int):Array<Float> {
		#if cpp
		var arr:Array<Float> = [0.0, 0.0, 0.0, 0.0];
		Glad.getVertexAttribdv(index, pname, Pointer.ofArray(arr));
		return arr;
		#elseif (js || html5)
		var val = context.getVertexAttrib(index, pname);
		return Std.isOfType(val, Array) ? cast val : [val];
		#else
		return [];
		#end
	}

	public static function isProgram(program:GLProgram):Bool {
		#if cpp
		return Glad.isProgram(program) != 0;
		#elseif (js || html5)
		return context.isProgram(program);
		#else
		return false;
		#end
	}

	public static function isShader(shader:GLShader):Bool {
		#if cpp
		return Glad.isShader(shader) != 0;
		#elseif (js || html5)
		return context.isShader(shader);
		#else
		return false;
		#end
	}

	public static function linkProgram(program:GLProgram):Void {
		#if cpp
		Glad.linkProgram(program);
		#elseif (js || html5)
		context.linkProgram(program);
		#end
	}

	public static function useProgram(program:GLProgram):Void {
		#if cpp
		Glad.useProgram(program ?? 0);
		#elseif (js || html5)
		context.useProgram(program);
		#end
	}

	public static function validateProgram(program:GLProgram):Void {
		#if cpp
		Glad.validateProgram(program);
		#elseif (js || html5)
		context.validateProgram(program);
		#end
	}

	public static function shaderSource(shader:GLShader, source:String):Void {
		#if cpp
		var src:ConstCharStar = ConstCharStar.fromString(source);
		Glad.shaderSource(shader, 1, untyped __cpp__("&{0}", src), null);
		#elseif (js || html5)
		context.shaderSource(shader, source);
		#end
	}

	public static function uniform1fv(location:GLUniformLocation, value:Array<Float32>):Void {
		#if cpp
		var ptr:ConstStar<Float32> = untyped __cpp__("(const float*) {0}", Pointer.ofArray(value));
		Glad.uniform1fv(location, value.length, ptr);
		#elseif (js || html5)
		context.uniform1fv(location, value);
		#end
	}

	public static function uniform2fv(location:GLUniformLocation, value:Vec2):Void {
		#if cpp
		var data:Array<Float32> = value.toArray();
		var ptr:ConstStar<Float32> = untyped __cpp__("(const float*) {0}", Pointer.ofArray(data));
		Glad.uniform2fv(location, 1, ptr);
		#elseif (js || html5)
		context.uniform2fv(location, value);
		#end
	}

	public static function uniform3fv(location:GLUniformLocation, value:Vec3):Void {
		#if cpp
		var data:Array<Float32> = value.toArray();
		var ptr:ConstStar<Float32> = untyped __cpp__("(const float*) {0}", Pointer.ofArray(data));
		Glad.uniform3fv(location, 1, ptr);
		#elseif (js || html5)
		context.uniform3fv(location, value);
		#end
	}

	public static function uniform4fv(location:GLUniformLocation, value:Vec4):Void {
		#if cpp
		var data:Array<Float32> = value.toArray();
		var ptr:ConstStar<Float32> = untyped __cpp__("(const float*) {0}", Pointer.ofArray(data));
		Glad.uniform4fv(location, 1, ptr);
		#elseif (js || html5)
		context.uniform4fv(location, value);
		#end
	}

	public static function uniformMatrix3fv(location:GLUniformLocation, transpose:Bool, value:Mat3):Void {
		#if cpp
		var buf:RawPointer<Float32> = Helpers.malloc(9, Float32);
		for (i in 0...9)
			buf[i] = value[i];
		Glad.uniformMatrix3fv(location, 1, boolToInt(transpose), untyped __cpp__("(const float*) {0}", buf));
		Helpers.free(buf);
		#elseif (js || html5)
		context.uniformMatrix3fv(location, transpose, value);
		#end
	}

	public static function uniformMatrix4fv(location:GLUniformLocation, transpose:Bool, mat:Mat4):Void {
		#if cpp
		var buf:RawPointer<Float32> = Helpers.malloc(16, Float32);
		for (i in 0...16)
			buf[i] = mat[i];
		Glad.uniformMatrix4fv(location, 1, boolToInt(transpose), untyped __cpp__("(const float*) {0}", buf));
		Helpers.free(buf);
		#elseif (js || html5)
		context.uniformMatrix4fv(location, transpose, mat);
		#end
	}

	public static function vertexAttrib1f(index:UInt, x:Float):Void {
		#if cpp
		Glad.vertexAttrib1f(index, x);
		#elseif (js || html5)
		context.vertexAttrib1f(index, x);
		#end
	}

	public static function vertexAttrib2f(index:UInt, v:Vec2):Void {
		#if cpp
		Glad.vertexAttrib2f(index, v.x, v.y);
		#elseif (js || html5)
		context.vertexAttrib2f(index, v.x, v.y);
		#end
	}

	public static function vertexAttrib3f(index:UInt, v:Vec3):Void {
		#if cpp
		Glad.vertexAttrib3f(index, v.x, v.y, v.z);
		#elseif (js || html5)
		context.vertexAttrib3f(index, v.x, v.y, v.z);
		#end
	}

	public static function vertexAttrib4f(index:UInt, v:Vec4):Void {
		#if cpp
		Glad.vertexAttrib4f(index, v.x, v.y, v.z, v.w);
		#elseif (js || html5)
		context.vertexAttrib4f(index, v.x, v.y, v.z, v.w);
		#end
	}

	public static function vertexAttrib1fv(index:UInt, values:Array<Float32>):Void {
		#if cpp
		var buf:RawPointer<Float32> = Helpers.malloc(values.length, Float32);
		for (i in 0...values.length)
			buf[i] = values[i];
		Glad.vertexAttrib1fv(index, untyped __cpp__("(const float*) {0}", buf));
		Helpers.free(buf);
		#elseif (js || html5)
		context.vertexAttrib1fv(index, values);
		#end
	}

	public static function vertexAttrib2fv(index:UInt, values:Vec2):Void {
		#if cpp
		var data:Array<Float32> = values.toArray();
		var buf:RawPointer<Float32> = Helpers.malloc(data.length, Float32);
		for (i in 0...data.length)
			buf[i] = data[i];
		Glad.vertexAttrib2fv(index, untyped __cpp__("(const float*) {0}", buf));
		Helpers.free(buf);
		#elseif (js || html5)
		context.vertexAttrib2fv(index, values);
		#end
	}

	public static function vertexAttrib3fv(index:UInt, values:Vec3):Void {
		#if cpp
		var data:Array<Float32> = values.toArray();
		var buf:RawPointer<Float32> = Helpers.malloc(data.length, Float32);
		for (i in 0...data.length)
			buf[i] = data[i];
		Glad.vertexAttrib3fv(index, untyped __cpp__("(const float*) {0}", buf));
		Helpers.free(buf);
		#elseif (js || html5)
		context.vertexAttrib3fv(index, values);
		#end
	}

	public static function vertexAttrib4fv(index:UInt, values:Vec4):Void {
		#if cpp
		var data:Array<Float32> = values.toArray();
		var buf:RawPointer<Float32> = Helpers.malloc(data.length, Float32);
		for (i in 0...data.length)
			buf[i] = data[i];
		Glad.vertexAttrib4fv(index, untyped __cpp__("(const float*) {0}", buf));
		Helpers.free(buf);
		#elseif (js || html5)
		context.vertexAttrib4fv(index, values);
		#end
	}

	public static function vertexAttrib4d(index:UInt, x:Float, y:Float, z:Float, w:Float):Void {
		#if cpp
		Glad.vertexAttrib4d(index, x, y, z, w);
		#elseif (js || html5)
		context.vertexAttrib4f(index, x, y, z, w);
		#end
	}

	public static function vertexAttrib4dv(index:UInt, values:Vec4):Void {
		#if cpp
		var v:Array<Float32> = values.toArray();
		var buf:RawPointer<Float32> = Helpers.malloc(v.length, Float32);
		for (i in 0...v.length)
			buf[i] = v[i];
		Glad.vertexAttrib4dv(index, untyped __cpp__("(const GLdouble*) {0}", buf));
		Helpers.free(buf);
		#elseif (js || html5)
		context.vertexAttrib4fv(index, values);
		#end
	}

	public static function vertexAttrib4s(index:UInt, x:Int, y:Int, z:Int, w:Int):Void {
		#if cpp
		Glad.vertexAttrib4s(index, x, y, z, w);
		#elseif (js || html5)
		context.vertexAttrib4f(index, x, y, z, w);
		#end
	}

	public static function vertexAttrib4sv(index:UInt, values:Array<Int16>):Void {
		#if cpp
		var buf:RawPointer<Int16> = Helpers.malloc(values.length, Int16);
		for (i in 0...values.length)
			buf[i] = values[i];
		Glad.vertexAttrib4sv(index, untyped __cpp__("(const GLshort*) {0}", buf));
		Helpers.free(buf);
		#elseif (js || html5)
		throw 'vertexAttrib4sv is not supported in WebGL/WebGL2';
		#end
	}

	public static function vertexAttrib4Nbv(index:UInt, values:Array<Int16>):Void {
		#if cpp
		var buf:RawPointer<Int16> = Helpers.malloc(values.length, Int16);
		for (i in 0...values.length)
			buf[i] = values[i];
		Glad.vertexAttrib4Nbv(index, untyped __cpp__("(const GLbyte*) {0}", buf));
		Helpers.free(buf);
		#elseif (js || html5)
		if (values.length >= 4) {
			context.vertexAttrib4f(index, values[0], values[1], values[2], values[3]);
		}
		#end
	}

	public static function vertexAttrib4Nsv(index:UInt, values:Array<Int16>):Void {
		#if cpp
		var buf:RawPointer<Int16> = Helpers.malloc(values.length, Int16);
		for (i in 0...values.length)
			buf[i] = values[i];
		Glad.vertexAttrib4Nsv(index, untyped __cpp__("(const GLshort*) {0}", buf));
		Helpers.free(buf);
		#elseif (js || html5)
		if (values.length >= 4) {
			context.vertexAttrib4f(index, values[0], values[1], values[2], values[3]);
		}
		#end
	}

	public static function vertexAttrib4Niv(index:UInt, values:Array<Int16>):Void {
		#if cpp
		var buf:RawPointer<Int16> = Helpers.malloc(values.length, Int16);
		for (i in 0...values.length)
			buf[i] = values[i];
		Glad.vertexAttrib4Niv(index, untyped __cpp__("(const GLint*) {0}", buf));
		Helpers.free(buf);
		#elseif (js || html5)
		if (values.length >= 4) {
			context.vertexAttrib4f(index, values[0], values[1], values[2], values[3]);
		}
		#end
	}

	public static function vertexAttrib4Nub(index:UInt, x:Int, y:Int, z:Int, w:Int):Void {
		#if cpp
		Glad.vertexAttrib4Nub(index, x, y, z, w);
		#elseif (js || html5)
		context.vertexAttrib4f(index, x, y, z, w);
		#end
	}

	public static function vertexAttrib4Nubv(index:UInt, values:Array<Int16>):Void {
		#if cpp
		var buf:RawPointer<Int16> = Helpers.malloc(values.length, Int16);
		for (i in 0...values.length)
			buf[i] = values[i];
		Glad.vertexAttrib4Nubv(index, untyped __cpp__("(const GLubyte*) {0}", buf));
		Helpers.free(buf);
		#elseif (js || html5)
		if (values.length >= 4) {
			context.vertexAttrib4f(index, values[0], values[1], values[2], values[3]);
		}
		#end
	}

	public static function vertexAttrib4Nuiv(index:UInt, values:Array<Int16>):Void {
		#if cpp
		var buf:RawPointer<Int16> = Helpers.malloc(values.length, Int16);
		for (i in 0...values.length)
			buf[i] = values[i];
		Glad.vertexAttrib4Nuiv(index, untyped __cpp__("(const GLuint*) {0}", buf));
		Helpers.free(buf);
		#elseif (js || html5)
		if (values.length >= 4) {
			context.vertexAttrib4f(index, values[0], values[1], values[2], values[3]);
		}
		#end
	}

	public static function vertexAttrib4Nusv(index:UInt, values:Array<Int16>):Void {
		#if cpp
		var buf:RawPointer<Int16> = Helpers.malloc(values.length, Int16);
		for (i in 0...values.length)
			buf[i] = values[i];
		Glad.vertexAttrib4Nusv(index, untyped __cpp__("(const GLushort*) {0}", buf));
		Helpers.free(buf);
		#elseif (js || html5)
		if (values.length >= 4) {
			context.vertexAttrib4f(index, values[0], values[1], values[2], values[3]);
		}
		#end
	}

	public static function vertexAttrib4bv(index:UInt, values:Array<Int16>):Void {
		#if cpp
		var buf:RawPointer<Int16> = Helpers.malloc(values.length, Int16);
		for (i in 0...values.length)
			buf[i] = values[i];
		Glad.vertexAttrib4bv(index, untyped __cpp__("(const GLbyte*) {0}", buf));
		Helpers.free(buf);
		#elseif (js || html5)
		if (values.length >= 4) {
			context.vertexAttrib4f(index, values[0], values[1], values[2], values[3]);
		}
		#end
	}

	public static function vertexAttrib4iv(index:UInt, values:Array<Int16>):Void {
		#if cpp
		var buf:RawPointer<Int16> = Helpers.malloc(values.length, Int16);
		for (i in 0...values.length)
			buf[i] = values[i];
		Glad.vertexAttrib4iv(index, untyped __cpp__("(const GLint*) {0}", buf));
		Helpers.free(buf);
		#elseif (js || html5)
		if (values.length >= 4) {
			context.vertexAttrib4f(index, values[0], values[1], values[2], values[3]);
		}
		#end
	}

	public static function vertexAttrib4ubv(index:UInt, values:Array<Int16>):Void {
		#if cpp
		var buf:RawPointer<Int16> = Helpers.malloc(values.length, Int16);
		for (i in 0...values.length)
			buf[i] = values[i];
		Glad.vertexAttrib4ubv(index, untyped __cpp__("(const GLubyte*) {0}", buf));
		Helpers.free(buf);
		#elseif (js || html5)
		if (values.length >= 4) {
			context.vertexAttrib4f(index, values[0], values[1], values[2], values[3]);
		}
		#end
	}

	public static function vertexAttrib4uiv(index:UInt, values:Array<Int16>):Void {
		#if cpp
		var buf:RawPointer<Int16> = Helpers.malloc(values.length, Int16);
		for (i in 0...values.length)
			buf[i] = values[i];
		Glad.vertexAttrib4uiv(index, untyped __cpp__("(const GLuint*) {0}", buf));
		Helpers.free(buf);
		#elseif (js || html5)
		if (values.length >= 4) {
			context.vertexAttrib4f(index, values[0], values[1], values[2], values[3]);
		}
		#end
	}

	public static function vertexAttrib4usv(index:UInt, values:Array<Int16>):Void {
		#if cpp
		var buf:RawPointer<Int16> = Helpers.malloc(values.length, Int16);
		for (i in 0...values.length)
			buf[i] = values[i];
		Glad.vertexAttrib4usv(index, untyped __cpp__("(const GLushort*) {0}", buf));
		Helpers.free(buf);
		#elseif (js || html5)
		if (values.length >= 4) {
			context.vertexAttrib4f(index, values[0], values[1], values[2], values[3]);
		}
		#end
	}

	public static function vertexAttribPointer(index:UInt, size:Int, type:Int, normalized:Bool, stride:Int, offset:Int):Void {
		#if cpp
		Glad.vertexAttribPointer(index, size, type, boolToInt(normalized), stride, untyped __cpp__("(void*) (uintptr_t) {0}", offset));
		#elseif (js || html5)
		context.vertexAttribPointer(index, size, type, normalized, stride, offset);
		#end
	}

	public static function uniformMatrix2x3fv(location:GLUniformLocation, transpose:Bool, value:Array<Float32>):Void {
		#if cpp
		var ptr:ConstStar<Float32> = untyped __cpp__("(const float*) {0}", Pointer.ofArray(value));
		Glad.uniformMatrix2x3fv(location, 1, boolToInt(transpose), ptr);
		#elseif (js || html5)
		context.uniformMatrix2x3fv(location, transpose, value);
		#end
	}

	public static function uniformMatrix3x2fv(location:GLUniformLocation, transpose:Bool, value:Array<Float32>):Void {
		#if cpp
		var ptr:ConstStar<Float32> = untyped __cpp__("(const float*) {0}", Pointer.ofArray(value));
		Glad.uniformMatrix3x2fv(location, 1, boolToInt(transpose), ptr);
		#elseif (js || html5)
		context.uniformMatrix3x2fv(location, transpose, value);
		#end
	}

	public static function uniformMatrix2x4fv(location:GLUniformLocation, transpose:Bool, value:Array<Float32>):Void {
		#if cpp
		var ptr:ConstStar<Float32> = untyped __cpp__("(const float*) {0}", Pointer.ofArray(value));
		Glad.uniformMatrix2x4fv(location, 1, boolToInt(transpose), ptr);
		#elseif (js || html5)
		context.uniformMatrix2x4fv(location, transpose, value);
		#end
	}

	public static function uniformMatrix4x2fv(location:GLUniformLocation, transpose:Bool, value:Array<Float32>):Void {
		#if cpp
		var ptr:ConstStar<Float32> = untyped __cpp__("(const float*) {0}", Pointer.ofArray(value));
		Glad.uniformMatrix4x2fv(location, 1, boolToInt(transpose), ptr);
		#elseif (js || html5)
		context.uniformMatrix4x2fv(location, transpose, value);
		#end
	}

	public static function uniformMatrix3x4fv(location:GLUniformLocation, transpose:Bool, value:Array<Float32>):Void {
		#if cpp
		var ptr:ConstStar<Float32> = untyped __cpp__("(const float*) {0}", Pointer.ofArray(value));
		Glad.uniformMatrix3x4fv(location, 1, boolToInt(transpose), ptr);
		#elseif (js || html5)
		context.uniformMatrix3x4fv(location, transpose, value);
		#end
	}

	public static function uniformMatrix4x3fv(location:GLUniformLocation, transpose:Bool, value:Array<Float32>):Void {
		#if cpp
		var ptr:ConstStar<Float32> = untyped __cpp__("(const float*) {0}", Pointer.ofArray(value));
		Glad.uniformMatrix4x3fv(location, 1, boolToInt(transpose), ptr);
		#elseif (js || html5)
		context.uniformMatrix4x3fv(location, transpose, value);
		#end
	}

	public static function colorMaski(index:UInt, r:Bool, g:Bool, b:Bool, a:Bool):Void {
		#if cpp
		Glad.colorMaski(index, boolToInt(r), boolToInt(g), boolToInt(b), boolToInt(a));
		#elseif (js || html5)
		#if debug
		throw "colorMaski not supported in WebGL; using global colorMask instead";
		#end
		context.colorMask(r, g, b, a);
		#end
	}

	public static function getBooleani_v(target:Int, index:UInt):Bool {
		#if cpp
		var v:GlBool = 0;
		Glad.getBooleani_v(target, index, Pointer.addressOf(v));
		return v != 0;
		#elseif (js || html5)
		return false;
		#else
		return false;
		#end
	}

	public static function getIntegeri_v(target:Int, index:UInt):Int {
		#if cpp
		var v:Int = 0;
		Glad.getIntegeri_v(target, index, Pointer.addressOf(v));
		return v;
		#elseif (js || html5)
		return context.getIndexedParameter(target, index);
		#else
		return 0;
		#end
	}

	public static function enablei(target:Int, index:UInt):Void {
		#if cpp
		Glad.enablei(target, index);
		#elseif (js || html5)
		#end
	}

	public static function disablei(target:Int, index:UInt):Void {
		#if cpp
		Glad.disablei(target, index);
		#elseif (js || html5)
		#end
	}

	public static function isEnabledi(target:Int, index:UInt):Bool {
		#if cpp
		return Glad.isEnabledi(target, index) != 0;
		#elseif (js || html5)
		return false;
		#else
		return false;
		#end
	}

	public static function beginTransformFeedback(primitiveMode:Int):Void {
		#if cpp
		Glad.beginTransformFeedback(primitiveMode);
		#elseif (js || html5)
		context.beginTransformFeedback(primitiveMode);
		#end
	}

	public static function endTransformFeedback():Void {
		#if cpp
		Glad.endTransformFeedback();
		#elseif (js || html5)
		context.endTransformFeedback();
		#end
	}

	public static function bindBufferRange(target:Int, index:UInt, buffer:GLBuffer, offset:Int, size:Int64):Void {
		#if cpp
		Glad.bindBufferRange(target, index, buffer, offset, untyped __cpp__("(long int){0}", size));
		#elseif (js || html5)
		context.bindBufferRange(target, index, buffer, offset, cast size);
		#end
	}

	public static function bindBufferBase(target:Int, index:UInt, buffer:GLBuffer):Void {
		#if cpp
		Glad.bindBufferBase(target, index, buffer);
		#elseif (js || html5)
		context.bindBufferBase(target, index, buffer);
		#end
	}

	public static function genVertexArray():GLVertexArray {
		#if cpp
		var vao:Int = 0;
		Glad.genVertexArrays(1, untyped __cpp__("(const int*) {0}", RawPointer.addressOf(vao)));
		return vao;
		#elseif (js || html5)
		return context.createVertexArray();
		#else
		return 0;
		#end
	}

	public static function bindVertexArray(vao:GLVertexArray):Void {
		#if cpp
		Glad.bindVertexArray(vao);
		#elseif (js || html5)
		context.bindVertexArray(vao);
		#end
	}

	private static function boolToInt(v:Bool):Int {
		return v ? 1 : 0;
	}
}

typedef GLAttribute = {
	length:Int,
	size:Int,
	type:Int,
	?name:String
}

typedef GLUniform = GLAttribute;

typedef GLAttachedShaders = {
	count:Int,
	shaders:Array<UInt32>
}