//
//  DrawableGameComponent.m
//  XNI
//
//  Created by Matej Jan on 12.10.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "DrawableGameComponent.h"
#import "System.h"
#import "Retronator.Xni.Framework.h"
#import "Retronator.Xni.Framework.Graphics.h"

@implementation DrawableGameComponent

- (id) initWithGame:(Game *)theGame {
    if (self = [super initWithGame:theGame]) {
        visible = YES;
        drawOrder = 0;
		
		visibleChanged = [[Event alloc] init];
		drawOrderChanged = [[Event alloc] init];
		
		graphicsDeviceService = [self.game.services getServiceOfType:[Protocols graphicsDeviceService]];
	}
	return self;
}

@synthesize visible;
- (void) setVisible:(BOOL)value {
	if (visible != value) {
		visible = value;
        [self onVisibleChanged];
	}
} 

@synthesize drawOrder;
- (void) setDrawOrder:(int)value {
	if (drawOrder != value) {
		drawOrder = value;
        [self onDrawOrderChanged];
	}
} 

@synthesize visibleChanged;
@synthesize drawOrderChanged;

- (GraphicsDevice*) graphicsDevice {
	return graphicsDeviceService.graphicsDevice;
}

- (void) initialize {
	if (!contentLoaded) {
		[self loadContent];
		contentLoaded = YES;
	}
}

- (void) loadContent {}
- (void) drawWithGameTime:(GameTime*)gameTime {}
- (void) unloadContent {}

- (void)onVisibleChanged {
    [visibleChanged raiseWithSender:self];
}

- (void)onDrawOrderChanged {
    [drawOrderChanged raiseWithSender:self];    
}

- (void) dealloc
{
	if (contentLoaded) {
		[self unloadContent];
	}
	[drawOrderChanged release];
	[visibleChanged release];
	[super dealloc];
}

@end

