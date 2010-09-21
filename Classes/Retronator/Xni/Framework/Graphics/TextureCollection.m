//
//  TextureCollection.m
//  XNI
//
//  Created by Matej Jan on 21.9.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "TextureCollection.h"

#import "Retronator.Xni.Framework.Graphics.h"

@implementation TextureCollection

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

- (Texture*)objectAtIndex:(NSUInteger)index {
	return (Texture*)[collection objectAtIndex:index];
}

- (void)addObject:(Texture*)anObject {
	[collection addObject:anObject];
}

- (void)insertObject:(Texture*)anObject atIndex:(NSUInteger)index {
	[collection insertObject:anObject atIndex:index];
}

- (void) dealloc
{
	[collection dealloc];
	[super dealloc];
}

@end
