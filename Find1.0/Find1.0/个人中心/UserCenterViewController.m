//
//  UserCenterViewController.m
//  Find1.0
//
//  Created by APPLE on 15/9/1.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "UserCenterViewController.h"
#import "HeadView.h"
#import "UserCenterImageViewCollectionViewCell.h"
#import "PersonalDataViewController.h"
#import "SettingViewController.h"

NSString *const MJCollectionViewCellIdentifier = @"Cell";

@interface UserCenterViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)NSDictionary * loginUserData;
@property (nonatomic,assign)NSInteger * allPicturePage;

@end

@implementation UserCenterViewController

- (void)viewWillAppear:(BOOL)animated{
    
    self.allPicturePage = 0;
    self.allPicturePage ++;
    
    self.loginUserData = [[NSDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userData"]];
    
    
    SingleSession * session = [SingleSession new];
    NSLog(@"session ==== %@",session.singleUserData);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}


- (void)getMoreUserAllPicture{

    self.allPicturePage++;
    
    //请求地址
    NSString * methodStr = @"user/findUserAllPicture.cmd";
    //向后台请求提交的参数
    NSDictionary *parmasDic = @{@"userId":self.loginUserData[@"userId"],@"token":self.loginUserData[@"token"],@"isVisitor":self.loginUserData[@"isVisitor"],@"pageNumber":[NSString stringWithFormat:@"%ld",self.allPicturePage]};
    
    [WebRequest webRequestWithURLMethod:methodStr parmas:parmasDic success:^(id result) {
        /*
         请求返回数据
         */
        [self.userAllPicture addObjectsFromArray:result[@"data"]];
        
        [self.imageListCollectionView.header endRefreshing];
    }fail:^(NSString *result) {
        NSLog(@"失败了！");
        [self.imageListCollectionView.header endRefreshing];
    }];

}



- (void)initView{

    self.navigationController.navigationBarHidden = YES;
    
    self.topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 273*HEIGHT_LENTH)];
    self.topImageView.userInteractionEnabled = YES;
    [self.topImageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.userData[@"data"][@"myAvatar"],self.userData[@"data"][@"avatar"]]] andPlaceholderImage:[UIImage imageNamed:@"默认头像.png"] options:SDWebImageTransformAnimatedImage progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    [self.view addSubview:self.topImageView];
    
    
    UIView * glassView = [[UIView alloc]initWithFrame:self.topImageView.frame];
    glassView.backgroundColor = BACKGROUND_PUPCOLOR;
    glassView.alpha = 0.7;
    [self.topImageView addSubview:glassView];
    
    self.backButton = [[UIButton alloc]initWithFrame:CGRectMake(15*WIDTH_LENTH, 25*HEIGHT_LENTH, 11*WIDTH_LENTH, 21*HEIGHT_LENTH)];
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.topImageView addSubview:self.backButton];
    
    //    名字文本
    self.nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(84.5*HEIGHT_LENTH, 25*HEIGHT_LENTH, 200*HEIGHT_LENTH,30*HEIGHT_LENTH)];
    self.nickNameLabel.text = self.userData[@"data"][@"nickName"];
    self.nickNameLabel.textColor = [UIColor whiteColor];
    self.nickNameLabel.font = [UIFont systemFontOfSize:18*HEIGHT_LENTH];
    self.nickNameLabel.textAlignment = YES;
    [self.topImageView addSubview:self.nickNameLabel];
    
    //    与我相关
    self.aboutButton = [[UIButton alloc]initWithFrame:CGRectMake(300*HEIGHT_LENTH, 20*HEIGHT_LENTH, 20*HEIGHT_LENTH, 40*HEIGHT_LENTH)];
    self.aboutButton.titleLabel.font = [UIFont systemFontOfSize:19*HEIGHT_LENTH];
    [self.aboutButton setTitle:@"@" forState:UIControlStateNormal];
    [self.aboutButton setTitleColor:MAIN_YELLOWCOLOR forState:UIControlStateNormal];
    [self.topImageView addSubview:self.aboutButton];
    
    
    self.settingButton = [[UIButton alloc]initWithFrame:CGRectMake(335*WIDTH_LENTH, 33*WIDTH_LENTH, 14*WIDTH_LENTH, 14*WIDTH_LENTH)];
    [self.settingButton setBackgroundImage:[UIImage imageNamed:@"people_info_setting.png"] forState:UIControlStateNormal];
    [self.settingButton addTarget:self action:@selector(pressSettingButton) forControlEvents:UIControlEventTouchUpInside];
    [self.topImageView addSubview:self.settingButton];
    
    
    
    //    UIView * redView = [[UIView alloc]initWithFrame:CGRectMake(353*HEIGHT_LENTH, 33*HEIGHT_LENTH, 5*HEIGHT_LENTH, 5*HEIGHT_LENTH)];
    //    redView.layer.cornerRadius = redView.frame.size.width / 2;
    //    redView.backgroundColor = [UIColor redColor];
    //    [self.topImageView addSubview:redView];
    
    
    UIImageView * headView = [[UIImageView alloc]initWithFrame:CGRectMake(152.5*HEIGHT_LENTH, 60*HEIGHT_LENTH, 70*HEIGHT_LENTH, 70*HEIGHT_LENTH)];
    headView.layer.cornerRadius = headView.frame.size.width / 2;
    [headView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.userData[@"data"][@"myAvatar"],self.userData[@"data"][@"avatar"]]] andPlaceholderImage:[UIImage imageNamed:@"默认头像.png"] options:SDWebImageTransformAnimatedImage progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    headView.layer.borderWidth = 3 * WIDTH_LENTH;
    headView.layer.masksToBounds = YES;
    headView.layer.cornerRadius = headView.frame.size.width / 2;
    headView.layer.borderColor = MAIN_YELLOWCOLOR.CGColor;
    [self.topImageView addSubview:headView];

    
    UIButton * headImageveiwChickButton = [[UIButton alloc]initWithFrame:headView.frame];
    [headImageveiwChickButton addTarget:self action:@selector(pressHeadButton) forControlEvents:UIControlEventTouchUpInside];
    headImageveiwChickButton.backgroundColor = [UIColor clearColor];
    [self.view addSubview:headImageveiwChickButton];
    
    
    
    //    id
    self.idLabel = [[UILabel alloc]initWithFrame:CGRectMake(100*HEIGHT_LENTH, 128*HEIGHT_LENTH, 175*HEIGHT_LENTH, 30*HEIGHT_LENTH)];
    self.idLabel.font = [UIFont systemFontOfSize:18*HEIGHT_LENTH];
    self.idLabel.textAlignment = YES;
    self.idLabel.text = [NSString stringWithFormat:@"ID:%@",self.userData[@"data"][@"openId"]];
    self.idLabel.textColor = MAIN_YELLOWCOLOR;
    [self.topImageView addSubview:self.idLabel];
    
    //    信息
    
    self.sexImageView = [[UIImageView alloc]initWithFrame:CGRectMake(139*HEIGHT_LENTH, 155*HEIGHT_LENTH, 8.5*HEIGHT_LENTH, 10*HEIGHT_LENTH)];
    if ([self.userData[@"data"][@"gender"] integerValue]== 1) {
            [self.sexImageView setImage:[UIImage imageNamed:@"男.png"]];
    }else{
        [self.sexImageView setImage:[UIImage imageNamed:@"女.png"]];
    }
    
    [self.topImageView addSubview:self.sexImageView];
    
    UILabel * ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(148*HEIGHT_LENTH, 150*HEIGHT_LENTH, 30*HEIGHT_LENTH, 20*HEIGHT_LENTH)];
    ageLabel.font = [UIFont systemFontOfSize:11*HEIGHT_LENTH];
    ageLabel.textAlignment = YES;
    ageLabel.text = [NSString stringWithFormat:@"%@",self.userData[@"data"][@"age"]];
    ageLabel.textColor = MAIN_YELLOWCOLOR;
    [self.topImageView addSubview:ageLabel];
    
    UILabel * addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(176*HEIGHT_LENTH, 150*HEIGHT_LENTH, 100*HEIGHT_LENTH, 20*HEIGHT_LENTH)];
    addressLabel.font = [UIFont systemFontOfSize:11*HEIGHT_LENTH];
    addressLabel.textAlignment = NSTextAlignmentLeft;
    addressLabel.text = self.userData[@"data"][@"city"];
    addressLabel.textColor = MAIN_YELLOWCOLOR;
    [self.topImageView addSubview:addressLabel];
    
    //    个人标签
    UIScrollView * personScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(75, 180, 215, 20)];
    personScrollView.backgroundColor = [UIColor redColor];
