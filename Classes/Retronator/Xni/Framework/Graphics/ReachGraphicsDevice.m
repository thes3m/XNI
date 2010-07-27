//
//  ReachGraphicsDevice.m
//  XNI
//
//  Created by Matej Jan on 27.7.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "ReachGraphicsDevice.h"

@implementation ReachGraphicsDevice

- (EAGLContext*) createContext { 
	return [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1]; 
}

@end
