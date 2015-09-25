//
//  LoginController.m
//  SquareDemo1.1
//
//  Created by APPLE on 15/7/6.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "LoginController.h"
#import "SquareViewController.h"
#import "SginViewController.h"



@interface LoginController ()<UITextFieldDelegate>
{
    UITextField * _userPasswordTextField;
    UITextField * _userNameTextField;
    
    BOOL islook;
    
    UIAlertView * _alterView;
    NSString * alterContent;
    
    UIActivityIndicatorView * _actVC;   // 活动指示器
    
}

@property (nonatomic,strong)TAlertView * tipsView;


@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationController.navigationBarHidden = YES;

    UIImageView * backGroundView = [[UIImageView alloc]initWithFrame:self.view.frame];
    [backGroundView setImage:[UIImage imageNamed:@"背景.png"]];
    backGroundView.userInteractionEnabled = YES;
    [self.view addSubview:backGroundView];
    
    UIButton * backButton = [[UIButton alloc]initWithFrame:CGRectMake(15*WIDTH_LENTH, 35*HEIGHT_LENTH, 11*WIDTH_LENTH, 21*HEIGHT_LENTH)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(pressBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:backButton];
    
    UILabel * login = [[UILabel alloc]initWithFrame:CGRectMake(150*WIDTH_LENTH, 35*HEIGHT_LENTH, 75*WIDTH_LENTH, 21*HEIGHT_LENTH)];
    login.text = @"登录";
    login.font = [UIFont systemFontOfSize:20*HEIGHT_LENTH];
    login.textAlignment = YES;
    login.textColor = MAIN_YELLOWCOLOR;
    [backGroundView addSubview:login];
    
    
    UIImageView * phoneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30*WIDTH_LENTH, 154*HEIGHT_LENTH, 12*WIDTH_LENTH, 17*HEIGHT_LENTH)];
    [phoneImageView setImage:[UIImage imageNamed:@"手机，W24,H34.png"]];
    [backGroundView addSubview:phoneImageView];
    
    
    UIButton * cleanButton = [[UIButton alloc]initWithFrame:CGRectMake(343*WIDTH_LENTH, 155*HEIGHT_LENTH, 15*WIDTH_LENTH, 15*HEIGHT_LENTH)];
    [cleanButton setBackgroundImage:[UIImage imageNamed:@"删除，W30，H30.png"] forState:UIControlStateNormal];
    [cleanButton addTarget:self action:@selector(pressCleanButton) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:cleanButton];
    
    
    _userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(45*WIDTH_LENTH, 147*HEIGHT_LENTH, 295*WIDTH_LENTH, 30*HEIGHT_LENTH)];
    _userNameTextField.borderStyle = UITextBorderStyleNone;
    _userNameTextField.placeholder = @"请输入手机号码：";
//    设置填出键盘的样式
    _userNameTextField.keyboardType = UIKeyboardTypePhonePad;
    _userNameTextField.textAlignment = YES;
    _userNameTextField.delegate = self;
    [backGroundView addSubview:_userNameTextField];
    
    UIImageView * lineOne = [[UIImageView alloc]initWithFrame:CGRectMake(10*WIDTH_LENTH, 178*HEIGHT_LENTH, self.view.frame.size.width - 10*2*WIDTH_LENTH ,1)];
    [lineOne setImage:[UIImage imageNamed:@"底线，W710，H1.png"]];
    [backGroundView addSubview:lineOne];
    
    UIImageView * passwordImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30*WIDTH_LENTH, 201*HEIGHT_LENTH, 13*WIDTH_LENTH, 17*HEIGHT_LENTH)];
    [passwordImageView setImage:[UIImage imageNamed:@"密码，W27H35.png"]];
    [backGroundView addSubview:passwordImageView];
    
    
    UIButton * lookButton = [[UIButton alloc]initWithFrame:CGRectMake(343*WIDTH_LENTH, 203*HEIGHT_LENTH, 15*WIDTH_LENTH, 12*HEIGHT_LENTH)];
    [lookButton setBackgroundImage:[UIImage imageNamed:@"显示，W30,H24.png"] forState:UIControlStateNormal];
     [lookButton addTarget:self action:@selector(pressLookButton) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:lookButton];
    
     _userPasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(45*WIDTH_LENTH, 193*HEIGHT_LENTH, 295*WIDTH_LENTH, 30*WIDTH_LENTH)];
    _userPasswordTextField.borderStyle = UITextBorderStyleNone;
    _userPasswordTextField.placeholder = @"请输入手密码：";
    _userPasswordTextField.secureTextEntry = YES;
    _userPasswordTextField.textAlignment = YES;
