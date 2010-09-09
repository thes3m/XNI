//
//  PixelBitmapContent.m
//  XNI
//
//  Created by Matej Jan on 8.9.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "PixelBitmapContent.h"

#import "Retronator.Xni.Framework.Content.Pipeline.Graphics.h"

@implementation PixelBitmapContent

- (id) initWithWidth:(int)theWidth Height:(int)theHeight Format:(SurfaceFormat)theFormat {
	if (self = [super initWithWidth:theWidth Height:theHeight]) {
		format = theFormat;
		BOOL result = [VectorConverter tryGetSizeInBytesOfSurfaceFormat:format SizeInBytes:&bytesPerPixel];
		if (!result) {
			[NSException raise:@"ArgumentException" format:@"The provided format is not supported"];
		}
	}
	return self;	
}

- (void*) getPixelData { 
	return pixelData; 
}

- (void) setPixelData:(void*)sourceData {
	pixelData = sourceData;
}

- (SurfaceFormat) tryGetFormat { 
	return format;
}

- (Byte *) getPixelAtX:(int)x Y:(int)y {
	// Index into the data array at bytesPerPixel intervals.
	return &pixelData[(x + y * width) * bytesPerPixel];
}

- (void) setPixelAtX:(int)x Y:(int)y Value:(Byte *)value {
	// The value contains bytesPerPixel bytes.
	memcpy(&pixelData[(x + y * width) * bytesPerPixel], value, bytesPerPixel);
}

@end
