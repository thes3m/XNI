//
//  GraphicsDevice.m
//  XNI
//
//  Created by Matej Jan on 27.7.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "GraphicsDevice.h"

#import "Retronator.Xni.Framework.h"
#import "Retronator.Xni.Framework.Graphics.h"

@interface GraphicsDevice()

+ (void) getFormat:(GLenum*)format AndType:(GLenum*)type ForSurfaceFormat:(SurfaceFormat)surfaceFormat;

@end

@implementation GraphicsDevice

- (id) initWithGame:(Game*)theGame
{
	if (self = [super init])
	{
        game = theGame;
        
        // Create an OpenGL ES context
		context = [self createContext];
        
        if (!context || ![EAGLContext setCurrentContext:context]) {
            [self release];
            return nil;
        }
        
		// Create default framebuffer object.
		glGenFramebuffersOES(1, &defaultFramebuffer);
		glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFramebuffer);
        
        // Create the color buffer.
       	glGenRenderbuffersOES(1, &colorRenderbuffer);
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
		glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, colorRenderbuffer);
        
        // Create the depth buffer.
        glGenRenderbuffersOES(1, &depthRenderbuffer);
        glBindRenderbufferOES(GL_RENDERBUFFER_OES, depthRenderbuffer);
        glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, depthRenderbuffer);
        
        // Do the initial reset.
        [self reset];
	}
	
	return self;
}

@synthesize graphicsProfile;

// Presentation
- (void) reset {
    CAEAGLLayer *layer = (CAEAGLLayer*)game.window.handle;
    
	// Allocate color buffer backing based on the current layer size.
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    [context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:layer];
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
    glViewport(0, 0, backingWidth, backingHeight);
	
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, depthRenderbuffer);
    glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, backingWidth, backingHeight);
    
    if (glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES){
		NSLog(@"Failed to make complete framebuffer object %x.", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
    } else {
        NSLog(@"Created a device with dimensions: %ix%i.", backingWidth, backingHeight);
    }
}

- (void) present {
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

// Render buffers

- (void) clearWithColor:(Color *)color {
    glClearColor(color.r / 255.0, color.g / 255.0, color.b / 255.0, color.a / 255.0);
    glClearDepthf(1);
    glClear(ClearOptionsTarget | ClearOptionsDepthBuffer);
}

- (void) clearWithOptions:(ClearOptions)options color:(Color *)color depth:(float)depth stencil:(int)stencil {
    glClearColor(color.r / 255.0, color.g / 255.0, color.b / 255.0, color.a / 255.0);
    glClearDepthf(depth);
    glClearStencil(stencil);
    glClear(options);    
}

// Low level methods
- (uint) createTexture {
    GLuint textureId;
    glGenTextures(1, &textureId);
    return textureId;    
}

- (void) setData:(void*)data toTexture2D:(Texture2D*)texture SourceRectangle:(Rectangle*)rect level:(int)level {
	GLenum format, type;
	[GraphicsDevice getFormat:&format AndType:&type ForSurfaceFormat:texture.format];
	
    glBindTexture(GL_TEXTURE_2D, texture.textureId);	
    
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR); 
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
	
	if (rect) {
		glTexSubImage2D(GL_TEXTURE_2D, level, rect.x, rect.y, rect.width, rect.height, format, type, data);
	} else {
		glTexImage2D(GL_TEXTURE_2D, level, format, texture.width, texture.height, 0, format, type, data);
    }
	
	glBindTexture(GL_TEXTURE_2D, 0);
}


// Profile specific

- (EAGLContext*) createContext { return nil; }

// Private methods

+ (void) getFormat:(GLenum*)format AndType:(GLenum*)type ForSurfaceFormat:(SurfaceFormat)surfaceFormat {
	switch (surfaceFormat) {
		case SurfaceFormatColor:
			*format = GL_RGBA;
			*type = GL_UNSIGNED_BYTE;
			break;
		case SurfaceFormatAlpha8:
			*format = GL_ALPHA;
			*type = GL_UNSIGNED_BYTE;
			break;
		case SurfaceFormatRgb565:
			*format = GL_RGB;
			*type = GL_UNSIGNED_SHORT_5_6_5;
			break;
		case SurfaceFormatRgba4444:
			*format = GL_RGBA;
			*type = GL_UNSIGNED_SHORT_4_4_4_4;
			break;
		case SurfaceFormatRgba5551:
			*format = GL_RGBA;
			*type = GL_UNSIGNED_SHORT_5_5_5_1;
			break;
		default:
			break;
	}
}


@end
