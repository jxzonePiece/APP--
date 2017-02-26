//
//  WDF_Left_ViewController.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_Left_ViewController.h"

#import "ICSDrawerController.h"

#import "WDF_Movie_message_ViewController.h"

#import "WDF_Baoyu_HomePage_ViewController.h"

#import "WDF_Second_ViewController.h"

static NSString * const BaoyuCellID = @"leftCell";

@interface WDF_Left_ViewController ()<UITableViewDelegate,UITableViewDataSource>

/** tabelView */
@property (nonatomic ,strong ) UITableView *tableView;

/** 数据源 */
@property (nonatomic ,strong) NSArray *dataSource;

@end

@implementation WDF_Left_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadBaoyuPlist];
    
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
}

/** 解析tableView标题的本地plist */
- (void)loadBaoyuPlist{
    self.dataSource = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"BaoyuLeft" ofType:@"plist"]];
}

#pragma mark =============== tableView协议 ================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.dataSource[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BaoyuCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:BaoyuCellID];
    }
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    int num = (int)indexPath.section * 12;
    num = num + (int)indexPath.row * 4;
    int _r = 180 - num;
    int _g = 64 - num;
    int _b = 80 - num;
    cell.backgroundColor = RGB(_r , _g, _b ,1);
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ICSDrawerController *ics = [ICSDrawerController defaultICSViewControllerWith:nil centerViewController:nil];
    [ics close];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 两秒钟之后, 停止活动
        NSLog(@"%@",self.dataSource[indexPath.section][indexPath.row]);
        WDF_Baoyu_HomePage_ViewController *home = [WDF_Baoyu_HomePage_ViewController defulatHomePage];
        WDF_Second_ViewController *second = [[WDF_Second_ViewController alloc] init];
        second.movieType = self.dataSource[indexPath.section][indexPath.row];
        [home.navigationController pushViewController:second animated:YES];
    });
}


#pragma mark =============== 懒加载 ================
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - 69) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =
        RGB(12 , 12, 12, 1);
    }
    return _tableView;
}



@end
