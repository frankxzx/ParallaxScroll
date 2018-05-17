//
//  PSAnimationValue.m
//  ParallaxScroll
//
//  Created by Xuzixiang on 2018/5/15.
//  Copyright © 2018年 frankxzx. All rights reserved.
//

#import "PSAnimationValue.h"
#import "UIColor+parallax.h"

UIColor * UIColorProgress(UIColor * fromValue, UIColor * toValue, CGFloat progress) {
    const CGFloat *componentColors = CGColorGetComponents(fromValue.CGColor);
    const CGFloat *toComponentColors = CGColorGetComponents(toValue.CGColor);
    CGFloat scale = 1 - progress;
    UIColor *newColor = [[UIColor alloc] initWithRed:(scale * componentColors[0] + toComponentColors[0])
                                               green:(scale * componentColors[1] + toComponentColors[1])
                                                blue:(scale * componentColors[2] + toComponentColors[2])
                                               alpha:componentColors[3]];
    return newColor;
}

NS_INLINE CGFloat CGFloatProgress(CGFloat fromValue, CGFloat toValue, CGFloat progress) {
    return fromValue + ((toValue - fromValue) * progress);
}

NS_INLINE CGPoint CGPointProgress(CGPoint fromValue, CGPoint toValue, CGFloat progress) {
    CGFloat xDiff = CGFloatProgress(fromValue.x, toValue.x, progress);
    CGFloat yDiff = CGFloatProgress(fromValue.y, toValue.y, progress);
    return CGPointMake(xDiff, yDiff);
}

NS_INLINE CGSize CGSizeProgress(CGSize fromValue, CGSize toValue, CGFloat progress) {
    CGFloat widthDiff = CGFloatProgress(fromValue.width, toValue.width, progress);
    CGFloat hightDiff = CGFloatProgress(fromValue.height, toValue.height, progress);
    return CGSizeMake(widthDiff, hightDiff);
}

NS_INLINE CGRect CGRectProgress(CGRect fromValue, CGRect toValue, CGFloat progress) {
    CGPoint point = CGPointProgress(fromValue.origin, toValue.origin, progress);
    CGSize size = CGSizeProgress(fromValue.size, toValue.size, progress);
    return CGRectMake(point.x, point.y, size.width, size.height);
}

NS_INLINE CGAffineTransform CGAffineTransformProgress(CGAffineTransform fromValue, CGAffineTransform toValue, CGFloat progress) {
    CGFloat aDiff  = CGFloatProgress(fromValue.a, toValue.a, progress);
    CGFloat bDiff  = CGFloatProgress(fromValue.b, toValue.b, progress);
    CGFloat cDiff  = CGFloatProgress(fromValue.c, toValue.c, progress);
    CGFloat dDiff  = CGFloatProgress(fromValue.d, toValue.d, progress);
    CGFloat txDiff = CGFloatProgress(fromValue.tx,toValue.tx, progress);
    CGFloat tyDiff = CGFloatProgress(fromValue.ty,toValue.ty, progress);
    return CGAffineTransformMake(aDiff, bDiff, cDiff, dDiff, txDiff, tyDiff);
}

NS_INLINE CATransform3D CATransform3DProgress(CATransform3D fromValue, CATransform3D toValue, CGFloat progress) {
    CGFloat m11Diff = CGFloatProgress(fromValue.m11, toValue.m11, progress);
    CGFloat m12Diff = CGFloatProgress(fromValue.m12, toValue.m12, progress);
    CGFloat m13Diff = CGFloatProgress(fromValue.m13, toValue.m13, progress);
    CGFloat m14Diff = CGFloatProgress(fromValue.m14, toValue.m14, progress);
    
    CGFloat m21Diff = CGFloatProgress(fromValue.m21, toValue.m21, progress);
    CGFloat m22Diff = CGFloatProgress(fromValue.m22, toValue.m22, progress);
    CGFloat m23Diff = CGFloatProgress(fromValue.m23, toValue.m23, progress);
    CGFloat m24Diff = CGFloatProgress(fromValue.m24, toValue.m24, progress);
    
    CGFloat m31Diff = CGFloatProgress(fromValue.m31, toValue.m31, progress);
    CGFloat m32Diff = CGFloatProgress(fromValue.m32, toValue.m32, progress);
    CGFloat m33Diff = CGFloatProgress(fromValue.m33, toValue.m33, progress);
    CGFloat m34Diff = CGFloatProgress(fromValue.m34, toValue.m34, progress);
    
    CGFloat m41Diff = CGFloatProgress(fromValue.m41, toValue.m41, progress);
    CGFloat m42Diff = CGFloatProgress(fromValue.m42, toValue.m42, progress);
    CGFloat m43Diff = CGFloatProgress(fromValue.m43, toValue.m43, progress);
    CGFloat m44Diff = CGFloatProgress(fromValue.m44, toValue.m44, progress);
    CATransform3D new3d = {m11Diff, m12Diff, m13Diff, m14Diff,
                           m21Diff, m22Diff, m23Diff, m24Diff,
                           m31Diff, m32Diff, m33Diff, m34Diff,
                           m41Diff, m42Diff, m43Diff, m44Diff};
    
    return new3d;
}

