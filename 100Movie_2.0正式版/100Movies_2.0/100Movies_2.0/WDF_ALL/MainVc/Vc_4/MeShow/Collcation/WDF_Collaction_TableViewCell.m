//
//  WDF_Collaction_TableViewCell.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_Collaction_TableViewCell.h"
#import "UIImageView+WebCache.h"
#import "WDF_Movie_Message_Model.h"
#import "AFNetworking.h"

#define PAD 10



@interface WDF_Collaction_TableViewCell ()


@property(nonatomic,strong)UILabel *label;

@property(nonatomic, strong)UIButton *button;


@end

@implementation WDF_Collaction_TableViewCell


- (void)setModel:(WDF_Movie_Message_Model *)model{
    
    
    NSString *message=[NSString stringWithFormat:@"《%@》\n%@",model.title,model.summary];
    
    self.label.text=message;
    
}

- (UILabel *)label{
    if (!_label) {
        _label=[[UILabel alloc] initWithFrame:CGRectMake(PAD*1.5f, PAD/2.f, SCREEN_WIDTH-PAD*3, 50)];
        _label.numberOfLines=2;
    
        [self.contentView addSubview:_label];
    }
    return _label;
}

@end
