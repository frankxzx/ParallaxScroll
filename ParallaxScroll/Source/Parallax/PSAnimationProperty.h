//
//  PSAnimationProperty.h
//  ParallaxScroll
//
//  Created by Xuzixiang on 2018/5/14.
//  Copyright © 2018年 frankxzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSAnimationValue.h"

@interface PSAnimationProperty : NSObject

@property(nonatomic, copy) NSString *animationPropertyKey;
@property(nonatomic, strong) PSAnimationValue *propertyValue;

-(void)adjustProgressForView:(UIView *)view
                     toValue:(PSAnimationValue *)value
                    progress:(CGFloat)progres;

@end
