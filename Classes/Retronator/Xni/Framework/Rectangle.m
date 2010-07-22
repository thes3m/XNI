//
//  Rectangle.m
//  XNI
//
//  Created by Matej Jan on 22.7.10.
//  Copyright 2010 Retronator, Razum. All rights reserved.
//

#import "Rectangle.h"


@implementation Rectangle

// CONSTRUCTORS

- (id) initWithX:(int)x Y:(int)y Width:(int)width Height:(int)height {
	if (self = [super init]) {
		data = RectangleMake(x, y, width, height);
	}
	return self;
}

- (id) initWithStruct:(RectangleStruct*) rectangleStruct {
	if (self = [super init]) {
		data = *rectangleStruct;
	}
	return self;
}

- (id) initWithRectangle:(Rectangle*) rectangle {
	return [self initWithStruct:rectangle.data];
}

+ (Rectangle*) rectangleWithX:(int)x Y:(int)y Width:(int)width Height:(int)height {
	return [[[Rectangle alloc] initWithX:x Y:y Width:width Height:height] autorelease];
}

+ (Rectangle*) rectangleWithStruct:(RectangleStruct*) rectangleStruct {
	return [[[Rectangle alloc] initWithStruct:rectangleStruct] autorelease];
}

+ (Rectangle*) rectangleWithRectangle:(Rectangle*) rectangle {
	return [[[Rectangle alloc] initWithRectangle:rectangle] autorelease];
}

+ (Rectangle*) rectangleWithCGRect:(CGRect) cgRect {
	return [Rectangle rectangleWithX:cgRect.origin.x Y:cgRect.origin.y
							   Width:cgRect.size.width Height:cgRect.size.height];
}

// PROPERTIES

- (int) x {return data.x;}
- (void) setX:(int)value {data.x = value;}

- (int) y {return data.y;}
- (void) setY:(int)value {data.y = value;}

- (int) width {return data.width;}
- (void) setWidth:(int)value {data.width = value;}

- (int) height {return data.height;}
- (void) setHeight:(int)value {data.height = value;}

- (RectangleStruct*) data {return &data;}

// METHODS

- (BOOL) equals:(Rectangle*)rectangle {
	return rectangle.data->x == data.x && rectangle.data->y == data.y &&
	rectangle.data->width == data.width && rectangle.data->height == data.height;
}

- (BOOL) isEqual:(id)object {
    if ([object isKindOfClass:[Rectangle class]]) {
        return [self equals:object];
    }
    return NO;
}

- (NSUInteger) hash {
    return data.x ^ data.y ^ data.width ^ data.height;
}

// CONSTANTS

+ (Rectangle*) empty {return [Rectangle rectangleWithX:0 Y:0 Width:0 Height:0];}

@end
