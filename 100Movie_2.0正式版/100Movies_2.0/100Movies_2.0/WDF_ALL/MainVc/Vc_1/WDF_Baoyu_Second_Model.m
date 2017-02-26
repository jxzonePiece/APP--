//
//  WDF_Baoyu_Second_Model.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_Baoyu_Second_Model.h"

@implementation WDF_Baoyu_Second_Model


+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id":@"MySecondID"
                                                       }];
}

@end
