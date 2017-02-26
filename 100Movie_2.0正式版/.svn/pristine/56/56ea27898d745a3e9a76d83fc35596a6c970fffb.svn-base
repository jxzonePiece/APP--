//
//  WDF_CommotView.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/9.
//  Copyright (c) 2016年 WDF. All rights reserved.
//

#import "WDF_CommotView.h"
#import "WDF_TableViewCell.h"

#import "AFNetworking.h"
#import "MJRefresh.h"

#import "WDF_Commont.h"
#import "WDF_Top500MovieReviewsAndCommonts.h"
#import "WDF_CommontsInfoViewController.h"


@interface WDF_CommotView ()<UITableViewDataSource,UITableViewDelegate>
{
    int _count;
    BOOL _isRefresh;
}
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic, strong)NSMutableArray *dataSource;

@property(nonatomic, strong)NSMutableArray *allCommontSource;


@end

@implementation WDF_CommotView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadData];
        [self addSubview:self.tableView];
        self.userInteractionEnabled=YES;
        self.backgroundColor=[UIColor colorWithRed:238/255.f green:238/255.f blue:238/255.f alpha:1];
    
        UIImageView *image=[[UIImageView alloc] initWithFrame:self.bounds];
        image.image=[UIImage imageNamed:@"commonts.jpg"];
        image.alpha=0.3;
        [self addSubview:image];
    
    }
    return self;
}

//数据加载完成
- (void)doneLoadData{
    // 停止下拉刷新
    [self.tableView.header endRefreshing];
    
    // 停止刷新
    [self.tableView.footer endRefreshing];
    
    // 刷新表格
    [self.tableView reloadData];
    
}

#pragma mark ========================数据加载=======================
/** 加载数据 */
- (void)loadData{
    [self loadTop250Data];
    
}
/** 加载Top250*/
- (void)loadTop250Data{
    NSString *countUrl=[NSString stringWithFormat:DOUBAN_APIKEY,10,_count+10];
    NSString *pathUrl=[NSString stringWithFormat:@"%@%@?%@",DOUBAN_BASE_PATH,TOP250_PATH,countUrl];
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
   
    [manager GET:pathUrl parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self parseTop:responseObject];
        [self doneLoadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self doneLoadData];
        NSLog(@"%@",error);
    }];
}

/** 加载全部数据*/
- (void)loadMainData{
    
    NSString *subjectID;
    if (_isRefresh==YES) {
        WDF_Top500MovieReviewsAndCommonts *model=self.allCommontSource.firstObject;
        subjectID=model.ID;
    }else{
        WDF_Top500MovieReviewsAndCommonts *model=self.allCommontSource[arc4random()%self.allCommontSource.count];
        subjectID=model.ID;
    }
    NSString *commUrl=[NSString stringWithFormat:MOVIE_REVIEWS_PATH,subjectID];
    
//    int count=(NSInteger)arc4random()%10+1;
    
    NSString *countUrl=[NSString stringWithFormat:DOUBAN_APIKEY,0,10];
    
    NSString *mainUrl=[NSString stringWithFormat:@"%@%@%@",DOUBAN_BASE_PATH,commUrl,countUrl];
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    [manager GET:mainUrl parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self parseInfo:responseObject];
        [self doneLoadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self doneLoadData];
        NSLog(@"%@",error);
    }];
}

#pragma mark ========================解析数据=======================
- (void)parseTop:(NSDictionary *)data{
    NSArray *allData=data[@"subjects"];
    
    for (NSDictionary *dict in allData) {
        WDF_Top500MovieReviewsAndCommonts *model=[[WDF_Top500MovieReviewsAndCommonts alloc] initWithDictionary:dict error:nil];
        [self.allCommontSource addObject:model];
    }
    [self loadMainData];
    
}
- (void)parseInfo:(NSDictionary *)data{
    NSArray *allData=data[@"reviews"];
    
    for (NSDictionary *dict in allData) {
        WDF_Commont *model=[[WDF_Commont alloc] initWithDictionary:dict error:nil];
        [_dataSource addObject:model];
    }
    [self.tableView reloadData];
}


#pragma  mark ==================刷新集成===================
- (void)addRefreshControl{
    MJRefreshNormalHeader *header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        _isRefresh=YES;
       
        [self doneLoadData];
        
        
    }];
    self.tableView.header=header;
    MJRefreshAutoNormalFooter *footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _count+=10;
        if (_count==100) {
            _count=0;
        }
        [self loadMainData];
    }];
    // 集成
    self.tableView.footer =footer;
    
}



#pragma mark ======================tableview协议====================

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WDF_TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    WDF_Commont *model=self.dataSource[indexPath.row];
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    cell.model=model;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WDF_TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    WDF_Commont *model=self.dataSource[indexPath.row];
    
    cell.model=model;
    
    return cell.maxY;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.clicke) {
        WDF_Commont *model=self.dataSource[indexPath.row];
        self.clicke(model);
        
    }
    
}
#pragma mark =========================懒加载========================

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        [_tableView registerClass:[WDF_TableViewCell class] forCellReuseIdentifier:@"cell"];
        [self addRefreshControl];
        
    }
    return _tableView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc] init];
    }
    return _dataSource;
}


- (NSMutableArray *)allCommontSource{
    if (!_allCommontSource) {
        _allCommontSource=[[NSMutableArray alloc] init];
    }
    return _allCommontSource;
}

@end
