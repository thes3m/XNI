//
//  Color.m
//  XNI
//
//  Created by Matej Jan on 27.7.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "Color.h"

#define CLAMP_TO_BYTE(X) (X < 0 ? 0 : (X > 255 ? 255 : X))


@implementation Color

// CONSTRUCTORS

- (id) initWithRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha {
    if (self = [super init]) {
        red = CLAMP_TO_BYTE(red);
        green = CLAMP_TO_BYTE(green) << 8;
        blue = CLAMP_TO_BYTE(blue) << 16;
        alpha = CLAMP_TO_BYTE(alpha) << 24;
		packedValue = red | green | blue | alpha;
    }
    return self;
}

- (id) initWithRed:(int)red Green:(int)green Blue:(int)blue {
    return [self initWithRed:red Green:green Blue:blue Alpha:255];
}

- (id) initWithPercentageRed:(float)red Green:(float)green Blue:(float)blue Alpha:(float)alpha {
    return [self initWithRed:255 * red Green:255 * green Blue:255 * blue Alpha:255 * alpha];
}

- (id) initWithPercentageRed:(float)red Green:(float)green Blue:(float)blue {
    return [self initWithPercentageRed:red Green:green Blue:blue Alpha:1];
}

- (id) initWithColor:(Color*)color {
    return [self initWithRed:color.r Green:color.g Blue:color.b Alpha:color.a];
}

+ (Color*) colorWithRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha {
    return [[[Color alloc] initWithRed:red Green:green Blue:blue Alpha:alpha] autorelease];
}

+ (Color*) colorWithRed:(int)red Green:(int)green Blue:(int)blue {
    return [[[Color alloc] initWithRed:red Green:green Blue:blue] autorelease];
}

+ (Color*) colorWithPercentageRed:(float)red Green:(float)green Blue:(float)blue Alpha:(float)alpha {
    return [[[Color alloc] initWithPercentageRed:red Green:green Blue:blue Alpha:alpha] autorelease];
}

+ (Color*) colorWithPercentageRed:(float)red Green:(float)green Blue:(float)blue {
    return [[[Color alloc] initWithPercentageRed:red Green:green Blue:blue] autorelease];
}

+ (Color*) colorWithColor:(Color *)color {
    return [[[Color alloc] initWithColor:color] autorelease];
}

// PROPERTIES

- (Byte) r {return (Byte)packedValue;}
- (void) setR:(Byte)value {packedValue = packedValue & 0xffffff00 | value;}

- (Byte) g {return (Byte)(packedValue >> 8);}
- (void) setG:(Byte)value {packedValue = packedValue & 0xffff00ff | ((uint)value << 8);}

- (Byte) b {return (Byte)(packedValue >> 16);}
- (void) setB:(Byte)value {packedValue = packedValue & 0xff00ffff | ((uint)value << 16);}

- (Byte) a {return (Byte)(packedValue >> 24);}
- (void) setA:(Byte)value {packedValue = packedValue & 0x00ffffff | ((uint)value << 24);}

@synthesize packedValue;

// METHODS

/*- (Vector3 *) toVector3 {
    return [Vector3 vectorWithX:data.red Y:data.green Z:data.blue];
}*/


