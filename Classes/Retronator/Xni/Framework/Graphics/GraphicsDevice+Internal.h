//
//  GraphicsDevice+Internal.h
//  XNI
//
//  Created by Matej Jan on 29.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GraphicsDevice.h"

@interface GraphicsDevice (Internal)

@property (nonatomic) BOOL rrt;

- (uint) createTexture;
- (void) releaseTexture:(uint)textureId;

//- (void) getData:(void*)data fromTexture2D:(Texture2D*)texture level:(int)level;
- (void) setData:(void*)data toTexture2D:(Texture2D*)texture SourceRectangle:(Rectangle*)rect level:(int)level;

- (uint) createBuffer;
- (void) setData:(void*)data toIndexBuffer:(IndexBuffer*)buffer; 
- (void) setData:(void*)data toVertexBuffer:(VertexBuffer*)buffer;
- (void) releaseBuffer:(uint)bufferId;

// Profile specific
- (EAGLContext*) createContext;

@end
