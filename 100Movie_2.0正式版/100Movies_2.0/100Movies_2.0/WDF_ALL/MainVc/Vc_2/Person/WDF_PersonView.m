//
//  WDF_PersonView.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/9.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_PersonView.h"

#import "AFNetworking.h"

#import "WDF_PersonModel.h"

#import "WDF_PersonTableViewCell.h"

#import "WDF_GuangGuang_ViewController.h"

#import "MJRefresh.h"

#import "MBProgressHUD.h"

@interface WDF_PersonView ()<UITableViewDataSource,UITableViewDelegate>
{
    int _count; //表示当前请求的分页数据是第几页
//    BOOL      _isRefresh; //表示是刷新还是上拉加载 YES:刷新  NO:加载
}
@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSMutableArray *dataSource;

@property(nonatomic,strong) NSMutableArray *array;

@end

@implementation WDF_PersonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor grayColor];
        [self addSubview:self.tableView];
        
        [self loadMainData];
    }
    return self;
}

#pragma mark==================数据解析=================

-(void)loadMainData{
    _count=0;
    [self showHUD:@"正在加载数据..." isDim:YES];
    [self reloadData];
}

-(void)reloadData{
    
    NSString *path=[NSString stringWithFormat:DOUBAN_APIKEY,_count,_count+20];
    
    NSString *url=[DOUBAN_BASE_PATH stringByAppendingString:TOP250_PATH];
    
    NSString *pathUrl=[url stringByAppendingString:path];
    
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    [manager GET:pathUrl parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *allData=responseObject[@"subjects"];
        for (NSDictionary *dict in allData) {
            NSDictionary *dic=[dict[@"directors"] firstObject];
            NSString *ID=dic[@"id"];
            if (self.array.count>0) {
                for (int i = 0; i<self.array.count; i++) {
                    NSString *str = self.array[i];
                    if ([str isEqualToString:ID]) {
                        break;
                    }
                    if (i == self.array.count - 1) {
                        [self doneLoadData];
                        [self preaseDir:ID];
                        [self.array addObject:ID];
                        [self doneLoadData];
                    }
                }
            }else{
                [self preaseDir:ID];
                [self.array addObject:ID];
                [self doneLoadData];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showHUDComplete:@"加载数据失败"];
    }];
}

-(void)preaseDir:(NSString *)dirID{
    NSString *dirurl1=[NSString stringWithFormat:CELEBRITY_PATH,dirID];
    NSString *dirUrl=[DOUBAN_BASE_PATH stringByAppendingString:dirurl1];
    NSString *dirUrl2=[dirUrl stringByAppendingString:DOUBAN_APIKEY_BLACK_PRIVATE];
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    [manager GET:dirUrl2 parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        WDF_PersonModel *model=[[WDF_PersonModel alloc]initWithDictionary:responseObject error:nil];
        [self.dataSource addObject:model];
        [self doneLoadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showHUDComplete:@"加载数据失败"];
        [self doneLoadData];
    }];
}

//数据加载完成
-(void)doneLoadData{
    //停止刷新
    [self.tableView.header endRefreshing];
    
    //停止上拉刷新
    [self.tableView.footer endRefreshing];
    
    //刷新表格
    [self.tableView reloadData];
    
    [self hideHUD];
}

#pragma mark================tableView的协议方法=============
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WDF_PersonTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    WDF_PersonModel *model=self.dataSource[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=model;
    cell.backgroundColor=[UIColor grayColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.clickPerson) {
        WDF_PersonModel *model=self.dataSource[indexPath.row];
        self.clickPerson(model.Did);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

#pragma mark==========刷新集成====================
-(void)addRefreshControl{
    //下啦刷新集成
    MJRefreshNormalHeader *header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
//        _isRefresh=YES;
        //刷新之前重置page
        _count=0;
        //重新加载数据
        [self reloadData];
        
    }];
    
    //添加到tableView
    self.tableView.header=header;

    //上拉刷新加载集成
    MJRefreshAutoNormalFooter *footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        _isRefresh=NO;
        _count+=20;
        //上拉加载的时候只需要请求分页的数据即可
        [self reloadData];
    }];
    
    //集成
    self.tableView.footer=footer;
}

-(void)showHUD:(NSString *)title isDim:(BOOL)isDim
{
    self.hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
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


#pragma mark======================懒加载==================

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.frame)-49) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.backgroundColor=[UIColor grayColor];
        [self addRefreshControl];
        [_tableView registerClass:[WDF_PersonTableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.separatorStyle = NO;
    }
    return _tableView;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc]init];
    }
    return _dataSource;
}

-(NSMutableArray *)array{
    if (!_array) {
        _array=[[NSMutableArray alloc]init];
    }
    return _array;
}

@end
