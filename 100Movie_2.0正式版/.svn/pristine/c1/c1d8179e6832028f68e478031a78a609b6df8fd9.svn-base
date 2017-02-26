//
//  Baoyu_LineLayout.m
//  CollectionCoverFlow
//
//  Created by qianfeng on 16/1/8.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "Baoyu_LineLayout.h"

//单元格宽度
#define ITEM_WIDTH 126
//单元格高度
#define ITEM_HEIGHT  180

//跳格旋转的角度
#define rotate 50*M_PI/180.0

//活动中心半径
#define ACTIVE_DISTANCE 400

#define ZOOM_FACTOR 0.3


@implementation Baoyu_LineLayout



#pragma mark =============== 重写init ================

- (instancetype)init
{
    self = [super init];
    if (self) {
        //设置单元大小
        self.itemSize = CGSizeMake(ITEM_WIDTH  , ITEM_HEIGHT);
        
        //滑动方向
//        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        
        self.sectionInset = UIEdgeInsetsMake(20, ITEM_WIDTH, 20, ITEM_WIDTH);
        
        //item之间的间距
        self.minimumLineSpacing = 30;
    }
    return self;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}



-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes* attributes in array) {
        
        CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
        
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            
            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
            if (ABS(distance) < ACTIVE_DISTANCE) {
                CGFloat zoom = rotate*normalizedDistance;
                CATransform3D transfrom = CATransform3DIdentity;
                transfrom.m34 = 1.0 / 600;
                transfrom = CATransform3DRotate(transfrom, -zoom, 0.0f, 1.0f, 0.0f);
                attributes.transform3D = transfrom;
                attributes.zIndex = 1;
                
            }else
            {
                CATransform3D transfrom = CATransform3DIdentity;
                transfrom.m34 = 1.0 / 600;
                if (distance>0) {
                    transfrom = CATransform3DRotate(transfrom, -rotate, 0.0f, 1.0f, 0.0f);
                    
                }
                else{
                    transfrom = CATransform3DRotate(transfrom, rotate, 0.0f, 1.0f, 0.0f);
                    
                }
                
                attributes.transform3D = transfrom;
                attributes.zIndex = 1;
            }
            
        }
    }
    return array;
}


- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}



















@end
