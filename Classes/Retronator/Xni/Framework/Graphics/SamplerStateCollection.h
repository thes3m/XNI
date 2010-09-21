//
//  SamplerStateCollection.h
//  XNI
//
//  Created by Matej Jan on 21.9.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Retronator.Xni.Framework.Graphics.classes.h"

@interface SamplerStateCollection : NSObject {
	NSMutableArray *collection;
}
 
- (int) count;
- (SamplerState*)objectAtIndex:(NSUInteger)index;
- (void)addObject:(SamplerState*)anObject;
- (void)insertObject:(SamplerState*)anObject atIndex:(NSUInteger)index;

@end
