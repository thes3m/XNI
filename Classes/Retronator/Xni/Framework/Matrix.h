//
//  Matrix.h
//  XNI
//
//  Created by Matej Jan on 9.9.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Retronator.Xni.Framework.classes.h"

@interface Matrix : NSObject {
    MatrixStruct data;
}

- (id) initWithStruct: (MatrixStruct*)matrixData;
- (id) initWithMatrix: (Matrix*)matrix;

+ (Matrix*) matrixWithStruct: (MatrixStruct*)matrixData;
+ (Matrix*) matrixWithMatrix: (Matrix*)matrix;

+ (Matrix*) translation:(Vector3*)position;
+ (Matrix*) scale:(Vector3*)scale;
+ (Matrix*) rotationAround:(Vector3*)axis for:(float)angle;
+ (Matrix*) rotationWithQuaternion:(Quaternion*)quaternion;
+ (Matrix*) lookAt:(Vector3*)target from:(Vector3*)position up:(Vector3*)up;
+ (Matrix*) perspectiveWithWidth:(float)width height:(float)height nearPlane:(float)nearPlane farPlane:(float)farPlane;
+ (Matrix*) perspectiveWithFieldOfView:(float)fieldOfView aspectRatio:(float)aspectRatio nearPlane:(float)nearPlane farPlane:(float)farPlane;
+ (Matrix*) worldAt:(Vector3*)position forward:(Vector3*)forward up:(Vector3*)up;

@property (nonatomic, readonly) MatrixStruct *data;
@property (nonatomic, assign) Vector3 *left;
@property (nonatomic, assign) Vector3 *right;
@property (nonatomic, assign) Vector3 *up;
@property (nonatomic, assign) Vector3 *down;
@property (nonatomic, assign) Vector3 *forward;
@property (nonatomic, assign) Vector3 *backward;
@property (nonatomic, assign) Vector3 *translation;

- (Matrix*) transpose;
- (Matrix*) inverse;
- (Matrix*) multiplyWith:(Matrix*)value;

// Constants
+ (id) zero;
+ (id) identity;

@end
