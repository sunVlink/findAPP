//
//  SettingViewController.m
//  Find1.0
//
//  Created by APPLE on 15/9/16.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutUsViewController.h"
#import "NoviceTutorialViewController.h"
#import "FeedbackViewController.h"
#import "WdCleanCaches.h"

@interface SettingViewController ()<UIAlertViewDelegate>
@property (nonatomic,strong)UILabel * cacheLabel;
@property (nonatomic,strong)UILabel * editionLabel;
@property (nonatomic,strong)NSString * cleanPath;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = BACKGROUND_PUPCOLOR;
    
    self.cleanPath = [WdCleanCaches CachesDirectory];
    
    
    UIButton * backButton = [[UIButton alloc]initWithFrame:CGRectMake(15*WIDTH_LENTH, 35*HEIGHT_LENTH, 11*WIDTH_LENTH, 21*HEIGHT_LENTH)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(pressBackButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];

    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100*WIDTH_LENTH, 35*WIDTH_LENTH, 175*WIDTH_LENTH, 20*WIDTH_LENTH)];
    titleLabel.textAlignment = YES;
    titleLabel.text = @"系统设置";
    titleLabel.font = [UIFont systemFontOfSize:18*WIDTH_LENTH];
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    
    NSArray * titleArr = [[NSArray alloc]initWithObjects:@"清除缓存",@"关于",@"意见反馈",@"新手教程",@"版本号",@"检查跟新", nil];
    
    for (int i = 0; i < 6; i++) {
        UIImageView * lineView = [[UIImageView alloc]initWithFrame:CGRectMake(5*WIDTH_LENTH, (150 + i * 50)*WIDTH_LENTH, 365*WIDTH_LENTH, 1)];
        lineView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
        [self.view addSubview:lineView];
        
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10*WIDTH_LENTH, (117 + i * 50)*WIDTH_LENTH, 100*WIDTH_LENTH, 20*WIDTH_LENTH)];
        titleLabel.text = titleArr[i];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:16*WIDTH_LENTH];
        titleLabel.textColor = [UIColor colorWithRed:73/255.0 green:135/255.0 blue:176/255.0 alpha:1];
        [self.view addSubview:titleLabel];
        
        if (i == 0){
            self.cacheLabel = [[UILabel alloc]initWithFrame:CGRectMake(215*WIDTH_LENTH, (117 + i * 50)*WIDTH_LENTH, 150 * WIDTH_LENTH, 20 * WIDTH_LENTH)];
            NSString * contentStr = [NSString new];
            if ([WdCleanCaches sizeWithFilePaht:self.cleanPath] < 1024) {
               contentStr = [NSString stringWithFormat:@"%0.2fMB",[WdCleanCaches sizeWithFilePaht:self.cleanPath]];
            }else{
               contentStr = [NSString stringWithFormat:@"%0.2fG",[WdCleanCaches sizeWithFilePaht:self.cleanPath]/1024.0];
            }
            self.cacheLabel.text = contentStr;
            self.cacheLabel.textAlignment = NSTextAlignmentRight;
            self.cacheLabel.textColor = [UIColor whiteColor];
            self.cacheLabel.font = [UIFont systemFontOfSize:16*WIDTH_LENTH];
            [self.view addSubview:self.cacheLabel];
            
        }else if (i == 4){
            self.editionLabel = [[UILabel alloc]initWithFrame:CGRectMake(215*WIDTH_LENTH, (117 + i * 50)*WIDTH_LENTH, 150 * WIDTH_LENTH, 20 * WIDTH_LENTH)];
            self.editionLabel.text = @"v1.0.0";
            self.editionLabel.textAlignment = NSTextAlignmentRight;
            self.editionLabel.textColor = [UIColor whiteColor];
            self.editionLabel.font = [UIFont systemFontOfSize:16*WIDTH_LENTH];
            [self.view addSubview:self.editionLabel];
        }else{
            UIImageView * rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(350*WIDTH_LENTH, (117 + i * 50)*WIDTH_LENTH, 11*WIDTH_LENTH, 18* WIDTH_LENTH)];
            [rightImageView setImage:[UIImage imageNamed:@"前进.png"]];
            [self.view addSubview:rightImageView];
        }

        if (i == 4) {
            
        }else{
        
            UIButton * chickButton = [[UIButton alloc]initWithFrame:CGRectMake(0, (100 + i * 50)*WIDTH_LENTH, Screen_width, 50*WIDTH_LENTH)];
            chickButton.tag = i;
            [chickButton addTarget:self action:@selector(pressChickButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:chickButton];
            
        }
        
    }
    
    UIButton * loginOutButton = [[UIButton alloc]initWithFrame:CGRectMake(10*WIDTH_LENTH, 580*HEIGHT_LENTH, 355*WIDTH_LENTH, 45*HEIGHT_LENTH)];
    loginOutButton.titleLabel.tintColor = MAIN_YELLOWCOLOR;
    [loginOutButton setBackgroundImage:[UIImage imageNamed:@"退出登录.png"] forState:UIControlStateNormal];
        [loginOutButton addTarget:self action:@selector(pressLoginOutButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginOutButton];

    
}

- (void)pressBackButton{

    [self.navigationController popViewControllerAnimated:YES];

}



- (void)pressChickButton:(UIButton *)sender{

    if (sender.tag == 0) {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"Tips:" message:@"您确认删除缓存吗？" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
        [alertView show];
    }
    
    if (sender.tag == 1) {
        AboutUsViewController * aboutUsVC = [AboutUsViewController new];
        [self.navigationController pushViewController:aboutUsVC animated:YES];
    }
    
    if (sender.tag == 2) {
        FeedbackViewController * feedbackVC = [FeedbackViewController new];
        [self.navigationController pushViewController:feedbackVC animated:YES];
    }
    
    if (sender.tag == 3) {
        NoviceTutorialViewController * noviceTutoriaVC = [NoviceTutorialViewController new];
        [self.navigationController pushViewController:noviceTutoriaVC animated:YES];
    }
    
    
    if (sender.tag == 5) {
        TAlertView * tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"您的App已经是最新版了!"];
        tipsView.timeToClose = 1;
        [tipsView show];
    }
    
    
}



- (void)pressLoginOutButton{
    
    
    //请求地址
    NSString * methodStr = @"user/visitor.cmd";
    //向后台请求提交的参数
    NSDictionary *parmasDic = @{@"isVisitor":@"1"};
    
    [WebRequest webRequestWithURLMethod:methodStr parmas:parmasDic success:^(id result) {
        /*
         请求返回数据
         */
    
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isTourist"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setObject:result forKey:@"userData"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        TAlertView * tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"注销成功!"];
        tipsView.timeToClose = 1;
        [tipsView show];
        
        [self.navigationController popToRootViewControllerAnimated:YES];

    }fail:^(NSString *result) {
        TAlertView * tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"注销失败!"];
        tipsView.timeToClose = 1;
        [tipsView show];
    }];

    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [WdCleanCaches clearCachesWithFilePath:self.cleanPath];
        [[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];
        self.cacheLabel.text = @"0.00MB";
        TAlertView * tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"清除缓存成功!"];
        tipsView.timeToClose = 1;
        [tipsView show];
        
    }else{
        NSLog(@"不清除缓存!");
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
