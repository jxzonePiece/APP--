//
//  WDF_DoubanWeb_ViewController.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/13.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_DoubanWeb_ViewController.h"

@interface WDF_DoubanWeb_ViewController ()

@property (nonatomic ,strong) UIWebView *web;

@end

@implementation WDF_DoubanWeb_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.web];
    
    [self openURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)openURL{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.URL]];
    
    [self.web loadRequest:request];
}


#pragma mark =============== 懒加载 ================
- (UIWebView *)web{
    if (!_web) {
        _web = [[UIWebView alloc] initWithFrame:self.view.bounds];
    }
    return _web;
}


@end
