//
//  RenderTarget2D.m
//  XNI
//
//  Created by Samo Pajk on 9/3/12.
//  Copyright (c) 2012 Samo Pajk. All rights reserved.
//

#import "RenderTarget2D.h"
#import "Retronator.Xni.Framework.h"
#import "Retronator.Xni.Framework.Graphics.h"

#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface RenderTarget2D (){
    GLuint framebuffer;
}

@end

@implementation RenderTarget2D

- (id)initWithGraphicsDevice:(GraphicsDevice *)theGraphicsDevice width:(int)theWidth height:(int)theHeight{
    
    return [self initWithGraphicsDevice:theGraphicsDevice width:theWidth height:theHeight mipmap:NO surfaceFormat:SurfaceFormatAlpha8 depthFormat:DepthFormatNone multiSampleCount:0 usage:RenderTargetUsageDiscardContents];
}

- (id)initWithGraphicsDevice:(GraphicsDevice *)theGraphicsDevice
                       width:(int)theWidth
                      height:(int)theHeight
                      mipmap:(BOOL)theMipmap
               surfaceFormat:(SurfaceFormat)theSurfaceFormat
                 depthFormat:(DepthFormat)theDepthFormat{
    
    return [self initWithGraphicsDevice:theGraphicsDevice width:theWidth height:theHeight mipmap:NO surfaceFormat:theSurfaceFormat depthFormat:theDepthFormat multiSampleCount:0 usage:RenderTargetUsageDiscardContents];
}

- (id)initWithGraphicsDevice:(GraphicsDevice *)theGraphicsDevice
                       width:(int)theWidth
                      height:(int)theHeight
                      mipmap:(BOOL)theMipmap
               surfaceFormat:(SurfaceFormat)theSurfaceFormat
                 depthFormat:(DepthFormat)theDepthFormat
            multiSampleCount:(int) theMultisampleCount
                       usage:(RenderTargetUsage)theUsage{
    
    self = [super initWithGraphicsDevice:theGraphicsDevice width:theWidth height:theHeight mipMaps:theMipmap format:theSurfaceFormat];
    if (self) {
        //Texture is already created by super object.
        //Here we only create a framebuffer.
        glGenFramebuffersOES(1, &framebuffer);
    }
    return self;
}

@synthesize renderTargetUsage, isContentLost;

-(GLuint) colorFramebuffer{
    return framebuffer;
}

- (void)dealloc{
    glDeleteFramebuffers(1, &framebuffer);
    [super dealloc];
}

//- (void) saveAsPng:(NSData*)textureData width:(int)width height:(int)height{
//    
//}

@end
