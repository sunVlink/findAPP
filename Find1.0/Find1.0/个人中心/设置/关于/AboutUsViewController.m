//
//  AboutUsViewController.m
//  Find1.0
//
//  Created by APPLE on 15/9/17.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = BACKGROUND_PUPCOLOR;
    
    UIButton * backButton = [[UIButton alloc]initWithFrame:CGRectMake(15*WIDTH_LENTH, 35*HEIGHT_LENTH, 11*WIDTH_LENTH, 21*HEIGHT_LENTH)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(pressBackButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    //    名字文本
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100*HEIGHT_LENTH, 35*HEIGHT_LENTH, 175*HEIGHT_LENTH,30*HEIGHT_LENTH)];
    titleLabel.text = @"关于";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20 * HEIGHT_LENTH];
    titleLabel.textAlignment = YES;
    [self.view addSubview:titleLabel];
    
    
    UIImageView * logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(150*WIDTH_LENTH, 130*HEIGHT_LENTH, 75*WIDTH_LENTH, 75*WIDTH_LENTH)];
    [logoImageView setImage:[UIImage imageNamed:@"icon.png"]];
    [self.view addSubview:logoImageView];
    
    
    UITextView * contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(13 * WIDTH_LENTH, 230* HEIGHT_LENTH, Screen_width - 20 * WIDTH_LENTH, 300 * HEIGHT_LENTH)];
    contentTextView.backgroundColor = BACKGROUND_PUPCOLOR;
    contentTextView.textColor = MAIN_YELLOWCOLOR;
    contentTextView.font = [UIFont systemFontOfSize:18*WIDTH_LENTH];
    contentTextView.textAlignment = NSTextAlignmentLeft;
    contentTextView.text = @"太阳系全体居民强烈推荐的一款图片弹幕社交软件完美兼容各个次元，完美适配吐槽达人、点赞狂魔或是晒图小公举最酷最in的图片“弹幕”哟！";
    contentTextView.userInteractionEnabled = NO;
    [self.view addSubview:contentTextView];
    
}

- (void)pressBackButton{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
