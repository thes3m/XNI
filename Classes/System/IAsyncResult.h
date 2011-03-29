//
//  IAsyncResult.h
//  XNI
//
//  Created by Matej Jan on 23.2.11.
//  Copyright 2011 Retronator. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol IAsyncResult

@property (nonatomic, readonly) id asyncState;
@property (nonatomic, readonly) NSLock *asyncLock;
@property (nonatomic, readonly) BOOL completedSynchronously;
@property (nonatomic, readonly) BOOL isCompleted;

@end
