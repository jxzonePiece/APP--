//
//  WDF_ShitsOur_ViewController.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/13.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_ShitsOur_ViewController.h"
@interface WDF_ShitsOur_ViewController ()
{
    NSString *_string;
}
@property(nonatomic,strong)UILabel *label;


@end

@implementation WDF_ShitsOur_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
    UIBarButtonItem *fabiao=[[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(doneAction)];
    
    UIBarButtonItem *allDelte=[[UIBarButtonItem alloc] initWithTitle:@"清空" style:UIBarButtonItemStylePlain target:self action:@selector(doneAction)];
    self.navigationItem.rightBarButtonItems=@[allDelte,fabiao];
    
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(exitAction)];
    [self createImageView];
    
    
    [self creatAlter];
    [self label];
    
}
- (void)exitAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    [self creatAlter];
    
    
}
- (void)doneAction{
    UIAlertController *alter=[UIAlertController alertControllerWithTitle:@"发表说说" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *done=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        self.label.text=@"";
        
        UIAlertView *alters=[[UIAlertView alloc] initWithTitle:nil message:@"发表成功" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alters show];
        
    }];
    
    [alter addAction:done];
    [alter addAction:action];
    [self presentViewController:alter animated:YES completion:nil];
}
- (void)createImageView{
    UIImageView *im=[[UIImageView alloc] initWithFrame:self.view.bounds];
    im.image=[UIImage imageNamed:@"shitess.jpg"];
    im.alpha=0.4;
    [self.view addSubview:im];
    [self.view bringSubviewToFront:im];
}

- (void)creatAlter{
    UIAlertController *alter=[UIAlertController alertControllerWithTitle:@"发表说说" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    UIAlertAction *done=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        NSArray *texts=alter.textFields;
        UITextField *text=texts.firstObject;
        self.label.text=text.text;
        
        
    }];
    [alter addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"请输入内容";
        textField.clearButtonMode = UITextFieldViewModeAlways;
    }];
    [alter addAction:done];
    [alter addAction:action];
    [self presentViewController:alter animated:YES completion:nil];
}
- (UILabel *)label{
    if (!_label) {
        _label=[[UILabel alloc] initWithFrame:CGRectMake(50, 50, SCREEN_WIDTH-100, 70)];
        _label.layer.borderWidth=1.5f;
        _label.layer.borderColor=[UIColor orangeColor].CGColor;
        _label.layer.cornerRadius=8.f;
        _label.numberOfLines=0;
        _label.textAlignment=NSTextAlignmentLeft;
        [self.view addSubview:_label];
    }
    return _label;
    
}


@end

