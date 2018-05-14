//
//  UIView+parallax.m
//  ParallaxScroll
//
//  Created by Xuzixiang on 2018/5/14.
//  Copyright © 2018年 frankxzx. All rights reserved.
//

#import "UIView+parallax.h"
#import <objc/runtime.h>

static char kAssociatedObjectKey_Parallax;

@implementation UIView (parallax)

- (void)setCachedProgressAnimator:(PSAnimator *)cachedProgressAnimator {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_Parallax, cachedProgressAnimator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (PSAnimator *)cachedProgressAnimator {
    return (PSAnimator *)objc_getAssociatedObject(self, &kAssociatedObjectKey_Parallax);
}

@end
