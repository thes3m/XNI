//
//  GameWindow.m
//  XNI
//
//  Created by Matej Jan on 20.7.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "GameWindow.h"
#import "GameWindow+Internal.h"

#import "Retronator.Xni.Framework.h"
#import "GameViewController.h"
#import "GameView.h"
#import "TouchPanel+Internal.h"

@interface GameWindow()

- (Rectangle*) calculateClientBounds;

@end


@implementation GameWindow

- (id) init {
    if (self = [super init]) {
        clientSizeChanged = [[Event alloc] init];
		orientationChanged = [[Event alloc] init];
		
		clientBounds = [[Rectangle rectangleWithCGRect:[[UIScreen mainScreen] bounds]] retain];	
        float scale = [UIScreen mainScreen].scale;
        clientBounds.width *= scale;
        clientBounds.height *= scale;
    }
    return self;
}

// PROPERTIES

@synthesize clientBounds;
@synthesize clientSizeChanged;
@synthesize orientationChanged;

- (DisplayOrientation) currentOrientation {
	return [GameViewController getDisplayOrientationForInterfaceOrientation:gameViewController.interfaceOrientation];
}

- (UIWindow*) window {
	return window;
}

- (GameViewController *) gameViewController {
	return gameViewController;
}

- (id) handle {
    return (id)gameViewController.view.layer;
}

// METHODS

- (void) beginScreenDeviceChangeWithFullscreen:(BOOL)willBeFullscreen {
    gameViewController.wantsFullScreenLayout = willBeFullscreen;
    [[UIApplication sharedApplication] setStatusBarHidden:willBeFullscreen];
}

- (void) endScreenDeviceChangeWithClientWidth:(int)clientWidth clientHeight:(int)clientHeight {
	CGRect realFrame = [UIScreen mainScreen].applicationFrame;
	float realScale = [UIScreen mainScreen].scale;
	
	float realAspectRatio = realFrame.size.width / realFrame.size.height;
	
	if (clientWidth == 0) {
		clientWidth = realFrame.size.width * realScale;
	}
	
	if (clientHeight == 0) {
		clientHeight = realFrame.size.height * realScale;
	}
	
	float targetAspectRatio = (float)clientWidth/(float)clientHeight;
	CGRect targetFrame;
	
	if (targetAspectRatio >= realAspectRatio) {
		// Add black borders on top and bottom.
		targetFrame.size.width = realFrame.size.width ;
		targetFrame.size.height = targetFrame.size.width / targetAspectRatio;
	} else {
		// Add black borders on left and right.
		targetFrame.size.height = realFrame.size.height;
		targetFrame.size.width = targetFrame.size.height * targetAspectRatio;
	}

	// Center the window.
	targetFrame.origin.x = realFrame.origin.x + (realFrame.size.width - targetFrame.size.width) / 2;
	targetFrame.origin.y = realFrame.origin.y + (realFrame.size.height - targetFrame.size.height) / 2;
	
	// Resize the target view.
	gameViewController.view.frame = targetFrame;
	
	// Set scale factor.
	if (targetAspectRatio >= realAspectRatio) {
		gameViewController.gameView.scale = clientWidth / realFrame.size.width;
	} else {
		gameViewController.gameView.scale = clientHeight / realFrame.size.height;
	}

	// Recalculate client bounds.
	[clientBounds release];
	clientBounds = [[self calculateClientBounds] retain];	
}

- (void) initialize {
	// Create UI window.
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	// Create game view controller.
	gameViewController = [[GameViewController alloc] initWithGameWindow:self];
	
	[((GameView*)gameViewController.view).viewSizeChanged
	 subscribeDelegate:[Delegate delegateWithTarget:self Method:@selector(gameViewSizeChanged)]];
	
	// Add the game view to the window.
	[window addSubview: gameViewController.view];
    window.rootViewController = gameViewController;
	
	// Report view to TouchPanel.
	[[TouchPanel getInstance] setView:gameViewController.gameView];
	
	// Present the window.
	[window makeKeyAndVisible];	
}

- (void) setSupportedOrientations:(DisplayOrientation)orientations {
	gameViewController.supportedOrientations = orientations;
}

- (void) gameViewSizeChanged {
	Rectangle *newClientBounds = [self calculateClientBounds];
    if (![newClientBounds equals:clientBounds]) {
		[clientBounds release];
        clientBounds = [newClientBounds retain];
        [clientSizeChanged raiseWithSender:self];
    }
}

- (Rectangle*) calculateClientBounds {
	Rectangle *bounds = [Rectangle rectangleWithCGRect:gameViewController.view.bounds];
	float scale = gameViewController.gameView.scale;
	bounds.width *= scale;
	bounds.height *= scale;
	return bounds;
}

- (void) dealloc
{
	[clientBounds release];
    [gameViewController release];
    [window release];
    [super dealloc];
}

@end
