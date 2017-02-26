//
//  WDF_Casts_HeaderView.m
//  100Movies_2.0
//  主演的个人照片以及简介展示
//  Created by qianfeng on 16/1/14.
//  Copyright © 2016年 WDF. All rights reserved.
//  王长勇

#import "WDF_Casts_HeaderView.h"
#import "WDF_Casts_Message_Model.h"
#import "UIImageView+WebCache.h"

@interface WDF_Casts_HeaderView ()

@property (nonatomic, strong) UIImageView *starImageView;
@property (nonatomic, strong) UILabel *nameLable;
@property (nonatomic, strong) UILabel *sexLabel;
@property (nonatomic, strong) UILabel *countryLabel;

@end

@implementation WDF_Casts_HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.618);
        
//        [self.starImageView sd_setImageWithURL:[NSURL URLWithString:self.model.avatars.large]];
        
        [self addSubview:self.starImageView];
        [self addSubview:self.nameLable];
        [self addSubview:self.sexLabel];
        [self addSubview:self.countryLabel];
    }
    return self;
}

- (void)setModel:(WDF_Casts_Message_Model *)model{
    _model = model;
    [self.starImageView sd_setImageWithURL:[NSURL URLWithString:model.avatars.large] placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
//    [self.starImageView sd_setImageWithURL:[NSURL URLWithString:model.avatars.large]];
    [self.nameLable setFont:[UIFont systemFontOfSize:22]];
    self.nameLable.text = model.name;
    self.sexLabel.text = [NSString stringWithFormat:@"性别:  %@",model.gender];
    self.countryLabel.text = [NSString stringWithFormat:@"出生地:   %@",model.born_place];
}

- (UIImageView *)starImageView{
    if (_starImageView == nil) {
        _starImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH *0.4, SCREEN_WIDTH*4/7)];
        _starImageView.layer.cornerRadius = 10;
    }
    return _starImageView;
}

- (UILabel *)nameLable{
    if (_nameLable == nil) {
        _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH *0.4+30, 10, SCREEN_WIDTH*0.4, SCREEN_WIDTH *0.1)];

    }
    return _nameLable;
}

- (UILabel *)sexLabel{
    if (_sexLabel == nil) {
        _sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH *0.4+30, SCREEN_WIDTH*0.1+20, SCREEN_WIDTH*0.4, SCREEN_WIDTH*0.1)];
    }
    return _sexLabel;
}

- (UILabel *)countryLabel{
    if (_countryLabel == nil) {
        _countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.4+30, SCREEN_WIDTH*0.2+20, SCREEN_WIDTH*0.4, SCREEN_WIDTH*0.2)];
        _countryLabel.numberOfLines = 0;
    }
    return _countryLabel;
}

@end
