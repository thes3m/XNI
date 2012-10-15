//
//  SamplerStateCollection.m
//  XNI
//
//  Created by Matej Jan on 21.9.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "SamplerStateCollection.h"
#import "SamplerStateCollection+Internal.h"
#import "XniSamplerEventArgs.h"
#import "XniSamplerEventArgs+Internal.h"
#import "Retronator.Xni.Framework.Graphics.h"


@interface SamplerStateCollection (){
    XniSamplerEventArgs *eventArgs;
}

@end

@implementation SamplerStateCollection

- (id) init
{
	self = [super init];
	if (self != nil) {
		for (int i = 0; i < GL_MAX_TEXTURE_UNITS; i++) {
			samplerStates[i] = nil;
		}
        eventArgs = [[XniSamplerEventArgs alloc] initWithSamplerIndex:0];
		samplerStateChanged = [[Event alloc] init];
	}
	return self;
}

- (Event *) samplerStateChanged {
	return samplerStateChanged;
}

- (SamplerState*)itemAtIndex:(NSUInteger)index {
	return samplerStates[index];
}

- (void)setItem:(SamplerState*)item atIndex:(NSUInteger)index {
	if (samplerStates[index] != item) {
		samplerStates[index] = item;
        eventArgs.samplerIndex = index;
		[samplerStateChanged raiseWithSender:self eventArgs:eventArgs];
	}
}

- (void) dealloc
{
    [eventArgs release];
	[samplerStateChanged release];
	[super dealloc];
}

@end
