//
//  WDF_Collection_ViewController.m
//  100Movies_2.0//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_Collection_ViewController.h"
#import "WDF_Collaction_TableViewCell.h"
#import "WDF_Movie_Message_Model.h"
#import "WDF_MovieInfo_DataManager.h"

#import "WDF_Movie_message_ViewController.h"

@interface WDF_Collection_ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataSource;

@property(nonatomic,strong)NSMutableArray *allData;

@end

@implementation WDF_Collection_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title=@"收藏";
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(exitAction)];
    [self.view addSubview:self.tableView];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"清空" style:UIBarButtonItemStylePlain target:self action:@selector(removeAllData)];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:self.view.bounds];
    image.image = [UIImage imageNamed:@"collaction.jpg"];
    
    image.alpha= 0.8;
    self.tableView.alpha = 0.9;
    [self.view addSubview:self.tableView];
    [self.tableView setBackgroundView:image];
    
    [self.view addSubview:image];
    
}
- (void)viewWillAppear:(BOOL)animated{
    if (!_allData) {
        _allData=[[NSMutableArray alloc] init];
    }
    [_allData  addObjectsFromArray:[[WDF_MovieInfo_DataManager sharedManager] selectRecord]];
    [self.tableView reloadData];
}
// 清空收藏
- (void)removeAllData{
    
    UIAlertController *alter=[UIAlertController alertControllerWithTitle:@"清空" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *done=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        for ( WDF_Movie_Message_Model *model in self.dataSource) {
            [[WDF_MovieInfo_DataManager sharedManager] deleteRecord:model];
        }
        [self.dataSource removeAllObjects];
        [self.tableView reloadData];
    }];
    [alter addAction:done];
    [alter addAction:action];
    [self presentViewController:alter animated:YES completion:nil];
}
// 退出收藏
- (void)exitAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark =============================协议方法=============
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WDF_Collaction_TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    WDF_Movie_Message_Model *model=self.dataSource[indexPath.section];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=model;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WDF_Movie_message_ViewController *movieInfo=[[WDF_Movie_message_ViewController alloc] init];
    WDF_Movie_Message_Model *model=self.dataSource[indexPath.section];
    movieInfo.ID=model.id;
    movieInfo.tag=100;
    [self.navigationController pushViewController:movieInfo animated:YES];
}

// 删除操作
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WDF_Movie_Message_Model *model=self.dataSource[indexPath.section];
    
    [[WDF_MovieInfo_DataManager sharedManager] deleteRecord:model];
    
    
    [self.dataSource removeObjectAtIndex:indexPath.section];
    
    [self.tableView reloadData];
}



#pragma mark =========================懒加载==================
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        [_tableView registerClass:[WDF_Collaction_TableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
        [_dataSource addObjectsFromArray:_allData];
    }
    return _dataSource;
}

    
@end
