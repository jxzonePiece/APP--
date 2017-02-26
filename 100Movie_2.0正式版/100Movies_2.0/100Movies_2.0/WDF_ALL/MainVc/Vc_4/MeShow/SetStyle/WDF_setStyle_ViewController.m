//
//  WDF_setStyle_ViewController.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/13.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_setStyle_ViewController.h"

#import "WDF_Root_ViewController.h"

@interface WDF_setStyle_ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *dataSource;




@end

@implementation WDF_setStyle_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(exitAction)];
    
    UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"set.jpg"]];
    
    image.alpha=0.4;
    
    [self.view addSubview:image];
    
}
- (void)exitAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark===================tableView协议方法=========

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text=self.dataSource[indexPath.section];
    [cell addSubview: [self createWitch]];
    return cell;
}
// 创建开关
- (UISwitch *)createWitch{
    UISwitch *switcher=[[UISwitch alloc] init];
    switcher.frame=CGRectMake(SCREEN_WIDTH-80, 10, 100, 100);
    [switcher setOn:NO animated:NO];
    switcher.tintColor=[UIColor orangeColor];
    
    [switcher addTarget:self action:@selector(switcherAction:) forControlEvents:UIControlEventValueChanged];
    return switcher;
}
// 开关事件
- (void)switcherAction:(UISwitch *)switcher{
    if (switcher.isOn==YES) {
        // 1.修改导航栏
        self.view.window.alpha=0.3;
//        [appearance setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor],NSFontAttributeName:[UIFont systemFontOfSize:20]}];
//        [appearance setBackgroundImage:[UIImage imageNamed:@"header_bg64"] forBarMetrics:UIBarMetricsDefault];
//        [self.view reloadInputViews];/
        
        
        
        
    }else{
        self.view.window.alpha=1;
//        UINavigationBar *  appearance = [UINavigationBar appearance];
//        [appearance setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
//        [appearance setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//        [appearance setTranslucent:YES];
        
    }
}


// 没一行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


#pragma mark=======================懒加载================
// tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        // 添加一个头视图
//        _tableView.tableHeaderView=self.headerView;
        // 注册事件
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
// 数据

- (NSArray *)dataSource{
    
    return @[@"夜间模式"];
}
@end
