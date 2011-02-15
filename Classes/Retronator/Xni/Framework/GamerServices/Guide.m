//
//  Guide.m
//  XNI
//
//  Created by Matej Jan on 7.12.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "Guide.h"
#import "Guide+Internal.h"

#import "Retronator.Xni.Framework.h"

#import "Game+Internal.h"

@implementation Guide

static Guide *instance = nil;

- (id) initWithGame:(Game*)theGame;
{
	self = [super init];
	if (self != nil) {
		game = theGame;
	}
	return self;
}

+ (void) initializeWithGame:(Game *)theGame
{
	if (!instance) {
		instance = [[Guide alloc] initWithGame:theGame];
	}
}

@synthesize isVisible;

+ (void) showAchievements {
	[instance showAchievements];
}

+ (void) showLeaderboard {
	[instance showLeaderboard];
}

+ (Guide*) getInstance {
	return instance;
}

- (void) showAchievements {
	GKAchievementViewController *achievements = [[GKAchievementViewController alloc] init];
    if (achievements != nil)
    {
        achievements.achievementDelegate = self;
		[game presentModalViewController:achievements];
    }
    [achievements release];
}

- (void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController {
	[game dismissModalViewController];
}

- (void) showLeaderboard {
	GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
    if (leaderboardController != nil)
    {
        leaderboardController.leaderboardDelegate = self;
        [game presentModalViewController:leaderboardController];
    }
	[leaderboardController release];
}

- (void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController {
	[game dismissModalViewController];	
}

@end
