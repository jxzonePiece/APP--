//
//  Baoyu_Cell_CollectionViewCell.m
//  CollectionCoverFlow
//
//  Created by qianfeng on 16/1/8.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "Baoyu_Cell_CollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "DSReflectionLayer.h"
#import "UIView+DSImages.h"




@interface Baoyu_Cell_CollectionViewCell()

@property (strong, nonatomic) DSReflectionLayer* reflectionlayer;

@end


@implementation Baoyu_Cell_CollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        [self.imgView addSubview:self.label];
        
        [self.contentView addSubview:self.imgView];
        
        self.contentView.layer.shouldRasterize = YES;
        self.contentView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        self.reflectionlayer = [self.imgView addReflectionToSuperLayer];
        self.reflectionlayer.verticalOffset = 10;
    }
    return self;
}


#pragma mark =============== 懒加载 ================
- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.imgView.frame) - 30, CGRectGetWidth(self.imgView.frame), 30)];
        _label.backgroundColor = [UIColor blackColor];
//        _label.alpha = 0.9;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:12];
        _label.textColor = [UIColor redColor];
        _label.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        
    }
    return _label;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetHeight(self.frame)*0.7, CGRectGetHeight(self.frame))];
        _imgView.layer.cornerRadius = 5;
        _imgView.layer.masksToBounds = YES;
        
    }
    return _imgView;
}

@end
