//
//  WDF_MovieInfo_DataManager.h
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "FMDatabase.h"
@class WDF_Movie_Message_Model;
@interface WDF_MovieInfo_DataManager : FMDatabase


+ (instancetype)sharedManager;

// 增
- (void)addRecord:(WDF_Movie_Message_Model *)model;

// 查询
- (NSArray *)selectRecord;

// 删
- (void)deleteRecord:(WDF_Movie_Message_Model *)model;

// 指定查询
- (BOOL)selectePointID:(NSString *)ID;



@end
