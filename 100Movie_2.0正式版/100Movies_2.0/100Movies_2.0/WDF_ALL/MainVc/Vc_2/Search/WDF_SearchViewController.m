//
//  WDF_SearchViewController.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/14.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_SearchViewController.h"

#import "AFNetworking.h"

#import "WDF_SearchModel.h"

#import "WDF_SrarchTableViewCell.h"

#import "WDF_Movie_message_ViewController.h"

@interface WDF_SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UITextFieldDelegate>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSMutableArray *dataSource;

@property(nonatomic,strong) UISearchController * search;

@end

@implementation WDF_SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.title=@"搜索";
    
    [self search];
}

-(void)viewWillAppear:(BOOL)animated{
    self.search.searchBar.hidden=NO;
    self.search.active=NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.search.searchBar.hidden=YES;
    [self.search.searchBar resignFirstResponder];
    self.search.active=NO;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.search.searchBar resignFirstResponder];
}

#pragma mark=================tableView的协议方法=============

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WDF_SrarchTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    WDF_SearchModel *model=self.dataSource[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=model;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.search resignFirstResponder];
    self.search.active=NO;
    
    WDF_Movie_message_ViewController *message=[[WDF_Movie_message_ViewController alloc]init];
    WDF_SearchModel *model=self.dataSource[indexPath.row];
    message.ID=model.id;
    [self.navigationController pushViewController:message animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_WIDTH/3.5f*5/3;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"9621544");
    return YES;
}

//搜索事件
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    if(self.search.searchBar.text==nil||[self.search.searchBar.text isEqualToString:@""]){
//         [self alertController];
    }else{
        
    NSString * urlString = [self.search.searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *path=[NSString stringWithFormat:SERARCH_PATH,urlString];
    NSString *url=[DOUBAN_BASE_PATH stringByAppendingString:path];
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.dataSource removeAllObjects];
       NSInteger count= [responseObject[@"total"] integerValue];
        if (count==0) {
           
        }else{
        NSArray *array=responseObject[@"subjects"];
        for (NSDictionary *dict in array) {
            WDF_SearchModel *model=[[WDF_SearchModel alloc]initWithDictionary:dict error:nil];
            [self.dataSource addObject:model];
        }
        [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    }
    
}

-(void)alertController{

    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"信息" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionDone=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:actionDone];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

#pragma mark===============懒加载================

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerClass:[WDF_SrarchTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc]init];
    }
    return _dataSource;
}

-(UISearchController *)search{
    if (!_search) {
        _search=[[UISearchController alloc]initWithSearchResultsController:nil];
        _search.dimsBackgroundDuringPresentation=NO;
        _search.hidesNavigationBarDuringPresentation=NO;
        //是否搜索相关
        _search.searchResultsUpdater=self;
        _search.searchBar.frame=CGRectMake(0, 0, 0, 44);
        _tableView.tableHeaderView=_search.searchBar;
    }
    return _search;
}



@end