//    _userPasswordTextField.delegate = self;
    [backGroundView addSubview:_userPasswordTextField];
    
    
    UIImageView * lineTwo = [[UIImageView alloc]initWithFrame:CGRectMake(10*WIDTH_LENTH, 225*HEIGHT_LENTH, self.view.frame.size.width - 10*2*WIDTH_LENTH ,1)];
    [lineTwo setImage:[UIImage imageNamed:@"底线，W710，H1.png"]];
    [backGroundView addSubview:lineTwo];
    
    
    
    UIButton * loginButton = [[UIButton alloc]initWithFrame:CGRectMake(10*WIDTH_LENTH, 288*HEIGHT_LENTH, 355*WIDTH_LENTH, 45*HEIGHT_LENTH)];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"登录，W710，H90.png"] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(pressLoginButton) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:loginButton];
    
    
    UIButton * newsignButton = [[UIButton alloc]initWithFrame:CGRectMake(10*WIDTH_LENTH, 343*HEIGHT_LENTH, 100*WIDTH_LENTH, 30*HEIGHT_LENTH)];
    [newsignButton addTarget:self action:@selector(pressNewSignButton) forControlEvents:UIControlEventTouchUpInside];
    [newsignButton setTitle:@"新用户注册" forState:UIControlStateNormal];
    [newsignButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    newsignButton.titleLabel.font = [UIFont systemFontOfSize:18*WIDTH_LENTH];
    newsignButton.tag = 1001;
    [backGroundView addSubview:newsignButton];

    UIButton * forgetPasswordButton = [[UIButton alloc]initWithFrame:CGRectMake(265*WIDTH_LENTH, 343*HEIGHT_LENTH, 100*WIDTH_LENTH, 30*HEIGHT_LENTH)];
//    [forgetPasswordButton addTarget:self action:@selector(pressForgetPasswordButton) forControlEvents:UIControlEventTouchUpInside];
     [forgetPasswordButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:18*WIDTH_LENTH];
    forgetPasswordButton.tag = 1002;
    [backGroundView addSubview:forgetPasswordButton];

    
    UILabel * loginTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(87.5*WIDTH_LENTH, 399*HEIGHT_LENTH, 200*WIDTH_LENTH, 40*HEIGHT_LENTH)];
    loginTitleLabel.text = @"第三方登录";
    loginTitleLabel.font = [UIFont systemFontOfSize:18*WIDTH_LENTH];
    loginTitleLabel.textAlignment = YES;
    [backGroundView addSubview:loginTitleLabel];
    
    UIButton * sinaButton = [[UIButton alloc]initWithFrame:CGRectMake(37*WIDTH_LENTH, 449*HEIGHT_LENTH, 60*WIDTH_LENTH, 60*HEIGHT_LENTH)];
    [sinaButton setBackgroundImage:[UIImage imageNamed:@"微博,W120,H120.png"] forState:UIControlStateNormal];
    sinaButton.layer.cornerRadius = sinaButton.frame.size.width /2;
    [sinaButton addTarget:self action:@selector(pressSinaButton) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:sinaButton];
    
    UIButton * wechatButton = [[UIButton alloc]initWithFrame:CGRectMake(157*WIDTH_LENTH, 449*HEIGHT_LENTH, 60*WIDTH_LENTH, 60*HEIGHT_LENTH)];
    [wechatButton setBackgroundImage:[UIImage imageNamed:@"微信,W120,H120.png"] forState:UIControlStateNormal];
    wechatButton.layer.cornerRadius = wechatButton.frame.size.width /2;
    [wechatButton addTarget:self action:@selector(pressWechatButton) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:wechatButton];
    
    
    UIButton * qqButton = [[UIButton alloc]initWithFrame:CGRectMake(269*WIDTH_LENTH, 449*HEIGHT_LENTH, 60*WIDTH_LENTH, 60*HEIGHT_LENTH)];
    [qqButton setBackgroundImage:[UIImage imageNamed:@"QQ,W120H120.png"] forState:UIControlStateNormal];
    qqButton.layer.cornerRadius = qqButton.frame.size.width /2;
    [qqButton addTarget:self action:@selector(pressQQButton) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:qqButton];
    
    UIButton * otherButton = [[UIButton alloc]initWithFrame:CGRectMake(150*WIDTH_LENTH, 593*HEIGHT_LENTH, 80*WIDTH_LENTH, 30*HEIGHT_LENTH)];
    otherButton.titleLabel.textAlignment = YES;
    [otherButton setTitle:@"先逛逛" forState:UIControlStateNormal];
    [backGroundView addSubview:otherButton];
    
}

- (void)pressCleanButton{
    
    _userNameTextField.text = @"";

}


