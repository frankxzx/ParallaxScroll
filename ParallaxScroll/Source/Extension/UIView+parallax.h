//
//  UIView+parallax.h
//  ParallaxScroll
//
//  Created by Xuzixiang on 2018/5/14.
//  Copyright © 2018年 frankxzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSAnimator.h"

@interface UIView (parallax)

@property(nonatomic, strong) PSAnimator *cachedProgressAnimator;

@end