// Constants
+ (Color*) aliceBlue {return [Color colorWithRed:240 Green:248 Blue:255 Alpha:255];}
+ (Color*) antiqueWhite {return [Color colorWithRed:250 Green:235 Blue:215 Alpha:255];}
+ (Color*) aqua {return [Color colorWithRed:0 Green:255 Blue:255 Alpha:255];}
+ (Color*) aquamarine {return [Color colorWithRed:127 Green:255 Blue:212 Alpha:255];}
+ (Color*) azure {return [Color colorWithRed:240 Green:255 Blue:255 Alpha:255];}
+ (Color*) beige {return [Color colorWithRed:245 Green:245 Blue:220 Alpha:255];}
+ (Color*) bisque {return [Color colorWithRed:255 Green:228 Blue:196 Alpha:255];}
+ (Color*) black {return [Color colorWithRed:0 Green:0 Blue:0 Alpha:255];}
+ (Color*) blanchedAlmond {return [Color colorWithRed:255 Green:235 Blue:205 Alpha:255];}
+ (Color*) blue {return [Color colorWithRed:0 Green:0 Blue:255 Alpha:255];}
+ (Color*) blueViolet {return [Color colorWithRed:138 Green:43 Blue:226 Alpha:255];}
+ (Color*) brown {return [Color colorWithRed:165 Green:42 Blue:42 Alpha:255];}
+ (Color*) burlyWood {return [Color colorWithRed:222 Green:184 Blue:135 Alpha:255];}
+ (Color*) cadetBlue {return [Color colorWithRed:95 Green:158 Blue:160 Alpha:255];}
+ (Color*) chartreuse {return [Color colorWithRed:127 Green:255 Blue:0 Alpha:255];}
+ (Color*) chocolate {return [Color colorWithRed:210 Green:105 Blue:30 Alpha:255];}
+ (Color*) coral {return [Color colorWithRed:255 Green:127 Blue:80 Alpha:255];}
+ (Color*) cornflowerBlue {return [Color colorWithRed:100 Green:149 Blue:237 Alpha:255];}
+ (Color*) cornsilk {return [Color colorWithRed:255 Green:248 Blue:220 Alpha:255];}
+ (Color*) crimson {return [Color colorWithRed:220 Green:20 Blue:60 Alpha:255];}
+ (Color*) cyan {return [Color colorWithRed:0 Green:255 Blue:255 Alpha:255];}
+ (Color*) darkBlue {return [Color colorWithRed:0 Green:0 Blue:139 Alpha:255];}
+ (Color*) darkCyan {return [Color colorWithRed:0 Green:139 Blue:139 Alpha:255];}
+ (Color*) darkGoldenrod {return [Color colorWithRed:184 Green:134 Blue:11 Alpha:255];}
+ (Color*) darkGray {return [Color colorWithRed:169 Green:169 Blue:169 Alpha:255];}
+ (Color*) darkGreen {return [Color colorWithRed:0 Green:100 Blue:0 Alpha:255];}
+ (Color*) darkKhaki {return [Color colorWithRed:189 Green:183 Blue:107 Alpha:255];}
+ (Color*) darkMagenta {return [Color colorWithRed:139 Green:0 Blue:139 Alpha:255];}
+ (Color*) darkOliveGreen {return [Color colorWithRed:85 Green:107 Blue:47 Alpha:255];}
+ (Color*) darkOrange {return [Color colorWithRed:255 Green:140 Blue:0 Alpha:255];}
+ (Color*) darkOrchid {return [Color colorWithRed:153 Green:50 Blue:204 Alpha:255];}
+ (Color*) darkRed {return [Color colorWithRed:139 Green:0 Blue:0 Alpha:255];}
+ (Color*) darkSalmon {return [Color colorWithRed:233 Green:150 Blue:122 Alpha:255];}
+ (Color*) darkSeaGreen {return [Color colorWithRed:143 Green:188 Blue:139 Alpha:255];}
+ (Color*) darkSlateBlue {return [Color colorWithRed:72 Green:61 Blue:139 Alpha:255];}
+ (Color*) darkSlateGray {return [Color colorWithRed:47 Green:79 Blue:79 Alpha:255];}
+ (Color*) darkTurquoise {return [Color colorWithRed:0 Green:206 Blue:209 Alpha:255];}
+ (Color*) darkViolet {return [Color colorWithRed:148 Green:0 Blue:211 Alpha:255];}
+ (Color*) deepPink {return [Color colorWithRed:255 Green:20 Blue:147 Alpha:255];}
+ (Color*) deepSkyBlue {return [Color colorWithRed:0 Green:191 Blue:255 Alpha:255];}
+ (Color*) dimGray {return [Color colorWithRed:105 Green:105 Blue:105 Alpha:255];}
+ (Color*) dodgerBlue {return [Color colorWithRed:30 Green:144 Blue:255 Alpha:255];}
+ (Color*) firebrick {return [Color colorWithRed:178 Green:34 Blue:34 Alpha:255];}
+ (Color*) floralWhite {return [Color colorWithRed:255 Green:250 Blue:240 Alpha:255];}
+ (Color*) forestGreen {return [Color colorWithRed:34 Green:139 Blue:34 Alpha:255];}
+ (Color*) fuchsia {return [Color colorWithRed:255 Green:0 Blue:255 Alpha:255];}
+ (Color*) gainsboro {return [Color colorWithRed:220 Green:220 Blue:220 Alpha:255];}
+ (Color*) ghostWhite {return [Color colorWithRed:248 Green:248 Blue:255 Alpha:255];}
+ (Color*) gold {return [Color colorWithRed:255 Green:215 Blue:0 Alpha:255];}
+ (Color*) goldenrod {return [Color colorWithRed:218 Green:165 Blue:32 Alpha:255];}
+ (Color*) gray {return [Color colorWithRed:128 Green:128 Blue:128 Alpha:255];}
+ (Color*) green {return [Color colorWithRed:0 Green:128 Blue:0 Alpha:255];}
+ (Color*) greenYellow {return [Color colorWithRed:173 Green:255 Blue:47 Alpha:255];}
+ (Color*) honeydew {return [Color colorWithRed:240 Green:255 Blue:240 Alpha:255];}
+ (Color*) hotPink {return [Color colorWithRed:255 Green:105 Blue:180 Alpha:255];}
+ (Color*) indianRed {return [Color colorWithRed:205 Green:92 Blue:92 Alpha:255];}
+ (Color*) indigo {return [Color colorWithRed:75 Green:0 Blue:130 Alpha:255];}
+ (Color*) ivory {return [Color colorWithRed:255 Green:255 Blue:240 Alpha:255];}
+ (Color*) khaki {return [Color colorWithRed:240 Green:230 Blue:140 Alpha:255];}
+ (Color*) lavender {return [Color colorWithRed:230 Green:230 Blue:250 Alpha:255];}
+ (Color*) lavenderBlush {return [Color colorWithRed:255 Green:240 Blue:245 Alpha:255];}
+ (Color*) lawnGreen {return [Color colorWithRed:124 Green:252 Blue:0 Alpha:255];}
+ (Color*) lemonChiffon {return [Color colorWithRed:255 Green:250 Blue:205 Alpha:255];}
+ (Color*) lightBlue {return [Color colorWithRed:173 Green:216 Blue:230 Alpha:255];}
+ (Color*) lightCoral {return [Color colorWithRed:240 Green:128 Blue:128 Alpha:255];}
+ (Color*) lightCyan {return [Color colorWithRed:224 Green:255 Blue:255 Alpha:255];}
+ (Color*) lightGoldenrodYellow {return [Color colorWithRed:250 Green:250 Blue:210 Alpha:255];}
+ (Color*) lightGray {return [Color colorWithRed:211 Green:211 Blue:211 Alpha:255];}
+ (Color*) lightGreen {return [Color colorWithRed:144 Green:238 Blue:144 Alpha:255];}
+ (Color*) lightPink {return [Color colorWithRed:255 Green:182 Blue:193 Alpha:255];}
+ (Color*) lightSalmon {return [Color colorWithRed:255 Green:160 Blue:122 Alpha:255];}
+ (Color*) lightSeaGreen {return [Color colorWithRed:32 Green:178 Blue:170 Alpha:255];}
+ (Color*) lightSkyBlue {return [Color colorWithRed:135 Green:206 Blue:250 Alpha:255];}
+ (Color*) lightSlateGray {return [Color colorWithRed:119 Green:136 Blue:153 Alpha:255];}
+ (Color*) lightSteelBlue {return [Color colorWithRed:176 Green:196 Blue:222 Alpha:255];}
+ (Color*) lightYellow {return [Color colorWithRed:255 Green:255 Blue:224 Alpha:255];}
+ (Color*) lime {return [Color colorWithRed:0 Green:255 Blue:0 Alpha:255];}
+ (Color*) limeGreen {return [Color colorWithRed:50 Green:205 Blue:50 Alpha:255];}
+ (Color*) linen {return [Color colorWithRed:250 Green:240 Blue:230 Alpha:255];}
+ (Color*) magenta {return [Color colorWithRed:255 Green:0 Blue:255 Alpha:255];}
+ (Color*) maroon {return [Color colorWithRed:128 Green:0 Blue:0 Alpha:255];}
+ (Color*) mediumAquamarine {return [Color colorWithRed:102 Green:205 Blue:170 Alpha:255];}
+ (Color*) mediumBlue {return [Color colorWithRed:0 Green:0 Blue:205 Alpha:255];}
+ (Color*) mediumOrchid {return [Color colorWithRed:186 Green:85 Blue:211 Alpha:255];}
+ (Color*) mediumPurple {return [Color colorWithRed:147 Green:112 Blue:219 Alpha:255];}
+ (Color*) mediumSeaGreen {return [Color colorWithRed:60 Green:179 Blue:113 Alpha:255];}
+ (Color*) mediumSlateBlue {return [Color colorWithRed:123 Green:104 Blue:238 Alpha:255];}
+ (Color*) mediumSpringGreen {return [Color colorWithRed:0 Green:250 Blue:154 Alpha:255];}
+ (Color*) mediumTurquoise {return [Color colorWithRed:72 Green:209 Blue:204 Alpha:255];}
+ (Color*) mediumVioletRed {return [Color colorWithRed:199 Green:21 Blue:133 Alpha:255];}
+ (Color*) midnightBlue {return [Color colorWithRed:25 Green:25 Blue:112 Alpha:255];}
+ (Color*) mintCream {return [Color colorWithRed:245 Green:255 Blue:250 Alpha:255];}
+ (Color*) mistyRose {return [Color colorWithRed:255 Green:228 Blue:225 Alpha:255];}
+ (Color*) moccasin {return [Color colorWithRed:255 Green:228 Blue:181 Alpha:255];}
+ (Color*) navajoWhite {return [Color colorWithRed:255 Green:222 Blue:173 Alpha:255];}
+ (Color*) navy {return [Color colorWithRed:0 Green:0 Blue:128 Alpha:255];}
+ (Color*) oldLace {return [Color colorWithRed:253 Green:245 Blue:230 Alpha:255];}
+ (Color*) olive {return [Color colorWithRed:128 Green:128 Blue:0 Alpha:255];}
+ (Color*) oliveDrab {return [Color colorWithRed:107 Green:142 Blue:35 Alpha:255];}
+ (Color*) orange {return [Color colorWithRed:255 Green:165 Blue:0 Alpha:255];}
+ (Color*) orangeRed {return [Color colorWithRed:255 Green:69 Blue:0 Alpha:255];}
+ (Color*) orchid {return [Color colorWithRed:218 Green:112 Blue:214 Alpha:255];}
+ (Color*) paleGoldenrod {return [Color colorWithRed:238 Green:232 Blue:170 Alpha:255];}
+ (Color*) paleGreen {return [Color colorWithRed:152 Green:251 Blue:152 Alpha:255];}
+ (Color*) paleTurquoise {return [Color colorWithRed:175 Green:238 Blue:238 Alpha:255];}
+ (Color*) paleVioletRed {return [Color colorWithRed:219 Green:112 Blue:147 Alpha:255];}
+ (Color*) papayaWhip {return [Color colorWithRed:255 Green:239 Blue:213 Alpha:255];}
+ (Color*) peachPuff {return [Color colorWithRed:255 Green:218 Blue:185 Alpha:255];}
+ (Color*) peru {return [Color colorWithRed:205 Green:133 Blue:63 Alpha:255];}
+ (Color*) pink {return [Color colorWithRed:255 Green:192 Blue:203 Alpha:255];}
+ (Color*) plum {return [Color colorWithRed:221 Green:160 Blue:221 Alpha:255];}
+ (Color*) powderBlue {return [Color colorWithRed:176 Green:224 Blue:230 Alpha:255];}
+ (Color*) purple {return [Color colorWithRed:128 Green:0 Blue:128 Alpha:255];}
+ (Color*) red {return [Color colorWithRed:255 Green:0 Blue:0 Alpha:255];}
+ (Color*) rosyBrown {return [Color colorWithRed:188 Green:143 Blue:143 Alpha:255];}
+ (Color*) royalBlue {return [Color colorWithRed:65 Green:105 Blue:225 Alpha:255];}
+ (Color*) saddleBrown {return [Color colorWithRed:139 Green:69 Blue:19 Alpha:255];}
+ (Color*) salmon {return [Color colorWithRed:250 Green:128 Blue:114 Alpha:255];}
+ (Color*) sandyBrown {return [Color colorWithRed:244 Green:164 Blue:96 Alpha:255];}
+ (Color*) seaGreen {return [Color colorWithRed:46 Green:139 Blue:87 Alpha:255];}
+ (Color*) seaShell {return [Color colorWithRed:255 Green:245 Blue:238 Alpha:255];}
+ (Color*) sienna {return [Color colorWithRed:160 Green:82 Blue:45 Alpha:255];}
+ (Color*) silver {return [Color colorWithRed:192 Green:192 Blue:192 Alpha:255];}
+ (Color*) skyBlue {return [Color colorWithRed:135 Green:206 Blue:235 Alpha:255];}
+ (Color*) slateBlue {return [Color colorWithRed:106 Green:90 Blue:205 Alpha:255];}
+ (Color*) slateGray {return [Color colorWithRed:112 Green:128 Blue:144 Alpha:255];}
+ (Color*) snow {return [Color colorWithRed:255 Green:250 Blue:250 Alpha:255];}
+ (Color*) springGreen {return [Color colorWithRed:0 Green:255 Blue:127 Alpha:255];}
+ (Color*) steelBlue {return [Color colorWithRed:70 Green:130 Blue:180 Alpha:255];}
+ (Color*) tan {return [Color colorWithRed:210 Green:180 Blue:140 Alpha:255];}
+ (Color*) teal {return [Color colorWithRed:0 Green:128 Blue:128 Alpha:255];}
+ (Color*) thistle {return [Color colorWithRed:216 Green:191 Blue:216 Alpha:255];}
+ (Color*) tomato {return [Color colorWithRed:255 Green:99 Blue:71 Alpha:255];}
+ (Color*) transparent {return [Color colorWithRed:0 Green:0 Blue:0 Alpha:0];}
+ (Color*) turquoise {return [Color colorWithRed:64 Green:224 Blue:208 Alpha:255];}
+ (Color*) violet {return [Color colorWithRed:238 Green:130 Blue:238 Alpha:255];}
+ (Color*) wheat {return [Color colorWithRed:245 Green:222 Blue:179 Alpha:255];}
+ (Color*) white {return [Color colorWithRed:255 Green:255 Blue:255 Alpha:255];}
+ (Color*) whiteSmoke {return [Color colorWithRed:245 Green:245 Blue:245 Alpha:255];}
+ (Color*) yellow {return [Color colorWithRed:255 Green:255 Blue:0 Alpha:255];}
+ (Color*) yellowGreen {return [Color colorWithRed:154 Green:205 Blue:50 Alpha:255];}

@end
