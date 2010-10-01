//
//  GameViewController.h
//  XNI
//
//  Created by Matej Jan on 22.7.10.
//  Copyright 2010 Retronator, Razum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Retronator.Xni.Framework.classes.h"

@interface GameViewController : UIViewController {
    GameWindow *gameWindow;
}

- initWithGameWindow: (GameWindow*)theGameWindow;

+ (DisplayOrientation) getDisplayOrientationForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end
