//
//  TextureImporter.m
//  XNI
//
//  Created by Matej Jan on 7.9.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "TextureImporter.h"
#import <UIKit/UIKit.h>

#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.Xni.Framework.Content.Pipeline.h"
#import "Retronator.Xni.Framework.Content.Pipeline.Graphics.h"

#define PVR_TEXTURE_FLAG_TYPE_MASK  0xff


static char gPVRTexIdentifier[4] = "PVR!";

enum
{
    kPVRTextureFlagTypePVRTC_2 = 24,
    kPVRTextureFlagTypePVRTC_4
};

typedef struct _PVRTexHeader
{
    uint32_t headerLength;
    uint32_t height;
    uint32_t width;
    uint32_t numMipmaps;
    uint32_t flags;
    uint32_t dataLength;
    uint32_t bpp;
    uint32_t bitmaskRed;
    uint32_t bitmaskGreen;
    uint32_t bitmaskBlue;
    uint32_t bitmaskAlpha;
    uint32_t pvrTag;
    uint32_t numSurfs;
} PVRTexHeader;

@implementation TextureImporter

- (TextureContent*) importFile:(NSString*)filename {
    NSData *textureData = [NSData dataWithContentsOfFile:filename];
    
    if ([[filename pathExtension] isEqualToString:@"pvr"]) {
        //Import pvrtc texture
        NSMutableArray *images = [NSMutableArray array];
        SurfaceFormat format;
        int width;
        int height;
        
        [self unpackPVR:textureData to:images format:&format width:&width height:&height];
        if (images.count == 0) {
            [NSException raise:@"InvalidArgumentException" format:@"Make sure that .pvr texture is properly compressed and that the file has correct header. Use this command in terminal:/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/texturetool -e PVRTC -f PVR --channel-weighting-perceptual --bits-per-pixel-4 -o output.pvr input.png"];
        }
        
        // This bitmap is the only one in the mipmap chain.
        MipmapChain *mipmaps = [[[MipmapChain alloc] init] autorelease];
        
        for(NSData *imgData in images){
            PixelBitmapContent *bitmap = [[PixelBitmapContent alloc] initWithWidth:(int)width height:(int)height format:format];
            NSLog(@"Storing compressed texture with data length:%d", [imgData length]);
            [bitmap setPixelData:[NSData dataWithBytes:[imgData bytes] length:[imgData length]]];
            [mipmaps addObject:bitmap];
            [bitmap release];
        }
        
        // Create the texture content.
        Texture2DContent *content = [[[Texture2DContent alloc] init] autorelease];
        content.identity.sourceFilename = filename;
        content.mipmaps = mipmaps;
        return content;
    }else{
        
        UIImage *image = [UIImage imageWithData:textureData];
        if (image == nil) {
            [NSException raise:@"InvalidArgumentException" format:@"The provided file is not a supported texture resource."];
        }	
        
        // Allocate space for raw data.
        GLuint width = CGImageGetWidth(image.CGImage);
        GLuint height = CGImageGetHeight(image.CGImage);
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        void *imageData = malloc(width * height * 4);
        
        // Create a context for drawing to the raw data space.
        CGContextRef textureContext = CGBitmapContextCreate(imageData, width, height, 8, 4 * width, colorSpace,
                                                            kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big );

        // Draw the image to our context.
        CGContextClearRect(textureContext, CGRectMake(0, 0, width, height));
        CGContextTranslateCTM(textureContext, 0, 0);	
        CGContextDrawImage(textureContext, CGRectMake(0, 0, width, height), image.CGImage);
            
        // Create pixel bitmap content.
        PixelBitmapContent *bitmap = [[[PixelBitmapContent alloc] initWithWidth:(int)width height:(int)height format:SurfaceFormatColor] autorelease];
        [bitmap setPixelData:[NSData dataWithBytes:imageData length:width*height*4]];
        
        // Clean up.
        CGColorSpaceRelease(colorSpace);
        CGContextRelease(textureContext); 	
        free(imageData);
        
        // This bitmap is the only one in the mipmap chain.
        MipmapChain *mipmaps = [[[MipmapChain alloc] init] autorelease];
        [mipmaps addObject:bitmap];
        
        // Create the texture content.
        Texture2DContent *content = [[[Texture2DContent alloc] init] autorelease];
        content.identity.sourceFilename = filename;
        content.mipmaps = mipmaps;
        
        return content;
    }
}

