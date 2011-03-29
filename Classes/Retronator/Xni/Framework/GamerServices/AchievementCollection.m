//
//  AchievementCollection.m
//  XNI
//
//  Created by Matej Jan on 18.2.11.
//  Copyright 2011 Retronator. All rights reserved.
//

#import "AchievementCollection.h"

#import "Retronator.Xni.Framework.GamerServices.h"

#define ReadOnlyCollection AchievementCollection
#define T Achievement*
#define Initialization achievements = [[NSMutableDictionary alloc] init]; for (Achievement* achievement in collection) {if (achievement.key) [achievements setObject:achievement forKey:achievement.key];}
#define Disposing [achievements release];

#include "ReadOnlyCollection.m.h"

@implementation AchievementCollection (Custom)

- (Achievement*) itemForKey:(NSString*)key {
	return [achievements objectForKey:key];
}

@end

#undef ReadOnlyCollection
#undef T
#undef Initialization