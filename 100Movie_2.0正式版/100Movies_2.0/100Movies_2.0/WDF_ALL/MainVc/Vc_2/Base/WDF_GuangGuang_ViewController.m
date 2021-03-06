//
//  WDF_GuangGuang_ViewController.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/9.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_GuangGuang_ViewController.h"

#import "WDF_PersonView.h"
#import "WDF_PersonViewController.h"
#import "WDF_PhotoView.h"
#import "WDF_Movie_message_ViewController.h"

#import "WDF_CommontsInfoViewController.h"
#import "WDF_Commont.h"
#import "WDF_CommotView.h"

#import "WDF_SearchViewController.h"

#define Width self.view.bounds.size.width

#define Higth self.view.bounds.size.height

@interface WDF_GuangGuang_ViewController ()<UIScrollViewDelegate>


// 存放标题按钮和滑块的视图
@property(nonatomic,strong)UIView *vs;
// 显示各个标题内容模块
@property(nonatomic, strong)UIScrollView *scrollView;
// 滑块,指示浏览当前为那个(导演/剧照/影评)
@property(nonatomic, strong)UIView *slilper;
//搜索按钮
@property(nonatomic,strong) UIButton *searchBtn;

@end

@implementation WDF_GuangGuang_ViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor yellowColor]}];
    // 标题
    [self vs];
    // 创建对应button来放标题
    [self prepareTitle];
    // ScrollView
    [self scrollView];
    [self searchBtn];
}
/** 创建ScrollView */
- (void)createScrollView{
    for (int i = 0; i < 3; i++) {
        if (i==0) {
            WDF_PersonView *view=[[WDF_PersonView alloc] initWithFrame:CGRectMake(Width*i, 0, Width, Higth-64)];
            
            [view setClickPerson:^(NSString *Did) {
                WDF_PersonViewController *person=[[WDF_PersonViewController alloc]init];
                person.Did=Did;
                [self.navigationController pushViewController:person animated:YES];
            }];
            
            view.userInteractionEnabled=YES;
            [self.scrollView addSubview:view];
            continue;
        }
        if (i==1) {
            WDF_PhotoView *photo=[[WDF_PhotoView alloc]initWithFrame:CGRectMake(Width*i, 0, Width, Higth-64)];
            
            [photo setClickPhoto:^(NSString *movieID) {
                WDF_Movie_message_ViewController *moview=[[WDF_Movie_message_ViewController alloc]init];
                moview.ID=movieID;
                [self.navigationController pushViewController:moview animated:YES];
            }];
            
            photo.userInteractionEnabled=YES;
            [self.scrollView addSubview:photo];
            continue;
        }
        if (i==2) {
            WDF_CommotView *vs=[[WDF_CommotView alloc] initWithFrame:CGRectMake(Width*i, 0, Width, Higth-64)];
            WDF_CommontsInfoViewController *info=[[WDF_CommontsInfoViewController alloc] init];
            [vs setClicke:^(WDF_Commont *model) {
                [self.navigationController pushViewController:info animated:YES];
                info.model=model;
                
            }];
            [self.scrollView addSubview:vs];
        }
        
    }
    // 设置scrollView contentOffset偏移量
    self.scrollView.contentOffset=CGPointMake(0, 0);
    // 设置scrollView contentSize大小
    self.scrollView.contentSize = CGSizeMake(Width*3, 0);
    
}
/** 创建ScrollView */
-(void)prepareTitle
{
    // 标题数组
    NSArray * titles = @[@"人物",@"剧照",@"评论"];
    //布局标题按钮
    for (int i = 0; i<titles.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        // button的属性设置
        button.titleLabel.font=[UIFont boldSystemFontOfSize:18];
        
        button.frame = CGRectMake(SCREEN_WIDTH/5.f*(i+1), 30, SCREEN_WIDTH/5.f, 25);
        [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        
        [button setTitleColor:RGB(250, 250, 179, 1) forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTintColor:[UIColor grayColor]];
        
        // button事件
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        // 设置button tag值
        button.tag = 1000+i;
        if (i==0) {
            button.selected = YES;
        }else
            button.selected=NO;
        [self.vs addSubview:button];
        
    }
    // 先给滑块设置一个初始的frame
    self.slilper.frame=CGRectMake(SCREEN_WIDTH/5.f, 69, SCREEN_WIDTH/5.f, 3);
    // 给滑块一个tag值
    self.slilper.tag=2000;
    
}
#pragma mark =======================UIScrollView协议================
/** 手动拖动事件 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger page=self.scrollView.contentOffset.x/Width;
    // 改变偏移量
    self.scrollView.contentOffset=CGPointMake((page)*CGRectGetWidth(self.view.bounds), 0);
    // 改变滑块的位置
    [UIView animateWithDuration:0.4 animations:^{
        self.slilper.frame=CGRectMake(SCREEN_WIDTH/5.f*(page+1), 69, SCREEN_WIDTH/5.f, 3);
    }];
    // 遍历self.vs上的视图
    for (UIView *view in self.vs.subviews) {
        // 取消不是当前选中按钮的选中状态
        if (view.tag != 2000) {
            ((UIButton *)view).selected = NO;
        }
    }
    // 获取当前按钮视图
    UIButton *btb=[self.vs viewWithTag:page+1000];
    // 设置选中状态
    btb.selected=YES;
}

/** button的响应方法 */
-(void)buttonClick:(UIButton *)button
{
    //将原来选中的按钮选中状态取消掉
    for (UIView * view in self.vs.subviews) {
        if (view.tag != 2000) {
            ((UIButton *)view).selected = NO;
        }
    }
    //将点击的按钮进行选中
    button.selected = YES;
    
    // 给scrollView设置偏移量
    self.scrollView.contentOffset=CGPointMake((button.tag - 1000)*CGRectGetWidth(self.view.bounds), 0);
    
    //改变滑块的位置
    //使用动画来进行移动改变滑块的位置
    [UIView animateWithDuration:0.4 animations:^{
        self.slilper.frame=CGRectMake(SCREEN_WIDTH/5.f*((button.tag - 1000)+1), 62, SCREEN_WIDTH/5.f, 3);
    }];
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
}

-(void)searchAction{
    WDF_SearchViewController *search=[[WDF_SearchViewController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
}

#pragma mark ==============================懒加载=========================
/** scrollView的懒加载 */

- (UIScrollView *)scrollView{
    if([UIDevice currentDevice])
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60,self.view.bounds.size.width, self.view.bounds.size.height)];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.userInteractionEnabled=YES;
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
        [self createScrollView];
    }
    
    return _scrollView;
}
/** 滑块的懒加载*/
- (UIView *)slilper{
    if (!_slilper) {
        _slilper=[[UIView alloc] init];
        _slilper.backgroundColor=[UIColor whiteColor];
        [self.vs addSubview:_slilper];
    }
    return _slilper;
}
/** 存放标题按钮和滑块的视图的懒加载 */
- (UIView *)vs{
    if (!_vs) {

        _vs=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        _vs.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_2.jpg"]];

        [self.view addSubview:_vs];
    }
    return _vs;
}

-(UIButton *)searchBtn{
    if (!_searchBtn) {
        _searchBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-40, 25, 30, 30)];

       [_searchBtn setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_searchBtn];
    }
    return _searchBtn;
}


@end
