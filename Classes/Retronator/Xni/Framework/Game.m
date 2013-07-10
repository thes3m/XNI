//
//  Game.m
//  XNI
//
//  Created by Matej Jan on 27.7.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "Game.h"
#import "Game+Internal.h"

#import "Retronator.Xni.Framework.h"
#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.Xni.Framework.Content.h"
#import "Retronator.Xni.Framework.Media.h"
#import "TouchPanel+Internal.h"
#import "GameWindow+Internal.h"
#import "GameViewController.h"
#import "GameView.h"
#import "Guide+Internal.h"
#import "SoundEffect+Internal.h"
#import "MediaPlayer+Internal.h"

@interface Game ()

- (void) addEnabledComponent:(id <IUpdatable>)component;
- (void) addVisibleComponent:(id <IDrawable>)component;

@end


@implementation Game

static NSArray *updateOrderSort;
static NSArray *drawOrderSort;

+ (void) initialize {
	if (!updateOrderSort) {
		NSSortDescriptor *updateOrderSortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"updateOrder" ascending:YES] autorelease];	
		updateOrderSort = [[NSArray arrayWithObject:updateOrderSortDescriptor] retain];
	}
	
	if (!drawOrderSort) {
		NSSortDescriptor *drawOrderSortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"drawOrder" ascending:YES] autorelease];
		drawOrderSort = [[NSArray arrayWithObject:drawOrderSortDescriptor] retain];
	}
}

- (id) init
{
    self = [super init];
    if (self) {
        // Allocation and early initialization that doesn't depend on the graphics device.
        gameTime = [[GameTime alloc] init];
		
        components = [[GameComponentCollection alloc] init];
		enabledComponents = [[NSMutableArray alloc] init];
		visibleComponents = [[NSMutableArray alloc] init];
		
		// A temporary array for operations on components.
		// First it is used for constructing a list of components, that need to be initialized.
		// In run it is used to make a copy of enabled/visible components for enumerating over them.
		componentsList = [[NSMutableArray alloc] init];
        		
        [components.componentAdded subscribeDelegate:
		 [Delegate delegateWithTarget:self Method:@selector(componentAddedTo:eventArgs:)]];
		
		[components.componentRemoved subscribeDelegate:
		 [Delegate delegateWithTarget:self Method:@selector(componentRemovedFrom:eventArgs:)]];
        
        services = [[GameServiceContainer alloc] init];
		
		content = [[ContentManager alloc] initWithServiceProvider:services];
		
		activated = [[Event alloc] init];
		deactivated = [[Event alloc] init];
		disposed = [[Event alloc] init];
		exiting = [[Event alloc] init];
		
        isFixedTimeStep = YES;
        targetElapsedTime = 1.0 / 60.0;
        inactiveSleepTime = 1.0 / 5.0;
		maximumElapsedTime = 1.0 / 2.0;
        displayLinkFrameInterval = 1;
        usesDisplayLink = NO;
		
		// Gamer services
		[Guide initializeWithGame:self];
		
        // Get the game host.
        gameHost = (GameHost*)[UIApplication sharedApplication];
    }
    
    return self;
}

// PROPERTIES

- (UIWindow*) window {
    return [gameHost window].window;
}

- (GameWindow*) gameWindow {
    return [gameHost window];
}

- (GraphicsDevice*) graphicsDevice {
	return [graphicsDeviceService graphicsDevice];
}

@synthesize isActive;

@synthesize isFixedTimeStep;
@synthesize targetElapsedTime;
@synthesize inactiveSleepTime;

@synthesize usesDisplayLink, displayLinkFrameInterval;

- (void)setDisplayLinkFrameInterval:(int)value {
    displayLinkFrameInterval = value;
    [displayLink setFrameInterval:displayLinkFrameInterval];
}

@synthesize content;
@synthesize components;
@synthesize services;

@synthesize activated, deactivated, disposed, exiting;

// METHODS

- (void) run {
    // Initialize game window.
    [self.gameWindow initialize];
    
    // Create the graphics device so we can finish initialization.
    graphicsDeviceManager = [services getServiceOfType:[Protocols graphicsDeviceManager]];
    graphicsDeviceService = [services getServiceOfType:[Protocols graphicsDeviceService]];
    [graphicsDeviceManager createDevice];
    
    // Initialize the game.
    [self initialize];
    
    // Start run
    inRun = YES;
    [self beginRun];
    
    // First frame with zero gameTime.
    [self updateWithGameTime:gameTime];   
    
    if ([self beginDraw]) {
        [self drawWithGameTime:gameTime];
        [self endDraw];
    }
    
    // Force redraw.
    [self.gameWindow.gameViewController.gameView layoutSubviews];
    
    if (usesDisplayLink) {
        displayLink = [[CADisplayLink displayLinkWithTarget:self selector:@selector(tick)] retain];
        [displayLink setFrameInterval:displayLinkFrameInterval];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    } else {
        // Run the game host with a delay event, so we don't block this method.
        [gameHost performSelector:@selector(run) withObject:nil afterDelay:0];
    }
}

