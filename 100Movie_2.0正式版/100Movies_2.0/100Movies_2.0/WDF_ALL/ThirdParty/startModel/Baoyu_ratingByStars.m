//
//  Baoyu_ratingByStars.m
//  DB_Movie_2
//
//  Created by qianfeng on 15/12/31.
//  Copyright (c) 2015年 Muzibaoyu. All rights reserved.
//

#import "Baoyu_ratingByStars.h"

@interface Baoyu_ratingByStars ()


@end

@implementation Baoyu_ratingByStars

- (instancetype)initWithFrame:(CGRect)frame withScores:(CGFloat)scores withImages:(NSArray *)images{
    self = [super init];
    if (self) {
        
        int num_red = scores/2;
        int num_half = scores/1 - num_red*2;
        
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        CGFloat star_r = height;
        CGFloat star_dis = (width - 5*star_r)/6.f;
        
        for (int i = 0 ; i<5; i++) {
            UIImageView *star_img = [[UIImageView alloc] initWithFrame:CGRectMake(star_dis + i*(star_r+star_dis), 0, star_r, star_r)];
            
            if (i < num_red) {
                star_img.image = [UIImage imageNamed:images[0]];
            }else if (i >= num_red && i <num_half+num_red){
                star_img.image = [UIImage imageNamed:images[1]];
            }else{
                star_img.image = [UIImage imageNamed:images[2]];
            }
            
            [self addSubview:star_img];
        }
    }
    return self;
}


- (instancetype)setScores:(CGFloat)scores withImages:(NSArray *)images{
    
    int num_red = scores/2;
    int num_half = scores/1 - num_red*2;
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat star_r = height;
    CGFloat star_dis = (width - 5*star_r)/20.f;
    
    for (int i = 0 ; i<5; i++) {
        UIImageView *star_img = [[UIImageView alloc] initWithFrame:CGRectMake(star_dis + i*(star_r+star_dis), 0, star_r, star_r)];
        
        if (i < num_red) {
            star_img.image = [UIImage imageNamed:images[0]];
        }else if (i >= num_red && i <num_half+num_red){
            star_img.image = [UIImage imageNamed:images[1]];
        }else{
            star_img.image = [UIImage imageNamed:images[2]];
        }
        
        [self addSubview:star_img];
    }
    return self;
}

@end
