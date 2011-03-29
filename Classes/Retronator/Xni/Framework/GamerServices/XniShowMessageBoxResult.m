//
//  XniShowMessageBoxResult.m
//  XNI
//
//  Created by Matej Jan on 23.2.11.
//  Copyright 2011 Retronator. All rights reserved.
//

#import "XniShowMessageBoxResult.h"


@implementation XniShowMessageBoxResult

- (id) initWithAsyncState:(id)theAsyncState callback:(Delegate*)theCallback
{
	self = [super init];
	if (self != nil) {
		asyncState = [theAsyncState retain];
		callback = [theCallback retain];
		
		// Lock the lock until the alert returns.
		asyncLock = [[NSLock alloc] init];
		[asyncLock lock];
	}
	return self;
}

@synthesize asyncState, asyncLock, isCompleted, result;

- (BOOL) completedSynchronously {
	return NO;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	[asyncLock unlock];
	isCompleted = YES;
	
	result = [[NSNumber alloc] initWithInteger:buttonIndex];
	
	[callback invokeWithArgument:self];
}
			  
- (void) dealloc
{
	[asyncState release];
	[callback release];
	[asyncLock release];
	[result release];
	[super dealloc];
}		

@end
