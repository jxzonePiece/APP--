//
//  WDF_CommotView.h
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/9.
//  Copyright (c) 2016年 WDF. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WDF_Commont;
@interface WDF_CommotView : UIView



@property(nonatomic,copy) void (^clicke)(WDF_Commont *model);
@end
