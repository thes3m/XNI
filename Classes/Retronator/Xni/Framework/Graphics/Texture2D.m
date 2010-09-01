//
//  Texture2D.m
//  XNI
//
//  Created by Matej Jan on 1.9.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "Texture2D.h"
#import <UIKit/UIKit.h>

#import "Retronator.Xni.Framework.h"
#import "Retronator.Xni.Framework.Graphics.h"

@implementation Texture2D

- (id) initWithGraphicsDevice:(GraphicsDevice*)theGraphicsDevice Width:(int)theWidth Height:(int)theHeight {
	if (self = [super initWithGraphicsDevice:theGraphicsDevice SurfaceFormat:SurfaceFormatColor LevelCount:1]) {
		width = theWidth;
		height = theHeight;
		textureId = [graphicsDevice createTexture];
	}
	return self;
}

- (Rectangle*) bounds {
	return [Rectangle rectangleWithX:0 Y:0 Width:width Height:height];
}

@synthesize width;
@synthesize height;


+ (Texture2D*) fromData:(NSData*)textureData GraphicsDevice:(GraphicsDevice*)graphicsDevice {
    if (graphicsDevice == nil) {
        [NSException raise:@"ArgumentNullException" format:@"The graphics device cannot be null."];
    }
    
    UIImage *image = [[UIImage alloc] initWithData:textureData];
    if (image == nil) {
        [NSException raise:@"NotSupportedException" format:@"textureData contains an unknown format."];
        return nil;
    }
    
    GLuint width = CGImageGetWidth(image.CGImage);
    GLuint height = CGImageGetHeight(image.CGImage);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    void *imageData = malloc(height * width * 4);
    
    CGContextRef textureContext = CGBitmapContextCreate(imageData, width, height, 8, 4 * width, colorSpace,
                                                        kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big );
    CGColorSpaceRelease(colorSpace);
    CGContextClearRect(textureContext, CGRectMake(0, 0, width, height));
    CGContextTranslateCTM(textureContext, 0, 0);
    CGContextDrawImage(textureContext, CGRectMake(0, 0, width, height), image.CGImage);
    
    Texture2D *texture = [[Texture2D alloc] initWithGraphicsDevice:graphicsDevice Width:(int)width Height:(int)height];
    [texture setDataFrom:imageData];
    
    CGContextRelease(textureContext);  
    free(imageData);
    [image release];
    
    return texture;	
}

- (void) setDataFrom:(void *)data {
	[graphicsDevice setData:data toTexture2D:self level:0];
}

@end
