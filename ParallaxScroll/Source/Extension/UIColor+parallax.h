//
//  UIColor+parallax.h
//  ParallaxScroll
//
//  Created by Xuzixiang on 2018/5/17.
//  Copyright © 2018年 frankxzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (parallax)

- (UIColor *)ps_transitionToColor:(UIColor *)toColor progress:(CGFloat)progress;

+ (UIColor *)ps_colorFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor progress:(CGFloat)progress;

@end
