//
//  WDF_InfoTableViewCell.h
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WDF_Commont;

@interface WDF_InfoTableViewCell : UITableViewCell

@property(nonatomic,strong)WDF_Commont *model;

@property(nonatomic,assign)CGFloat maxY;

@end
