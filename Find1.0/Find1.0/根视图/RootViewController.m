//
//  RootViewController.m
//  Find1.0
//
//  Created by APPLE on 15/8/22.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "RootViewController.h"
#import "GuidePageViewController.h"
#import "LoginController.h"
#import "UserCenterViewController.h"

@interface RootViewController ()

@property (nonatomic,strong)UserCenterViewController * userVC;

@end

@implementation RootViewController


- (void)viewWillAppear:(BOOL)animated{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = BACKGROUND_PUPCOLOR;
    
    
        if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isTourist"];
            NSLog(@"第一次启动");

            GuidePageViewController * guidePageVC = [GuidePageViewController new];
            [self presentViewController:guidePageVC animated:NO completion:^{
            }];

        }else{
            NSLog(@"已经不是第一次启动了");
        }
    
    
    self.navigationController.navigationBar.barTintColor = BACKGROUND_PUPCOLOR;
    //    设置半透明
    self.navigationController.navigationBar.translucent = NO;
    
    self.listVC = [[ListViewController alloc]init];
    [self addChildViewController:self.listVC];
    [self.view addSubview:self.listVC.view];
    
    self.squareVC = [[SquareViewController alloc]init];
    [self addChildViewController:self.squareVC];
    [self.view addSubview:self.squareVC.view];
    
 
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"my_account.png"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(pressTopButton:)];
    leftItem.tag = 2001;
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"message.png"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(pressTopButton:)];
    rightItem.tag = 2002;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 210*WIDTH_LENTH, 40)];
    self.navigationItem.titleView = titleView;
    
    UIView * frameView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, 210*WIDTH_LENTH, 30)];
    frameView.layer.borderWidth = 1;
    frameView.layer.cornerRadius = 3;
    frameView.layer.borderColor = [[UIColor colorWithRed:163/255.0 green:167/255.0 blue:7/255.0 alpha:1] CGColor];
    [titleView addSubview:frameView];
    
    
