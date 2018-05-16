//
//  PSAnimator.m
//  ParallaxScroll
//
//  Created by Xuzixiang on 2018/5/14.
//  Copyright © 2018年 frankxzx. All rights reserved.
//

#import "PSAnimator.h"
#import "PSAnimationView.h"

@interface PSAnimator()

@end

@implementation PSAnimator

+(instancetype)animateWithDirection:(PSScrollDirection)direction {
    return [[self.class alloc]initWithDirection:direction];
}

-(instancetype)initWithDirection:(PSScrollDirection)direction {
    if (self = [super init]) {
        self.direction = direction;
    }
    return self;
}

-(void)applyAnimationWithProgress:(PSScrollProgessValue)value {
    //执行最小单位的动画组
    [self.animationViews enumerateObjectsUsingBlock:^(PSAnimationView * _Nonnull animationView, NSUInteger idx, BOOL * _Nonnull stop) {
        [animationView setProgress:value];
    }];
}

@end
