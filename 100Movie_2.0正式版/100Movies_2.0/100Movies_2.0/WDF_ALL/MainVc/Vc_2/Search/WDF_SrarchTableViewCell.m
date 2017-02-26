//
//  WDF_SrarchTableViewCell.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/14.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_SrarchTableViewCell.h"

#import "UIImageView+WebCache.h"

#import "WDF_SearchModel.h"
#import "Baoyu_ratingByStars.h"
#define Padding 10

@interface WDF_SrarchTableViewCell ()

@property(nonatomic,strong) UIImageView *image;

@property(nonatomic,strong) UILabel *movieName;

@property(nonatomic,strong) UILabel *dir;

@property(nonatomic,strong) UILabel *year;

@property(nonatomic,strong) UIView *starView;

@property(nonatomic,strong) UILabel *genres;//电影类型

@end

@implementation WDF_SrarchTableViewCell

-(void)setModel:(WDF_SearchModel *)model{
    _model=model;
 
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.images.large]];
    
    NSDictionary *dict= model.directors.firstObject;
    NSString *name=dict[@"name"];
    
    NSString *message=[NSString stringWithFormat:@"%@",model.title];
    NSMutableAttributedString *att=[[NSMutableAttributedString alloc]initWithString:message];
    [att addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} range:NSMakeRange(0, model.title.length)];
    self.movieName.attributedText=att;
    
    Baoyu_ratingByStars *star=[[Baoyu_ratingByStars alloc]initWithFrame:CGRectMake(3*Padding, 40, 80, 15) withScores:model.rating.average.floatValue withImages:@[@"full",@"half",@"nil"]];
    [self.starView addSubview:star];
    
    self.dir.text=name;
    self.year.text=[NSString stringWithFormat:@"%@",model.year];
    
    NSArray *arr2=model.genres;
    
    NSMutableString *strRole=[[NSMutableString alloc]init];
    strRole = arr2.firstObject;
    for (int i=1; i<arr2.count; i++) {
        
        strRole=[NSMutableString stringWithFormat:@"%@/%@",strRole,arr2[i]];
    }
    
    NSString *message3=[NSString stringWithFormat:@"%@",strRole];
    NSMutableAttributedString *att3=[[NSMutableAttributedString alloc]initWithString:message3];
    [att3 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],
                          NSForegroundColorAttributeName:RGB(113, 189, 217, 1)} range:NSMakeRange(0, message3.length)];
    
    self.genres.attributedText=att3;
}


-(UIImageView *)image{
    if (!_image) {
        _image=[[UIImageView alloc]initWithFrame:CGRectMake(Padding, Padding, SCREEN_WIDTH/3.5f,SCREEN_WIDTH/3.5f*10/7)];
        [self addSubview:_image];
    }
    return _image;
}

-(UILabel *)movieName{
    if (!_movieName) {
        _movieName=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.image.frame)+3*Padding, 20, 200, 30)];
        [self addSubview:_movieName];
    }
    return _movieName;
}

-(UILabel *)dir{
    if (!_dir) {
        _dir=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.image.frame)+3*Padding,CGRectGetHeight(self.image.frame)/3.f, 200, 30)];
        [self addSubview:_dir];
    }
    return _dir;
}

-(UILabel *)genres{
    if (!_genres) {
        _genres=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.image.frame)+3*Padding, CGRectGetHeight(self.image.frame)*3/5-10, 100, 30)];
        [self addSubview:_genres];
    }
    return _genres;
}

-(UILabel *)year{
    if (!_year) {
        _year=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.image.frame)+3*Padding, CGRectGetHeight(self.image.frame)*4/5-10, 100, 30)];
        [self addSubview:_year];
    }
    return _year;
}

-(UIView *)starView{
    if (!_starView) {
        _starView=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3.5f+3*Padding, CGRectGetHeight(self.image.frame)-10, 80, 10)];
        [self addSubview:_starView];
    }
    return _starView;
}

@end
