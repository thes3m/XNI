//
//  GameServiceContainer.h
//  XNI
//
//  Created by Matej Jan on 27.7.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GameServiceContainer : NSObject {
    CFMutableDictionaryRef services;
}

- (void)addService:(id)provider ofType:(id)type;
- (id)getServiceOfType:(id)type;
- (void)removeServiceOfType:(id)type;

@end