@interface NSValue (UnBox)

-(BOOL)isCATransform3DType;

-(BOOL)isCGRectType;

-(BOOL)isCGPointType;

-(BOOL)isCGSizeType;

-(BOOL)isCGAffineTransformType;

-(BOOL)isCGFloatType;

@end

@implementation NSValue (UnBox)

-(BOOL)isCATransform3DType {
    NSString *valueType = [NSString stringWithUTF8String:self.objCType];
    return [valueType hasPrefix:@"{CATransform3D"];
}

-(BOOL)isCGRectType {
    NSString *valueType = [NSString stringWithUTF8String:self.objCType];
    return [valueType hasPrefix:@"{CGRect"];
}

-(BOOL)isCGPointType {
    NSString *valueType = [NSString stringWithUTF8String:self.objCType];
    return [valueType hasPrefix:@"{CGPoint"];
}

-(BOOL)isCGSizeType {
    NSString *valueType = [NSString stringWithUTF8String:self.objCType];
    return [valueType hasPrefix:@"{CGSize"];
}

-(BOOL)isCGFloatType {
    NSString *valueType = [NSString stringWithUTF8String:self.objCType];
    
#if (CGFLOAT_IS_DOUBLE == 1)
    return [valueType isEqualToString:@"d"];
#else
    return [valueType isEqualToString:@"f"];
#endif
    

}

-(BOOL)isCGAffineTransformType {
    NSString *valueType = [NSString stringWithUTF8String:self.objCType];
    return [valueType hasPrefix:@"{CGAffineTransform"];
}

@end

@interface NSNumber (CGFloat)

- (CGFloat)CGFloatValue;

- (id)initWithCGFloat:(CGFloat)value;

+ (NSNumber *)numberWithCGFloat:(CGFloat)value;

@end

@implementation NSNumber (CGFloat)

- (CGFloat)CGFloatValue
{
#if (CGFLOAT_IS_DOUBLE == 1)
    CGFloat result = [self doubleValue];
#else
    CGFloat result = [self floatValue];
#endif
    return result;
}

- (id)initWithCGFloat:(CGFloat)value
{
#if (CGFLOAT_IS_DOUBLE == 1)
    self = [self initWithDouble:value];
#else
    self = [self initWithFloat:value];
#endif
    return self;
}

+ (NSNumber *)numberWithCGFloat:(CGFloat)value
{
    NSNumber *result = [[self alloc] initWithCGFloat:value];
    return result;
}

@end

@interface PSAnimationValue()

@property(nonatomic, strong) NSValue *value;
@property(nonatomic, strong) UIColor *color;

@end

@implementation PSAnimationValue

- (PSAnimationValue *)initWithCGFloat:(CGFloat)value {
    PSAnimationValue *v = [[PSAnimationValue alloc]init];
    v.value = [NSNumber numberWithCGFloat:value];
    return v;
}

- (PSAnimationValue *)initWithCGPoint:(CGPoint)value {
    PSAnimationValue *v = [[PSAnimationValue alloc]init];
    v.value = [NSValue valueWithCGPoint:value];
    return v;
}

