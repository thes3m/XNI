//
//  Gamer.h
//  XNI
//
//  Created by Matej Jan on 18.2.11.
//  Copyright 2011 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Retronator.Xni.Framework.GamerServices.classes.h"

@interface Gamer : NSObject {
	NSString *displayName;
	NSString *gamertag;
	id tag;
}

@property (nonatomic, retain) NSString *displayName;
@property (nonatomic, readonly) NSString *gamertag;
@property (nonatomic, retain) id tag;

+ (SignedInGamerCollection*) signedInGamers;

+ (Gamer*) getFromGamertag:(NSString*)gamertag;

- (GamerProfile*) getProfile;

@end
