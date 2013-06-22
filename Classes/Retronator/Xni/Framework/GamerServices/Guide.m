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
#import "XniShowMessageBoxResult.h"

@implementation Guide

static Guide *instance = nil;

- (id) initWithGame:(Game*)theGame;
{
	self = [super init];
	if (self != nil) {
		game = theGame;
		messageBoxResults = [[NSMutableSet alloc] init];
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

- (NotificationPosition) notificationPosition {
	return NotificationPositionCenter;
}

- (void) setNotificationPosition:(NotificationPosition)value {
	[NSException raise:@"NotSupportedException" format:@"You can't set the position of notifications on iOS."];
}

+ (void) showAchievements {
	[instance showAchievements];
}

+ (void) showLeaderboard {
	[instance showLeaderboard];
}

+ (id<IAsyncResult>) beginShowMessageBoxWithTitle:(NSString*)title text:(NSString*)text buttons:(NSArray*)buttons focusButton:(int)focusButton 
								 icon:(MessageBoxIcon)icon callback:(Delegate*)callback state:(id)state {
	return [instance beginShowMessageBoxWithTitle:title text:text buttons:buttons focusButton:focusButton icon:icon callback:callback state:state];
}

+ (NSNumber*) endShowMessageBox:(id <IAsyncResult>)result {
	return [instance endShowMessageBox:result];
}

+ (Guide*) getInstance {
	return instance;
}

- (void) showAchievements {
	isVisible = YES;
	GKAchievementViewController *achievements = [[GKAchievementViewController alloc] init];
    if (achievements != nil)
    {
        achievements.achievementDelegate = self;
		[game presentModalViewController:achievements];
    }
    [achievements release];
}

- (void) showLeaderboard {
	isVisible = YES;
	GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
    if (leaderboardController != nil)
    {
        leaderboardController.leaderboardDelegate = self;
        [game presentModalViewController:leaderboardController];
    }
	[leaderboardController release];
}

- (id<IAsyncResult>) beginShowMessageBoxWithTitle:(NSString *)title text:(NSString *)text buttons:(NSArray *)buttons focusButton:(int)focusButton 
								 icon:(MessageBoxIcon)icon callback:(Delegate*)callback state:(id)state {
	
	XniShowMessageBoxResult *result = [[[XniShowMessageBoxResult alloc] initWithAsyncState:state callback:callback] autorelease];
	[messageBoxResults addObject:result];
	
	UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:title message:text delegate:result cancelButtonTitle:nil otherButtonTitles:nil] autorelease];
	
	for (NSString *button in buttons) {
		[alertView addButtonWithTitle:button];
	}
	
	alertView.cancelButtonIndex = focusButton;

	[alertView show];
	return result;
}

- (NSNumber *) endShowMessageBox:(id <IAsyncResult>)result {
	[messageBoxResults removeObject:result];
	
	XniShowMessageBoxResult *messageBoxResult = (XniShowMessageBoxResult*)result;
	return messageBoxResult.result;
}

- (void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController {
	[game dismissModalViewController];
	isVisible = NO;
}

- (void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController {
	[game dismissModalViewController];
	isVisible = NO;
}

- (void) dealloc {
	[messageBoxResults release];
	[super dealloc];
}


@end
