//
//  WDF_PhotoModel.h
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/9.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "JSONModel.h"

@class PSubject,Photos;
@interface WDF_PhotoModel : JSONModel


@property (nonatomic, strong) NSArray *photos;

@property (nonatomic, strong) PSubject *subject;

@property(nonatomic,strong) NSString<Optional> *moviewID;


@end
@interface PSubject : JSONModel

@property (nonatomic, copy) NSString *ID;


@end


@interface Photos : JSONModel

@property (nonatomic, copy) NSString *cover;

@property(nonatomic,copy)NSString *image;

@end
