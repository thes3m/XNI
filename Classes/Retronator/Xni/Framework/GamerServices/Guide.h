//
//  Guide.h
//  XNI
//
//  Created by Matej Jan on 7.12.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

#import "Retronator.Xni.Framework.classes.h"
#import "Retronator.Xni.Framework.GamerServices.classes.h"
#import "System.h"

@interface Guide : NSObject <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate> {
	Game *game;
	BOOL isVisible;
	NotificationPosition notificationPosition;
	
	NSMutableSet *messageBoxResults;
}

@property (nonatomic) BOOL isVisible;
@property (nonatomic) NotificationPosition notificationPosition;

+ (void) showAchievements;
+ (void) showLeaderboard;
+ (id<IAsyncResult>) beginShowMessageBoxWithTitle:(NSString*)title text:(NSString*)text buttons:(NSArray*)buttons focusButton:(int)focusButton 
								 icon:(MessageBoxIcon)icon callback:(Delegate*)callback state:(id)state;
+ (NSNumber *) endShowMessageBox:(id<IAsyncResult>)result;

+ (Guide*) getInstance;

- (void) showAchievements;
- (void) showLeaderboard;
- (id<IAsyncResult>) beginShowMessageBoxWithTitle:(NSString*)title text:(NSString*)text buttons:(NSArray*)buttons focusButton:(int)focusButton 
								 icon:(MessageBoxIcon)icon callback:(Delegate*)callback state:(id)state;
- (NSNumber *) endShowMessageBox:(id<IAsyncResult>)result;

@end
