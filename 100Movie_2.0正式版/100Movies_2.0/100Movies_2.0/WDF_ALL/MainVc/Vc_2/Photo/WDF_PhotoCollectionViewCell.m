//
//  WDF_PhotoCollectionViewCell.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/9.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_PhotoCollectionViewCell.h"

#import "UIImageView+WebCache.h"

#import "WDF_PhotoModel.h"

@interface WDF_PhotoCollectionViewCell ()



@end

@implementation WDF_PhotoCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.image = [[UIImageView alloc]init];
        [self.contentView addSubview:self.image];
    }
    return self;
}

-(void)setModel:(WDF_PhotoModel *)model{
    _model=model;
    
    NSDictionary *arr=model.photos.firstObject;
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:arr[@"image"]] placeholderImage:[UIImage imageNamed:@"zhanweitu.png"]];
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.image.frame = CGRectMake(0, 0, layoutAttributes.frame.size.width, layoutAttributes.frame.size.height);
}


@end
