//
//  TouchLocation.h
//  XNI
//
//  Created by Matej Jan on 29.9.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Retronator.Xni.Framework.classes.h"
#import "Retronator.Xni.Framework.Input.Touch.classes.h"

@interface TouchLocation : NSObject {
	int id;
	Vector2 *position;
	TouchLocationState state;
}

@property (nonatomic, readonly) int id;
@property (nonatomic, readonly) Vector2 *position;
@property (nonatomic, readonly) TouchLocationState state;

@end
