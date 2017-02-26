//
//  WDFGuidPageViewController.m
//  100MovieByWDF
//
//  Created by qianfeng on 16/1/7.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDFGuidPageViewController.h"



@interface WDFGuidPageViewController ()<UIScrollViewDelegate>

@end

@implementation WDFGuidPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createScrollView];
}
-(void)run{
    //1.获取scrollView
    UIScrollView *sc=(UIScrollView *)[self.view viewWithTag:987];
    
    //2.自动滚动
    CGPoint point =sc.contentOffset;
    point.x+=CGRectGetWidth(sc.frame);
    
    [sc setContentOffset:point animated:YES];
    
}
////以setContentOffset: animaed:YES 实现滚动的,滚动结束后会调用这个方法
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//    NSInteger page=scrollView.contentOffset.x/CGRectGetWidth(scrollView.frame);
//}
/**
 *  创建一个scrollView
 */
- (void)createScrollView{
    //1.创建一个scrollView
    UIScrollView *sc=[[UIScrollView alloc] initWithFrame:self.view.bounds];
    //2.
    //每一个图片的宽
    float width=CGRectGetWidth(sc.frame);
    //每一个图片的高
    float heigth=CGRectGetHeight(sc.frame);
    
    for (int i=0; i<3; i++) {
        
        UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(width *i, 0, width, heigth)];
 
//        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150,53, 100, 50)];
//        [btn setTitle:@"跳过" forState:UIControlStateNormal];
//        [btn setTitleColor:RGB(0, 0, 0, 1) forState:UIControlStateNormal];
//        btn.layer.cornerRadius=5;
//        btn.layer.borderWidth=1;
//        [btn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchDown];
//        [img addSubview:btn];
        [img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTouch:)]];
        img.userInteractionEnabled =YES;
        img.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i+10]];
        
        [sc addSubview:img];
    }
    // 隐藏水平方向指示条
    sc.showsHorizontalScrollIndicator = NO;
    // 设置scrollView的大小
    sc.contentSize=CGSizeMake(width *3, 0);
    sc.tag=987;
    // 代理
    sc.delegate=self;
    sc.pagingEnabled =YES;
    [self.view addSubview:sc];
}




- (void)tapTouch:(UITapGestureRecognizer *)tap{
    if (self.compete) {
        self.compete();
    }
}
//- (void)tapAction:(UIButton *)tap{
//    if (self.compete) {
//        self.compete();
//    }
//}


@end
