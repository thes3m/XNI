//
//  TouchPanel.h
//  XNI
//
//  Created by Matej Jan on 29.9.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Retronator.Xni.Framework.classes.h"
#import "Retronator.Xni.Framework.Input.Touch.classes.h"

@interface TouchPanel : NSObject {

}

+ (int) getDisplayWidth;
+ (void) setDisplayWidth:(int)value;

+ (int) getDisplayHeight;
+ (void) setDisplayHeight:(int)value;

+ (DisplayOrientation) getDisplayOrientation;
+ (void) setDisplayOrientation:(DisplayOrientation)value;

+ (GestureType) getEnabledGestures;
+ (void) setEnabledGestures:(GestureType)value;

+ (BOOL) isGestureAvailable;
+ (TouchCollection*) getState;
+ (GestureSample*) readGesture;

@end
