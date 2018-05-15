//
//  PSAnimationState.m
//  ParallaxScroll
//
//  Created by Xuzixiang on 2018/5/15.
//  Copyright © 2018年 frankxzx. All rights reserved.
//

#import "PSAnimationState.h"

@implementation PSAnimationState

-(void)adjustProgressForView:(UIView *)view
                     toState:(PSAnimationState *)state
                    progress:(CGFloat)progress {
    [self.animationProperty enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, PSAnimationProperty * _Nonnull property, BOOL * _Nonnull stop) {
        
    }];
}

@end
