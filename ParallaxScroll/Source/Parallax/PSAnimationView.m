//
//  PSAnimationView.m
//  ParallaxScroll
//
//  Created by Xuzixiang on 2018/5/16.
//  Copyright © 2018年 frankxzx. All rights reserved.
//

#import "PSAnimationView.h"
#import "PSAnimationValue.h"

@implementation PSAnimationView

-(void)setProgress:(PSScrollProgessValue)progress {
    
    PSAnimationValue *formValue = self.fromAnimationProperty.propertyValue;
    PSAnimationValue *toValue = self.toAnimationProperty.propertyValue;
    PSAnimationValue *diffValue = [formValue progressToValue:toValue atProgress:progress.value];
    if (diffValue) {
        NSString *keyPath = self.fromAnimationProperty.animationPropertyKey;
        UIView *view = self.view;
        if ([keyPath isEqualToString:@"transform3D"]) {
            [view.layer setValue:diffValue.boxValue forKey:keyPath];
        } else if ([view respondsToSelector:NSSelectorFromString(keyPath)]) {
            [view setValue:diffValue.boxValue forKey:keyPath];
        } else if ([view.layer respondsToSelector:NSSelectorFromString(keyPath)]) {
            [view.layer setValue:diffValue.boxValue forKey:keyPath];
        }
    }
}

@end
