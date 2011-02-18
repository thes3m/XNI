//
//  AccelerometerReadingEventArgs.m
//  XNI
//
//  Created by Matej Jan on 15.2.11.
//  Copyright 2011 Retronator. All rights reserved.
//

#import "AccelerometerReadingEventArgs.h"
#import "AccelerometerReadingEventArgs+Internal.h"

@implementation AccelerometerReadingEventArgs

- (id) initWithTimestamp:(NSTimeInterval)timestampValue x:(double)xValue y:(double)yValue z:(double)zValue
{
	self = [super init];
	if (self != nil) {
		timestamp = timestampValue;
		x = xValue;
		y = yValue;
		z = zValue;
	}
	return self;
}

@synthesize timestamp, x, y, z;

- (void) dealloc
{
	[super dealloc];
}

@end
