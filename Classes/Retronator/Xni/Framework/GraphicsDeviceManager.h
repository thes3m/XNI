//
//  GraphicsDeviceManager.h
//  XNI
//
//  Created by Matej Jan on 27.7.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "System.h"

#import "IGraphicsDeviceManager.h"
#import "IGraphicsDeviceService.h"
#import "Retronator.Xni.Framework.classes.h"
#import "Retronator.Xni.Framework.Graphics.classes.h"

@interface GraphicsDeviceManager : NSObject <IGraphicsDeviceManager, IGraphicsDeviceService> {
	GraphicsProfile graphicsProfile;
    BOOL isFullScreen;
	BOOL preferMultiSampling;
	SurfaceFormat preferredSurfaceFormat;
	int preferredBackBufferWidth;
	int preferredBackBufferHeight;
	DepthFormat preferredDepthStencilFormat;
	DisplayOrientation supportedOrientations;
    
    Game *game;
    GraphicsDevice *graphicsDevice;
    Event *deviceCreated;
    Event *deviceDisposing;
    Event *deviceResetting;
    Event *deviceReset;
}

- (id) initWithGame:(Game*)theGame;

@property (nonatomic) GraphicsProfile graphicsProfile;
@property (nonatomic) BOOL isFullScreen;
@property (nonatomic) BOOL preferMultiSampling;
@property (nonatomic) SurfaceFormat preferredSurfaceFormat;
@property (nonatomic) int preferredBackBufferWidth;
@property (nonatomic) int preferredBackBufferHeight;
@property (nonatomic) DepthFormat preferredDepthStencilFormat;
@property (nonatomic) DisplayOrientation supportedOrientations;

- (void) toggleFullscreen;
- (void) applyChanges;

@end
