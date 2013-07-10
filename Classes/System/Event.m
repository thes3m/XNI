//
//  Event.m
//  XNI
//
//  Created by Matej Jan on 20.7.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "Event.h"

#import "System.h"

@interface Event (){
    NSMutableArray *tempEvents;
}

@end

@implementation Event

- (id) init {
    if (self = [super init]) {
        delegates = [[NSMutableArray alloc] init];
        tempEvents = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) subscribeDelegate:(Delegate*)delegate {
    [delegates addObject:delegate];
}

- (void) unsubscribeDelegate:(Delegate*)delegate {
    [delegates removeObject:delegate];
}

- (void) raiseWithSender:(id)sender {
	EventArgs *e = [EventArgs empty];
	[self raiseWithSender:sender eventArgs:e];
}

- (void) raiseWithSender:(id)sender eventArgs:(EventArgs*)e {
    [tempEvents removeAllObjects];
    [tempEvents addObjectsFromArray:delegates];
    for (Delegate *delegate in tempEvents) {
        [delegate invokeWithArgument:sender argument:e];
    }
    [tempEvents removeAllObjects];
}

- (void) dealloc {
    [delegates release];
    [tempEvents release];
    [super dealloc];
}

@end