//
//  GraphicsDevice.h
//  XNI
//
//  Created by Matej Jan on 27.7.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/ES1/glext.h>
#import <OpenGLES/ES2/glext.h>

#import "Retronator.Xni.Framework.classes.h"
#import "Retronator.Xni.Framework.Graphics.classes.h"

@interface GraphicsDevice : NSObject {
    Game *game;
	EAGLContext *context;
	
	// The pixel dimensions of the CAEAGLLayer
	GLint backingWidth;
	GLint backingHeight;
	
	// The OpenGL names for the buffers used to render to this view
	GLuint defaultFramebuffer, colorRenderbuffer, depthRenderbuffer;
}

@property (nonatomic, readonly) GraphicsProfile graphicsProfile;

- (id) initWithGame:(Game*) theGame;

// Presentation
- (void) reset;
- (void) present;

// Render buffers
- (void) clearWithColor:(Color*)color;
- (void) clearWithOptions:(ClearOptions)options color:(Color*)color depth:(float)depth stencil:(int)stencil;

// Low level methods
- (uint) createTexture;

//- (void) getData:(void*)data fromTexture2D:(Texture2D*)texture level:(int)level;

- (void) setData:(void*)data toTexture2D:(Texture2D*)texture SourceRectangle:(Rectangle*)rect level:(int)level;

// Profile specific
- (EAGLContext*) createContext;

@end
