//
//  GuidePageViewController.m
//  Find1.0
//
//  Created by APPLE on 15/8/22.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "GuidePageViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import  "RootViewController.h"


@interface GuidePageViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView * fistScrollView;
@property (nonatomic,strong)UIButton * startButton;
@end

@implementation GuidePageViewController


- (void)viewWillAppear:(BOOL)animated{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.fistScrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height)];
    self.fistScrollView.delegate = self;
    [self.view addSubview:self.fistScrollView];
    
    
    NSArray * showImageViewArr = [[NSArray alloc]initWithObjects:@"引导页01.png",@"引导页2.png",@"引导页3.png", nil];
    
    for (int i = 0; i < 3; i++) {
        UIImageView * showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_width*i, 0, Screen_width, Screen_height)];
        [showImageView setImage:[UIImage imageNamed:showImageViewArr[i]]];
        [self.fistScrollView addSubview:showImageView];
    }
    
    self.fistScrollView.showsHorizontalScrollIndicator = NO;
    self.fistScrollView.showsVerticalScrollIndicator = NO;
    self.fistScrollView.bounces = NO;
    self.fistScrollView.pagingEnabled = YES;
    self.fistScrollView.contentSize = CGSizeMake(Screen_width * 3, 0);
    
    //初始化 UIPageControl 和 _scrollView 显示在 同一个页面中
    UIPageControl *pageConteol = [[UIPageControl alloc] initWithFrame:CGRectMake(150, self.view.frame.size.height - 60*HEIGHT_LENTH, 75*WIDTH_LENTH, 40*HEIGHT_LENTH)];
    pageConteol.numberOfPages = 3;//设置pageConteol 的page 和 _scrollView 上的图片一样多
    pageConteol.tag = 201;
    [self.view addSubview: pageConteol];
    
    
    self.startButton = [[UIButton alloc]initWithFrame:CGRectMake(135*WIDTH_LENTH, 500*HEIGHT_LENTH, 100*WIDTH_LENTH, 70*HEIGHT_LENTH)];
    [self.startButton setBackgroundImage:[UIImage imageNamed:@"开始.png"] forState:UIControlStateNormal];
     self.startButton.titleLabel.font = [UIFont boldSystemFontOfSize:20*WIDTH_LENTH];
     self.startButton.titleLabel.textAlignment = YES;
    [ self.startButton addTarget:self action:@selector(chick) forControlEvents:UIControlEventTouchUpInside];
    self.startButton.alpha = 0;
    [self.view addSubview: self.startButton];

}

- (void)chick{

    [self dismissViewControllerAnimated:YES completion:^{
    
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 记录scrollView 的当前位置，因为已经设置了分页效果，所以：位置/屏幕大小 = 第几页
    int current = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    
    //根据scrollView 的位置对page 的当前页赋值
    UIPageControl *page = (UIPageControl *)[self.view viewWithTag:201];
    page.currentPage = current;
    
    //当显示到最后一页时，让滑动图消失
    if (page.currentPage == 2) {
        self.startButton.alpha = 1;
        page.alpha = 0;
    }else{
        self.startButton.alpha = 0;
        page.alpha = 1;
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
