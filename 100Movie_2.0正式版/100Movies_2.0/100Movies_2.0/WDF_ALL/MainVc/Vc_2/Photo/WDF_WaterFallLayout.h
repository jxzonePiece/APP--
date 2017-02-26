//
//  WDF_WaterFallLayout.h
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WaterLayoutDelegate <NSObject>

@required
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath;




@end
@interface WDF_WaterFallLayout : UICollectionViewLayout
@property (nonatomic, assign) id<WaterLayoutDelegate> delegate;
// 行数
@property (nonatomic, assign) NSInteger lineCount;
// 水平间距
@property (nonatomic, assign) CGFloat verticalSpacing;
// 垂直间距
@property (nonatomic, assign) CGFloat horizontalSpacing;
@property (nonatomic, assign) UIEdgeInsets sectionInset;
@end
