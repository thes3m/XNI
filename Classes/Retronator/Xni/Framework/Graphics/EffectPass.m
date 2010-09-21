//
//  EffectPass.m
//  XNI
//
//  Created by Matej Jan on 21.9.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "EffectPass.h"


@implementation EffectPass

-(id) initWithName:(NSString *)theName {
    if (self = [super init]) {
        name = [theName retain];
    }
    return self;
}

@synthesize name;

- (void) apply {}

- (void) dealloc
{
    [name release];
    [super dealloc];
}


@end
