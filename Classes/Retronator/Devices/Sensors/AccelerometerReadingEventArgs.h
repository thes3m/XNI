//
//  AccelerometerReadingEventArgs.h
//  XNI
//
//  Created by Matej Jan on 15.2.11.
//  Copyright 2011 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "System.h"

@interface AccelerometerReadingEventArgs : EventArgs {
	NSTimeInterval timestamp;
	double x, y, z;
}

@property (nonatomic, readonly) NSTimeInterval timestamp;
@property (nonatomic, readonly) double x, y, z;

@end
