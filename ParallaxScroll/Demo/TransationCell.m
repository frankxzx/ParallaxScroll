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
    PSAnimator *a = [[PSAnimator alloc]init];
    PSAnimationView *v = [[PSAnimationView alloc]init];
    v.fromAnimationProperty = [self setupAnimationProperty1];
    v.toAnimationProperty = [self setupAnimationProperty2];;
    v.view = self.view1;
    
    PSAnimationView *v2 = [[PSAnimationView alloc]init];
    v2.fromAnimationProperty = [self setupAnimationProperty3];
    v2.toAnimationProperty = [self setupAnimationProperty4];;
    v2.view = self.view2;
    
    a.animationViews = @[v, v2];
    
    return a;
}

-(PSAnimationProperty *)setupAnimationProperty1 {
    PSAnimationProperty *f = [[PSAnimationProperty alloc]init];
    f.animationPropertyKey = @"backgroundColor";
    f.propertyValue = [[PSAnimationValue alloc]initWithUIColor:[UIColor yellowColor]];
    return f;
}

-(PSAnimationProperty *)setupAnimationProperty2 {
    PSAnimationProperty *f = [[PSAnimationProperty alloc]init];
    f.animationPropertyKey = @"backgroundColor";
    f.propertyValue = [[PSAnimationValue alloc]initWithUIColor:[UIColor whiteColor]];
    return f;
}

-(PSAnimationProperty *)setupAnimationProperty3 {
    PSAnimationProperty *t = [[PSAnimationProperty alloc]init];
    t.animationPropertyKey = @"cornerRadius";
    t.propertyValue = [[PSAnimationValue alloc]initWithCGFloat:0];
    return t;
}

-(PSAnimationProperty *)setupAnimationProperty4 {
    PSAnimationProperty *f = [[PSAnimationProperty alloc]init];
    f.animationPropertyKey = @"cornerRadius";
    f.propertyValue = [[PSAnimationValue alloc]initWithCGFloat:50];
    return f;
}


-(UIView *)view1 {
    if (!_view1) {
        _view1 = [[UIView alloc]initWithFrame:CGRectMake(30, 30, 100, 100)];
        _view1.backgroundColor = [UIColor yellowColor];
    }
    return _view1;
}

-(UIView *)view2 {
    if (!_view2) {
        _view2 = [[UIView alloc]initWithFrame:CGRectMake(30, 140, 100, 100)];
        _view2.clipsToBounds = YES;
        _view2.backgroundColor = [UIColor brownColor];
    }
    return _view2;
}

@end
