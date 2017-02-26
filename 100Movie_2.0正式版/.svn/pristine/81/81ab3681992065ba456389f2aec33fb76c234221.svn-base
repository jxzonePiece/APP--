//
//  WDF_Comments_Message_Model.h
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/15.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_Base_Model.h"

@class WAuthor,WRating;
@interface WDF_Comments_Message_Model : WDF_Base_Model
@property (nonatomic, strong) WRating *rating;

@property (nonatomic, strong) WAuthor *author;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, copy) NSString *subject_id;

@property (nonatomic, assign) NSInteger useful_count;


@end
@interface WAuthor : WDF_Base_Model

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *signature;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *alt;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *avatar;

@end

@interface WRating : WDF_Base_Model

@property (nonatomic, assign) NSInteger max;

@property (nonatomic, assign) NSInteger value;

@property (nonatomic, assign) NSInteger min;

@end
