//
//  PSAnimationState.h
//  ParallaxScroll
//
//  Created by Xuzixiang on 2018/5/15.
//  Copyright © 2018年 frankxzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSAnimationProperty.h"

@interface PSAnimationState : NSObject

@property(nonatomic, strong) NSDictionary <NSString *, PSAnimationProperty *>*animationProperty;

-(void)adjustProgressForView:(UIView *)view
                     toState:(PSAnimationState *)state
                    progress:(CGFloat)progress;

@end