- (void) tick {
    if (!lastFrameTime) {
        lastFrameTime = [[NSDate alloc] init];
    }
    
    // Sleep if inactive.
    if (!isActive) {
        if (!usesDisplayLink) {
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, inactiveSleepTime, NO);
        }
		return;
    }
    
    // Calculate elapsed times.
    currentFrameTime = [[NSDate alloc] init];
    NSTimeInterval elapsedRealTime = [currentFrameTime timeIntervalSinceDate:lastFrameTime];
    
    // Sleep if we're ahead of the target elapsed time.
	if (isFixedTimeStep && !usesDisplayLink) {
		if (elapsedRealTime < targetElapsedTime) {
			NSTimeInterval sleepTime = targetElapsedTime - elapsedRealTime;
			CFRunLoopRunInMode(kCFRunLoopDefaultMode, sleepTime, NO);
			
			// Recalculate elapsed times.
			[currentFrameTime release];
			currentFrameTime = [[NSDate alloc] init];
			elapsedRealTime = [currentFrameTime timeIntervalSinceDate:lastFrameTime];
			gameTime.isRunningSlowly = NO;
		} else {
			gameTime.isRunningSlowly = YES;
		}
	}
    
    // Store current time for next frame.
    [lastFrameTime release];
    lastFrameTime = currentFrameTime;
    currentFrameTime = nil;
    
    // Update game time.
    NSTimeInterval elapsedGameTime = MIN(isFixedTimeStep ? targetElapsedTime : elapsedRealTime, maximumElapsedTime);
    gameTime.elapsedGameTime = elapsedGameTime;
    gameTime.totalGameTime += elapsedGameTime;
	
	// Update input.
	[[TouchPanel getInstance] update];
	
    // Update the game.
    [self updateWithGameTime:gameTime];
	
	// Update audio.
	[SoundEffect update];
	
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
    [MediaPlayer toBackground];
	[deactivated raiseWithSender:self];
}

- (void) applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"Application was activated.");
    isActive = YES;
    [MediaPlayer returnFromBackground];
	[activated raiseWithSender:self];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"Application will terminate.");
	[exiting raiseWithSender:self];
    [gameHost exit];
    [self endRun];
}

- (void) applicationDidEnterBackground:(UIApplication *)application {
	NSLog(@"Application entered background.");
}

- (void) applicationWillEnterForeground:(UIApplication *)application {
	NSLog(@"Application will enter foreground.");
}

// Virtual methods to be mainly implemented in the game. 
// Here we only handle the components.

- (void) initialize {
	while ([componentsList count] > 0) {
		id<IGameComponent> component = [componentsList objectAtIndex:0];
        [component initialize];
		[componentsList removeObjectAtIndex:0];
	}
    initializeDone = YES;
	
	[self loadContent];
}

- (void) loadContent {}

- (void) beginRun {}

- (void) updateWithGameTime:(GameTime*)theGameTime {
	[componentsList addObjectsFromArray:enabledComponents];
    for (id<IUpdatable> updatable in componentsList) {
		[updatable updateWithGameTime:theGameTime];
    }
	[componentsList removeAllObjects];
}

- (BOOL) beginDraw {
    return [graphicsDeviceManager beginDraw];
}

- (void) drawWithGameTime:(GameTime*)theGameTime {
 	[componentsList addObjectsFromArray:visibleComponents];
	for (id<IDrawable> drawable in componentsList) {
		[drawable drawWithGameTime:theGameTime];
    }
	[componentsList removeAllObjects];
}

- (void) endDraw {
    [graphicsDeviceManager endDraw];
}
 
- (void) unloadContent {}

- (void) endRun {}

// Internal methods

- (void) presentModalViewController:(UIViewController*)viewController {
	if (viewController) {
		[gameHost.window.gameViewController presentModalViewController:viewController animated:YES];
	}
	
	// Stop host loop so messages are properly processed.
	[gameHost exit];
}

- (void) dismissModalViewController {
	[gameHost.window.gameViewController dismissModalViewControllerAnimated:YES];
	
	// Rerun host loop so game continues.
    [gameHost performSelector:@selector(run) withObject:nil afterDelay:0];
}


// Private methods for component management.

