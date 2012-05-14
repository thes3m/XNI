//
//  ContentIdentity.m
//  XNI
//
//  Created by Matej Jan on 7.9.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "ContentIdentity.h"


@implementation ContentIdentity

@synthesize fragmentIdentifier;
@synthesize sourceFilename;
@synthesize sourceTool;

- (void)dealloc
{
    [fragmentIdentifier release];
    [sourceFilename release];
    [sourceTool release];
    [super dealloc];
}

@end
