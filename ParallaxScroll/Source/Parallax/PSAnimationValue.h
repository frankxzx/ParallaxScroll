//
//  PSAnimationValue.h
//  ParallaxScroll
//
//  Created by Xuzixiang on 2018/5/15.
//  Copyright © 2018年 frankxzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSAnimationValue : NSObject

- (PSAnimationValue *)initWithCGFloat:(CGFloat)value;
- (PSAnimationValue *)initWithCGPoint:(CGPoint)value;
- (PSAnimationValue *)initWithCGAffineTransform:(CGAffineTransform)value;
- (PSAnimationValue *)initWithCATransform3D:(CATransform3D)value;
- (PSAnimationValue *)initWithUIColor:(UIColor *)value;
- (PSAnimationValue *)initWithCGRect:(CGRect)value;
- (PSAnimationValue *)initWithCGSize:(CGSize)value;

@property (readonly) CGFloat cgFloatValue;
@property (readonly) CGPoint cgPointValue;
@property (readonly) CGSize cgSizeValue;
@property (readonly) CGAffineTransform cgAffineTransformValue;
@property (readonly) CATransform3D caTransform3DValue;
@property (readonly) UIColor *colorValue;
- (CGRect) cgRectValue;

-(PSAnimationValue *)progressToValue:(PSAnimationValue *)value atProgress:(CGFloat)progress;

@end
