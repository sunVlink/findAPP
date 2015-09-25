//
//  PhoneBindViewController.m
//  SquareDemo1.1
//
//  Created by APPLE on 15/7/9.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "PhoneBindViewController.h"

@interface PhoneBindViewController ()
{
    UIAlertView * _alterView;
    
    UIButton * _getCodeButton;
    int a ;
}
@property (nonatomic,strong)UITextField * phoneTextField;
@property (nonatomic,strong)TAlertView * tipsView;

@end

@implementation PhoneBindViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView * backGroundView = [[UIImageView alloc]initWithFrame:self.view.frame];
    [backGroundView setImage:[UIImage imageNamed:@"背景.png"]];
    backGroundView.userInteractionEnabled = YES;
    [self.view addSubview:backGroundView];
    
    UIButton * backButton = [[UIButton alloc]initWithFrame:CGRectMake(15*WIDTH_LENTH, 35*HEIGHT_LENTH, 11*WIDTH_LENTH, 21*HEIGHT_LENTH)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(pressBackButton) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:backButton];
    
    UILabel * phoneBind = [[UILabel alloc]initWithFrame:CGRectMake(100*WIDTH_LENTH, 35*HEIGHT_LENTH, 175*WIDTH_LENTH, 21*HEIGHT_LENTH)];
    phoneBind.text = @"绑定手机";
    phoneBind.font = [UIFont systemFontOfSize:20*HEIGHT_LENTH];
    phoneBind.textAlignment = YES;
    phoneBind.textColor = MAIN_YELLOWCOLOR;
    [backGroundView addSubview:phoneBind];
    
    
    UIImageView * phoneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30*WIDTH_LENTH, 154*HEIGHT_LENTH, 12*WIDTH_LENTH, 17*HEIGHT_LENTH)];
    [phoneImageView setImage:[UIImage imageNamed:@"手机，W24,H34.png"]];
    [backGroundView addSubview:phoneImageView];
    
    
    UIButton * cleanButton = [[UIButton alloc]initWithFrame:CGRectMake(343*WIDTH_LENTH, 155*HEIGHT_LENTH, 15*WIDTH_LENTH, 15*HEIGHT_LENTH)];
    [cleanButton setBackgroundImage:[UIImage imageNamed:@"删除，W30，H30.png"] forState:UIControlStateNormal];
    [cleanButton addTarget:self action:@selector(pressCleanButton) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:cleanButton];
    
    
    self.phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(45*WIDTH_LENTH, 147*HEIGHT_LENTH, 295*WIDTH_LENTH, 30*HEIGHT_LENTH)];
    self.phoneTextField.borderStyle = UITextBorderStyleNone;
    self.phoneTextField.placeholder = @"请输入手机号码：";
    //    设置填出键盘的样式
    self.phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    [backGroundView addSubview:self.phoneTextField];
    
    UIImageView * lineOne = [[UIImageView alloc]initWithFrame:CGRectMake(10*WIDTH_LENTH, 178*HEIGHT_LENTH, self.view.frame.size.width - 10*2*WIDTH_LENTH ,1)];
    [lineOne setImage:[UIImage imageNamed:@"底线，W710，H1.png"]];
    [backGroundView addSubview:lineOne];
    
    UIImageView * passwordImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30*WIDTH_LENTH, 201*HEIGHT_LENTH, 13*WIDTH_LENTH, 17*HEIGHT_LENTH)];
    [passwordImageView setImage:[UIImage imageNamed:@"密码，W27H35.png"]];
    [backGroundView addSubview:passwordImageView];
    
    
    UITextField * codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(45*WIDTH_LENTH, 193*HEIGHT_LENTH, 200*WIDTH_LENTH, 30*WIDTH_LENTH)];
    codeTextField.borderStyle = UITextBorderStyleNone;
    codeTextField.placeholder = @"请输入验证码：";
    [backGroundView addSubview:codeTextField];
    
    _getCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(260*WIDTH_LENTH, 193*HEIGHT_LENTH, 100*WIDTH_LENTH, 30*HEIGHT_LENTH)];
    _getCodeButton.layer.cornerRadius = 5 * WIDTH_LENTH;
    _getCodeButton.titleLabel.font = [UIFont systemFontOfSize:18*WIDTH_LENTH];
    _getCodeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getCodeButton addTarget:self action:@selector(pressCodeButton) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:_getCodeButton];
    
    
    UIImageView * lineTwo = [[UIImageView alloc]initWithFrame:CGRectMake(10*WIDTH_LENTH, 225*HEIGHT_LENTH, self.view.frame.size.width - 10*2*WIDTH_LENTH ,1)];
    [lineTwo setImage:[UIImage imageNamed:@"底线，W710，H1.png"]];
    [backGroundView addSubview:lineTwo];
    
    UIButton * nextButton = [[UIButton alloc]initWithFrame:CGRectMake(10*WIDTH_LENTH, 470*HEIGHT_LENTH, 355*WIDTH_LENTH, 40*HEIGHT_LENTH)];
    [nextButton setTitle:@"确定" forState:UIControlStateNormal];
    nextButton.titleLabel.tintColor = MAIN_YELLOWCOLOR;
    [nextButton setBackgroundImage:[UIImage imageNamed:@"圆角矩形 5.png"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(pressNextButton) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:nextButton];
    
    

}


- (void)pressCleanButton{
    
_phoneTextField.text = @"";

}


- (void)pressCodeButton{
    
    if ([_phoneTextField.text isEqual:@""]) {
        NSLog(@"请输入手机号！");
    }else{
    
        //请求地址
        NSString * methodStr = @"user/getRegCode.cmd";
        //向后台请求提交的参数
        NSDictionary *parmasDic = @{@"phoneNumber":_phoneTextField.text};
        
        [WebRequest webRequestWithURLMethod:methodStr parmas:parmasDic success:^(id result) {
            /*
             请求返回数据
             */
            
            _getCodeButton.selected = YES;
            _getCodeButton.userInteractionEnabled = NO;
            a = 60;
            [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(performDismiss) userInfo:nil repeats:YES];
            
            self.tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"验证码已发送，请注意查收！"];
            self.tipsView.timeToClose = 1;
            [self.tipsView show];
            
        }fail:^(NSString *result) {
            self.tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"网络错误！"];
            self.tipsView.timeToClose = 1;
            [self.tipsView show];
        }];
    }
  
}

- (void)performDismiss{
    a--;
    [_getCodeButton setTitle:[NSString stringWithFormat:@"( %d )",a] forState:UIControlStateSelected];
    if (a < 0) {
        _getCodeButton.selected = NO;
        _getCodeButton.userInteractionEnabled = YES;
    }
    
}


- (void)pressNextButton{

}


- (void)pressBackButton{

    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}





@end
