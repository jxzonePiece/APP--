//
//  WDF_PhotoView.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/9.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_PhotoView.h"

#import "AFNetworking.h"

#import "WDF_PhotoModel.h"

#import "WDF_PhotoCollectionViewCell.h"

#import "MJRefresh.h"

#import "MBProgressHUD.h"

#import "UIImageView+WebCache.h"

#import "UIImage+MultiFormat.h"

#import "MBProgressHUD.h"

#import "AoiroSoraLayout.h"

#import "UIImage+MultiFormat.h"


@interface WDF_PhotoView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AoiroSoraLayoutDelegate>
{
    NSInteger _count;
    BOOL      _isRefresh; //表示是刷新还是上拉加载 YES:刷新  NO:加载
}
@property(nonatomic,strong) UICollectionView *collection;

@property(nonatomic,strong) NSMutableArray *dataSource;

@property(nonatomic,strong) NSMutableArray *movieID;
//存放所有图片的数组
@property(nonatomic,strong) NSMutableArray *imageArray;

@property(nonatomic,strong) UIImage *image;

@property (nonatomic,assign)NSInteger itemHeight;
@property (nonatomic,strong)NSMutableArray * heightArray;
@property (nonatomic,strong)NSMutableArray * modelArray;

@end

@implementation WDF_PhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor blackColor];
        [self addSubview:self.collection];
        [self loadMainData];
    }
    return self;
}

#pragma mark====================解析数据==================

-(void)loadMainData{
    _count=0;
    [self showHUD:@"正在加载数据..." isDim:NO];
    [self reloadData];
    self.heightArray = [NSMutableArray array];
    self.modelArray  = [NSMutableArray array];
}

-(void)reloadData{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    NSDictionary *parameters=@{@"type":@"movie",@"tag":@"高分",@"sort":@"recommend",@"page_limit":@"20",@"page_start":@(_count)};
    
    [manager GET:GaoPoint_path parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *allData=responseObject[@"subjects"];
        for (NSDictionary *dict in allData) {
            //获取电影的ID
            NSString *ID=dict[@"id"];
            
            [self preasePhoto:ID];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showHUDComplete:@"加载数据失败"];
        [self doneLoadData];
    }];
}

-(void)preasePhoto:(NSString *)ID{
    
    NSString *path=[NSString stringWithFormat:MOVIE_PHOTOS_PATH,ID];
    
    NSString *url2=[DOUBAN_BASE_PATH stringByAppendingString:path];
    
    NSString *pathUrl=[url2 stringByAppendingString:DOUBAN_APIKEY_BLACK_PRIVATE];
    
    NSURL * url = [NSURL URLWithString:pathUrl];
    
    // 创建请求对象
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask * dataTask = [[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        WDF_PhotoModel *model=[[WDF_PhotoModel alloc]initWithDictionary:dict error:nil];
        
            model.moviewID=ID;
        
        NSArray *arr=model.photos;
        NSString *str=arr.firstObject[@"image"];
        NSData *data2=[NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
        UIImage *image=[UIImage sd_imageWithData:data2];
        
        [self.imageArray addObject:image];
            
            [self.dataSource addObject:model];
        // 获取图片的高度并按比例压缩
        NSInteger itemHeight = image.size.height * (((self.frame.size.width - 20) / 2 / image.size.width));
        
        
        NSNumber * number = [NSNumber numberWithInteger:itemHeight];
        
        [self.heightArray addObject:number];
    
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self doneLoadData];
        });
    }];
    
     [dataTask resume]; // 开始请求
}

//数据加载完成
-(void)doneLoadData{
    //停止刷新
    [self.collection.header endRefreshing];
    //停止上拉刷新
    [self.collection.footer endRefreshing];
    
    //刷新表格
    [self.collection reloadData];
    
    [self hideHUD];
}

#pragma mark==============collectionView的相关协议============
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    WDF_PhotoCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    WDF_PhotoModel *model=self.dataSource[indexPath.row];
    
    cell.model=model;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    WDF_PhotoModel *model=self.dataSource[indexPath.row];
    if (self.clickPhoto) {
        self.clickPhoto(model.moviewID);
    }
}

//返回每个item的高度
- (CGFloat)itemHeightLayOut:(AoiroSoraLayout *)layOut indexPath:(NSIndexPath *)indexPath
{
    UIImage * image = self.imageArray[indexPath.row];
    return image.size.height * ((([UIScreen mainScreen].bounds.size.width-20)/2.0) / image.size.width);
}


#pragma mark==========刷新集成====================
-(void)addRefreshControl{
    //下拉刷新集成
    MJRefreshNormalHeader *header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        _isRefresh=YES;
        //刷新之前重置page
        _count=0;
        //重新加载数据
        [self reloadData];
        
    }];
    
    // 添加到tableView
    self.collection.header=header;
    
    //上拉刷新加载集成
    MJRefreshAutoNormalFooter *footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _count+=20;
        _isRefresh=NO;
        [self reloadData];
    }];
    self.collection.footer=footer;
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



#pragma mark=====================懒加载=================

-(UICollectionView *)collection{
    AoiroSoraLayout * layout = [[AoiroSoraLayout alloc]init];
    layout.interSpace = 10; // 每个item 的间隔
    layout.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.colNum = 2; // 列数;
    layout.delegate = self;
    
    if (!_collection) {
        _collection=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.frame)-49) collectionViewLayout:layout];
        _collection.delegate=self;
        _collection.dataSource=self;
    
        [self addRefreshControl];
        
        [_collection registerClass:[WDF_PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        _collection.backgroundColor=[UIColor blackColor];
        
    }
    return _collection;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc]init];
    }
    return _dataSource;
}

-(NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray=[[NSMutableArray alloc]init];
    }
    return _imageArray;
}

@end
