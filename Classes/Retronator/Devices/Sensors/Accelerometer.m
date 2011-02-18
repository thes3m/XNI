//
//  Accelerometer.m
//  XNI
//
//  Created by Matej Jan on 15.2.11.
//  Copyright 2011 Retronator. All rights reserved.
//

#import "Accelerometer.h"

#import "Retronator.Devices.Sensors.h"
#import "AccelerometerReadingEventArgs+Internal.h"

@implementation Accelerometer

- (id) init
{
	self = [super init];
	if (self != nil) {
		state = SensorStateInitializing;
		readingChanged = [[Event alloc] init];
		[UIAccelerometer sharedAccelerometer].updateInterval = 1.0/30.0;
	}
	return self;
}

@synthesize state, readingChanged;

- (void) start {
	state = SensorStateReady;
	[UIAccelerometer sharedAccelerometer].delegate = self;
}

- (void) stop {
	state = SensorStateDisabled;
	[UIAccelerometer sharedAccelerometer].delegate = nil;
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)uiAcceleration
{  
	AccelerometerReadingEventArgs *eventArgs = [[[AccelerometerReadingEventArgs alloc] initWithTimestamp:uiAcceleration.timestamp
																									   x:uiAcceleration.x 
																									   y:uiAcceleration.y 
																									   z:uiAcceleration.z] autorelease];
	
    [readingChanged raiseWithSender:self eventArgs:eventArgs];
}

- (void) dealloc
{
	[readingChanged release];
	[super dealloc];
}


@end
