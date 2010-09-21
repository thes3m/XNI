//
//  TextureCollection.h
//  XNI
//
//  Created by Matej Jan on 21.9.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Retronator.Xni.Framework.Graphics.classes.h"

@interface TextureCollection : NSObject {
	NSMutableArray *collection;
}

- (int) count;
- (Texture*)objectAtIndex:(NSUInteger)index;
- (void)addObject:(Texture*)anObject;
- (void)insertObject:(Texture*)anObject atIndex:(NSUInteger)index;

@end
