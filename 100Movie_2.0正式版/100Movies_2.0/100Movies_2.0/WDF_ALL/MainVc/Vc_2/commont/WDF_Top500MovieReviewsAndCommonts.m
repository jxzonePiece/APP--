//
//  WDF_Top500MovieReviewsAndCommonts.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/9.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_Top500MovieReviewsAndCommonts.h"

@implementation WDF_Top500MovieReviewsAndCommonts


+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"ID"}];
}


@end
