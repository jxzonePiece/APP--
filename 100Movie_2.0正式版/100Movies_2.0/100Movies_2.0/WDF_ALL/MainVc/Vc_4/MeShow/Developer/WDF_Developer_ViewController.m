//
//  WDF_Developer_ViewController.m
//  100Movies_2.0
//
//  Created by qianfeng on 16/1/13.
//  Copyright © 2016年 WDF. All rights reserved.
//

#import "WDF_Developer_ViewController.h"

@interface WDF_Developer_ViewController ()

@property(nonatomic,strong)UILabel *desc;

@end

@implementation WDF_Developer_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIImageView *im=[[UIImageView alloc] initWithFrame:self.view.bounds];
    im.image=[UIImage imageNamed:@"shits.jpg"];
    im.alpha=0.4;
    [self.view addSubview:im];
    [self.view bringSubviewToFront:im];
    
    
    UIScrollView *sc=[[UIScrollView alloc] initWithFrame:CGRectMake(15, 20, SCREEN_WIDTH-30, SCREEN_HEIGHT-49-64-40)];
    
    sc.contentSize=CGSizeMake(SCREEN_WIDTH-40, 450);
    
    [self.view addSubview:sc];
    sc.alpha=0.7;
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(exitAction)];
    self.desc.text=@"从前...有个国王为他的公主举办宴会\n有个卫兵见到公主走过\n她实在太美了 他立刻坠入情网\n但是卑微的士兵 哪配得上公主?\n后来 他终于有机会告诉她 他不能没有她\n公主深深受到感动 她告诉士兵\n“你如果连续100个昼夜 都守在我的阳台下 我就以心相许”\n于是 士兵去等了1天...2天 10天 20天\n每晚公主都看到他在窗外等着\n刮风下雨 他都等着\n小鸟在他头上歇脚 蜜蜂也去蜇他 他还是不动\n90天过去了 他已经变得苍白虚弱\n双眼不听使唤...流下泪来 甚至睡觉的力气也没有了\n这一切都看在公主眼里\n到了第99夜 士兵起身 搬起椅子...走了\n     ------------《一呼百影》今日启程";
    
    self.desc.frame=CGRectMake(0, 0, sc.bounds.size.width, sc.contentSize.height);
    
    [sc addSubview:self.desc];

    
}
- (void)exitAction{
    [self.navigationController popViewControllerAnimated:YES];
}


- (UILabel *)desc{
    if (!_desc) {
        _desc=[[UILabel alloc] init];
//        _desc.layer.cornerRadius=8;
//        _desc.layer.borderColor=[UIColor purpleColor].CGColor;
//        _desc.layer.borderWidth=1;
        _desc.backgroundColor=[UIColor whiteColor];
        _desc.textAlignment=NSTextAlignmentCenter;
//        _desc.alpha=0.7;
        _desc.textColor=[UIColor blackColor];
    
        _desc.numberOfLines=0;
       
        
    }
    return _desc;
}









@end