- (BOOL) unpackPVR:(NSData*)data to:(NSMutableArray*)imageData format:(GLenum*)formatOut width:(int*)widthOut height:(int*)heightOut{

    BOOL success = FALSE;
    PVRTexHeader *header = NULL;
    uint32_t flags, pvrTag;
    uint32_t dataLength = 0, dataOffset = 0, dataSize = 0;
    uint32_t blockSize = 0, widthBlocks = 0, heightBlocks = 0;
    uint32_t width = 0, height = 0, bpp = 4;
    uint8_t *bytes = NULL;
    uint32_t formatFlags;
    
    header = (PVRTexHeader *)[data bytes];
    
    pvrTag = CFSwapInt32LittleToHost(header->pvrTag);
    
    if (gPVRTexIdentifier[0] != ((pvrTag >>  0) & 0xff) ||
        gPVRTexIdentifier[1] != ((pvrTag >>  8) & 0xff) ||
        gPVRTexIdentifier[2] != ((pvrTag >> 16) & 0xff) ||
        gPVRTexIdentifier[3] != ((pvrTag >> 24) & 0xff))
    {
        return FALSE;
    }
    
    flags = CFSwapInt32LittleToHost(header->flags);
    formatFlags = flags & PVR_TEXTURE_FLAG_TYPE_MASK;
    
    if (formatFlags == kPVRTextureFlagTypePVRTC_4 || formatFlags == kPVRTextureFlagTypePVRTC_2)
    {
        [imageData removeAllObjects];
        
        BOOL alpha = FALSE;
        
        if (CFSwapInt32LittleToHost(header->bitmaskAlpha))
            alpha = TRUE;
        else
            alpha = FALSE;
        
        if (formatFlags == kPVRTextureFlagTypePVRTC_4 && alpha)
            *formatOut = SurfaceFormatPvrtc4bAlpha;
        else if (formatFlags == kPVRTextureFlagTypePVRTC_4 && !alpha)
            *formatOut = SurfaceFormatPvrtc4b;
        else if (formatFlags == kPVRTextureFlagTypePVRTC_2 && alpha)
            *formatOut = SurfaceFormatPvrtc2bAlpha;
        else if (formatFlags == kPVRTextureFlagTypePVRTC_2 && !alpha)
            *formatOut = SurfaceFormatPvrtc2b;
        
        *widthOut = width = CFSwapInt32LittleToHost(header->width);
        *heightOut = height = CFSwapInt32LittleToHost(header->height);
        
        dataLength = CFSwapInt32LittleToHost(header->dataLength);
        
        bytes = ((uint8_t *)[data bytes]) + sizeof(PVRTexHeader);
        
        // Calculate the data size for each texture level and respect the minimum number of blocks
        while (dataOffset < dataLength)
        {
            if (formatFlags == kPVRTextureFlagTypePVRTC_4)
            {
                blockSize = 4 * 4; // Pixel by pixel block size for 4bpp
                widthBlocks = width / 4;
                heightBlocks = height / 4;
                bpp = 4;
            }
            else
            {
                blockSize = 8 * 4; // Pixel by pixel block size for 2bpp
                widthBlocks = width / 8;
                heightBlocks = height / 4;
                bpp = 2;
            }
            
            // Clamp to minimum number of blocks
            if (widthBlocks < 2)
                widthBlocks = 2;
            if (heightBlocks < 2)
                heightBlocks = 2;
            
            dataSize = widthBlocks * heightBlocks * ((blockSize  * bpp) / 8);
            
            [imageData addObject:[NSData dataWithBytes:bytes+dataOffset length:dataSize]];
            
            dataOffset += dataSize;
            
            width = MAX(width >> 1, 1);
            height = MAX(height >> 1, 1);
        }
        
        success = TRUE;
    }
    
    return success;
}

@end
