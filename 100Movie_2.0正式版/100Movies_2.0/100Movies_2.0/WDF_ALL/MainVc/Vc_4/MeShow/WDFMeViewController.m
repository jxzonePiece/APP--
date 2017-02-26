//
//  WDFMeViewController.m
//  100MovieByWDF
//
//  Created by qianfeng on 16/1/7.
//  Copyright © 2016年 WDF. All rights reserved.
//
// 张继新test
//
#import "WDFMeViewController.h"
#import "WDF_Collection_ViewController.h"
#import "WDF_setStyle_ViewController.h"

#import "WDF_ShitsOur_ViewController.h"

#import "WDF_Developer_ViewController.h"

#import "WDF_Me_TableViewCell.h"
#import "WDF_MeModel.h"
@interface WDFMeViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>


// 界面展示
@property(nonatomic,strong)UITableView *tableView;

// 数据源数据
@property(nonatomic,strong)NSArray *dataSource;

// 头视图
@property(nonatomic,strong)UIView *headerView;

// 头像
@property(nonatomic, strong)UIImageView *icon;

@end

@implementation WDFMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 添加tableView
    
    [self loadeData];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"me.jpg"]];

    [self.view addSubview:image];
    [self.view addSubview:self.tableView];
    
    self.tableView.alpha=0.85;
    
    
    

}
- (void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *defults=[NSUserDefaults standardUserDefaults];
    NSData *imageData=[defults dataForKey:@"image"];
    if (imageData==nil) {
        self.icon.image=[UIImage imageNamed:@"base.jpg"];
    }else{
        self.icon.image=[UIImage imageWithData:imageData];
    }

}

#pragma mark===================tableView协议方法=========
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
// 每一行显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WDF_Me_TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *dic=self.dataSource[indexPath.row];
    
    WDF_MeModel *model=[[WDF_MeModel alloc] init];
    model.name=dic[@"name"];
    model.icon=dic[@"icon"];
    cell.model=model;

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
   
 
    return cell;
}
// 没一行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

// 选中回调
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            WDF_Collection_ViewController *collection=[[WDF_Collection_ViewController alloc] init];
            [self.navigationController pushViewController:collection animated:YES];
            break;
        }
//        case :{
//            WDF_setStyle_ViewController *setStyle=[[WDF_setStyle_ViewController alloc] init];
//            [self.navigationController pushViewController:setStyle animated:YES];
//            break;
//        }
        case 1:{
            WDF_Developer_ViewController *developer=[[WDF_Developer_ViewController alloc] init];
            [self.navigationController pushViewController:developer animated:YES];
            break;
        }
        case 2:{
            WDF_ShitsOur_ViewController *shits=[[WDF_ShitsOur_ViewController alloc] init];
            [self.navigationController pushViewController:shits animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark=======================懒加载================
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        // 添加一个头视图
        _tableView.tableHeaderView=self.headerView;
        // 注册事件
        [_tableView registerClass:[WDF_Me_TableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (void)loadeData{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Me" ofType:@"plist"];

    self.dataSource=[NSArray arrayWithContentsOfFile:path];
}
// 头视图
- (UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2.f+10)];
        _headerView.userInteractionEnabled=YES;
        
    }
    return _headerView;
}
// 头像
- (UIImageView *)icon{
    if (!_icon) {
        _icon=[[UIImageView alloc] initWithFrame:self.headerView.bounds];
        _icon.userInteractionEnabled=YES;
        [_icon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
        
        [self.headerView addSubview:_icon];
    }
    return _icon;
}
#pragma mark ===============================添加头像事件=======================
- (void)tapAction:(UITapGestureRecognizer *)tap{
    // UIImagePickerController 来实现相册
    // 1. 实例化对象
    UIImagePickerController *picker=[[UIImagePickerController alloc] init];
    
    UIAlertController *alter=[UIAlertController alertControllerWithTitle:@"选择头像来源" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate=self;
        [self presentViewController:picker animated:YES completion:nil];
    }];
    UIAlertAction *done=[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.allowsEditing = YES;
            picker.delegate=self;
            [self presentViewController:picker animated:YES completion:nil];
            
        }else{
            UIAlertView *aleter=[[UIAlertView alloc] initWithTitle:nil message:@"相机不可用,从图库选择" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles: nil];
            [aleter show];
            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            picker.allowsEditing = YES;
            picker.delegate=self;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }];
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alter addAction:done];
    [alter addAction:action];
    [alter addAction:cancel];
    [self presentViewController:alter animated:YES completion:nil];
    
   
}

#pragma mark =================图片的协议方法===========
// 选择图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image=info[UIImagePickerControllerOriginalImage];
    NSUserDefaults *defaultes=[NSUserDefaults standardUserDefaults];

    // 把选取的照片先本地存储
    NSData *imageData=UIImageJPEGRepresentation(image, 100);
    [defaultes setObject:imageData forKey:@"image"];
    [defaultes synchronize];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//取消选择
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


@end
