//
//  WDF_BaoyuPhoto_ViewController.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/14.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_BaoyuPhoto_ViewController.h"
#import "WDF_Baoyu_Photos_Model.h"

#import "UIImageView+WebCache.h"

@interface WDF_BaoyuPhoto_ViewController ()

@property (nonatomic, strong) UIImageView *moviePhoto;

@property (nonatomic, strong) UIButton *saveButton;

@end

@implementation WDF_BaoyuPhoto_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPage];
    [self.view addSubview:self.moviePhoto];
    [self.view addSubview:self.saveButton];
    [self.moviePhoto sd_setImageWithURL:[NSURL URLWithString:self.model.image]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 设置页面信息 */
- (void)setPage{
    
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark =============== setter ================
- (void)setModel:(WDF_Baoyu_Photos_Model *)model{
    _model = model;
    
    
    
}

#pragma mark =============== 弹窗 ================
- (void)openAlertWith:(NSString *)Msg with:(NSString *)Msg2{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"启奏皇上" message:Msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:Msg2 style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}


#pragma mark =============== 懒加载 ================
- (UIImageView *)moviePhoto{
    if (!_moviePhoto) {
        _moviePhoto = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _moviePhoto.contentMode = UIViewContentModeScaleAspectFit;
        _moviePhoto.layer.masksToBounds = YES;
    }
    return _moviePhoto;
}

- (UIButton *)saveButton{
    if (!_saveButton) {
        float butSc = 40 ;
        _saveButton = [[UIButton alloc] initWithFrame:CGRectMake(10, self.view.bounds.size.height - butSc - 10 , butSc, butSc)];
        [_saveButton setImage:[UIImage imageNamed:@"baoyusave"] forState:UIControlStateNormal];
        [_saveButton addTarget:self action:@selector(savePhoto:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}
- (void)savePhoto:(UIButton *)button{
    UIImageWriteToSavedPhotosAlbum(self.moviePhoto.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (!error) {
        [self openAlertWith:@"保存成功" with:@"朕知道了"];
        
    }else{
        [self openAlertWith:@"保存失败~" with:@"朕要斩了你！"];
    }
}


@end
