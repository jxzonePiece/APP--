//
//  WDF_User_Message_ViewController.m
//  100Movies_2.0
//  评论用户的网页展示
//  Created by qianfeng on 16/1/13.
//  Copyright © 2016年 WDF. All rights reserved.
//  王长勇

#import "WDF_User_Message_ViewController.h"
#import "WDF_Comments_Message_Model.h"

@interface WDF_User_Message_ViewController ()

@end

@implementation WDF_User_Message_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width-20, self.view.bounds.size.height - 49)];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.model.author.alt]];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
}



@end
