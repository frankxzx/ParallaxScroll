//
//  TransationCell.m
//  ParallaxScroll
//
//  Created by Xuzixiang on 2018/5/16.
//  Copyright © 2018年 frankxzx. All rights reserved.
//

#import "TransationCell.h"
#import "PSAnimationView.h"

@interface TransationCell()

@property(nonatomic, strong) UIView *view1;
@property(nonatomic, strong) UIView *view2;

@end

@implementation TransationCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.view1];
        [self addSubview:self.view2];
    }
    return self;
}

-(PSAnimator *)configureAnimator {
    
    PSAnimationProperty *p1 = [PSAnimationProperty propertyWithAlph:0];
    PSAnimationProperty *p2 = [PSAnimationProperty propertyWithAlph:1];
    
    PSAnimationProperty *p3 = [PSAnimationProperty propertyWithColor:[UIColor yellowColor]];
    PSAnimationProperty *p4 = [PSAnimationProperty propertyWithColor:[UIColor purpleColor]];
    
    PSAnimationProperty *p5 = [PSAnimationProperty propertyWithCornerRadius:0];
    PSAnimationProperty *p6 = [PSAnimationProperty propertyWithCornerRadius:50];
    
    PSAnimationProperty *p7 = [PSAnimationProperty propertyWithAlph:0];
    PSAnimationProperty *p8 = [PSAnimationProperty propertyWithAlph:1];
    
    return [PSAnimator animateWithDirection:PSScrollDirectionVertical
                             animationViews:@[[PSAnimationView animvationViewWithBeginProperty:p1
                                                                                   endProperty:p2
                                                                                        inView:self.view1],
                                              [PSAnimationView animvationViewWithBeginProperty:p3
                                                                                   endProperty:p4
                                                                                        inView:self.view1],
                                              [PSAnimationView animvationViewWithBeginProperty:p5
                                                                                   endProperty:p6
                                                                                        inView:self.view2],
                                              [PSAnimationView animvationViewWithBeginProperty:p7
                                                                                   endProperty:p8
                                                                                        inView:self.view2]
    ]];
    
//    return [PSAnimator animateWithDirection:PSScrollDirectionVertical
//                             animationViews:@[[PSAnimationView animvationViewWithView:self.view1 endProperty:p2],
//                                              [PSAnimationView animvationViewWithView:self.view1 endProperty:p3],
//                                              [PSAnimationView animvationViewWithView:self.view2 endProperty:p2],
//                                              [PSAnimationView animvationViewWithView:self.view2 endProperty:p6]
//                                              ]];
}

-(UIView *)view1 {
    if (!_view1) {
        CGFloat w = self.frame.size.width;
        CGFloat h = self.frame.size.height;
        _view1 = [[UIView alloc]initWithFrame:CGRectMake((w-100)/2, (h-100)/2, 100, 100)];
        _view1.alpha = 0;
        _view1.backgroundColor = [UIColor yellowColor];
    }
    return _view1;
}

-(UIView *)view2 {
    if (!_view2) {
        _view2 = [[UIView alloc]initWithFrame:CGRectMake(30, 140, 100, 100)];
        _view2.clipsToBounds = YES;
        _view2.alpha = 0;
        _view2.backgroundColor = [UIColor brownColor];
    }
    return _view2;
}

@end
