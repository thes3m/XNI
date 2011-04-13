//
//  Gamer.m
//  XNI
//
//  Created by Matej Jan on 18.2.11.
//  Copyright 2011 Retronator. All rights reserved.
//

#import "Gamer.h"


@implementation Gamer

@synthesize displayName, gamertag, tag;

+ (SignedInGamerCollection*) signedInGamers {
    [NSException raise:@"NotImplementedException" format:@"This method is not yet implemented."];
    return nil;
}

+ (Gamer*) getFromGamertag:(NSString*)gamertag {
    [NSException raise:@"NotImplementedException" format:@"This method is not yet implemented."];
    return nil;
}

- (GamerProfile*) getProfile {
    [NSException raise:@"NotImplementedException" format:@"This method is not yet implemented."];
    return nil;
}

@end
