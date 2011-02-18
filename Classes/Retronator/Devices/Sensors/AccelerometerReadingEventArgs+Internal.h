//
//  AccelerometerReadingEventArgs+Internal.h
//  XNI
//
//  Created by Matej Jan on 15.2.11.
//  Copyright 2011 Retronator. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AccelerometerReadingEventArgs (Internal)

- (id) initWithTimestamp:(NSTimeInterval)timestampValue x:(double)xValue y:(double)yValue z:(double)zValue;

@end