//    [self.topImageView addSubview:personScrollView];
    
    //    NSArray * arr = [[NSArray alloc]initWithObjects:@"青春",@"傻不啦叽",@"逗比",@"非常二",@"好人", nil];
    //    SelfAdaptionButton * btn = [[SelfAdaptionButton alloc]initWithFrame:CGRectMake(230*HEIGHT_LENTH, 8*HEIGHT_LENTH, 191*HEIGHT_LENTH, 25*HEIGHT_LENTH) TitleName:arr Length:HEIGHT_LENTH];
    //    btn.showsHorizontalScrollIndicator = NO;  //水平方向
    //    [personScrollView addSubview:btn];
    
    
    
    //    数据统计
    UIView * dataView = [[UIView alloc]initWithFrame:CGRectMake(0, 230*HEIGHT_LENTH, self.topImageView.frame.size.width, 43*HEIGHT_LENTH)];
    dataView.backgroundColor = BACKGROUND_PUPCOLOR;
    dataView.alpha = 0.8;
    [self.topImageView addSubview:dataView];
    
    
    NSArray * titleArr = [[NSArray alloc]initWithObjects:@"照片",@"点赞",@"评论", nil];
    NSArray * numberArr = [[NSArray alloc]initWithObjects:self.userData[@"data"][@"pictureCount"],self.userData[@"data"][@"likeCount"],self.userData[@"data"][@"commentCount"], nil];
    
    for (int i = 0; i < 3; i++) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0 + 80 * i*HEIGHT_LENTH,5*HEIGHT_LENTH, 80*HEIGHT_LENTH ,15*HEIGHT_LENTH)];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [UIColor lightGrayColor];
        label.text = titleArr[i];
        label.font = [UIFont systemFontOfSize:13*HEIGHT_LENTH];
        [dataView addSubview:label];
        
        UILabel * numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(40*HEIGHT_LENTH + 81 * i*HEIGHT_LENTH,25*HEIGHT_LENTH, 50*HEIGHT_LENTH ,15*HEIGHT_LENTH)];
        numberLabel.textAlignment = YES;
        numberLabel.text = [NSString stringWithFormat:@"%@",numberArr[i]];
        numberLabel.font = [UIFont systemFontOfSize:13*HEIGHT_LENTH];
        numberLabel.textColor = [UIColor lightGrayColor];
        [dataView addSubview:numberLabel];
        
    }
    
    
    UILabel * friendLabel = [[UILabel alloc]initWithFrame:CGRectMake(240*HEIGHT_LENTH,5*HEIGHT_LENTH, 80*HEIGHT_LENTH ,15*HEIGHT_LENTH)];
    friendLabel.textColor = [UIColor whiteColor];
    friendLabel.textAlignment = NSTextAlignmentRight;
    friendLabel.textColor = [UIColor lightGrayColor];
    friendLabel.text = @"好友";
    friendLabel.font = [UIFont systemFontOfSize:13*HEIGHT_LENTH];
    [dataView addSubview:friendLabel];
    
    UILabel * friendNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(281*HEIGHT_LENTH,25*HEIGHT_LENTH, 50*HEIGHT_LENTH ,15*HEIGHT_LENTH)];
    friendNumberLabel.textAlignment = YES;
    friendNumberLabel.text =[NSString stringWithFormat:@"%@",self.userData[@"data"][@"friendCount"]];
    friendNumberLabel.font = [UIFont systemFontOfSize:13*HEIGHT_LENTH];
    friendNumberLabel.textColor = [UIColor lightGrayColor];
    [dataView addSubview:friendNumberLabel];
    
    
    
    UIButton * friendListButton = [[UIButton alloc]initWithFrame:CGRectMake(292*HEIGHT_LENTH, 5*HEIGHT_LENTH, 28*HEIGHT_LENTH, 40*HEIGHT_LENTH)];
    friendListButton.backgroundColor = [UIColor clearColor];
    [dataView addSubview:friendListButton];
    
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setItemSize:CGSizeMake(117*WIDTH_LENTH, 117*WIDTH_LENTH)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.imageListCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 280*WIDTH_LENTH, Screen_width, 387*WIDTH_LENTH) collectionViewLayout:flowLayout];
    self.imageListCollectionView.dataSource = self;
    self.imageListCollectionView.delegate = self;
    self.imageListCollectionView.backgroundColor = [UIColor clearColor];
    [self.imageListCollectionView registerClass:[UserCenterImageViewCollectionViewCell class] forCellWithReuseIdentifier:MJCollectionViewCellIdentifier];
    [self.view addSubview:self.imageListCollectionView];
    
    [self.imageListCollectionView addLegendHeaderWithRefreshingBlock:^{
        [self getMoreUserAllPicture];
    }];
    

}


