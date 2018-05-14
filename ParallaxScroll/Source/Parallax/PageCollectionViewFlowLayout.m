//
//  PageCollectionViewFlowLayout.m
//  ParallaxScroll
//
//  Created by Xuzixiang on 2018/5/14.
//  Copyright © 2018年 frankxzx. All rights reserved.
//

#import "PageCollectionViewFlowLayout.h"

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
//    if (visibleIndex > [self.collectionView numberOfItemsInSection:0]-1) {
//        self
//    }
}

//-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset {
//
//}

@end
