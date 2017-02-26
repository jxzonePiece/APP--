//
//  WDF_Commont.h
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/9.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_Base_Model.h"

@class Author,Rating;
@interface WDF_Commont : WDF_Base_Model

/** 评论者给定的星级数 */
@property (nonatomic, strong) Rating *rating;

@property (nonatomic, copy) NSString *ID;
/** 阅读量 */
@property (nonatomic, assign) NSInteger useful_count;

/** 评论者 */
@property (nonatomic, strong) Author *author;
/** 发表时间 */
@property (nonatomic, copy) NSString *created_at;
/** 评论标题 */
@property (nonatomic, copy) NSString *title;
/** 评论电影ID */
@property (nonatomic, copy) NSString *subject_id;
/** 评论内容简介 */
@property (nonatomic, copy) NSString *summary;
/** 更新时间 */
@property (nonatomic, copy) NSString *updated_at;

@property (nonatomic, copy) NSString *share_url;
/** 有用数 */
@property (nonatomic, assign) NSInteger comments_count;
/** 无用数 */
@property (nonatomic, assign) NSInteger useless_count;

@property (nonatomic, copy) NSString *alt;
/** 评论内容 */
@property (nonatomic, copy) NSString *content;


@end
//
/** 评论者信息 */
@interface Author : WDF_Base_Model

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *alt;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *avatar;

@end
/** 星级 */
@interface Rating : WDF_Base_Model

@property (nonatomic, assign) NSInteger max;
/** 评论者给的星级*/
@property (nonatomic, assign) NSInteger value;

@property (nonatomic, assign) NSInteger min;

@end

