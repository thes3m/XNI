//
//  SpriteBatch.h
//  XNI
//
//  Created by Matej Jan on 16.9.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GraphicsResource.h"

@interface SpriteBatch : GraphicsResource {
	
}

- (void) begin;

- (void) beginWithSortMode:(SpriteSortMode)sortMode 
				BlendState:(BlendState*)blendState;

- (void) beginWithSortMode:(SpriteSortMode)sortMode 
				BlendState:(BlendState*)blendState 
			  SamplerState:(SamplerState*)samplerState 
		 DepthStencilState:(DepthStencilState*)depthStencilState 
		   RasterizerState:(RasterizerState*)rasterizerState;

- (void) beginWithSortMode:(SpriteSortMode)sortMode 
				BlendState:(BlendState*)blendState 
			  SamplerState:(SamplerState*)samplerState 
		 DepthStencilState:(DepthStencilState*)depthStencilState 
		   RasterizerState:(RasterizerState*)rasterizerState 
					Effect:(Effect*)effect;

- (void) beginWithSortMode:(SpriteSortMode)sortMode 
				BlendState:(BlendState*)blendState 
			  SamplerState:(SamplerState*)samplerState 
		 DepthStencilState:(DepthStencilState*)depthStencilState 
		   RasterizerState:(RasterizerState*)rasterizerState 
					Effect:(Effect*)effect 
		   TransformMatrix:(Matrix*)transformMatrix;


@end
