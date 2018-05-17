//
//  UIColor+parallax.m
//  ParallaxScroll
//
//  Created by Xuzixiang on 2018/5/17.
//  Copyright © 2018年 frankxzx. All rights reserved.
//

#import "UIColor+parallax.h"

@implementation UIColor (parallax)

- (UIColor *)ps_transitionToColor:(UIColor *)toColor progress:(CGFloat)progress {
    return [UIColor ps_colorFromColor:self toColor:toColor progress:progress];
}

+ (UIColor *)ps_colorFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor progress:(CGFloat)progress {
    progress = MIN(progress, 1.0f);
    CGFloat fromRed = fromColor.ps_red;
    CGFloat fromGreen = fromColor.ps_green;
    CGFloat fromBlue = fromColor.ps_blue;
    CGFloat fromAlpha = fromColor.ps_alpha;
    
    CGFloat toRed = toColor.ps_red;
    CGFloat toGreen = toColor.ps_green;
    CGFloat toBlue = toColor.ps_blue;
    CGFloat toAlpha = toColor.ps_alpha;
    
    CGFloat finalRed = fromRed + (toRed - fromRed) * progress;
    CGFloat finalGreen = fromGreen + (toGreen - fromGreen) * progress;
    CGFloat finalBlue = fromBlue + (toBlue - fromBlue) * progress;
    CGFloat finalAlpha = fromAlpha + (toAlpha - fromAlpha) * progress;
    
    return [UIColor colorWithRed:finalRed green:finalGreen blue:finalBlue alpha:finalAlpha];
}

- (CGFloat)ps_red {
    CGFloat r;
    if ([self getRed:&r green:0 blue:0 alpha:0]) {
        return r;
    }
    return 0;
}

- (CGFloat)ps_green {
    CGFloat g;
    if ([self getRed:0 green:&g blue:0 alpha:0]) {
        return g;
    }
    return 0;
}

- (CGFloat)ps_blue {
    CGFloat b;
    if ([self getRed:0 green:0 blue:&b alpha:0]) {
        return b;
    }
    return 0;
}

- (CGFloat)ps_alpha {
    CGFloat a;
    if ([self getRed:0 green:0 blue:0 alpha:&a]) {
        return a;
    }
    return 0;
}

@end