#pragma mark - 广场按钮
    self.squareButton = [[UIButton alloc]initWithFrame:CGRectMake(2.5*WIDTH_LENTH, 2.5, 102.5*WIDTH_LENTH, 25)];
    [self.squareButton setTitle:@"广场" forState:UIControlStateNormal];
    self.squareButton.titleLabel.font = [UIFont systemFontOfSize:19 *WIDTH_LENTH];
    [self.squareButton setTitleColor:MAIN_YELLOWCOLOR forState:UIControlStateNormal];
    [self.squareButton setTitleColor:BACKGROUND_PUPCOLOR forState:UIControlStateSelected];
    [self.squareButton setBackgroundImage:[UIImage imageNamed:@"圆角矩形 5 拷贝.png"] forState:UIControlStateSelected];
    self.squareButton.titleLabel.textAlignment = YES;
    [self.squareButton addTarget:self action:@selector(pressTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    self.squareButton.selected = YES;
    
    
#pragma mark - 榜单按钮
    self.listButton = [[UIButton alloc]initWithFrame:CGRectMake(105*WIDTH_LENTH, 2.5, 102.5*WIDTH_LENTH, 25)];
    [self.listButton setTitle:@"榜单" forState:UIControlStateNormal];
 [self.listButton setBackgroundImage:[UIImage imageNamed:@"圆角矩形 5 拷贝.png"] forState:UIControlStateSelected];
    self.listButton.titleLabel.font = [UIFont systemFontOfSize:19 *WIDTH_LENTH];
    [self.listButton setTitleColor:MAIN_YELLOWCOLOR forState:UIControlStateNormal];
    [self.listButton setTitleColor:BACKGROUND_PUPCOLOR forState:UIControlStateSelected];
    self.listButton.titleLabel.textAlignment = YES;
    [self.listButton addTarget:self action:@selector(pressTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [frameView addSubview:_squareButton];
    [frameView addSubview:self.listButton];
    
}

- (void)pressTitleButton:(UIButton *)sender{

    if (sender == self.squareButton) {
        self.listButton.selected = NO;
        self.squareButton.selected = YES;
        [self.view bringSubviewToFront:self.squareVC.view];
        
    }
    if (sender == self.listButton) {
        [self getListSore];
    }
}


- (void)getListSore{
    
    NSDictionary * userData = [[NSDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userData"]];
    
    //请求地址
    NSString * methodStr = @"list/getList.cmd";
    //向后台请求提交的参数
    NSDictionary *parmasDic = [NSDictionary new];
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isTourist"]) {
        parmasDic = @{@"userId":userData[@"userId"],@"isVisitor":userData[@"flag"],@"pageNumber":@"1",@"token":@""};
    }else{
        parmasDic = @{@"userId":userData[@"userId"],@"isVisitor":userData[@"isVisitor"],@"pageNumber":@"1",@"token":userData[@"token"]};
    }
    
    
    [WebRequest webRequestWithURLMethod:methodStr parmas:parmasDic success:^(id result) {
        /*
         请求返回数据
         */

        
        NSArray * arr = [[NSArray alloc]initWithArray:result[@"data"]];
        
        for (int i = 0; i < arr.count; i++) {
            [self.listVC.listArr addObject:arr[i]];
        }
        
        [self.listVC.listTableView reloadData];
        
        self.listButton.selected = YES;
        self.squareButton.selected = NO;
        [self.view bringSubviewToFront:self.listVC.view];
        
    }fail:^(NSString *result) {
        NSLog(@"失败了！");
    }];
    
}



- (void)pressTopButton:(UIBarButtonItem *)sender{
    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isTourist"]) {
        
        
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"Tips:" contentText:@"请先登录" leftButtonTitle:@"不！" rightButtonTitle:@"登录"];
        [alert show];
        alert.leftBlock = ^() {
            NSLog(@"left button clicked");
        };
        alert.rightBlock = ^() {
            LoginController * loginVC = [LoginController new];
            [self.navigationController pushViewController:loginVC animated:NO];
        };
        alert.dismissBlock = ^() {
            NSLog(@"Do something interesting after dismiss block");
        };

    }else{
     
            if(sender.tag == 2001){
                
                self.loginUserData = [[NSDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userData"]];
                
                self.userVC = [UserCenterViewController new];
                [self getUserData];
            }

            if (sender.tag == 2002) {
              NSLog(@"聊天界面");
            }
        
    }

}


- (void)getUserData{
    
    //请求地址
    NSString * methodStr = @"user/findUserInfo.cmd";
    //向后台请求提交的参数
    NSDictionary *parmasDic = @{@"userId":self.loginUserData[@"userId"],@"token":self.loginUserData[@"token"],@"isVisitor":self.loginUserData[@"isVisitor"]};
    
    [WebRequest webRequestWithURLMethod:methodStr parmas:parmasDic success:^(id result) {
        /*
         请求返回数据
         */
        self.userVC.userData = [[NSDictionary alloc]initWithDictionary:result];
        [self getUserAllPicture];
        
    }fail:^(NSString *result) {
        NSLog(@"失败了！");
    }];
    
}

- (void)getUserAllPicture{
    
    //    self.allPicturePage++;
    
    //请求地址
    NSString * methodStr = @"user/findUserAllPicture.cmd";
    //向后台请求提交的参数
    NSDictionary *parmasDic = @{@"userId":self.loginUserData[@"userId"],@"token":self.loginUserData[@"token"],@"isVisitor":self.loginUserData[@"isVisitor"],@"pageNumber":@"1"};
    
    [WebRequest webRequestWithURLMethod:methodStr parmas:parmasDic success:^(id result) {
        /*
         请求返回数据
         */
        
        self.userVC.userAllPicture = result[@"data"];

        [self.navigationController pushViewController:self.userVC animated:NO];
        
    }fail:^(NSString *result) {
        NSLog(@"失败了！");
    }];
    
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
