//
//  BitmapContent.m
//  XNI
//
//  Created by Matej Jan on 7.9.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "BitmapContent.h"


@implementation BitmapContent

- (id) initWithWidth:(int)theWidth Height:(int)theHeight {
	if (self = [super init]) {
		width = theWidth;
		height = theHeight;
	}
	return self;
}

@synthesize width;
@synthesize height;

- (void*) getPixelData { return nil; }
- (void) setPixelData:(void*)sourceData { }
- (SurfaceFormat) tryGetFormat { return SurfaceFormatColor; }

@end
