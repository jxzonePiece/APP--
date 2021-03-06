//
//  WDF_PersonTableViewCell.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/9.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_PersonTableViewCell.h"

#import "UIImageView+WebCache.h"

#import "WDF_PersonModel.h"



#define Padding 10

@interface WDF_PersonTableViewCell ()

@property(nonatomic,strong) UIImageView *image;//导演图片

@property(nonatomic,strong) UILabel *dirName;//导演的名字

@property(nonatomic,strong) UILabel *burnPlace;//导演的出生地

@property(nonatomic,strong) UILabel *role;//导演的角色

@end

@implementation WDF_PersonTableViewCell

-(void)setModel:(WDF_PersonModel *)model{
    
    _model=model;
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.avatars.small ]  placeholderImage:[UIImage imageNamed:@"zhanweitu.png"]];
    
    NSString *message=[NSString stringWithFormat:@"%@",model.name];
    NSMutableAttributedString *att=[[NSMutableAttributedString alloc]initWithString:message];
    [att addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]
                         } range:NSMakeRange(0, message.length)];
    
    self.dirName.attributedText=att;
    
    NSString *message2=[NSString stringWithFormat:@"%@",model.born_place];
    NSMutableAttributedString *att2=[[NSMutableAttributedString alloc]initWithString:message2];
    [att2 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],
                          NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(0, message2.length)];
    self.burnPlace.attributedText=att2;
    
    
    NSArray *arr2=model.professions;
    
    NSMutableString *strRole=[[NSMutableString alloc]init];
    strRole = arr2.firstObject;
    for (int i=1; i<arr2.count; i++) {
        
        strRole=[NSMutableString stringWithFormat:@"%@/%@",strRole,arr2[i]];
    }
    
    NSString *message3=[NSString stringWithFormat:@"%@",strRole];
    NSMutableAttributedString *att3=[[NSMutableAttributedString alloc]initWithString:message3];
    [att3 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],
                          NSForegroundColorAttributeName:RGB(113, 189, 217, 1)} range:NSMakeRange(0, message3.length)];
    self.role.attributedText=att3;
}



#pragma mark==================懒加载=============================
-(UIImageView *)image{
    
    if (_image==nil) {
        _image=[[UIImageView alloc]initWithFrame:CGRectMake(Padding, Padding, 70, 100)];
        [self addSubview:_image];
    }
    return _image;
}

-(UILabel *)dirName{
    
    if (!_dirName) {
        _dirName=[[UILabel alloc]initWithFrame:CGRectMake(3*Padding+CGRectGetWidth(self.image.frame), 15, SCREEN_WIDTH-2*Padding, 20)];
        _dirName.font=[UIFont systemFontOfSize:16];
        [self addSubview:_dirName];
    }
    return _dirName;
}

-(UILabel *)burnPlace{
    if (!_burnPlace) {
        _burnPlace=[[UILabel alloc]initWithFrame:CGRectMake(3*Padding+CGRectGetWidth(self.image.frame), 45, SCREEN_WIDTH-2*Padding, 20)];
        [self addSubview:_burnPlace];
    }
    return _burnPlace;
}

-(UILabel *)role{
    if (!_role) {
        _role=[[UILabel alloc]initWithFrame:CGRectMake(3*Padding+CGRectGetWidth(self.image.frame), 75, SCREEN_WIDTH-2*Padding, 20)];
        [self addSubview:_role];
    }
    return _role;
}
@end
