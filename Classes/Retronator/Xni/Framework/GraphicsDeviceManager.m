//
//  GraphicsDeviceManager.m
//  XNI
//
//  Created by Matej Jan on 27.7.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "GraphicsDeviceManager.h"

#import "Retronator.Xni.Framework.h"
#import "Retronator.Xni.Framework.Graphics.h"

@implementation GraphicsDeviceManager
- (id) initWithGame:(Game*)theGame {
    if (self = [super init]) {
        game = theGame;
        
        deviceCreated = [[Event alloc] init];
        deviceDisposing = [[Event alloc] init];
        deviceReseting = [[Event alloc] init];
        deviceReset = [[Event alloc] init];
        
        [game.services addService:self ofType:[Protocols graphicsDeviceManager]];
        [game.services addService:self ofType:[Protocols graphicsDeviceService]];
    }
    return self;
}

@synthesize graphicsProfile;
@synthesize isFullScreen;
@synthesize preferMultiSampling;
@synthesize preferedSurfaceFormat;
@synthesize preferedBackBufferWidth;
@synthesize preferedBackBufferHeight;
@synthesize preferedDepthStencilFormat;
@synthesize supportedOrientations;

@synthesize graphicsDevice;
@synthesize deviceCreated;
@synthesize deviceDisposing;
@synthesize deviceReseting;
@synthesize deviceReset;

- (void) toggleFullscreen {
    isFullScreen = !isFullScreen;
    [self applyChanges];
}

- (void) createDevice {
    [self applyChanges];
    
    // Listen to client size change from now on.
    [game.window.clientSizeChanged
	  subscribeDelegate:[Delegate delegateWithTarget:self Method:@selector(applyChanges)]];
}

- (BOOL) beginDraw {
    return YES;
}

- (void) endDraw {
    [graphicsDevice present];
}

- (void) applyChanges {
    [game.window beginScreenDeviceChangeWithFullscreen:isFullScreen];
	
	if (graphicsDevice != nil && graphicsDevice.graphicsProfile != graphicsProfile) {
		// Different graphics profile requested.
		[deviceDisposing raiseWithSender:self];
		[graphicsDevice release];
		graphicsDevice = nil;
	}
    if (graphicsDevice == nil) {
        // Create a new device.
        graphicsDevice = [[GraphicsDevice alloc] initWithGame:game];
        [game.window endScreenDeviceChange];
        [deviceCreated raiseWithSender:self];
    } else {
        // Reset the existing device.
        [deviceReseting raiseWithSender:self];
        [graphicsDevice reset];
        [game.window endScreenDeviceChange];
        [deviceReset raiseWithSender:self];
    }
}

- (void) dealloc {
    [deviceDisposing raiseWithSender:self];
    [graphicsDevice release];
    [deviceCreated release];
    [deviceDisposing release];
    [deviceReseting release];
    [deviceReset release];
    [super dealloc];
}
@end
