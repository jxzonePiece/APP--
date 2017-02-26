//
//  WDF_SearchModel.h
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/14.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "JSONModel.h"

@class SImages,SRating;
@interface WDF_SearchModel : JSONModel


@property (nonatomic, strong) SRating *rating;//评分

@property (nonatomic, copy) NSString *id;//电影的ID

@property (nonatomic, strong) NSArray *directors;//导演信息

@property (nonatomic, copy) NSString *title;//电影名

@property (nonatomic, copy) NSString *year;//上映事件

@property (nonatomic, strong) NSArray *genres;//电影类型

@property (nonatomic, strong) SImages *images;//照片

@end

@interface SImages : JSONModel

@property (nonatomic, copy) NSString *small;

@property (nonatomic, copy) NSString *large;

@property (nonatomic, copy) NSString *medium;

@end

@interface SRating : JSONModel

@property (nonatomic, copy) NSString * average;//电影评分

@end





