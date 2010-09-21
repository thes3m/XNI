//
//  EffectPass.h
//  XNI
//
//  Created by Matej Jan on 21.9.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EffectPass : NSObject {
    NSString *name;
}

- (id) initWithName:(NSString*)theName;

@property (nonatomic, readonly) NSString *name;

- (void) apply;

@end
