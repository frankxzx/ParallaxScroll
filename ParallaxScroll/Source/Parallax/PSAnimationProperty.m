//
//  PSAnimationProperty.m
//  ParallaxScroll
//
//  Created by Xuzixiang on 2018/5/14.
//  Copyright © 2018年 frankxzx. All rights reserved.
//

#import "PSAnimationProperty.h"

@implementation PSAnimationProperty

-(void)adjustProgressForView:(UIView *)view
                     toValue:(PSAnimationValue *)toValue
                    progress:(CGFloat)progress {
    if (!_animationPropertyKey || !toValue) { return; }
 
    PSAnimationValue *formValue = self.propertyValue;
    PSAnimationValue *diffValue = [formValue progressToValue:toValue atProgress:progress];
    if (diffValue) {
        
    }
}

@end
