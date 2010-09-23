//
//  Matrix.m
//  XNI
//
//  Created by Matej Jan on 9.9.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "Matrix.h"

#import "Retronator.Xni.Framework.h"

@implementation Matrix

- (id) initWithStruct: (MatrixStruct*)matrixStruct {
    if (self = [super init]) {
        data = *matrixStruct;
    }
    return self;
}

- (id) initWithMatrix: (Matrix*)matrix {
    return [self initWithStruct:matrix.data];  
}

+ (Matrix*) matrixWithStruct: (MatrixStruct*)matrixStruct {
    return [[[Matrix alloc] initWithStruct:matrixStruct] autorelease];
}

+ (Matrix*) matrixWithMatrix: (Matrix*)matrix {
    return [[[Matrix alloc] initWithMatrix:matrix] autorelease];
}

+ (Matrix*) createTranslation:(Vector3*)position {
    Matrix *matrix = [Matrix identity];
    matrix.translation = position;
    return matrix;
}

+ (Matrix*) createScaleUniform:(float)scale {
    Matrix *matrix = [Matrix identity];
    matrix.data->m11 = scale;
    matrix.data->m22 = scale;
    matrix.data->m33 = scale;
    return matrix;    
}

+ (Matrix*) createScale:(Vector3 *)scales {
    Matrix *matrix = [Matrix identity];
    matrix.data->m11 = scales.x;
    matrix.data->m22 = scales.y;
    matrix.data->m33 = scales.z;
    return matrix;    
}

+ (Matrix*) createFromAxis:(Vector3 *)axis angle:(float)angle {
    Vector3 *normalizedAxis = [[Vector3 vectorWithVector:axis] normalize];
    
    float c = cosf(angle);
    float s = sinf(angle);
    float x = normalizedAxis.x;
    float y = normalizedAxis.y;
    float z = normalizedAxis.z;
    
    Matrix *matrix = [Matrix zero];
    matrix.data->m11 = (x * x) * (1 - c) + c;
    matrix.data->m12 = (y * x) * (1 - c) + (z * s);
    matrix.data->m13 = (x * z) * (1 - c) - (y * s);
    matrix.data->m21 = (x * y) * (1 - c) - (z * s);
    matrix.data->m22 = (y * y) * (1 - c) + c;
    matrix.data->m23 = (y * z) * (1 - c) + (x * s);
    matrix.data->m31 = (x * z) * (1 - c) + (y * s);
    matrix.data->m32 = (y * z) * (1 - c) - (x * s);
    matrix.data->m33 = (z * z) * (1 - c) + c;   
    matrix.data->m44 = 1;
    return matrix;
}

+ (Matrix*) createFromQuaternion:(Quaternion *)quaternion {
    Quaternion *normalizedQuaternion = [[Quaternion quaternionWithQuaternion:quaternion] normalize];
    
    float x = normalizedQuaternion.x;
    float y = normalizedQuaternion.y;
    float z = normalizedQuaternion.z;
    float w = normalizedQuaternion.w;
    
    Matrix *matrix = [Matrix zero];
    matrix.data->m11 = 1 - 2 * ( y * y + z * z );
    matrix.data->m12 = 2 * ( x * y - z * w );
    matrix.data->m13 = 2 * ( x * z + y * w );
    matrix.data->m21 = 2 * ( x * y + z * w );
    matrix.data->m22 = 1 - 2 * ( x * x + z * z );
    matrix.data->m23 = 2 * ( y * z - x * w );
    matrix.data->m31 = 2 * ( x * z - y * w );
    matrix.data->m32 = 2 * ( y * z + x * w );
    matrix.data->m33 = 1 - 2 * ( x * x + y * y );
    matrix.data->m44 = 1;
    return matrix;
}

