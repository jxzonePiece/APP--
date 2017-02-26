//
//  UIImage+MuzipooOriginallImage.m
//  Day7_UITabbarController
//
//  Created by qianfeng on 15/12/1.
//  Copyright (c) 2015年 Muzipoo. All rights reserved.
//

#import "UIImage+MuzipooOriginallImage.h"

@implementation UIImage (MuzipooOriginallImage)

- (UIImage *)originalImage{
    if ([UIDevice currentDevice].systemVersion.floatValue >=7.0) {
        return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return self;
}

@end
