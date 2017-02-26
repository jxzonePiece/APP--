//
//  WDF_TableViewCell.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/9.
//  Copyright (c) 2016年 WDF. All rights reserved.
//

#import "WDF_TableViewCell.h"
#import "WDF_Commont.h"

#import "Baoyu_ratingByStars.h"

#import "UIImageView+WebCache.h"

/** 边距 */
#define PADDING 10

@interface WDF_TableViewCell()

@property(nonatomic,strong)UIImageView *avatar;

@property(nonatomic,strong)UILabel *name;

@property(nonatomic, strong)UILabel *created_at;

@property(nonatomic, strong)UILabel *summary;

/** 电影评分星星 */
@property (nonatomic, strong) Baoyu_ratingByStars *starsView;

@end

@implementation WDF_TableViewCell

/** 从写set方法 */
- (void)setModel:(WDF_Commont *)model{
    _model=model;
    
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:model.author.avatar]];
    
    NSString *message=[NSString stringWithFormat:@"发帖人|:|  %@",model.author.name];
    NSMutableAttributedString *att=[[NSMutableAttributedString alloc]initWithString:message];
    [att addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],
                         NSForegroundColorAttributeName:[UIColor purpleColor]} range:NSMakeRange(4,1)];
    [att addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18
                                              ],
                         NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(7, message.length-7)];
    
    
    
    self.name.attributedText=att;
    
    NSString *time=[NSString stringWithFormat:@"发表时间:    %@",model.created_at];
    NSMutableAttributedString *attTime=[[NSMutableAttributedString alloc]initWithString:time];
    
    [attTime addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16
                                                  ],
                             NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(5, time.length-5)];
    
    self.created_at.attributedText=attTime;
    
    
    
    
    NSArray *arr = @[@"full",@"half",@"nil"];
    [self.starsView setScores:model.rating.value withImages:arr];
    
  
    //1. 设置 段落样式
    NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:8];
    
    // 2.设置内容所占大小
    CGSize size=[model.summary boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor],NSParagraphStyleAttributeName: style} context:nil].size;
    
    self.summary.text=[NSString stringWithFormat:@"     %@",model.summary];
    
    self.summary.frame=CGRectMake(PADDING, CGRectGetMaxY(self.created_at.frame)+PADDING, SCREEN_WIDTH-PADDING*2, size.height);
    
    // 垂直方向最大值
    self.maxY= CGRectGetMaxY(self.summary.frame)+10;
    
}


#pragma mark =========================懒加载=============

- (UIImageView *)avatar{
    if (!_avatar) {
        _avatar=[[UIImageView alloc] initWithFrame:CGRectMake(PADDING, PADDING, 40, 40)];
        _avatar.layer.cornerRadius=5;
        
        [self.contentView addSubview:_avatar];
    }
    return _avatar;
}
- (UILabel *)name{
    if (!_name) {
        _name=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avatar.frame)+PADDING,PADDING ,200, 30)];
        
        [self.contentView addSubview:_name];
    }
    return _name;
}

- (Baoyu_ratingByStars *)starsView{
    if (!_starsView) {
        _starsView = [[Baoyu_ratingByStars alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.name.frame)+PADDING, PADDING*1.7,30, 15)];
        [self.contentView addSubview:_starsView];
        
    }
    return _starsView;
}



- (UILabel *)created_at{
    if (!_created_at) {
        _created_at=[[UILabel alloc] initWithFrame:CGRectMake(PADDING, CGRectGetMaxY(self.name.frame)+PADDING,SCREEN_WIDTH-PADDING*3, 30)];
        [self.contentView addSubview:_created_at];
    }
    return _created_at;
}

- (UILabel *)summary{
    if (!_summary) {
        _summary=[[UILabel alloc] init];
        _summary.numberOfLines=0;
        _summary.textColor=[UIColor blackColor];
        _summary.font=[UIFont systemFontOfSize:16];
        [self.contentView addSubview:_summary];
    }
    return _summary;
}





@end
