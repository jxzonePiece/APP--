//
//  WDF_PersonModel.h
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/9.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "JSONModel.h"

@class TAvatars,Works,TSubject,TRating;
@interface WDF_PersonModel : JSONModel
//人物的英文名
@property (nonatomic, copy) NSString *name_en;
//出生地
@property (nonatomic, copy) NSString *born_place;

@property (nonatomic, strong) NSArray *works;
//人物ID
@property (nonatomic, copy) NSString *Did;
//中文名
@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) TAvatars *avatars;
//职位
@property(nonatomic,strong) NSArray *professions;

@property(nonatomic,strong) NSString *birthday;

@end
@interface TAvatars : JSONModel
//小图
@property (nonatomic, copy) NSString *small;
//中图
@property (nonatomic, copy) NSString *medium;
//大图
@property(nonatomic,copy) NSString *large;

@end

@interface Works : JSONModel
//人物角色
@property (nonatomic, strong) NSArray *roles;

@property (nonatomic, strong) TSubject *subject;

@end

@interface TSubject : JSONModel

@property (nonatomic, strong) TRating *rating;

@property (nonatomic, copy) NSString *workID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *year;

@property (nonatomic, strong) NSString *images;

@end

@interface TRating : JSONModel


@property (nonatomic, assign) float average;


@end








