//
//  PageCollectionViewFlowLayout.m
//  ParallaxScroll
//
//  Created by Xuzixiang on 2018/5/14.
//  Copyright © 2018年 frankxzx. All rights reserved.
//

#import "PageCollectionViewFlowLayout.h"

static CGFloat const kThresholdOffsetPrecentage = 0.3;
static CGFloat const kVelocityThreshold = 0.37;
static CGFloat const kDelayedVelocityThreshold = 1.4;

@interface PageCollectionViewFlowLayout()

@property(nonatomic, assign) NSInteger visibleIndex;

@end

@implementation PageCollectionViewFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}

-(void)setVisibleIndex:(NSInteger)visibleIndex {
    if (visibleIndex > [self.collectionView numberOfItemsInSection:0]-1) {
        _visibleIndex =  visibleIndex;
    }
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return NO;
}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {

    CGFloat height = self.collectionView.bounds.size.height;
    CGFloat topThreshold = height * (self.visibleIndex - kThresholdOffsetPrecentage);
    CGFloat bottomThreshold = height * (self.visibleIndex + kThresholdOffsetPrecentage);
    CGFloat currentHorizontalOffset = self.collectionView.contentOffset.y;
    
    
    if (currentHorizontalOffset < topThreshold ||                  // If the user scrolled past the halfway point
        velocity.y < -kVelocityThreshold)  {
        // If the user flicked the item
        self.visibleIndex = MAX(0 , (self.visibleIndex - 1));
        }
    else if (currentHorizontalOffset > bottomThreshold ||          // If the user scrolled past the halfway point
        velocity.y > kVelocityThreshold) {                          // If the user flicked the it
            self.visibleIndex += 1;
            self.visibleIndex = MIN([self.collectionView numberOfItemsInSection:0]-1, self.visibleIndex);
        }
    
    CGFloat yOffset = height * self.visibleIndex;
    
    // This ensures that the collecitonview smooth stops at the bottom
    // otherwise it causes a monster bounce sometimes
    if (self.visibleIndex == [self.collectionView numberOfItemsInSection:0]-1)
    {
        yOffset -= 1.0;
    }
    
    // This ensures that the collecitonview smooth stops at the top
    // otherwise it causes a monster bounce sometimes
    else if (self.visibleIndex == 0) {
        yOffset = 1.0;
    }
    
    CGPoint _proposedContentOffset = proposedContentOffset;
    _proposedContentOffset.y = yOffset;
    
    return _proposedContentOffset;
}

@end
