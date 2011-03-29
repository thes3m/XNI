//
//  AchievementCollection.h
//  XNI
//
//  Created by Matej Jan on 18.2.11.
//  Copyright 2011 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Retronator.Xni.Framework.GamerServices.classes.h"

#define ReadOnlyCollection AchievementCollection
#define T Achievement*
#define Variables NSMutableDictionary *achievements;

#include "ReadOnlyCollection.h"

@interface AchievementCollection (Custom)

- (Achievement*) itemForKey:(NSString*)key;

@end

#undef ReadOnlyCollection
#undef T
#undef Variables
