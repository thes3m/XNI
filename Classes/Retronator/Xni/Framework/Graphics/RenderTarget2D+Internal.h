//
//  RenderTarget2D+Internal.h
//  XNI
//
//  Created by Samo Pajk on 9/6/12.
//  Copyright (c) 2012 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RenderTarget2D (Internal)

- (GLuint) colorFramebuffer;

- (GLuint) colorRenderbuffer;

@end
