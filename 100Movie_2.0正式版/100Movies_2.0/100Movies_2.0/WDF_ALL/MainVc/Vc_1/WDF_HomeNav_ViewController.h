//
//  WDF_HomeNav_ViewController.h
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"

@interface WDF_HomeNav_ViewController : UINavigationController<ICSDrawerControllerChild, ICSDrawerControllerPresenting>

@property (nonatomic , strong) void(^loadDataFinishBlock)(id responseObject);

//单例
+ (instancetype)defaultHomeNav;



@end
