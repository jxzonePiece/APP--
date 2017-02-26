//
//  WDF_workTableViewCell.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_workTableViewCell.h"

#import "UIImageView+WebCache.h"

#import "WDF_PersonModel.h"

#import "Baoyu_ratingByStars.h"

#define Padding 10
@interface WDF_workTableViewCell ()
//作品的照片
@property(nonatomic,strong) UIImageView *image;
//作品的名字
@property(nonatomic,strong) UILabel *workName;

@property(nonatomic,strong) UIView *starView;

@end

@implementation WDF_workTableViewCell

-(void)setModel:(WDF_PersonModel *)model{
    _model=model;
    
    NSDictionary *dic=model.works[self.row];
    
    NSDictionary *subject=dic[@"subject"];
    
    NSDictionary *image=subject[@"images"];
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:image[@"medium"]]];
    
    NSString *message=[NSString stringWithFormat:@"%@\n%@",subject[@"title"],subject[@"title"]];
    NSMutableAttributedString *att=[[NSMutableAttributedString alloc]initWithString:message];
    [att addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],
                         NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, [subject[@"title"] length])];
    
    [att addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                         NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange([subject[@"title"] length]+1, [subject[@"title"] length])];
    
    self.workName.attributedText=att;
    
    
    Baoyu_ratingByStars *star=[[Baoyu_ratingByStars alloc]initWithFrame:CGRectMake(Padding*3+CGRectGetWidth(self.image.frame), 50, 80, 15) withScores:[subject[@"rating"][@"average"] floatValue] withImages:@[@"full",@"half",@"nil"]];
    [self.starView addSubview:star];
    [self.contentView addSubview:_workName];
    [self.contentView addSubview:_starView];
    
}

-(UIImageView *)image{
    if (!_image) {
        _image=[[UIImageView alloc] initWithFrame:CGRectMake(Padding*2, 5, 70, 90)];
        [self addSubview:_image];
    }
    return _image;
}

-(UILabel *)workName{
    if (!_workName) {
        _workName=[[UILabel alloc]initWithFrame:CGRectMake(Padding*3+CGRectGetWidth(self.image.frame), 10, 200, 30)];
        
    }
    return _workName;
}

-(UIView *)starView{
    if (!_starView) {
        _starView=[[UIView alloc]initWithFrame:CGRectMake(Padding*3+CGRectGetWidth(self.image.frame), 50, 100, 20)];
    }
    return _starView;
}

@end
