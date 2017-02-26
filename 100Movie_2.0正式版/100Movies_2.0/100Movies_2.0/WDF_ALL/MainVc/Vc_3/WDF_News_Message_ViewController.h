//
//  WDF_News_Message_ViewController.h
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_Root_ViewController.h"
@class MBProgressHUD;
@interface WDF_News_Message_ViewController : WDF_Root_ViewController
@property (nonatomic,strong)MBProgressHUD *hud;

-(void)showHUD:(NSString *)title isDim:(BOOL)isDim;
-(void)showHUDComplete:(NSString *)title;
-(void)hideHUD;
@end
