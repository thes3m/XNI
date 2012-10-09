//
//  GameHost.m
//  XNI
//
//  Created by Matej Jan on 20.7.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "GameHost.h"
#import <QuartzCore/QuartzCore.h>

#import "Retronator.Xni.Framework.h"
#import "Retronator.Xni.Framework.Media.h"

@implementation GameHost

- (id) init {
    self = [super init];
    if (self) {
		[MediaPlayer load];
        window = [[GameWindow alloc] init]; 	
    }
    return self;
}

@synthesize window;

- (void) run {    	
    
    game = [self delegate];
    
    // If game uses display link we don't need to run our own game loop.
    if (game.usesDisplayLink) return;
	
    // Hijack the run loop.
    NSLog(@"Starting the game loop.");
        
    SInt32 runResult;
    
	isExiting = NO;
    while (!isExiting)
    {   
        // We run a very tight autorelease pool loop.
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        
        // Handle all the waiting event sources.
        do {
            runResult = CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, YES);
        } while (runResult == kCFRunLoopRunHandledSource);
        		
        [game tick];
        
        // We release memory every frame.
        [pool release];
    }    
}

- (void) exit {
    if (game.usesDisplayLink) return;

    NSLog(@"Exiting the game loop.");
    isExiting = YES;
}

- (void) dealloc
{
	[window release];
    [super dealloc];
}


@end
