//
//  Color.m
//  XNI
//
//  Created by Matej Jan on 27.7.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "Color.h"

#define CLAMP_TO_BYTE(X) (X < 0 ? 0 : (X > 255 ? 255 : X))


@implementation Color

// CONSTRUCTORS

- (id) initWithRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha {
    if (self = [super init]) {
        red = CLAMP_TO_BYTE(red);
        green = CLAMP_TO_BYTE(green) << 8;
        blue = CLAMP_TO_BYTE(blue) << 16;
        alpha = CLAMP_TO_BYTE(alpha) << 24;
		packedValue = red | green | blue | alpha;
    }
    return self;
}

- (id) initWithRed:(int)red Green:(int)green Blue:(int)blue {
    return [self initWithRed:red Green:green Blue:blue Alpha:255];
}

- (id) initWithPercentageRed:(float)red Green:(float)green Blue:(float)blue Alpha:(float)alpha {
    return [self initWithRed:255 * red Green:255 * green Blue:255 * blue Alpha:255 * alpha];
}

- (id) initWithPercentageRed:(float)red Green:(float)green Blue:(float)blue {
    return [self initWithPercentageRed:red Green:green Blue:blue Alpha:1];
}

- (id) initWithColor:(Color*)color {
    return [self initWithRed:color.r Green:color.g Blue:color.b Alpha:color.a];
}

+ (Color*) colorWithRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha {
    return [[[Color alloc] initWithRed:red Green:green Blue:blue Alpha:alpha] autorelease];
}

+ (Color*) colorWithRed:(int)red Green:(int)green Blue:(int)blue {
    return [[[Color alloc] initWithRed:red Green:green Blue:blue] autorelease];
}

+ (Color*) colorWithPercentageRed:(float)red Green:(float)green Blue:(float)blue Alpha:(float)alpha {
    return [[[Color alloc] initWithPercentageRed:red Green:green Blue:blue Alpha:alpha] autorelease];
}

+ (Color*) colorWithPercentageRed:(float)red Green:(float)green Blue:(float)blue {
    return [[[Color alloc] initWithPercentageRed:red Green:green Blue:blue] autorelease];
}

+ (Color*) colorWithColor:(Color *)color {
    return [[[Color alloc] initWithColor:color] autorelease];
}

// PROPERTIES

- (Byte) r {return (Byte)packedValue;}
- (void) setR:(Byte)value {packedValue = packedValue & 0xffffff00 | value;}

- (Byte) g {return (Byte)(packedValue >> 8);}
- (void) setG:(Byte)value {packedValue = packedValue & 0xffff00ff | ((uint)value << 8);}

- (Byte) b {return (Byte)(packedValue >> 16);}
- (void) setB:(Byte)value {packedValue = packedValue & 0xff00ffff | ((uint)value << 16);}

- (Byte) a {return (Byte)(packedValue >> 24);}
- (void) setA:(Byte)value {packedValue = packedValue & 0x00ffffff | ((uint)value << 24);}

@synthesize packedValue;

// METHODS

/*- (Vector3 *) toVector3 {
    return [Vector3 vectorWithX:data.red Y:data.green Z:data.blue];
}*/


// Constants
+ (Color*) black {return [Color colorWithRed:0 Green:0 Blue:0];}
+ (Color*) blue {return [Color colorWithRed:0 Green:0 Blue:255];}
+ (Color*) red {return [Color colorWithRed:255 Green:0 Blue:0];}
+ (Color*) fuchsia {return [Color colorWithRed:255 Green:0 Blue:255];}
+ (Color*) lime {return [Color colorWithRed:0 Green:255 Blue:0];}
+ (Color*) cyan {return [Color colorWithRed:0 Green:255 Blue:255];}
+ (Color*) yellow {return [Color colorWithRed:255 Green:255 Blue:0];}
+ (Color*) white {return [Color colorWithRed:255 Green:255 Blue:255];}
+ (Color*) transparent {return [Color colorWithRed:0 Green:0 Blue:0 Alpha:0];}

@end
