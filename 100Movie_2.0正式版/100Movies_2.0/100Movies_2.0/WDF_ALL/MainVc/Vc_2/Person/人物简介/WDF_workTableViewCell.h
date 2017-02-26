//
//  WDF_workTableViewCell.h
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WDF_PersonModel;
@interface WDF_workTableViewCell : UITableViewCell

@property(nonatomic,strong)WDF_PersonModel*model;

@property(nonatomic,assign) NSInteger row;

@end
