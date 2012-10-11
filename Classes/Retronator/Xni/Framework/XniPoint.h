//
//  XniPoint.h
//  XNI
//
//  Created by Matej Jan on 8.12.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Retronator.Xni.Framework.classes.h"

@interface XniPoint : NSObject <NSCopying, NSCoding> {
	PointStruct data;
}

- (id) initWithIntX:(int)x y:(int)y;
- (id) initWithPointStruct:(PointStruct*) pointStruct;
- (id) initWithPoint:(XniPoint*) point;

+ (XniPoint*) pointWithX:(int)x y:(int)y;
+ (XniPoint*) pointWithStruct:(PointStruct*) pointStruct;
+ (XniPoint*) pointWithPoint:(XniPoint*) point;
+ (XniPoint*) pointWithCGPoint:(CGPoint) cgPoint;

@property (nonatomic) int x;
@property (nonatomic) int y;
@property (nonatomic, readonly) PointStruct *data;

+ (XniPoint*) add:(XniPoint*)value1 to:(XniPoint*)value2;
+ (XniPoint*) subtract:(XniPoint*)value1 by:(XniPoint*)value2;

- (XniPoint*) set:(XniPoint*)value;

- (XniPoint*) add:(XniPoint*)value;
- (XniPoint*) subtract:(XniPoint*)value;

- (BOOL) equals:(XniPoint*)point;

+ (XniPoint*) zero;

@end
