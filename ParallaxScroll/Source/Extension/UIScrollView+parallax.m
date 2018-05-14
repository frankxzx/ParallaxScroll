//
//  UIScrollView+parallax.m
//  ParallaxScroll
//
//  Created by Xuzixiang on 2018/5/14.
//  Copyright © 2018年 frankxzx. All rights reserved.
//

#import "UIScrollView+parallax.h"
#import "UIView+parallax.h"
#import "PSAnimator.h"
#import <objc/runtime.h>

static CGFloat const kCenterThreshHold = 0.0005;

static inline void ps_swizzleSelector(Class _class, SEL _originSelector, SEL _newSelector) {
    Method oriMethod = class_getInstanceMethod(_class, _originSelector);
    Method newMethod = class_getInstanceMethod(_class, _newSelector);
    BOOL isAddedMethod = class_addMethod(_class, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        class_replaceMethod(_class, _newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}

NS_INLINE CGFloat relativeProgressTransform(CGFloat progressValue, CGFloat relativeValue) {
    CGFloat relativePercent = (progressValue - (relativeValue / 2.0)) / relativeValue;
    if (relativePercent == 0.0) { return  0.0; }
    if (relativePercent <= -1.0) { return -1.0; }
    if (relativePercent >=  1.0) { return  1.0; }
    return relativePercent;
}

@implementation UIScrollView (parallax)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ps_swizzleSelector([self class], @selector(setContentOffset:animated:), @selector(ps_setContentOffSet:animated:));
        ps_swizzleSelector([self class], @selector(setContentOffset:), @selector(ps_setContentOffSet:));
        ps_swizzleSelector([self class], @selector(contentOffset), @selector(ps_setContentOffSet:));
    });
}

-(void)ps_setContentOffSet:(CGPoint)offSet animated:(BOOL)animated {
    [self ps_setContentOffSet:offSet animated:animated];
}

-(void)ps_setContentOffSet:(CGPoint)offSet {
    [self ps_setContentOffSet:offSet];
}

-(CGPoint)ps_contentOffSet {
    return [self ps_contentOffSet];
}

-(void)updateView {
    BOOL isListView = [self isKindOfClass:[UICollectionView class]] ||
                      [self isKindOfClass:[UITableView class]];
    if (!isListView) { return; }
    
    NSArray <UIView *>* needUpdateViews;
    if ([self isKindOfClass:[UICollectionView class]]) {
        needUpdateViews = ((UICollectionView *)self).visibleCells;
    }
    else if ([self isKindOfClass:[UITableView class]]) {
        needUpdateViews = ((UITableView *)self).visibleCells;
    }
    else {
        needUpdateViews = self.subviews;
    }
    //执行动画
    [needUpdateViews enumerateObjectsUsingBlock:^(UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([view respondsToSelector:@selector(configureAnimator)]) {
            PSAnimator *animator = view.cachedProgressAnimator;
            if (!animator) {
                animator = [(id<PSAnimatableType>)view configureAnimator];
            }
            
            //转化到 父容器坐标系
            CGPoint center = [self convertPoint:view.center toView:self];
            switch (animator.direction) {
                case PSScrollDirectionVertical:
                    [animator applyAnimationWithProgress:[self verticalProgressAtCenter:center toViewPortHeight:self.bounds.size.height]];
                    break;
                case PSScrollDirectionHorizontal:
                    [animator applyAnimationWithProgress:[self horizontalProgressAtCenter:center toViewPortWidth:self.bounds.size.width]];
                    break;
            }
        }
    }];
}

-(PSScrollProgessValue)verticalProgressAtCenter:(CGPoint)center toViewPortHeight:(CGFloat)height {
    CGFloat relativePercent = relativeProgressTransform(center.y, height);
    if (relativePercent < -kCenterThreshHold)
    {
        return PSScrollProgessMake(PSScrollProgressStateAbove, 1.0 + relativePercent);
    }
    else if (relativePercent > kCenterThreshHold)
    {
        return PSScrollProgessMake(PSScrollProgressStateBelow, 1.0 - relativePercent);
    }
    return PSScrollProgessMake(PSScrollProgressStateCenter, 0);
}

-(PSScrollProgessValue)horizontalProgressAtCenter:(CGPoint)center toViewPortWidth:(CGFloat)Width {
    CGFloat relativePercent = relativeProgressTransform(center.x, Width);
    if (relativePercent < -kCenterThreshHold)
    {
        return PSScrollProgessMake(PSScrollProgressStateLeft, 1.0 + relativePercent);
    }
    else if (relativePercent > kCenterThreshHold)
    {
        return PSScrollProgessMake(PSScrollProgressStateRight, 1.0 - relativePercent);
    }
    return PSScrollProgessMake(PSScrollProgressStateCenter, 0);
}

@end
