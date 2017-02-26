//
//  WDF_Movie_Message_For_Summary_TableViewCell.m
//  100Movies_2.0
//  电影简介的自定义展示
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 WDF. All rights reserved.
//  王长勇

#import "WDF_Movie_Message_For_Summary_TableViewCell.h"

#import "WDF_Movie_Message_Model.h"

@interface WDF_Movie_Message_For_Summary_TableViewCell ()
/** 电影简介label 显示 */
@property (nonatomic, strong) UILabel *summaryLabel;

@end

@implementation WDF_Movie_Message_For_Summary_TableViewCell

- (void)setModel:(WDF_Movie_Message_Model *)model{
    _model = model;
    //    _summaryLabel.text = [NSString stringWithFormat:@"电影简介\n%@",model.summary];
    if (self.model) {
        NSMutableString *message = [NSMutableString stringWithFormat:@"电影简介:\n\t%@",model.summary];
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:message];
        
        
        [att addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:SCREEN_WIDTH/36],NSForegroundColorAttributeName:RGB(0, 0, 0, 0.8)} range:NSMakeRange(5, message.length-5)];
        
        self.summaryLabel.alpha = 0.7;
        self.summaryLabel.attributedText = att;
    }else{
    }
    //将电影详情label添加到viewController上
    [self.contentView addSubview:self.summaryLabel];
}

#pragma mark ============== 懒加载  ===============
- (UILabel *)summaryLabel{
    
    if (_summaryLabel == nil) {
        _summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH- 20, 160)];
        _summaryLabel.numberOfLines = 0;
    }
    return _summaryLabel;
}

@end
