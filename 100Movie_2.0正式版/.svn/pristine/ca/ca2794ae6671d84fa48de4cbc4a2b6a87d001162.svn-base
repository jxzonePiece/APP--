//
//  WDF_PersonMainTableViewCell.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_PersonMainTableViewCell.h"

#import "WDF_PersonModel.h"

#import "UIImageView+WebCache.h"


#define Padding 10

@interface WDF_PersonMainTableViewCell ()

@property(nonatomic,strong)UIImageView *image;

@property(nonatomic,strong) UILabel *name;

@property(nonatomic,strong) UILabel *role;

@end

@implementation WDF_PersonMainTableViewCell

-(void)setModel:(WDF_PersonModel *)model{
    _model=model;
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.avatars.large]placeholderImage:[UIImage imageNamed:@"zhanweitu.png"]];
    if (model.name.length==0) {
        self.name.text=@"";
    }
    else{
    NSString *message=[NSString stringWithFormat:@"%@\n%@\n%@",model.name,model.name,model.birthday];
    NSMutableAttributedString *att=[[NSMutableAttributedString alloc]initWithString:message];
    [att addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(0, model.name.length)];
    
        [att addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(model.name.length+1, model.name.length+model.birthday.length+1)];
    
    self.name.attributedText=att;
    }
    
    
    //角色的label
    NSArray *arr2=model.professions;
    
    NSMutableString *strRole=[[NSMutableString alloc]init];
    strRole = arr2.firstObject;
    for (int i=1; i<arr2.count; i++) {
        strRole=[NSMutableString stringWithFormat:@"%@/%@",strRole,arr2[i]];
    }
    if (strRole.length==0) {
        self.role.text=@"";
    }else{
        
    NSString *message3=[NSString stringWithFormat:@"%@",strRole];
    NSMutableAttributedString *att3=[[NSMutableAttributedString alloc]initWithString:message3];
    [att3 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],
                          NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, message3.length)];
    if(att3==nil){
        self.role.text=@"";
    }
    self.role.attributedText=att3;
    }

    
}

#pragma mark============懒加载================

-(UIImageView *)image{
    if (_image==nil) {
        _image=[[UIImageView alloc]initWithFrame:CGRectMake(Padding, Padding, 70*1.2, 100*1.2)];
        [self.contentView addSubview:_image];
    }
    return _image;
}

-(UILabel *)name{
    if (!_name) {
        _name=[[UILabel alloc]initWithFrame:CGRectMake(3*Padding+CGRectGetWidth(self.image.frame), 10, SCREEN_WIDTH-CGRectGetWidth(self.image.frame), 80)];
        _name.text=@" ";
        _name.numberOfLines=0;
        [self.contentView addSubview:_name];
    }
    return _name;
}

-(UILabel *)role{
    if (!_role) {
        _role=[[UILabel alloc]initWithFrame:CGRectMake(3*Padding+CGRectGetWidth(self.image.frame),100,SCREEN_WIDTH-CGRectGetWidth(self.image.frame)-2*Padding,20)];
        _role.text=@" ";
        [self.contentView addSubview:_role];
    }
    return _role;
}

@end
