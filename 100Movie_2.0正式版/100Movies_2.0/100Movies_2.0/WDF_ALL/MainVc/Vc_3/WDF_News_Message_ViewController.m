//
//  WDF_News_Message_ViewController.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_News_Message_ViewController.h"

#import "AFNetworking.h"
#import "WDF_News_Message_Model.h"
#import "WDF_News_Message_TableViewCell.h"
#import "WDF_News_Web_ViewController.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "WDF_News_Header_ScrollView.h"
#import "MBProgressHUD.h"
@interface WDF_News_Message_ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int   _page;      // 表示当前请求的分页数据是第几页
    BOOL        _isRefresh; // 表示是刷新还是上拉加载 YES: 刷新 NO: 上拉加载
    long _timerNew;
}
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic,strong) UIView *headerView;

@end

@implementation WDF_News_Message_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _page = 1;
    [self loadData];
    [self.view addSubview:self.tableView];
    [self showHUD:@"正在加载中" isDim:YES];
}



- (void)loadData{
    [self showHUD:@"正在加载中" isDim:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *string = [NSString stringWithFormat:MTIME_NEWAPI_BLACK,_page];
    [manager GET:string parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_isRefresh) {
            [self.dataSource removeAllObjects];
        }
        [self creatModelAndSaveToDataSourceWith:responseObject];
        [self loadDone];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showHUDComplete:@"加载失败"];
        [self loadDone];
    }];
}

/** 数据加载完成 */
- (void) loadDone{
    // 1. 停止下拉刷新
    [self.tableView.header endRefreshing];
    
    // 停止上拉加载
    [self.tableView.footer endRefreshing];
    
    _timerNew = [[NSDate date] timeIntervalSince1970];
    _timerNew +=28800;
    
    // 2. 刷新表格
    [self.tableView reloadData];
    [self hideHUD];
}

- (void) creatModelAndSaveToDataSourceWith:(NSDictionary *)responseObject{
    
    NSArray *allData = responseObject[@"newsList"];
    for (int i = 0; i < allData.count; i ++) {
        NSDictionary *dict = allData[i];
        WDF_News_Message_Model *model = [[WDF_News_Message_Model alloc] initWithDictionary:dict error:nil];
        [self.dataSource addObject:model];
        [self.tableView reloadData];
        
    }
}

#pragma mark ================= tableView协议方法 =====================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // 返回数组的长度
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WDF_News_Message_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.timerNow = _timerNew;
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 返回每一行的高度按照屏幕的宽度取值
    return SCREEN_WIDTH*0.3+20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WDF_News_Message_Model *model = self.dataSource[indexPath.row];
    WDF_News_Web_ViewController *newsWeb = [[WDF_News_Web_ViewController alloc] init];
    newsWeb.model = model;
    
    [self.navigationController pushViewController:newsWeb animated:YES];
}

// 关于下拉刷新
- (void)addRefreshControl {
    MJRefreshNormalHeader *headerRefresh = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _isRefresh = YES;
        _page = 1;
        [self loadData];
    }];
    self.tableView.header = headerRefresh;
    
    MJRefreshAutoFooter *footerAuto = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        _isRefresh = NO;
        _page ++;
        [self loadData];
    }];
    self.tableView.footer = footerAuto;
    
}

#pragma mark ============== 懒加载 =================

- (UIView *)headerView{
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.48)];
        WDF_News_Header_ScrollView *header=[[WDF_News_Header_ScrollView alloc]init];
        [_headerView addSubview:header];
    }
    return _headerView;
}
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        [_tableView registerClass:[WDF_News_Message_TableViewCell class] forCellReuseIdentifier:@"cell"];
        
        _tableView.tableHeaderView = self.headerView;
        _tableView.dataSource = self;
        _tableView .delegate = self;
        
        [self addRefreshControl];
    }
    return _tableView;
}
-(void)showHUD:(NSString *)title isDim:(BOOL)isDim
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.dimBackground = isDim;
    self.hud.labelText = title;
}

-(void)showHUDComplete:(NSString *)title
{
    self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.labelText = title;
    [self hideHUD];
}

-(void)hideHUD
{
    [self.hud hide:YES afterDelay:0.3];
}

@end
