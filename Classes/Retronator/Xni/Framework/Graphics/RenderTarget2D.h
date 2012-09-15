//
//  RenderTarget2D.h
//  XNI
//
//  Created by Samo Pajk on 9/3/12.
//  Copyright (c) 2012 Samo Pajk. All rights reserved.
//

#import "Texture2D.h"

@interface RenderTarget2D : Texture2D

@property (nonatomic, readonly) BOOL isContentLost;
@property (nonatomic, readonly) RenderTargetUsage renderTargetUsage;

- (id)initWithGraphicsDevice:(GraphicsDevice *)theGraphicsDevice
                       width:(int)theWidth
                      height:(int)theHeight
                      mipmap:(BOOL)theMipmap
               surfaceFormat:(SurfaceFormat)theSurfaceFormat
                 depthFormat:(DepthFormat)theDepthFormat
            multiSampleCount:(int) theMultisampleCount
                       usage:(RenderTargetUsage)theUsage;

@end
