//
//  SignedInGamer.h
//  XNI
//
//  Created by Matej Jan on 18.2.11.
//  Copyright 2011 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Gamer.h"

@interface SignedInGamer : Gamer {

}

- (AchievementCollection*) getAchievements;

@end
