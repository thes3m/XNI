//
//  GameComponent.m
//  XNI
//
//  Created by Matej Jan on 12.10.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "GameComponent.h"

#import "System.h"
#import "Retronator.Xni.Framework.h"

@implementation GameComponent

- (id) initWithGame:(Game *)theGame {
    if (self = [super init]) {
        game = theGame;
        
		enabled = YES;
		updateOrder = 0;

        enabledChanged = [[Event alloc] init];
		updateOrderChanged = [[Event alloc] init];
    }
    return self;
}

@synthesize game;

@synthesize enabled;
- (void) setEnabled:(BOOL)value {
    if (enabled != value) {
        enabled = value;
        [self onEnabledChanged];
    }
}

@synthesize updateOrder;
- (void) setUpdateOrder:(int)value {
	if (updateOrder != value) {
		updateOrder = value;
        [self onUpdateOrderChanged];
	}
}

@synthesize enabledChanged;
@synthesize updateOrderChanged;

- (void) initialize {}

- (void) onEnabledChanged {
    [enabledChanged raiseWithSender:self];
}

- (void) onUpdateOrderChanged {
    [updateOrderChanged raiseWithSender:self];
}

- (void) updateWithGameTime:(GameTime*)gameTime {}

- (void) dealloc
{
	[updateOrderChanged release];
    [enabledChanged release];
    [super dealloc];
}

@end