- (void) addEnabledComponent:(id<IUpdatable>)component {
	[enabledComponents addObject:component];
	[enabledComponents sortUsingDescriptors:updateOrderSort];
}

- (void) addVisibleComponent:(id<IDrawable>)component {
	[visibleComponents addObject:component];
	[visibleComponents sortUsingDescriptors:drawOrderSort];
}

- (void) componentAddedTo:(GameComponentCollection*)sender eventArgs:(GameComponentCollectionEventArgs*)e {
    // Initialize component if it's being added after main initialize has been called.
	if (initializeDone) {
        [e.gameComponent initialize];
    } else {
		[componentsList addObject:e.gameComponent];
	}
	
	// Process updatable component.
	if ([e.gameComponent conformsToProtocol:@protocol(IUpdatable)]) {
		id<IUpdatable> updatable = (id<IUpdatable>)e.gameComponent;
		if (updatable.enabled) {
			[self addEnabledComponent:updatable];
		}
		[updatable.enabledChanged subscribeDelegate:
		 [Delegate delegateWithTarget:self Method:@selector(componentEnabledChanged:eventArgs:)]];
		[updatable.updateOrderChanged subscribeDelegate:
		 [Delegate delegateWithTarget:self Method:@selector(componentUpdateOrderChanged:eventArgs:)]];
	}
	
	// Process drawable component.
	if ([e.gameComponent conformsToProtocol:@protocol(IDrawable)]) {
		id<IDrawable> drawable = (id<IDrawable>)e.gameComponent;
		if (drawable.visible) {
			[self addVisibleComponent:drawable];
		}
		[drawable.visibleChanged subscribeDelegate:
		 [Delegate delegateWithTarget:self Method:@selector(componentVisibleChanged:eventArgs:)]];
		[drawable.drawOrderChanged subscribeDelegate:
		 [Delegate delegateWithTarget:self Method:@selector(componentDrawOrderChanged:eventArgs:)]];
	}	
}

- (void) componentRemovedFrom:(GameComponentCollection*)sender eventArgs:(GameComponentCollectionEventArgs*)e {
	if (!initializeDone) {
		[componentsList removeObject:e.gameComponent];
	}
	
	// Process updatable component.
	if ([e.gameComponent conformsToProtocol:@protocol(IUpdatable)]) {
		id<IUpdatable> updatable = (id<IUpdatable>)e.gameComponent;
		if (updatable.enabled) {
			[enabledComponents removeObject:updatable];
		}
		[updatable.enabledChanged unsubscribeDelegate:
		 [Delegate delegateWithTarget:self Method:@selector(componentEnabledChanged:eventArgs:)]];
		[updatable.updateOrderChanged unsubscribeDelegate:
		 [Delegate delegateWithTarget:self Method:@selector(componentUpdateOrderChanged:eventArgs:)]];
	}
	
	// Process drawable component.
	if ([e.gameComponent conformsToProtocol:@protocol(IDrawable)]) {
		id<IDrawable> drawable = (id<IDrawable>)e.gameComponent;
		if (drawable.visible) {
			[visibleComponents removeObject:drawable];
		}
		[drawable.visibleChanged unsubscribeDelegate:
		 [Delegate delegateWithTarget:self Method:@selector(componentVisibleChanged:eventArgs:)]];
		[drawable.drawOrderChanged unsubscribeDelegate:
		 [Delegate delegateWithTarget:self Method:@selector(componentDrawOrderChanged:eventArgs:)]];
	}	    
}

- (void) componentEnabledChanged:(id<IUpdatable>)sender eventArgs:(EventArgs*)e {
	if (sender.enabled) {
		[self addEnabledComponent: sender];
	} else {
		[enabledComponents removeObject:sender];
	}
}

- (void) componentUpdateOrderChanged:(id<IUpdatable>)sender eventArgs:(EventArgs*)e {
	[enabledComponents sortUsingDescriptors:updateOrderSort];
}

- (void) componentVisibleChanged:(id<IDrawable>)sender eventArgs:(EventArgs*)e {
	if (sender.visible) {
		[self addVisibleComponent:sender];
	} else {
		[visibleComponents removeObject:sender];
	}	
}

- (void) componentDrawOrderChanged:(id<IDrawable>)sender eventArgs:(EventArgs*)e {
	[visibleComponents sortUsingDescriptors:drawOrderSort];
}




- (void) dealloc
{   
    [disposed raiseWithSender:self];
	
	[activated release];
	[deactivated release];
	[disposed release];
	[exiting release];
	
	[self unloadContent];
    [gameTime release];
    [displayLink release];
    
	[componentsList release];	
	[enabledComponents release];
	[visibleComponents release];
    [components release];
    [services release];
	
	[super dealloc];
}

@end
