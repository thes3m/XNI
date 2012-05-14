//
//  ReachGraphicsDevice.h
//  XNI
//
//  Created by Matej Jan on 27.7.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GraphicsDevice.h"


@interface ReachGraphicsDevice : GraphicsDevice {
    BOOL lightsActive[8];
}

- (void) setLight:(uint)lightname to:(BOOL)value;

@end
