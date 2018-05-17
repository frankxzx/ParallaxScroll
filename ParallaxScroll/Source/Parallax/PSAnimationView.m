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

+(PSAnimationView *)animvationViewWithBeginProperty:(PSAnimationProperty *)begin
                                        endProperty:(PSAnimationProperty *)end
                                             inView:(UIView *)view {
    PSAnimationView *v = [[PSAnimationView alloc]init];
    v.fromAnimationProperty = begin;
    v.toAnimationProperty = end;
    v.view = view;
  
    return v;
}

/*
+(PSAnimationView *)animvationViewWithView:(UIView *)view
                               endProperty:(PSAnimationProperty *)end {
    PSAnimationView *v = [[PSAnimationView alloc]init];
    NSString *keyPath = end.animationPropertyKey;
    id value;
    if ([keyPath isEqualToString:@"transform3D"]) {
        value = [view.layer valueForKey:keyPath];
    } else if ([view respondsToSelector:NSSelectorFromString(keyPath)]) {
        value = [view valueForKey:keyPath];
    } else if ([view.layer respondsToSelector:NSSelectorFromString(keyPath)]) {
        value = [view.layer valueForKey:keyPath];
    }
    v.fromAnimationProperty = [PSAnimationProperty propertyWithKey:keyPath value:value];
    v.toAnimationProperty = end;
    v.view = view;
    
    return v;
}
 */

-(void)setProgress:(CGFloat)progress isResume:(BOOL)isResume {
    
    PSAnimationValue *fromValue = isResume? self.toAnimationProperty.propertyValue : self.fromAnimationProperty.propertyValue;
    PSAnimationValue *toValue = isResume? self.fromAnimationProperty.propertyValue : self.toAnimationProperty.propertyValue;

    PSAnimationValue *diffValue = [fromValue progressToValue:toValue atProgress:progress];
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
