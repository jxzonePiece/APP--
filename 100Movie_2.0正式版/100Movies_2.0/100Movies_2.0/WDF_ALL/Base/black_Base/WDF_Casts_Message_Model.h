//
//  WDF_Casts_Message_Model.h
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/14.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_Base_Model.h"


@class Blackavatars,Blacksubject,Blackrating,Blackimages;
@interface WDF_Casts_Message_Model : WDF_Base_Model

/** 姓名 */
@property(nonatomic, copy)NSString *name;
/** 性别 */
@property(nonatomic, copy)NSString *gender;
/** 照片集 */
@property(nonatomic, strong)Blackavatars *avatars;
/** 籍贯 */
@property(nonatomic, copy)NSString *born_place;
/** 影人的id */
@property(nonatomic, copy)NSString *id;
/** 最受好评的5部电影 */
@property(nonatomic, strong)NSArray *works;
@end

/** 照片 */
@interface Blackavatars : WDF_Base_Model
@property(nonatomic, copy)NSString *small;
@property(nonatomic, copy)NSString *large;
@property(nonatomic, copy)NSString *medium;
@end

@interface works : WDF_Base_Model
// 角色
@property(nonatomic, strong)NSArray *roles;
@property(nonatomic, strong)Blacksubject *subject;
@end

@interface Blacksubject : WDF_Base_Model
/** 电影名字 */
@property(nonatomic, copy)NSString *title;
/** 电影评分 */
@property(nonatomic, strong)Blackrating *rating;
/** 年份 */
@property(nonatomic, copy)NSString *year;
/** 电影照片 */
@property(nonatomic, strong)Blackimages *images;

@property(nonatomic, copy)NSString *id;

@end

@interface Blackrating : WDF_Base_Model
@property(nonatomic, copy)NSString *average;

@end

@interface Blackimages : WDF_Base_Model
@property(nonatomic, copy)NSString *small;
@property(nonatomic, copy)NSString *large;
@property(nonatomic, copy)NSString *medium;

@end



