//
//  GameViewController.m
//  XNI
//
//  Created by Matej Jan on 22.7.10.
//  Copyright 2010 Retronator, Razum. All rights reserved.
//

#import "GameViewController.h"

#import "Retronator.Xni.Framework.h"


@implementation GameViewController

- initWithGameWindow: (GameWindow*)theGameWindow {
    if (self = [super init]) {
        gameWindow = theGameWindow;
    }
    return self;
}

- (void)loadView {
    GameView *gameView = [[GameView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view = gameView;
    
    [gameView release];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    //InterfaceOrientationFlags orientationFlag = 1 << interfaceOrientation;
    return YES;// gameWindow.allowedOrientations & orientationFlag;
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
/*
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[MultiTouch instance].touchesBegan fireWithSender:self eventArgs:[TouchEventArgs argsWithTouches:touches event:event]];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[MultiTouch instance].touchesMoved fireWithSender:self eventArgs:[TouchEventArgs argsWithTouches:touches event:event]];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[MultiTouch instance].touchesEnded fireWithSender:self eventArgs:[TouchEventArgs argsWithTouches:touches event:event]];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [[MultiTouch instance].touchesCancelled fireWithSender:self eventArgs:[TouchEventArgs argsWithTouches:touches event:event]];
}*/

- (void)dealloc {
    [super dealloc];
}

@end
