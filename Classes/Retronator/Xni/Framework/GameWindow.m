//
//  GameWindow.m
//  XNI
//
//  Created by Matej Jan on 20.7.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "GameWindow.h"

#import "Retronator.Xni.Framework.h"
#import "GameViewController.h"
#import "GameView.h"

@implementation GameWindow

- (id) init {
    if (self = [super init]) {
		clientBounds = [[Rectangle empty] retain];
        currentOrientation = DisplayOrientationDefault;
        clientSizeChanged = [[Event alloc] init];
		orientationChanged = [[Event alloc] init];
    }
    return self;
}

// PROPERTIES

@synthesize clientBounds;
@synthesize currentOrientation;

@synthesize clientSizeChanged;
@synthesize orientationChanged;

- (id) handle {
    return (id)gameViewController.view.layer;
}

// METHODS

- (void) initialize {
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Initialize game view controller.
    gameViewController = [[GameViewController alloc] initWithGameWindow:self];
    [((GameView*)gameViewController.view).viewSizeChanged
     subscribeDelegate:[Delegate delegateWithTarget:self Method:@selector(gameViewSizeChanged)]];
    
    // Add the game view to the window.
    [window addSubview: gameViewController.view];
    
    // Present the window.
    [window makeKeyAndVisible];
}

- (void) beginScreenDeviceChangeWithFullscreen:(BOOL)willBeFullscreen {
    gameViewController.wantsFullScreenLayout = willBeFullscreen;
    [[UIApplication sharedApplication] setStatusBarHidden:willBeFullscreen];
    gameViewController.view.frame = [UIScreen mainScreen].applicationFrame;
    clientBounds = [[Rectangle rectangleWithCGRect:gameViewController.view.bounds] retain];
}

- (void) endScreenDeviceChange {
    
}

- (void) gameViewSizeChanged {
	Rectangle *newClientBounds = [Rectangle rectangleWithCGRect:gameViewController.view.bounds];
    if (![newClientBounds equals:clientBounds]) {
		[clientBounds release];
        clientBounds = [newClientBounds retain];
        [clientSizeChanged raiseWithSender:self];
    }
}

- (void) dealloc
{
	[clientBounds release];
    [gameViewController release];
    [window release];
    [super dealloc];
}

@end
