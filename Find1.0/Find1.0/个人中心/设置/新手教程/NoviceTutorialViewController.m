//
//  NoviceTutorialViewController.m
//  Find1.0
//
//  Created by APPLE on 15/9/17.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "NoviceTutorialViewController.h"

@interface NoviceTutorialViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIButton * skipButton;
@property (nonatomic,strong)UIButton * finshButton;
@end

@implementation NoviceTutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView * showScrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    showScrollView.delegate = self;
    [self.view addSubview:showScrollView];
    
    NSArray * showImageViewArr = [[NSArray alloc]initWithObjects:@"新手教程01.png",@"新手教程02.png",@"新手教程03.png",@"新手教程04.png", nil];
    
    for (int i = 0; i < 4; i ++) {
        UIImageView * showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_width * i, 0 *WIDTH_LENTH, Screen_width, Screen_height)];
        showImageView.userInteractionEnabled = YES;
        [showImageView setImage:[UIImage imageNamed:showImageViewArr[i]]];
        [showScrollView addSubview:showImageView];
        
    }
    
    showScrollView.showsHorizontalScrollIndicator = NO;
    showScrollView.showsVerticalScrollIndicator = NO;
    showScrollView.bounces = NO;
    showScrollView.pagingEnabled = YES;
    showScrollView.contentSize = CGSizeMake(Screen_width * 4, 0);
    
    
    self.skipButton = [[UIButton alloc]initWithFrame:CGRectMake(300*WIDTH_LENTH, 600*WIDTH_LENTH, 40*WIDTH_LENTH, 40*WIDTH_LENTH)];
    [self.skipButton setBackgroundImage:[UIImage imageNamed:@"跳过.png"] forState:UIControlStateNormal];
    [self.skipButton addTarget:self action:@selector(pressSkipButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.skipButton];
    
    
    self.finshButton = [[UIButton alloc]initWithFrame:CGRectMake(172*WIDTH_LENTH, 520*HEIGHT_LENTH, 40*WIDTH_LENTH, 100*HEIGHT_LENTH)];
//    self.finshButton.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [self.finshButton addTarget:self action:@selector(pressSkipButton) forControlEvents:UIControlEventTouchUpInside];
    self.finshButton.alpha = 0;
    [self.view addSubview:self.finshButton];
    
}


- (void)pressSkipButton{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x < 375 * 3 *WIDTH_LENTH) {
        self.skipButton.alpha = 1;
        self.finshButton.alpha = 0;
    }else{
        self.skipButton.alpha = 0;
        self.finshButton.alpha = 1;
    }

}

//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
