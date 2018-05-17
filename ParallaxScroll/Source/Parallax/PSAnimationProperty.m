//
//  PSAnimationProperty.m
//  ParallaxScroll
//
//  Created by Xuzixiang on 2018/5/14.
//  Copyright © 2018年 frankxzx. All rights reserved.
//

#import "PSAnimationProperty.h"

@implementation PSAnimationProperty

+ (PSAnimationProperty *)propertyWithKey:(NSString *)key value:(id)value {
    PSAnimationProperty *f = [[PSAnimationProperty alloc]init];
    f.animationPropertyKey = key;
    f.propertyValue = [[PSAnimationValue alloc]initWithValue:value];
    return f;
}

+ (PSAnimationProperty *)propertyWithColor:(UIColor *)color {
    PSAnimationProperty *f = [[PSAnimationProperty alloc]init];
    f.animationPropertyKey = @"backgroundColor";
    f.propertyValue = [[PSAnimationValue alloc]initWithUIColor:color];
    return f;
}

+ (PSAnimationProperty *)propertyWithCornerRadius:(CGFloat)cornerRadius {
    PSAnimationProperty *f = [[PSAnimationProperty alloc]init];
    f.animationPropertyKey = @"cornerRadius";
    f.propertyValue = [[PSAnimationValue alloc]initWithCGFloat:cornerRadius];
    return f;
}

+ (PSAnimationProperty *)propertyWithTransform3D:(CATransform3D)transform3D {
    PSAnimationProperty *f = [[PSAnimationProperty alloc]init];
    f.animationPropertyKey = @"transform3D";
    f.propertyValue = [[PSAnimationValue alloc]initWithCATransform3D:transform3D];
    return f;
}

+ (PSAnimationProperty *)propertyWithAffineTransform:(CGAffineTransform)affineTransform {
    PSAnimationProperty *f = [[PSAnimationProperty alloc]init];
    f.animationPropertyKey = @"transform";
    f.propertyValue = [[PSAnimationValue alloc]initWithCGAffineTransform:affineTransform];
    return f;
}

+ (PSAnimationProperty *)propertyWithAlph:(CGFloat)alpha {
    PSAnimationProperty *f = [[PSAnimationProperty alloc]init];
    f.animationPropertyKey = @"alpha";
    f.propertyValue = [[PSAnimationValue alloc]initWithCGFloat:alpha];
    return f;
}

@end
