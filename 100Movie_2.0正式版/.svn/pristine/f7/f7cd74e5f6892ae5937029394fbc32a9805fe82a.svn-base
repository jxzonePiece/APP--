//
//  WDF_Me_TableViewCell.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/13.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_Me_TableViewCell.h"

#import "WDF_MeModel.h"

@interface WDF_Me_TableViewCell ()

@property(nonatomic,strong)UIImageView *icon;

@property(nonatomic,strong)UILabel *name;



@end

@implementation WDF_Me_TableViewCell

- (void)setModel:(WDF_MeModel *)model{
    _model=model;
    self.icon.image=[UIImage imageNamed:model.icon];
    
    self.name.text=model.name;
}

- (UIImageView *)icon{
    if (!_icon) {
        _icon=[[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 35, 35)];
        [self.contentView addSubview:_icon];
    }
    return _icon;
}


- (UILabel *)name{
    if (!_name) {
        _name=[[UILabel alloc] initWithFrame:CGRectMake(60, 20, 100, 20)];
        [self.contentView addSubview:_name];
        
        _name.font=[UIFont systemFontOfSize:19];
    }
    return _name;
}

@end
