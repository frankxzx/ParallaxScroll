//
//  PSAnimationView.h
//  ParallaxScroll
//
//  Created by Xuzixiang on 2018/5/16.
//  Copyright © 2018年 frankxzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSAnimationProperty.h"
#import "PSAnimator.h"

@interface PSAnimationView : NSObject

@property(nonatomic, weak) UIView *view;
@property(nonatomic, strong) PSAnimationProperty *fromAnimationProperty;
@property(nonatomic, strong) PSAnimationProperty *toAnimationProperty;

-(void)setProgress:(PSScrollProgessValue)progress;

@end