- (void)pressLookButton{
    
    islook =! islook;
    if (islook) {
        _userPasswordTextField.secureTextEntry = NO;
    }else{
       _userPasswordTextField.secureTextEntry = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pressBackButton:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)pressNewSignButton{
    SginViewController * sginVC = [[SginViewController alloc]init];
    [self.navigationController pushViewController:sginVC animated:YES];
}


- (void)pressLoginButton{
    
   if([_userNameTextField.text isEqualToString:@""]){
       
       self.tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"帐号不能为空！"];
       self.tipsView.timeToClose = 1;
       [self.tipsView show];
       
    }else if ([_userPasswordTextField.text isEqualToString:@""]) {
     
        self.tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"密码不能为空！"];
        self.tipsView.timeToClose = 1;
        [self.tipsView show];
        
    }else if(_userNameTextField.text.length > 11){
    
        self.tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"帐号不能大于11位数！"];
        self.tipsView.timeToClose = 1;
        [self.tipsView show];
        
    }else if (_userNameTextField.text.length < 6){
        
        self.tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"帐号不能小于6位数！"];
        self.tipsView.timeToClose = 1;
        [self.tipsView show];
    
    }else if (_userPasswordTextField.text.length < 6){
        _alterView = [[UIAlertView alloc]initWithTitle:@"Tips" message:@"密码不能小于6位数！" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [_alterView show];
        
    }else if (_userPasswordTextField.text.length > 15){
    
        self.tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"密码不能大于15位数！"];
        self.tipsView.timeToClose = 1;
        [self.tipsView show];
        
        
    }else{
    
        _actVC = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        _actVC.center = self.view.center;
        _actVC.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        [self.view addSubview:_actVC];
        
        [_actVC startAnimating ];//启动
        
        [self login];
    }

}

- (void)login{

    //请求地址
    NSString * methodStr = @"user/doLogin.cmd";
    //向后台请求提交的参数
    NSDictionary *parmasDic = @{@"number":_userNameTextField.text,@"password":[MyMD5 md5:_userPasswordTextField.text]};

    [WebRequest webRequestWithURLMethod:methodStr parmas:parmasDic success:^(id result) {
        /*
         请求返回数据
         */
        
        if ([result[@"flag"] integerValue ]== 0) {
            
            self.tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"帐号或者密码错误！"];
            self.tipsView.timeToClose = 1;
            [self.tipsView show];
            
        }
        
        if ([result[@"flag"] integerValue]== 1) {
            
            [_actVC stopAnimating ];//停止
            
            self.tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"登录成功！"];
            self.tipsView.timeToClose = 1;
            [self.tipsView show];
            
            NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:result[@"loginUser"][@"userId"],@"userId",result[@"loginUser"][@"token"],@"token",result[@"flag"],@"isVisitor",nil];

            
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isTourist"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"userData"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            //创建通知
            NSNotification *notification =[NSNotification notificationWithName:@"isLogin" object:nil ];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];

            
            [self.navigationController popViewControllerAnimated:YES];
            
        }

        if ([result[@"flag"] integerValue]== 2) {
            
            [_actVC stopAnimating ];//停止
            
            self.tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"用户名或者密码为空！"];
            self.tipsView.timeToClose = 1;
            [self.tipsView show];

            
        }

        
    }fail:^(NSString *result) {
        
        self.tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"网络错误！"];
        self.tipsView.timeToClose = 1;
        [self.tipsView show];
        
    }];
}



- (void)pressSinaButton{
    
    NSLog(@"sina");
    
}

- (void)pressWechatButton{
    
    NSLog(@"微信");
    
}

- (void)pressQQButton{
    
    NSLog(@"QQ");
}


#pragma  mark - 设置最大输入字数<UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{  //string就是此时输入的那个字符textField就是此时正在输入的那个输入框返回YES就是可以改变输入框的值NO相反
    
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (_userNameTextField == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 11) { //如果输入框内容大于11则弹出警告
            textField.text = [toBeString substringToIndex:11];
            self.tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"超过最大字数不能输入了!"];
            self.tipsView.timeToClose = 1;
            [self.tipsView show];
            return NO;
        }
    }
    
    if (_userPasswordTextField == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 20) { //如果输入框内容大于20则弹出警告
            textField.text = [toBeString substringToIndex:20];
            self.tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"超过最大字数不能输入了!"];
            self.tipsView.timeToClose = 1;
            [self.tipsView show];
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - 键盘return键和go键点击事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == _userNameTextField) {
        [_userPasswordTextField becomeFirstResponder];
    }
    
    if (textField == _userPasswordTextField) {
        [self pressLoginButton];
    }
    
    return YES;
}




@end
