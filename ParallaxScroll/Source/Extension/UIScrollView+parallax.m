//
//  UIScrollView+parallax.m
//  ParallaxScroll
//
//  Created by Xuzixiang on 2018/5/14.
//  Copyright © 2018年 frankxzx. All rights reserved.
//

#import "UIScrollView+parallax.h"
#import <objc/runtime.h>

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
    if ([self isKindOfClass:[UITableView class]]) {
        needUpdateViews = ((UITableView *)self).visibleCells;
    }
    //执行动画
    [needUpdateViews enumerateObjectsUsingBlock:^(UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        
    }];
}

@end
