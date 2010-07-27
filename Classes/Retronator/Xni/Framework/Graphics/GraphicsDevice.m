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
- (void) clearWithColor:(Color*)color {}
- (void) clearWithOptions:(ClearOptions)options color:(Color*)color depth:(float)depth stencil:(int)stencil {}

- (EAGLContext*) createContext { return nil; }

@end
