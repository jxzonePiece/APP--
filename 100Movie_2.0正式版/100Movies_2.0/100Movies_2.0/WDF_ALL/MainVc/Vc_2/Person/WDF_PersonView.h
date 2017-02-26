//
//  WDF_PersonView.h
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/9.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_RootView.h"

@class MBProgressHUD;
@interface WDF_PersonView : WDF_RootView

//设置bolck,传一个导演的ID
@property(nonatomic,copy) void (^clickPerson)(NSString *);

@property (nonatomic,strong)MBProgressHUD *hud;
-(void)showHUD:(NSString *)title isDim:(BOOL)isDim;
-(void)showHUDComplete:(NSString *)title;
-(void)hideHUD;

@end
