//
//  WDF_PhotoView.h
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/9.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;
@interface WDF_PhotoView : UIView

@property(nonatomic,copy) void (^clickPhoto)(NSString *);
@property (nonatomic,strong)MBProgressHUD *hud;
-(void)showHUD:(NSString *)title isDim:(BOOL)isDim;
-(void)showHUDComplete:(NSString *)title;
-(void)hideHUD;
@end
