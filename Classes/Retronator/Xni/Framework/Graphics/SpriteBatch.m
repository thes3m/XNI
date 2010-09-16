//
//  SpriteBatch.m
//  XNI
//
//  Created by Matej Jan on 16.9.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "SpriteBatch.h"

#import "Retronator.Xni.Framework.Graphics.h"

@implementation SpriteBatch

- (void) begin {
	[self beginWithSortMode:SpriteSortModeDeffered BlendState:nil SamplerState:nil DepthStencilState:nil RasterizerState:nil Effect:nil TransformMatrix:nil];
}

- (void) beginWithSortMode:(SpriteSortMode)sortMode 
				BlendState:(BlendState*)blendState {
	[self beginWithSortMode:sortMode BlendState:blendState SamplerState:nil DepthStencilState:nil RasterizerState:nil Effect:nil TransformMatrix:nil];
}

- (void) beginWithSortMode:(SpriteSortMode)sortMode 
				BlendState:(BlendState*)blendState 
			  SamplerState:(SamplerState*)samplerState 
		 DepthStencilState:(DepthStencilState*)depthStencilState 
		   RasterizerState:(RasterizerState*)rasterizerState {
	[self beginWithSortMode:sortMode BlendState:blendState SamplerState:samplerState DepthStencilState:depthStencilState RasterizerState:rasterizerState Effect:nil TransformMatrix:nil];
}

- (void) beginWithSortMode:(SpriteSortMode)sortMode 
				BlendState:(BlendState*)blendState 
			  SamplerState:(SamplerState*)samplerState 
		 DepthStencilState:(DepthStencilState*)depthStencilState 
		   RasterizerState:(RasterizerState*)rasterizerState 
					Effect:(Effect*)effect {
	[self beginWithSortMode:sortMode BlendState:blendState SamplerState:samplerState DepthStencilState:depthStencilState RasterizerState:rasterizerState Effect:effect TransformMatrix:nil];
}

- (void) beginWithSortMode:(SpriteSortMode)sortMode 
				BlendState:(BlendState*)blendState 
			  SamplerState:(SamplerState*)samplerState 
		 DepthStencilState:(DepthStencilState*)depthStencilState 
		   RasterizerState:(RasterizerState*)rasterizerState 
					Effect:(Effect*)effect 
		   TransformMatrix:(Matrix*)transformMatrix {

	if (!blendState) blendState = [BlendState alphaBlend];
	if (!samplerState) samplerState = [SamplerState linearClamp];
	if (!depthStencilState) depthStencilState = [DepthStencilState none];
	if (!rasterizerState) rasterizerState = [RasterizerState cullCounterClockwise];
	
}

@end
