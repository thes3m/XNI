//
//  GameViewController.m
//  XNI
//
//  Created by Matej Jan on 22.7.10.
//  Copyright 2010 Retronator, Razum. All rights reserved.
//

#import "GameViewController.h"

#import "Retronator.Xni.Framework.h"
#import "TouchPanel+Internal.h"
#import "GameView.h"


@implementation GameViewController

- initWithGameWindow: (GameWindow*)theGameWindow {
    if (self = [super init]) {
        gameWindow = theGameWindow;
    }
    return self;
}

+ (DisplayOrientation) getDisplayOrientationForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
		return DisplayOrientationPortrait;
	} else {
		if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
			return DisplayOrientationLandscapeLeft;
		} else if (interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
			return DisplayOrientationLandscapeRight;
		} else {
			return DisplayOrientationDefault;
		}
	}
	
}

- (void)loadView {
    GameView *gameView = [[GameView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view = gameView;
	
	[TouchPanel instance].displayWidth = self.view.bounds.size.width;
	[TouchPanel instance].displayHeight = self.view.bounds.size.height;
	[TouchPanel instance].displayOrientation = [GameViewController getDisplayOrientationForInterfaceOrientation:self.interfaceOrientation];
    
    [gameView release];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    //InterfaceOrientationFlags orientationFlag = 1 << interfaceOrientation;
    return YES; // gameWindow.allowedOrientations & orientationFlag;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


// Touches

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[TouchPanel instance] touchesBegan:touches withEvent:event];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[TouchPanel instance] touchesMoved:touches withEvent:event];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[TouchPanel instance] touchesEnded:touches withEvent:event];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [[TouchPanel instance] touchesCancelled:touches withEvent:event];
}

- (void)dealloc {
    [super dealloc];
}

@end
