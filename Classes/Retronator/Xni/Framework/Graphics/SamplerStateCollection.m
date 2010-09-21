//
//  SamplerStateCollection.m
//  XNI
//
//  Created by Matej Jan on 21.9.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "SamplerStateCollection.h"

#import "Retronator.Xni.Framework.Graphics.h"

@implementation SamplerStateCollection

- (id) init
{
	self = [super init];
	if (self != nil) {
		collection = [[NSMutableArray alloc] init];
	}
	return self;
}

- (int) count {
	return [collection count];
}

- (SamplerState*)objectAtIndex:(NSUInteger)index {
	return (SamplerState*)[collection objectAtIndex:index];
}

- (void)addObject:(SamplerState*)anObject {
	[collection addObject:anObject];
}

- (void)insertObject:(SamplerState*)anObject atIndex:(NSUInteger)index {
	[collection insertObject:anObject atIndex:index];
}

- (void) dealloc
{
	[collection dealloc];
	[super dealloc];
}

@end
