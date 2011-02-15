//
//  Game+Internal.h
//  XNI
//
//  Created by Matej Jan on 15.2.11.
//  Copyright 2011 Retronator. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Game (Internal)

- (void) presentModalViewController:(UIViewController*)viewController;
- (void) dismissModalViewController;

@end
