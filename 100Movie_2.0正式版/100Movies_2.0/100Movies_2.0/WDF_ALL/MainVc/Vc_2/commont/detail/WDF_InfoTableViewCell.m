//
//  WDF_InfoTableViewCell.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_InfoTableViewCell.h"

#import "WDF_Commont.h"

@interface WDF_InfoTableViewCell ()

@property(nonatomic,strong)UILabel *titles;

@property(nonatomic,strong)UILabel *nameAndTime;

@property(nonatomic, strong)UILabel *content;

@property(nonatomic, strong)UILabel *useFul;

@end

@implementation WDF_InfoTableViewCell


- (void)setModel:(WDF_Commont *)model{
    _model=model;
    self.titles.text=model.title;
    self.nameAndTime.text=[NSString stringWithFormat:@"作者:%@     更新时间%@",model.author.name,model.updated_at];
    
    NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:3];
    
    CGSize size=[model.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSParagraphStyleAttributeName: style} context:nil].size;
    
    self.content.text=model.content;
    
    self.content.frame=CGRectMake(10, CGRectGetMaxY(self.nameAndTime.frame)+10, SCREEN_WIDTH-20, size.height);
    
    self.maxY=CGRectGetMaxY(self.useFul.frame)+60;
    

}


#pragma mark========================懒加载=================
- (UILabel *)titles{
    if (!_titles) {
        _titles=[[UILabel alloc] initWithFrame:CGRectMake(10,12, SCREEN_WIDTH-20, 70)];
        _titles.text=self.model.title;
        _titles.numberOfLines=2;
        _titles.textAlignment=NSTextAlignmentCenter;
        _titles.textColor=[UIColor blackColor];
        [self.contentView addSubview:_titles];
    }
    return _titles;
}

- (UILabel *)nameAndTime{
    if (!_nameAndTime) {
        _nameAndTime=[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titles.frame)+10, SCREEN_WIDTH-20, 30)];
        _nameAndTime.textAlignment=NSTextAlignmentCenter;
        _nameAndTime.textColor=[UIColor purpleColor];
        [self.contentView addSubview:_nameAndTime];
    }
    return _nameAndTime;
}

- (UILabel *)content{
    if (!_content) {
        _content=[[UILabel alloc] init];
        _content.numberOfLines=0;
        [self.contentView addSubview:_content];
    }
    return _content;
}
- (UILabel *)useFul{
    if (!_useFul) {
        _useFul=[[UILabel alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(self.content.frame)+10, SCREEN_WIDTH-130, 30)];
        _useFul.textAlignment=NSTextAlignmentRight;
        _useFul.textColor=[UIColor orangeColor];
        [self.contentView addSubview:_useFul];
        
    }
    return _useFul;
}


@end