+ (Matrix*) createLookAtFrom:(Vector3*)position to:(Vector3*)target up:(Vector3*)up {
    Vector3 *z = [[Vector3 subtract:position by:target] normalize];
    Vector3 *x = [[Vector3 crossProductOf:up with:z] normalize];
    Vector3 *y = [Vector3 crossProductOf:z with:x];
    Matrix *matrix = [Matrix zero];    
    // First column
    matrix.data->m11 = x.x;
    matrix.data->m21 = x.y;
    matrix.data->m31 = x.z;
    // Second column
    matrix.data->m12 = y.x;
    matrix.data->m22 = y.y;
    matrix.data->m32 = y.z;
    // Third column
    matrix.data->m13 = z.x;
    matrix.data->m23 = z.y;
    matrix.data->m33 = z.z;
    // Translation
    matrix.data->m41 = -[Vector3 dotProductOf:x with:position];
    matrix.data->m42 = -[Vector3 dotProductOf:y with:position];
    matrix.data->m43 = -[Vector3 dotProductOf:z with:position];
    matrix.data->m44 = 1;
    return matrix;
}

+ (Matrix*) createPerspectiveWithWidth:(float)width height:(float)height nearPlane:(float)nearPlane farPlane:(float)farPlane {
    Matrix *matrix = [Matrix zero];
    matrix.data->m11 = (2 * nearPlane) / width;
    matrix.data->m22 = (2 * nearPlane) / height;
    matrix.data->m33 = farPlane / (nearPlane - farPlane);
    matrix.data->m34 = -1;
    matrix.data->m43 = nearPlane * farPlane / (nearPlane - farPlane);
    return matrix;    
}

+ (Matrix*) createPerspectiveFieldOfView:(float)fieldOfView aspectRatio:(float)aspectRatio nearPlane:(float)nearPlane farPlane:(float)farPlane{
    float width = 2 * nearPlane * tanf(fieldOfView * 0.5f);
    float height = width / aspectRatio;
    return [Matrix createPerspectiveWithWidth:width height:height nearPlane:nearPlane farPlane:farPlane];
}

+ (Matrix*) createWorldAtPosition:(Vector3 *)position forward:(Vector3 *)forward up:(Vector3 *)up {
    Vector3 *z = [[Vector3 negate:forward] normalize];
    Vector3 *x = [[Vector3 crossProductOf:up with:z] normalize];
    Vector3 *y = [Vector3 crossProductOf:z with:x];
    Matrix *matrix = [Matrix identity];
    matrix.right = x;
    matrix.up = y;
    matrix.backward = z;
    matrix.translation = position;
    return matrix;
}

// PROPERTIES

- (MatrixStruct*) data {return &data;}

// Main rows

- (Vector3 *) right {return [Vector3 vectorWithX:data.m11 y:data.m12 z:data.m13];}
- (void) setRight:(Vector3 *)value {data.m11 = value.x; data.m12 = value.y; data.m13 = value.z;}

- (Vector3 *) up {return [Vector3 vectorWithX:data.m21 y:data.m22 z:data.m23];}
- (void) setUp:(Vector3 *)value {data.m21 = value.x; data.m22 = value.y; data.m23 = value.z;}

- (Vector3 *) backward {return [Vector3 vectorWithX:data.m31 y:data.m32 z:data.m33];}
- (void) setBackward:(Vector3 *)value {data.m31 = value.x; data.m32 = value.y; data.m33 = value.z;}

- (Vector3 *) translation {return [Vector3 vectorWithX:data.m41 y:data.m42 z:data.m43];}
- (void) setTranslation:(Vector3 *)value {data.m41 = value.x; data.m42 = value.y; data.m43 = value.z;}

// Negative rows

- (Vector3 *) left {return [Vector3 vectorWithX:-data.m11 y:-data.m12 z:-data.m13];}
- (void) setLeft:(Vector3 *)value {data.m11 = -value.x; data.m12 = -value.y; data.m13 = -value.z;}

