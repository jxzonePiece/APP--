//
//  WDF_News_Message_TableViewCell.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_News_Message_TableViewCell.h"
#import "WDF_News_Message_Model.h"
#import "UIImageView+WebCache.h"



@interface WDF_News_Message_TableViewCell ()


@property (nonatomic, strong) UIImageView *nameImage;
@property (nonatomic, strong) UILabel *mianTitle;
@property (nonatomic, strong) UILabel *viceTitle;
@property (nonatomic, strong) UILabel *timeLabel;
@end
@implementation WDF_News_Message_TableViewCell

- (void)setModel:(WDF_News_Message_Model *)model{
    _model = model;
    long timeDifference = self.timerNow - model.publishTime;
    
    if (timeDifference <300) {
        self.timeLabel.text = @"刚刚";
    }else if (timeDifference < 3600){
        self.timeLabel.text = [NSString stringWithFormat:@"%d分钟前",(int)timeDifference/60];
    }else if (timeDifference < 86400){
        self.timeLabel.text = [NSString stringWithFormat:@"%d小时前",(int)timeDifference/3600];
    }else{
        self.timeLabel.text = [NSString stringWithFormat:@"%d天前",(int)timeDifference/86400];
    }
    
    NSURL *url = [NSURL URLWithString:model.image];
    [self.nameImage sd_setImageWithURL:url];
    
    
    self.mianTitle.text = model.title;// 添加主标题
    [self.mianTitle setFont:[UIFont systemFontOfSize:20]];
    self.viceTitle.text = model.title2;// 添加副标题
    [self.viceTitle setTextColor:RGB(0, 0, 0, 0.6)];
    
    [self.timeLabel setFont:[UIFont systemFontOfSize:12]];
    self.timeLabel.alpha = 0.4;
    
    // 将要展示的内容放到视图上
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.nameImage];
    [self.contentView addSubview:self.viceTitle];
    [self.contentView addSubview:self.mianTitle];
}

// 新闻图片的懒加载
- (UIImageView *)nameImage{
    if (_nameImage == nil) {
        _nameImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH *0.3, SCREEN_WIDTH*0.3)];
    }
    return _nameImage;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.3+20, SCREEN_WIDTH*0.25+10, SCREEN_WIDTH*0.6, SCREEN_WIDTH*0.06)];
    }
    return _timeLabel;
}

// 主标题
- (UILabel *)mianTitle{
    if (_mianTitle == nil) {
        _mianTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.3+20, 10, SCREEN_WIDTH*0.6, SCREEN_WIDTH*0.13)];
//                _mianTitle.backgroundColor = RGB(152, 46, 85, 1);
    }
    return _mianTitle;
}

- (UILabel *)viceTitle{
    if (_viceTitle == nil) {
        _viceTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.3+20, SCREEN_WIDTH*0.13+20, SCREEN_WIDTH*0.6, SCREEN_WIDTH*0.08)];
//                _viceTitle.backgroundColor = RGB(85, 152, 251, 1);
    }
    return _viceTitle;
}

@end
