//
//  Achievement.h
//  XNI
//
//  Created by Matej Jan on 18.2.11.
//  Copyright 2011 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Achievement : NSObject {
	NSString *description;
	BOOL displayBeforeEarned;
	NSDate *earnedDateTime;
	int gamerScore;
	NSString *howToEarn;
	BOOL isEarned;
	NSString *key;
	NSString *name;
}

@property (nonatomic, readonly) NSString *description;
@property (nonatomic, readonly) BOOL displayBeforeEarned;
@property (nonatomic, readonly) NSDate *earnedDateTime;
@property (nonatomic, readonly) int gamerScore;
@property (nonatomic, readonly) NSString *howToEarn;
@property (nonatomic, readonly) BOOL isEarned;
@property (nonatomic, readonly) NSString *key;
@property (nonatomic, readonly) NSString *name;

- (NSData*) getPicture;

@end