- (PSAnimationValue *)initWithCGSize:(CGSize)value {
    PSAnimationValue *v = [[PSAnimationValue alloc]init];
    v.value = [NSValue valueWithCGSize:value];
    return v;
}

- (PSAnimationValue *)initWithCGRect:(CGRect)value {
    PSAnimationValue *v = [[PSAnimationValue alloc]init];
    v.value = [NSValue valueWithCGRect:value];
    return v;
}

- (PSAnimationValue *)initWithCGAffineTransform:(CGAffineTransform)value {
    PSAnimationValue *v = [[PSAnimationValue alloc]init];
    v.value = [NSValue valueWithCGAffineTransform:value];
    return v;
}

- (PSAnimationValue *)initWithCATransform3D:(CATransform3D)value {
    PSAnimationValue *v = [[PSAnimationValue alloc]init];
    v.value = [NSValue valueWithCATransform3D:value];
    return v;
}

- (PSAnimationValue *)initWithUIColor:(UIColor *)color {
    PSAnimationValue *v = [[PSAnimationValue alloc]init];
    v.color = color;
    return v;
}

- (PSAnimationValue *)initWithValue:(id)value {
    if ([value isKindOfClass:[UIColor class]]) {
        return [[PSAnimationValue alloc]initWithUIColor:value];
    } else if ([value isKindOfClass:[NSNumber class]]) {
        return [[PSAnimationValue alloc]initWithCGFloat:((NSNumber *)value).CGFloatValue];
    } else if ([value isKindOfClass:[NSValue class]]) {
        PSAnimationValue *v = [[PSAnimationValue alloc]init];
        v.value = value;
        return v;
    } else {
        return nil;
    }
}

- (CGFloat) cgFloatValue { return ((NSNumber *)self.value).CGFloatValue; }
- (CGPoint) cgPointValue { return self.value.CGPointValue; }
- (CGRect) cgRectValue { return self.value.CGRectValue; }
- (CGAffineTransform) cgAffineTransformValue { return self.value.CGAffineTransformValue; }
- (CATransform3D) caTransform3DValue { return self.value.CATransform3DValue; }
- (UIColor *)colorValue { return self.color; }
- (CGSize) cgSizeValue { return self.value.CGSizeValue; }
- (id) boxValue {
    if (self.color) { return self.color; }
    NSValue *v = self.value;
    return v;
}

-(PSAnimationValue *)progressToValue:(PSAnimationValue *)value atProgress:(CGFloat)progress {
    
    if (value.colorValue) {
        UIColor *newColor = [UIColor ps_colorFromColor:self.colorValue toColor:value.colorValue progress:progress];
        return [[PSAnimationValue alloc]initWithUIColor:newColor];
    }
    
    NSValue *v = value.value;
    if (v.isCGPointType) {
        CGPoint newPoint = CGPointProgress(self.cgPointValue, value.cgPointValue, progress);
        return [[PSAnimationValue alloc]initWithCGPoint:newPoint];
    }
    
    if (v.isCGRectType) {
        CGRect newRect = CGRectProgress(self.cgRectValue, value.cgRectValue, progress);
        return [[PSAnimationValue alloc]initWithCGRect:newRect];
    }
    
    if (v.isCGAffineTransformType) {
        CGAffineTransform newTransform = CGAffineTransformProgress(self.cgAffineTransformValue, value.cgAffineTransformValue, progress);
        return [[PSAnimationValue alloc]initWithCGAffineTransform:newTransform];
    }
    
    if (v.isCATransform3DType) {
        CATransform3D new3D = CATransform3DProgress(self.caTransform3DValue, value.caTransform3DValue, progress);
        return [[PSAnimationValue alloc]initWithCATransform3D:new3D];
    }
    
    if (v.isCGSizeType) {
        CGSize newSize = CGSizeProgress(self.cgSizeValue, value.cgSizeValue, progress);
        return [[PSAnimationValue alloc]initWithCGSize:newSize];
    }
    
    if (v.isCGFloatType) {
        CGFloat newFloat = CGFloatProgress(self.cgFloatValue, value.cgFloatValue, progress);
        return [[PSAnimationValue alloc]initWithCGFloat:newFloat];
    }
    
    return nil;
}

@end
