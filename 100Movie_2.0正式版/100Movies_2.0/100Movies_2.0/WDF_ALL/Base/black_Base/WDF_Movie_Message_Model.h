//
//  WDF_Movie_Message_Model.h
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/8.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_Base_Model.h"
@class images,directors,rating,casts,avatars,popular_comments,author;
@interface WDF_Movie_Message_Model : WDF_Base_Model

/** 上映日期 */
@property(nonatomic, copy)NSString *pubdate;
/** 电影名 */
@property(nonatomic, copy)NSString *title;
/** 电影简介 */
@property(nonatomic, copy)NSString *summary;
/** 电影的ID */
@property(nonatomic, copy)NSString *id;
/** 电影的海报*/
@property(nonatomic, strong)images *images;
/** 导演 */
@property(nonatomic, strong)NSArray *directors;
/** 影片评价 */
@property(nonatomic, strong)rating *rating;
/** 演员 */
@property(nonatomic, strong)NSArray *casts;
/** 电影类型 */
@property(nonatomic, strong)NSArray *genres;
/** 电影短评 */
@property(nonatomic, strong)NSArray *popular_comments;
/** 评论人数 */
@property(nonatomic, copy)NSString *ratings_count;
@end


/** 电影海报 */
@interface images : WDF_Base_Model

/** 小图 65*100*/
@property (nonatomic, copy) NSString *small;
/** 大图 300*419*/
@property (nonatomic, copy) NSString *large;
/** 中等图 100*139 */
@property (nonatomic, copy) NSString *medium;

@end


/** 导演详情 */
@interface directors : WDF_Base_Model

/** 导演ID */
@property (nonatomic, copy) NSString *id;
/** 导演英文名 */
@property (nonatomic, copy) NSString *name_en;
/** 导演中文名 */
@property (nonatomic, copy) NSString *name;
/** 导演详情界面(web) */
@property (nonatomic, copy) NSString *alt;
/** 导演照片 */
@property(nonatomic, strong)avatars *avatars;

@end


/** 导演/演员照片(大 中 小 ) */
@interface avatars : WDF_Base_Model

/** 导演照片小 */
@property (nonatomic, copy) NSString *small;
/** 导演照片 大 */
@property (nonatomic, copy) NSString *large;
/** 导演照片 中 */
@property (nonatomic, copy) NSString *medium;

@end


/** 电影的评价 */
@interface rating : WDF_Base_Model

/** ??? */
@property (nonatomic, copy) NSString *stars;
/** 电影评分的平均分 */
@property (nonatomic, assign) float average;
/** 最高分 */
@property (nonatomic, assign) NSInteger max;
/** 最低分 */
@property (nonatomic, assign) NSInteger min;

@end

/** 主演名单 */
@interface casts : WDF_Base_Model

/** 演员ID */
@property (nonatomic, copy) NSString *id;
/** 演员英文名 */
@property (nonatomic, copy) NSString *name_en;
/** 演员中文名 */
@property (nonatomic, copy) NSString *name;
/** 演员详情(web) */
@property (nonatomic, copy) NSString *alt;
/** 演员照片(同导演照片用一个model) */
@property(nonatomic, strong)avatars *avatars;

@end

/** 关于评价 */
@interface popular_comments : WDF_Base_Model

/** 评价 */
@property (nonatomic, strong) rating *rating;
/** 信息 */
@property (nonatomic, strong) author *author;
/** 评语 */
@property (nonatomic, copy) NSString *content;
/** 评价的id */
@property (nonatomic, copy) NSString *id;
/** 评价的时间*/
@property (nonatomic, copy) NSString *created_at;
/** 电影的ID */
@property (nonatomic, copy) NSString *subject_id;
/** 点赞的人数 */
@property (nonatomic, assign) NSInteger useful_count;

@end

/** 评论用户的信息 */
@interface author : WDF_Base_Model
/** 头像 */
@property (nonatomic, copy) NSString *id;
/** 签名 */
@property (nonatomic, copy) NSString *signature;
//
@property (nonatomic, copy) NSString *uid;
/** 个人豆瓣首页(web) */
@property (nonatomic, copy) NSString *alt;
/** 昵称 */
@property (nonatomic, copy) NSString *name;
/** 头像 */
@property (nonatomic, copy) NSString *avatar;

@end
