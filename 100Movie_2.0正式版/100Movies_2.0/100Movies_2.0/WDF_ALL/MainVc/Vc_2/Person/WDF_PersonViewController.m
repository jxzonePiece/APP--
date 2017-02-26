//
//  WDF_PersonViewController.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_PersonViewController.h"
#import "AFNetworking.h"
#import "WDF_PersonModel.h"
#import "WDF_PersonMainTableViewCell.h"
#import "WDF_workTableViewCell.h"
#import "MBProgressHUD.h"
#import "WDF_Movie_message_ViewController.h"

@interface WDF_PersonViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation WDF_PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"作品展示";
    [self showHUD:@"正在加载数据..." isDim:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_2.jpg"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent=NO;
    self.view.backgroundColor=RGB(238/255.f, 238/255.f, 238/255.f, 1);
    [self reloadMainData];
    [self.view addSubview:self.tableView];
   
}

-(void)reloadMainData{
    [self reloadData];
}


-(void)reloadData{
    
    //拼接请求地址
    NSString *url1=[NSString stringWithFormat:CELEBRITY_PATH,self.Did];
    
    NSString *url2=[url1 stringByAppendingString:DOUBAN_APIKEY_BLACK_PRIVATE];
    NSString *url3=[DOUBAN_BASE_PATH stringByAppendingString:url2];
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    [manager GET:url3 parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        WDF_PersonModel *model=[[WDF_PersonModel alloc]initWithDictionary:responseObject error:nil];
        
        [self.dataSource addObject:model];
        [self.tableView reloadData];
        [self hideHUD];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showHUDComplete:@"加载数据失败"];
    }];
    
}
#pragma mark==============tableView的相关协议方法====================
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    WDF_PersonModel *model=self.dataSource.firstObject;
    
    return model.works.count+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        WDF_PersonMainTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"titleCell"];
        cell.model=self.dataSource.firstObject;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
    }
        
        WDF_workTableViewCell *workCell=[tableView dequeueReusableCellWithIdentifier:@"workCell"];
        workCell.row=indexPath.row-1;
        workCell.model=self.dataSource.firstObject;
        workCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        workCell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return workCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row>0){
    WDF_Movie_message_ViewController *moview=[[WDF_Movie_message_ViewController alloc]init];
    WDF_PersonModel *model=self.dataSource.firstObject;
    NSDictionary *dic=model.works[indexPath.row-1];
    
    NSDictionary *subject=dic[@"subject"];
    
    moview.ID=subject[@"id"];
    NSLog(@"%zd",subject[@"id"]);
    [self.navigationController pushViewController:moview animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        return 150;
    }else{
        return 100;
    }
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark===============懒加载===================

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-69) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        //注册cell
        [_tableView registerClass:[WDF_PersonMainTableViewCell class] forCellReuseIdentifier:@"titleCell"];
        
        [_tableView registerClass:[WDF_workTableViewCell class] forCellReuseIdentifier:@"workCell"];
    }
    return _tableView;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc]init];
        
    }
    return _dataSource;
}

@end