- (void)pressButton:(UIButton *)sender{

    [self.navigationController popViewControllerAnimated:YES];

}

- (void)pressSettingButton{

    SettingViewController * settingVC = [SettingViewController new];
    [self.navigationController pushViewController:settingVC animated:YES];

}

- (void)pressHeadButton{

    [self getUserDataToNext];
}


- (void)getUserDataToNext{
    
    //请求地址
    NSString * methodStr = @"user/personalUser.cmd";
    //向后台请求提交的参数
    NSDictionary *parmasDic = @{@"userId":self.loginUserData[@"userId"],@"token":self.loginUserData[@"token"],@"isVisitor":self.loginUserData[@"isVisitor"]};
    
    [WebRequest webRequestWithURLMethod:methodStr parmas:parmasDic success:^(id result) {
        /*
         请求返回数据
         */
        
        PersonalDataViewController * personalDataVC = [PersonalDataViewController new];
        personalDataVC.userData = result;
        [self.navigationController pushViewController:personalDataVC animated:YES];
        
    }fail:^(NSString *result) {
        NSLog(@"失败了！");
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)sectio
{
    return self.userAllPicture.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UserCenterImageViewCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:MJCollectionViewCellIdentifier forIndexPath:indexPath];
    
    [cell.bgImageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.userData[@"data"][@"myAvatar"],self.userAllPicture[indexPath.row][@"pictureUrl"]]] andPlaceholderImage:[UIImage imageNamed:@"无图.png"]  options:SDWebImageTransformAnimatedImage  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    if ([self.userAllPicture[indexPath.row][@"likeCount"] integerValue] < 1000) {
        cell.priseLabel.text = [NSString stringWithFormat:@"%@",self.userAllPicture[indexPath.row][@"likeCount"]];
    }else{
        cell.priseLabel.text = @"999+";
    }
    
    if ([self.userAllPicture[indexPath.row][@"expireSeconds"] integerValue] != 0) {
        [cell.timeUpLabel removeFromSuperview];
    }
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",self.userAllPicture[indexPath.row][@"pictureId"]);
    
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