- (Vector3 *) down {return [Vector3 vectorWithX:-data.m21 y:-data.m22 z:-data.m23];}
- (void) setDown:(Vector3 *)value {data.m21 = -value.x; data.m22 = -value.y; data.m23 = -value.z;}

- (Vector3 *) forward {return [Vector3 vectorWithX:-data.m31 y:-data.m32 z:-data.m33];}
- (void) setForward:(Vector3 *)value {data.m31 = -value.x; data.m32 = -value.y; data.m33 = -value.z;}

// METHODS

+ (Matrix*) negate:(Matrix*)value {
	Matrix *result = [Matrix matrixWithMatrix:value];
	[result negate];
	return result;
}

+ (Matrix*) transpose:(Matrix*)value {
	MatrixStruct resultData = *value.data;
	MatrixTranspose(&resultData);
    return [Matrix matrixWithStruct:&resultData];
}

+ (Matrix*) invert:(Matrix*)value {
	MatrixStruct resultData = *value.data;
	MatrixInvert(&resultData);
    return [Matrix matrixWithStruct:&resultData];
}

+ (Matrix*) add:(Matrix*)value1 to:(Matrix*)value2 {
    MatrixStruct resultData;
    MatrixAdd(value1.data, value2.data, &resultData);
    return [Matrix matrixWithStruct:&resultData];
}

+ (Matrix*) subtract:(Matrix*)value1 by:(Matrix*)value2{
    MatrixStruct resultData;
    MatrixSubtract(value1.data, value2.data, &resultData);
    return [Matrix matrixWithStruct:&resultData];
}

+ (Matrix*) multiply:(Matrix*)value1 byScalar:(float)scaleFactor{
    MatrixStruct resultData;
    MatrixMultiplyScalar(value1.data, scaleFactor, &resultData);
    return [Matrix matrixWithStruct:&resultData];
}

+ (Matrix*) multiply:(Matrix*)value1 by:(Matrix*)value2{
    MatrixStruct resultData;
    MatrixMultiply(value1.data, value2.data, &resultData);
    return [Matrix matrixWithStruct:&resultData];
}

+ (Matrix*) divide:(Matrix*)value1 byScalar:(float)divider{
    MatrixStruct resultData;
    MatrixDivideScalar(value1.data, divider, &resultData);
    return [Matrix matrixWithStruct:&resultData];
}

+ (Matrix*) divide:(Matrix*)value1 by:(Matrix*)value2{
    MatrixStruct resultData;
    MatrixDivide(value1.data, value2.data, &resultData);
    return [Matrix matrixWithStruct:&resultData];
}

- (float) determinant {
	return MatrixDeterminant(self.data);
}

- (Matrix*) negate {
	MatrixNegate(self.data);
    return self;
}

- (Matrix*) add:(Matrix*)value {
	MatrixAdd(self.data, value.data, self.data);
    return self;
}

- (Matrix*) subtract:(Matrix*)value {
	MatrixSubtract(self.data, value.data, self.data);
    return self;
}

- (Matrix*) multiplyByScalar:(float)scaleFactor {
	MatrixMultiplyScalar(self.data, scaleFactor, self.data);
    return self;
}

- (Matrix*) multiplyBy:(Matrix*)value {
	MatrixMultiply(self.data, value.data, self.data);
    return self;
}

- (Matrix*) divideByScalar:(float)divider {
	MatrixDivideScalar(self.data, divider, self.data);
    return self;
}

- (Matrix*) divideBy:(Matrix*)value {
	MatrixDivide(self.data, value.data, self.data);
    return self;
}

// CONSTANTS

+ (id) zero {
	MatrixStruct MatrixStruct = MatrixMake(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	return [Matrix matrixWithStruct:&MatrixStruct];
}
+ (id) identity {
	MatrixStruct MatrixStruct = MatrixMake(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1);
	return [Matrix matrixWithStruct:&MatrixStruct];
}

@end
