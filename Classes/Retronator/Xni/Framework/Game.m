//
//  Game.m
//  XNI
//
//  Created by Matej Jan on 27.7.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "Game.h"

#import "Retronator.Xni.Framework.h"
#import "Retronator.Xni.Framework.Graphics.h"

@implementation Game

- (id) init
{
    if (self = [super init]) {
        // Allocation and early initialization that doesn't depend on the graphics device.
        gameTime = [[GameTime alloc] init];
        
        components = [[GameComponentCollection alloc] init];
        [components.componentAdded subscribeDelegate:
		 [Delegate delegateWithTarget:self Method:@selector(componentAddedTo:eventArgs:)]];
        
        services = [[GameServiceContainer alloc] init];
        
        isFixedTimeStep = YES;
        targetElapsedTime = 1.0 / 60.0;
        inactiveSleepTime = 1.0 / 5.0;
		maximumElapsedTime = 1.0 / 2.0;
        
        // Get the game host.
        gameHost = (GameHost*)[UIApplication sharedApplication];
    }
    
    return self;
}

// PROPERTIES

- (GameWindow*) window {
    return [gameHost window];
}

- (GraphicsDevice*) graphicsDevice {
	return [graphicsDeviceService graphicsDevice];
}

@synthesize isActive;

@synthesize isFixedTimeStep;
@synthesize targetElapsedTime;
@synthesize inactiveSleepTime;

@synthesize components;
@synthesize services;

// METHODS

- (void) run {    
    // Allow the game host to create the window as desired.
    [gameHost initialize];
    
    // Create the graphics device so we can finish initialization.
    graphicsDeviceManager = [services getServiceOfType:[Protocols graphicsDeviceManager]];
    graphicsDeviceService = [services getServiceOfType:[Protocols graphicsDeviceService]];
    [graphicsDeviceManager createDevice];
    
    // Initialize the game.
    [self initialize];
    
    // Start run
    inRun = YES;
    [self beginRun];
    
    // First update with zero gameTime.
    [self updateWithGameTime:gameTime];    
    lastFrameTime = [[NSDate alloc] init];
    
    // Run the game host with a delay event, so we don't block this method.
    [gameHost performSelector:@selector(run) withObject:nil afterDelay:0];
}

- (void) tick {
    // Sleep if inactive.
    if (!isActive) {
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, inactiveSleepTime, NO);
    }
    
    // Calculate elapsed times.
    currentFrameTime = [[NSDate alloc] init];
    NSTimeInterval elapsedRealTime = [currentFrameTime timeIntervalSinceDate:lastFrameTime];
    
    // Sleep if we're ahead of the target elapsed time.
    if (isFixedTimeStep && elapsedRealTime < targetElapsedTime) {
        NSTimeInterval sleepTime = targetElapsedTime - elapsedRealTime;
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, sleepTime, NO);
        
        // Recalculate elapsed times.
        [currentFrameTime release];
        currentFrameTime = [[NSDate alloc] init];
        elapsedRealTime = [currentFrameTime timeIntervalSinceDate:lastFrameTime];
    }
    
    // Store current time for next frame.
    [lastFrameTime release];
    lastFrameTime = currentFrameTime;
    currentFrameTime = nil;
    
    // Update game time.
    NSTimeInterval elapsedGameTime = MIN(isFixedTimeStep ? targetElapsedTime : elapsedRealTime, maximumElapsedTime);
    gameTime.elapsedGameTime = elapsedGameTime;
    gameTime.totalGameTime += elapsedGameTime;
    gameTime.isRunningSlowly = elapsedRealTime > elapsedGameTime;
    
    // Update the game.
    [self updateWithGameTime:gameTime];
    
    // Draw to display.
    if ([self beginDraw]) {
        [self drawWithGameTime:gameTime];
        [self endDraw];
    }    
}

// Application delegate methods.

- (void) applicationDidFinishLaunching:(UIApplication *)application {    
    NSLog(@"Application has started.");
    [self run];
}

- (void) applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"Application was deactivated.");
    isActive = NO;
}

- (void) applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"Application was activated.");
    isActive = YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"Application will terminate.");
    [gameHost exit];
    [self endRun];
}

// Virtual methods to be mainly implemented in the game. 
// Here we only handle the components.

- (void) initialize {
    for (id<IGameComponent> component in components) {
        [component initialize];
    }
    initializeDone = YES;
	
	[self loadContent];
}

- (void) loadContent {}

- (void) beginRun {}

- (void) updateWithGameTime:(GameTime*)theGameTime {
    for (id component in components) {
        if (![component conformsToProtocol:@protocol(IUpdatable)]) {
            continue;
        }
        id<IUpdatable> updatable = component;
        if (updatable.enabled) {
            [updatable updateWithGameTime:theGameTime];
        }
    }
}

- (BOOL) beginDraw {
    return [graphicsDeviceManager beginDraw];
}

- (void) drawWithGameTime:(GameTime*)theGameTime {
    for (id component in components) {
        if (![component conformsToProtocol:@protocol(IDrawable)]) {
            continue;
        }
        id<IDrawable> drawable = component;
        if (drawable.visible) {
            [drawable drawWithGameTime:theGameTime];
        }
    }
}

- (void) endDraw {
    [graphicsDeviceManager endDraw];
}

- (void) unloadContent {}

- (void) endRun {}

// Private methods

- (void) componentAddedTo:(GameComponentCollection*)sender eventArgs:(GameComponentCollectionEventArgs*)e {
    if (initializeDone) {
        [e.gameComponent initialize];
    }
}

- (void) dealloc
{       
	[self unloadContent];
    [gameTime release];
    
    [components release];
    [services release];
	
	[super dealloc];
}

@end
