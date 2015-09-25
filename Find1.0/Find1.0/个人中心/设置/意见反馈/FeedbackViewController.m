//
//  FeedbackViewController.m
//  Find1.0
//
//  Created by APPLE on 15/9/17.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@property (nonatomic,strong)UITextView * contentTextView;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = BACKGROUND_PUPCOLOR;
    
    UIButton * backButton = [[UIButton alloc]initWithFrame:CGRectMake(15*WIDTH_LENTH, 25*HEIGHT_LENTH, 11*WIDTH_LENTH, 21*HEIGHT_LENTH)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(pressBackButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    //    名字文本
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100*HEIGHT_LENTH, 25*HEIGHT_LENTH, 175*HEIGHT_LENTH,30*HEIGHT_LENTH)];
    titleLabel.text = @"意见反馈";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20 * HEIGHT_LENTH];
    titleLabel.textAlignment = YES;
    [self.view addSubview:titleLabel];
    
    UILabel * tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(10*WIDTH_LENTH, 80*HEIGHT_LENTH, 365*WIDTH_LENTH, 25*HEIGHT_LENTH)];
    tipLabel.textAlignment= NSTextAlignmentLeft;
    tipLabel.text = @"您的宝贵意见是我们前进的动力哦:";
    tipLabel.textColor = MAIN_YELLOWCOLOR;
    tipLabel.font = [UIFont systemFontOfSize:16*WIDTH_LENTH];
    [self.view addSubview:tipLabel];
    
    self.contentTextView =[[UITextView alloc]initWithFrame:CGRectMake(10*WIDTH_LENTH, 110*HEIGHT_LENTH, 355*WIDTH_LENTH, 150*HEIGHT_LENTH)];
    self.contentTextView.layer.borderColor = MAIN_YELLOWCOLOR.CGColor;
    self.contentTextView.backgroundColor = BACKGROUND_PUPCOLOR;
    self.contentTextView.layer.borderWidth = 0.5;
    self.contentTextView.textColor = [UIColor whiteColor];
    self.contentTextView.layer.cornerRadius = 8 * WIDTH_LENTH;
    self.contentTextView.font = [UIFont systemFontOfSize:18*WIDTH_LENTH];
    [self.view addSubview:self.contentTextView];
    
    
    UIButton * sendMessageButton = [[UIButton alloc]initWithFrame:CGRectMake(10*WIDTH_LENTH, 290*HEIGHT_LENTH, 355*WIDTH_LENTH, 40*HEIGHT_LENTH)];
    [sendMessageButton setBackgroundImage:[UIImage imageNamed:@"发送信息.png"] forState:UIControlStateNormal];
    [sendMessageButton addTarget:self action:@selector(pressSendMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendMessageButton];

    
}


- (void)pressBackButton{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pressSendMessage{
    if (![self.contentTextView.text  isEqual: @""]) {
        TAlertView * tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"发送成功!"];
        tipsView.timeToClose = 1;
        [tipsView show];
    }else{
        TAlertView * tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"内容不能为空!"];
        tipsView.timeToClose = 1;
        [tipsView show];
    }

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
