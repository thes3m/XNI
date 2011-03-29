//
//  XniShowMessageBoxResult.h
//  XNI
//
//  Created by Matej Jan on 23.2.11.
//  Copyright 2011 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "System.h"

@interface XniShowMessageBoxResult : NSObject <IAsyncResult, UIAlertViewDelegate> {
	id asyncState;
	Delegate *callback;
	NSLock *asyncLock;
	BOOL isCompleted;
	NSNumber *result;
}

- (id) initWithAsyncState:(id)theAsyncState callback:(Delegate*)theCallback;

@property (nonatomic, readonly) NSNumber *result;

@end
