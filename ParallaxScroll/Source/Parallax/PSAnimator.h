//
//  PSAnimator.h
//  ParallaxScroll
//
//  Created by Xuzixiang on 2018/5/14.
//  Copyright © 2018年 frankxzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PSAnimationView;

typedef enum PSScrollProgressState: NSUInteger {
    //垂直
    PSScrollProgressStateAbove,
    PSScrollProgressStateBelow,
    
    //水平
    PSScrollProgressStateLeft,
    PSScrollProgressStateRight,
    
    PSScrollProgressStateCenter,
    
} PSScrollProgressState;

typedef struct PSScrollProgessValue {
    PSScrollProgressState direction;
    CGFloat value;
} PSScrollProgessValue;

NS_INLINE PSScrollProgessValue PSScrollProgessMake(PSScrollProgressState direction, CGFloat value) {
    PSScrollProgessValue v;
    v.direction = direction;
    v.value = value;
    return v;
}

typedef NS_ENUM(NSUInteger, PSScrollDirection) {
    PSScrollDirectionVertical,
    PSScrollDirectionHorizontal,
};

@class PSAnimator;
@protocol PSAnimatableType <NSObject>

-(PSAnimator *)configureAnimator;

@end

@interface PSAnimator : NSObject

@property(nonatomic, assign) PSScrollDirection direction;

@property(nonatomic, strong) NSArray <PSAnimationView *>* animationViews;

+(instancetype)animateWithDirection:(PSScrollDirection)direction;

-(void)applyAnimationWithProgress:(PSScrollProgessValue)value;

@end
