//
//  WDF_Movie_Message_TableViewCell.m
//  100Movies_2.0
//  电影主演的自定义展示
//  Created by qianfeng on 16/1/8.
//  Copyright © 2016年 WDF. All rights reserved.
//  王长勇

#import "WDF_Movie_Message_TableViewCell.h"

#import "WDF_Movie_Message_Model.h"

#import "UIImageView+WebCache.h"

@interface WDF_Movie_Message_TableViewCell ()

// 演员名字
@property (nonatomic, strong) UILabel *nameLabel;

/** 演员照片 70 X 100 */
@property (nonatomic, strong) UIImageView *castSavatarsImage;

@end

@implementation WDF_Movie_Message_TableViewCell

- (void)setModel:(WDF_Movie_Message_Model *)model{
    _model = model;
    
    
    NSDictionary *dict = model.casts[self.row];
    
    
    NSDictionary *d = dict[@"avatars"];
    if (![d isKindOfClass:[NSNull class]]) {
        if (![dict[@"avatars"][@"small"] isKindOfClass:[NSNull class]] ) {
            NSString *string = [NSString stringWithFormat:@"%@",dict[@"avatars"][@"small"]];
            NSURL *url = [NSURL URLWithString:string];
            [self.castSavatarsImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
            
        }
    }
    self.nameLabel.text = dict[@"name"];
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.castSavatarsImage];
    
    
}

/** 演员照片 */

- (UIImageView *)castSavatarsImage{
    
    if (_castSavatarsImage == nil) {
        _castSavatarsImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 56, 80)];
        
    }
    return _castSavatarsImage;
    
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 20, 200, 56)];
    }
    return _nameLabel;
}

@end
