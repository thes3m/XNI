//
//  TouchPanel.m
//  XNI
//
//  Created by Matej Jan on 29.9.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "TouchPanel.h"
#import "TouchPanel+Internal.h"

#import "Retronator.Xni.Framework.h"
#import "Retronator.Xni.Framework.Input.Touch.h"

#import "GameView.h"

@interface XniTouchLocation : NSObject {
@public
	int identifier;
	Vector2 *position;
	Vector2 *previousPosition;
	TouchLocationState state;
    int age;
}

- (id) initWithPosition:(Vector2*)thePosition;

- (void) update;
- (void) moveToPosition:(Vector2*)newPosition;

- (TouchLocation*) createTouchLocation;

@end

@implementation XniTouchLocation

static int nextID = 0;

- (id) initWithPosition:(Vector2*)thePosition
{
	self = [super init];
	if (self != nil) {
		identifier = nextID++;
		position = [[Vector2 alloc] initWithVector2:thePosition];
		previousPosition = nil;
		state = TouchLocationStatePressed;
	}
	return self;
}

- (void) update {
	[self moveToPosition:position];
    age++;
}

- (void) moveToPosition:(Vector2*)newPosition {
	if (!previousPosition) {
		previousPosition = [[Vector2 alloc] init];
	}
	[previousPosition set:position];
	[position set:newPosition];
	state = TouchLocationStateMoved;
}

- (TouchLocation *) createTouchLocation {
	return [[[TouchLocation alloc] initWithIdentifier:identifier 
											 position:[Vector2 vectorWithVector:position] 
									 previousPosition:previousPosition ? [Vector2 vectorWithVector:previousPosition] : nil
												state:state] autorelease];
}

- (void) dealloc
{
	[position release];
	[previousPosition release];
	[super dealloc];
}

@end

@implementation TouchPanel

static TouchPanel *instance;

- (id) init
{
	self = [super init];
	if (self != nil) {
		addTouches = [[NSMutableSet alloc] init];
		removeTouches = [[NSMutableSet alloc] init];
		releaseTouches = [[NSMutableSet alloc] init];
		lateReleaseTouches = [[NSMutableSet alloc] init];
		
		touchLocations = (NSMutableDictionary*)CFDictionaryCreateMutable(NULL, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
		uiTouchesForLocations = (NSMutableDictionary*)CFDictionaryCreateMutable(NULL, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
	}
	return self;
}

+ (void) initialize {
	instance = [[TouchPanel alloc] init];
}

@synthesize displayWidth;
@synthesize displayHeight;
@synthesize displayOrientation;
@synthesize enabledGestures;

+ (TouchCollection*) getState {
	return [instance getState];
}

+ (GestureSample*) readGesture {
	return [instance readGesture];
}

+ (TouchPanel*) getInstance {
    return instance;
}

- (void) setView:(GameView *)theView {
	view = theView;
}

- (BOOL) isGestureAvailable{
	return NO;
}

- (TouchCollection*) getState{
	TouchCollection *collection = [[[TouchCollection alloc] init] autorelease];
	for (XniTouchLocation *touch in [touchLocations allValues]) {
		[collection addObject:[touch createTouchLocation]];
		
		// After get state is done, all pressed touches should be moved.
		[touch update];
        if (touch->age > 200) {
            UITouch *key = [uiTouchesForLocations objectForKey:touch];
            [removeTouches addObject:key];
        }
    }
	return collection;
}

- (GestureSample*) readGesture{
	return nil;
}

// Internal methods

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[addTouches unionSet:touches];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	float scale = view.scale;
	for (UITouch *touch in touches) {
		XniTouchLocation *location = [touchLocations objectForKey:touch];	
		if (location) {
            location->age = 0;
			CGPoint position = [touch locationInView:view];
			[location moveToPosition:[Vector2 vectorWithX:position.x * scale y:position.y * scale]];
		}
	}
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	for (UITouch *touch in touches) {
		if ([addTouches containsObject:touch]) {
			[lateReleaseTouches addObject:touch];
		} else {
			[releaseTouches addObject:touch];
		}
	}
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	// Just remove the touch locations so they dissapear from the state (without released happening).
	for (UITouch *touch in touches) {
		[touchLocations removeObjectForKey:touch];
	}	
}

- (void) update {
	// Remove all previously released touches.
	for (UITouch *touch in removeTouches) {
        XniTouchLocation *location = [[touchLocations objectForKey:touch] retain];
		[touchLocations removeObjectForKey:touch];
        if (location) {
            [uiTouchesForLocations removeObjectForKey:location];
            [location release];
        }
	}
	[removeTouches removeAllObjects];
    	
	// Set released touches.
	for (UITouch *touch in releaseTouches) {
		XniTouchLocation *location = [touchLocations objectForKey:touch];
        if (location) {
            location->state = TouchLocationStateReleased;
        }
	}
	
	// Shift the pools.
	NSMutableSet *temp = removeTouches;
	removeTouches = releaseTouches;
	releaseTouches = lateReleaseTouches;
	lateReleaseTouches = temp;
	
	// Add new touches
	float scale = view.scale;
	for (UITouch *touch in addTouches) {
		CGPoint position = [touch locationInView:view];
		XniTouchLocation *location = [[[XniTouchLocation alloc] 
											initWithPosition:[Vector2 vectorWithX:position.x * scale y:position.y * scale]] autorelease];
		
		CFDictionaryAddValue((CFMutableDictionaryRef)touchLocations, touch, location);
		CFDictionaryAddValue((CFMutableDictionaryRef)uiTouchesForLocations, location, touch);
	}
	[addTouches removeAllObjects];
	
}

- (void) dealloc
{
	[addTouches release];
	[removeTouches release];
	[releaseTouches release];
	[lateReleaseTouches release];
	[touchLocations release];
    [uiTouchesForLocations release];
	[super dealloc];
}



@end
