//
//  Texture2D.h
//  XNI
//
//  Created by Matej Jan on 1.9.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Texture.h"

@interface Texture2D : Texture {
	int height;
	int width;
}

- (id) initWithGraphicsDevice:(GraphicsDevice*)theGraphicsDevice Width:(int)theWidth Height:(int)theHeight;
// - (id) initWithGraphicsDevice:(GraphicsDevice*)theGraphicsDevice Width:(int)theWidth Height:(int)theHeight MipMaps:(BOOL)generateMipMaps Format:(SurfaceFormat)theFormat;

@property (nonatomic, readonly) Rectangle *bounds;
@property (nonatomic, readonly) int height;
@property (nonatomic, readonly) int width;

+ (Texture2D*) fromData:(NSData*)textureData GraphicsDevice:(GraphicsDevice*)graphicsDevice;
//+ (Texture2D*) fromData:(NSData*)textureData GraphicsDevice:(GraphicsDevice*)graphicsDevice Width:(int)width Height:(int)height Zoom:(BOOL)zoom;

// - (void) getDataTo:(void *)data;
// - (void) getDataTo:(void *)data StartIndex:(int)startIndex ElementCount:(int)elementCount;
// - (void) getDataFromLevel:(int)level SourceRectangle:(Rectangle*)rect To:(void *)data StartIndex:(int)startIndex ElementCount:(int)elementCount;

- (void) setDataFrom:(void *)data;
// - (void) setDataFrom:(void *)data StartIndex:(int)startIndex ElementCount:(int)elementCount;
// - (void) setDataToLevel:(int)level SourceRectangle:(Rectangle*)rect From:(void *)data StartIndex:(int)startIndex ElementCount:(int)elementCount;

// - (void) saveAsJpeg:(NSData*)textureData Width:(int)width Height:(int)height;
// - (void) saveAsPng:(NSData*)textureData Width:(int)width Height:(int)height;

@end
