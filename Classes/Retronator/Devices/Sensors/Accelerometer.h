//
//  Accelerometer.h
//  XNI
//
//  Created by Matej Jan on 15.2.11.
//  Copyright 2011 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "System.h"
#import "Retronator.Devices.Sensors.classes.h"

@interface Accelerometer : NSObject<UIAccelerometerDelegate> {
	SensorState state;

	Event *readingChanged;
}

@property (nonatomic, readonly) SensorState state;
@property (nonatomic, readonly) Event *readingChanged;

- (void) start;
- (void) stop;

@end
