//
//  Color.h
//  XNI
//
//  Created by Matej Jan on 27.7.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Retronator.Xni.Framework.classes.h"

@interface Color : NSObject {
	uint packedValue;
}

- (id) initWithRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha;
- (id) initWithRed:(int)red Green:(int)green Blue:(int)blue;
- (id) initWithPercentageRed:(float)red Green:(float)green Blue:(float)blue Alpha:(float)alpha;
- (id) initWithPercentageRed:(float)red Green:(float)green Blue:(float)blue;
- (id) initWithColor:(Color*)color;

+ (Color*) colorWithRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha;
+ (Color*) colorWithRed:(int)red Green:(int)green Blue:(int)blue;
+ (Color*) colorWithPercentageRed:(float)red Green:(float)green Blue:(float)blue Alpha:(float)alpha;
+ (Color*) colorWithPercentageRed:(float)red Green:(float)green Blue:(float)blue;
+ (Color*) colorWithColor:(Color*)color;

@property (nonatomic) Byte r;
@property (nonatomic) Byte g;
@property (nonatomic) Byte b;
@property (nonatomic) Byte a;
@property (nonatomic) uint packedValue;

//- (Vector3*) toVector3;

// Constants

+ (Color*) black;
+ (Color*) blue;
+ (Color*) red;
+ (Color*) fuchsia;
+ (Color*) lime;
+ (Color*) cyan;
+ (Color*) yellow;
+ (Color*) white;
+ (Color*) transparent;

@end
