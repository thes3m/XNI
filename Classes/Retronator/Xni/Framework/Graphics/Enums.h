#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES2/gl.h>

typedef enum {
    ClearOptionsDepthBuffer = GL_DEPTH_BUFFER_BIT,
    ClearOptionsStencil = GL_STENCIL_BUFFER_BIT,
    ClearOptionsTarget = GL_COLOR_BUFFER_BIT
} ClearOptions;

typedef enum {
    CompareFunctionAlways = GL_ALWAYS,
    CompareFunctionEqual = GL_EQUAL,
    CompareFunctionGreater = GL_GREATER,
    CompareFunctionGreaterEqual = GL_GEQUAL,
    CompareFunctionLess = GL_LESS,
    CompareFunctionLessEqual = GL_LEQUAL,
    CompareFunctionNever = GL_NEVER,
    CompareFunctionNotEqual = GL_NOTEQUAL
} CompareFunction;

typedef enum {
    DataTypeUnsignedByte = GL_UNSIGNED_BYTE,
    DataTypeByte = GL_BYTE,
    DataTypeUnsignedShort = GL_UNSIGNED_SHORT,
    DataTypeShort = GL_SHORT,
    DataTypeFixed = GL_FIXED,
    DataTypeFloat = GL_FLOAT
} DataType;

typedef enum {
    DepthFormatNone,
    DepthFormatDepth16,
    DepthFormatDepth24,
    DepthFormatDepth24Stencil8	
} DepthFormat;

typedef enum {
    FogModeNone = 0,
    FogModeLinear = GL_LINEAR,
    FogModeExponent = GL_EXP,
    FogModeExponentSquared = GL_EXP2
} FogMode;

typedef enum {
	GraphicsProfileReach,
	GraphicsProfileHiDef
} GraphicsProfile;

typedef enum {
    IndexElementSizeEightBits = 1,
    IndexElementSizeSixteenBits = 2,
} IndexElementSize;

typedef enum {
    PrimitiveTypePointList = GL_POINTS,
    PrimitiveTypeLineList = GL_LINES,
    PrimitiveTypeLineStrip = GL_LINE_STRIP,
    PrimitiveTypeTriangleList = GL_TRIANGLES,
    PrimitiveTypeTriangleStrip = GL_TRIANGLE_STRIP,
    PrimitiveTypeTriangleFan = GL_TRIANGLE_FAN
} PrimitiveType;

typedef enum {
    ResourceUsageStatic = GL_STATIC_DRAW,
    ResourceUsageDynamic = GL_DYNAMIC_DRAW
} ResourceUsage;

typedef enum {
    ResourceTypeTexture2D = GL_TEXTURE_2D,
    ResourceTypeIndexBuffer = GL_ELEMENT_ARRAY_BUFFER,
    ResourceTypeVertexBuffer = GL_ARRAY_BUFFER
} ResourceType;

typedef enum {
    SurfaceFormatColor,
    SurfaceFormatBgr565,
    SurfaceFormatBgra5551,
    SurfaceFormatBgra4444,
    SurfaceFormatDxt1,
    SurfaceFormatDxt3,
    SurfaceFormatDxt5,
    SurfaceFormatNormalizedByte2,
    SurfaceFormatNormalizedByte4,
    SurfaceFormatRgba1010102,
    SurfaceFormatRg32,
    SurfaceFormatRgba64,
    SurfaceFormatAlpha8,
    SurfaceFormatSingle,
    SurfaceFormatVector2,
    SurfaceFormatVector4,
    SurfaceFormatHalfSingle,
    SurfaceFormatHalfVector2,
    SurfaceFormatHalfVector4,
    SurfaceFormatHdrBlendable	
} SurfaceFormat;

typedef enum {
    VertexElementFormatSingle,
    VertexElementFormatVector2,
    VertexElementFormatVector3,
    VertexElementFormatVector4,
    VertexElementFormatHalfVector2,
    VertexElementFormatHalfVector4,
    VertexElementFormatRgba64,
    VertexElementFormatColor,
    VertexElementFormatRgba32,
    VertexElementFormatRg32,
    VertexElementFormatNormalizedShort2,
    VertexElementFormatNormalizedShort4,
    VertexElementFormatNormalized101010,
    VertexElementFormatShort2,
    VertexElementFormatShort4,
    VertexElementFormatByte4,
    VertexElementFormatUInt101010,
    VertexElementFormatUnused
} VertexElementFormat;

typedef enum {
    VertexElementUsagePosition = GL_VERTEX_ARRAY,
    VertexElementUsageNormal = GL_NORMAL_ARRAY,
    VertexElementUsageColor = GL_COLOR_ARRAY,
    VertexElementUsageTextureCoordinate = GL_TEXTURE_COORD_ARRAY,
    VertexElementUsagePointSize = GL_POINT_SIZE_ARRAY_OES
} VertexElementUsage;
