//
//  WDF_News_Message_TableViewCell.h
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WDF_News_Message_Model;
@interface WDF_News_Message_TableViewCell : UITableViewCell

@property(nonatomic, strong)WDF_News_Message_Model *model;

@property(nonatomic, assign)long timerNow;
@end
