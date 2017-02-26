//
//  WDF_News_Header_ScrollView.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/13.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_News_Header_ScrollView.h"

#define timer_duration 2
@interface WDF_News_Header_ScrollView ()<UIScrollViewDelegate>

@property(nonatomic,strong) NSTimer *timer;

@property(nonatomic,strong) UIScrollView *ads;

@property(nonatomic,strong) UIPageControl *pageControl;

@end

@implementation WDF_News_Header_ScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame=CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetMaxY(self.ads.frame));
        [self ads];
    }
    return self;
}

-(void)setScroll{
    NSArray *arr = @[@"2020",@"2019",@"2018",@"2017",@"2016",@"2015"];
    for (int i = 0; i < 8; i ++ ) {
        NSString *str=[[NSString alloc]init];
        if (i==0) {
            str=arr.lastObject;
        }else if(i==7){
            str=arr.firstObject;
        }else{
            str=arr[i-1];
        }
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake( SCREEN_WIDTH *i, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.48)];
        [imageView setImage:[UIImage imageNamed:str]];
        [self.ads addSubview:imageView];
    }
    self.ads.contentSize = CGSizeMake(SCREEN_WIDTH*8, 0);
    self.ads.pagingEnabled = YES;
    self.ads.contentOffset=CGPointMake(SCREEN_WIDTH, 0);
    [self bringSubviewToFront:self.pageControl];
}

#pragma mark --------------- 循环滚动相关 ---------------

// 减速完成, 手动滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self pageControlWithContentOffset:scrollView.contentOffset.x];
}

// 动画滚动完成
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    [self pageControlWithContentOffset:scrollView.contentOffset.x];
}

// 循环滚动相关
- (void)pageControlWithContentOffset:(CGFloat)x {
    
    // 获取当前分页
    NSInteger page = x / SCREEN_WIDTH;
    
    if (page == 0) {
        // 跳转到最后一个需要显示的图片的位置, 即 arr.count
        [self.ads setContentOffset:CGPointMake(SCREEN_WIDTH * 6, 0) animated:NO];
        self.pageControl.currentPage = 6;
    }
        if (page == 7) {
        // 跳转到第一个需要显示的图片的位置, 即1
        [self.ads setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
        self.pageControl.currentPage = 0;
    }

}
-(UIScrollView *)ads{
        if (_ads == nil) {
            // 需要保证图片的宽高比不变
            _ads = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 11 / 15.f)];
            // 翻页
            _ads.pagingEnabled = YES;
            
            _ads.showsHorizontalScrollIndicator=NO;
            _ads.showsVerticalScrollIndicator=NO;
            // 设置代理
            _ads.delegate = self;
            
            [self setScroll];
            // 添加到视图上
            [self addSubview:_ads];
        }
        return _ads;
    }

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        
        float width = 100;
        float height = 30;
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - width - 10, CGRectGetMaxY(self.ads.frame) - height - 10, width, height)];
        
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        
        
        [self addSubview:_pageControl];
    }
    return _pageControl;
}
@end
