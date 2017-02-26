
//  Copyright (c) 2016 田振 All rights reserved.


#import <UIKit/UIKit.h>
@class AoiroSoraLayout;
@protocol AoiroSoraLayoutDelegate <NSObject>

@required
/**
 *  设置每个item的自身高度
 *
 *  @param layOut
 *  @param indexPath 所在的位置
 *
 *  @return 高度
 */
- (CGFloat)itemHeightLayOut:(AoiroSoraLayout *)layOut indexPath:(NSIndexPath *)indexPath;

@end

@interface AoiroSoraLayout : UICollectionViewFlowLayout
/**
 *  列数
 */
@property (nonatomic, assign)NSInteger colNum;
/**
 *  每个item的间隔
 */
@property (nonatomic, assign)CGFloat interSpace;
/**
 *  整个CollectionView的间隔
 */
@property (nonatomic, assign)UIEdgeInsets edgeInsets;

@property (nonatomic, weak) id<AoiroSoraLayoutDelegate>delegate;

@end
