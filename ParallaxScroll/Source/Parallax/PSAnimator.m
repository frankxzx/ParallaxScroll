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

@property(nonatomic, strong) NSArray <PSAnimationView *>* animationViews;

@end

@implementation PSAnimator

+(instancetype)animateWithDirection:(PSScrollDirection)direction
                     animationViews:(NSArray <PSAnimationView *>*)animationViews {
    return [[self.class alloc]initWithDirection:direction animationViews:animationViews];
}

-(instancetype)initWithDirection:(PSScrollDirection)direction
                    animationViews:(NSArray <PSAnimationView *>*)animationViews {
    if (self = [super init]) {
        self.direction = direction;
        self.animationViews = animationViews;
    }
    return self;
}

-(void)applyAnimationWithProgress:(PSScrollProgessValue)value {

    CGFloat progress = 0.f;
    BOOL isResume;
    PSScrollProgressState progressState = value.direction;
    switch (progressState) {
        case PSScrollProgressStateAbove:
        case PSScrollProgressStateLeft:
            progress = 1+value.value;
            isResume = NO;
            break;
            
        case PSScrollProgressStateBelow:
        case PSScrollProgressStateRight:
            progress = value.value;
            isResume = YES;
            break;
            
        case PSScrollProgressStateCenter:
            progress = 1.0;
            isResume = NO;
            break;
    }
    
    NSLog(@"progressValue: %f", progress);

    //执行最小单位的动画组
    [self.animationViews enumerateObjectsUsingBlock:^(PSAnimationView * _Nonnull animationView, NSUInteger idx, BOOL * _Nonnull stop) {
        [animationView setProgress:progress isResume:isResume];
    }];
}

@end
