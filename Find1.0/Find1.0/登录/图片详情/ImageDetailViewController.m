//
//  ImageDetailViewController.m
//  SquareDemo1.1
//
//  Created by APPLE on 15/6/24.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "ImageDetailViewController.h"
//#import "PersonalCenterCollectionViewController.h"
#import "MoveView.h"
//#import "PersonalCenterCollectionViewController.h"


#define kWinSize [UIScreen mainScreen].bounds.size


@interface ImageDetailViewController ()<YcKeyBoardViewDelegate>
{
    int x;
    UIButton* _praiseButton;
    UILabel * _praiseNumberLabel;
    UIView * _bigView; //大表情界面
    UIImageView * _bgImageView;// 背景图片
    UIView * _downView;   //底部弹出视图
    
    UIView * _moveDetailView;  // 弹幕
    UIButton * _fromUserHeaderButton;
    UIButton * _toUserHeaderButton;
    UILabel * _connectLabel;
    UIButton * _contentButton;
    
    NSMutableArray * _moveArrOne;
    NSMutableArray * _moveArrTwo;
    
    
    NSMutableDictionary * _dic;
    
    
//    MoveView * move;
//    MoveView * move1;
//    MoveView * move2;
//    int a;
//    int b;
//    int c;
//    int d;
//    
//    MoveView * moveTwo;
//    MoveView * moveTwo1;
//    MoveView * moveTwo2;
//    int e;
//    int f;
//    int g;
//    int h;
    
    
}

@property (nonatomic,strong) YcKeyBoardView *key;
@property (nonatomic,assign) CGFloat keyBoardHeight;
@property (nonatomic,assign) CGRect originalKey;
@property (nonatomic,assign) CGRect originalText;
@property (nonatomic,strong) NSDictionary * loginUserData;

@end

@implementation ImageDetailViewController

- (void)viewWillDisappear:(BOOL)animated{
    
//        [move removeFromSuperview];
//        [move1 removeFromSuperview];
//        [move2 removeFromSuperview];
//    
//        [moveTwo removeFromSuperview];
//        [moveTwo1 removeFromSuperview];
//        [moveTwo2 removeFromSuperview];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSLog(@"%@",self.imageDic);
    
    self.loginUserData = [[NSDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userData"]];
    
    
    self.navigationController.navigationBarHidden = YES;
    
//    UIBarButtonItem  * left = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(respondsToLeftNavigationItem:)];
//    self.navigationItem.leftBarButtonItem = left;
//    
//    self.navigationItem.title = @"图片详情";
//    //    设置文字格式（颜色）
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:MAIN_YELLOWCOLOR}];
    
    
    UILabel * personCenterLabel = [[UILabel alloc]initWithFrame:CGRectMake(100*WIDTH_LENTH, 35*HEIGHT_LENTH, 175*WIDTH_LENTH, 21*HEIGHT_LENTH)];
    personCenterLabel.text = @"图片详情";
    personCenterLabel.font = [UIFont systemFontOfSize:20*HEIGHT_LENTH];
    personCenterLabel.textAlignment = YES;
    personCenterLabel.textColor = MAIN_YELLOWCOLOR;
    [self.view addSubview:personCenterLabel];
    
    UIButton * backButton = [[UIButton alloc]initWithFrame:CGRectMake(15*WIDTH_LENTH, 35*HEIGHT_LENTH, 11*WIDTH_LENTH, 21*HEIGHT_LENTH)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(pressBackButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    
    
    self.view.backgroundColor = BACKGROUND_PUPCOLOR;
    
//    [self getMoveSore];
    
    [self settingView];
    [self setttingDownView];
}



- (void)getMoveSore{


        NSArray * arr = [[NSArray alloc]initWithArray:self.imageDic[@"comments"]];
        _moveArrOne = [[NSMutableArray alloc]init];
        _moveArrTwo = [[NSMutableArray alloc]init];
        
        if ([self.imageDic[@"comments"] isEqual:[NSNull null]]) {
           
        }else{
            for (int i = 0; i < arr.count; i++) {
                
                if (i % 2 == 0) {
                    [_moveArrOne addObject:arr[i]];
                }else{
                    [_moveArrTwo addObject:arr[i]];
                }
                
            }

        }
    
        [self settingView];
        [self setttingDownView];
}


- (void)setttingDownView{
    
    _downView = [[UIView alloc]initWithFrame:CGRectMake(0, 667 * HEIGHT_LENTH, self.view.frame.size.width, 267 * HEIGHT_LENTH)];
    _downView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_downView];

    NSArray * shareArr = [[NSArray alloc]initWithObjects:@"qq.png",@"qq空间.png",@"微信.png",@"微博.png",@"空间.png", nil];
    
    for (int i = 0; i < 5; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn addTarget:self action:@selector(pressOtherButton:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[UIImage imageNamed:shareArr[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(15*WIDTH_LENTH+72*i*WIDTH_LENTH, 30*WIDTH_LENTH, 50*WIDTH_LENTH, 50*WIDTH_LENTH);
        btn.layer.cornerRadius = btn.frame.size.height / 2;
        btn.tag = i + 3000;
        [_downView addSubview:btn];
    }
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(15*HEIGHT_LENTH, 100*HEIGHT_LENTH, 345*HEIGHT_LENTH, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:0.5];
    [_downView addSubview:lineView];
    
    
    NSArray * arr = [[NSArray alloc]initWithObjects:@"屏蔽.png",@"举报.png",@"下载.png", nil];
    
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn addTarget:self action:@selector(pressOtherButton:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(15*WIDTH_LENTH+145*i*WIDTH_LENTH, 110*WIDTH_LENTH, 35*WIDTH_LENTH, 40*WIDTH_LENTH);
        btn.tag = i + 4000;
        [_downView addSubview:btn];
    }
    
    NSArray * titleArr = [[NSArray alloc]initWithObjects:@"屏蔽",@"举报",@"下载", nil];
    for (int i = 0; i < 3; i++) {
        UILabel *btn = [[UILabel alloc] init];
        btn.frame = CGRectMake(15*WIDTH_LENTH+145*i*WIDTH_LENTH, 150*WIDTH_LENTH, 40*WIDTH_LENTH, 30*WIDTH_LENTH);
        btn.text = titleArr[i];
        btn.textColor = [UIColor whiteColor];
        [_downView addSubview:btn];
    }
}


- (void)settingView{
    
#pragma mark - 大背景
    
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 95 * HEIGHT_LENTH, 375* WIDTH_LENTH, 375* HEIGHT_LENTH)];
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:self.imageDic[@"pictureUrl"]] placeholderImage:[UIImage imageNamed:@"默认头像.jpg"]];
    [self.view addSubview:_bgImageView];
    _bgImageView.userInteractionEnabled = YES;
    
#pragma mark - 个人信息挡板
    
    UIView * informationView = [[UIView alloc]initWithFrame:CGRectMake(50* WIDTH_LENTH, 76* HEIGHT_LENTH, 135* WIDTH_LENTH, 40*HEIGHT_LENTH)];
    informationView.layer.cornerRadius = 3;
    informationView.backgroundColor = [UIColor whiteColor];
    informationView.alpha = 0.5;
    [self.view addSubview:informationView];
    
#pragma mark - 用户名字
    
    UILabel * userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80* WIDTH_LENTH, 76* HEIGHT_LENTH , 80* WIDTH_LENTH, 20* HEIGHT_LENTH)];
    userNameLabel.font = [UIFont systemFontOfSize:13*WIDTH_LENTH];
    userNameLabel.textColor = [UIColor whiteColor];
    userNameLabel.text = self.imageDic[@"author"][@"nickName"];
    [self.view addSubview:userNameLabel];
    
#pragma mark - 用户性别
    
    UIImageView* userSex = [[UIImageView alloc]initWithFrame:CGRectMake(80* WIDTH_LENTH, 97* HEIGHT_LENTH, 15* WIDTH_LENTH, 15* HEIGHT_LENTH)];
    if ((int)self.imageDic[@"author"][@"gender"] == 1) {
        [userSex setImage:[UIImage imageNamed:@""]];
    }
    [userSex setImage:[UIImage imageNamed:@""]];
    [self.view addSubview:userSex];
    
#pragma mark - 用户年龄和地址
    
     UILabel* userInformationAddress = [[UILabel alloc]initWithFrame:CGRectMake(100* WIDTH_LENTH, 96* HEIGHT_LENTH, 120* WIDTH_LENTH, 20* HEIGHT_LENTH)];
    userInformationAddress.font = [UIFont systemFontOfSize:12*WIDTH_LENTH];
    userInformationAddress.textColor = [UIColor darkGrayColor];
    userInformationAddress.text = [NSString stringWithFormat:@"%@岁 %@",self.imageDic[@"author"][@"age"],self.imageDic[@"author"][@"city"]];
    [self.view addSubview:userInformationAddress];
    
#pragma mark - 用户顶部头像
    
    //    外部view
    UIImageView * externalView = [[UIImageView alloc]initWithFrame:CGRectMake(15*HEIGHT_LENTH, 64*HEIGHT_LENTH, 60*WIDTH_LENTH, 60*HEIGHT_LENTH)];
    [externalView setImage:[UIImage imageNamed:@"默认头像.jpg"]];
    externalView.layer.borderColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5].CGColor;
    externalView.layer.masksToBounds = YES;
    externalView.layer.borderWidth = 3*WIDTH_LENTH;
    externalView.layer.cornerRadius = externalView.frame.size.width / 2;
    [self.view addSubview:externalView];
    
    UIImageView* headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, externalView.frame.size.width - 6*WIDTH_LENTH , externalView.frame.size.height - 6*HEIGHT_LENTH)];
    headImageView.center = externalView.center;
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = headImageView.frame.size.width / 2;
     [headImageView sd_setImageWithURL:[NSURL URLWithString:self.imageDic[@"author"][@"avatar"]] placeholderImage:[UIImage imageNamed:@"默认头像.jpg"]];
    [self.view addSubview:headImageView];
    
    //    内部view
    UIButton* topHeadButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,externalView.frame.size.width, externalView.frame.size.height)];
    topHeadButton.center = externalView.center;
    topHeadButton.layer.masksToBounds = YES;
    topHeadButton.layer.cornerRadius = topHeadButton.frame.size.width / 2;
    topHeadButton.backgroundColor = [UIColor clearColor];
    [topHeadButton addTarget:self action:@selector(pressButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topHeadButton];
    
#pragma mark - 顶部标签
    
    UIScrollView * userTallyScrollView = [[UIScrollView alloc]init];
    [self.view addSubview:userTallyScrollView];
    
    int userSum = 0;
    
    NSArray * arr = [[NSArray alloc]initWithArray:self.imageDic[@"author"][@"userTags"]];
    
    if ([self.imageDic[@"author"][@"userTags"] isEqual:[NSNull null]]) {
        NSLog(@"顶部标签是空的！");
    }
    else{
        for (int i = 0; i < arr.count ; i++) {
            
            UIButton *btn = [[UIButton alloc] init];
            NSString * nameStr =  arr[i][@"tagName"];
            [btn setFrame:CGRectMake(0, 0, 13 + 14 * nameStr.length, 15)];
            [btn setTitleColor:[UIColor colorWithRed:225/255.0 green:211/255.0 blue:179/255.0 alpha:1] forState:UIControlStateNormal];
            UIImage *img=[UIImage imageNamed:@"person_tag.png"];
            img=[img stretchableImageWithLeftCapWidth:15 topCapHeight:0];
            [btn setBackgroundImage:img forState:UIControlStateNormal];
            [btn setTitle:nameStr forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:10];
            //    设置文字边距
            btn.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
            [userTallyScrollView addSubview:btn];
            
            [btn setFrame:CGRectMake(userSum + 2 * i + 10*WIDTH_LENTH , 0, btn.frame.size.width, 15)];
            userSum = CGRectGetWidth(btn.bounds)  + userSum;
            [userTallyScrollView addSubview:btn];
            
            [userTallyScrollView setFrame:CGRectMake(230*WIDTH_LENTH, 74*HEIGHT_LENTH, 145*WIDTH_LENTH, 20*HEIGHT_LENTH)];
            userTallyScrollView.contentSize = CGSizeMake(userSum + 18*WIDTH_LENTH, 15*HEIGHT_LENTH);
            userTallyScrollView.showsHorizontalScrollIndicator = YES;

    }
        
    }
    
#pragma mark - 顶部标签挡板
    
    UIImageView * disMissImageView = [[UIImageView alloc]initWithFrame:CGRectMake(220*WIDTH_LENTH, 64*HEIGHT_LENTH, 30* WIDTH_LENTH, 25* HEIGHT_LENTH)];
    [disMissImageView setImage:[UIImage imageNamed:@"dismiss.png"]];
    [self.view addSubview:disMissImageView];
    
#pragma mark - 图片下面的标签
    
    UIScrollView *  imageTallyScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(5*WIDTH_LENTH, 473*HEIGHT_LENTH, 375*WIDTH_LENTH, 25*HEIGHT_LENTH)];
    [self.view addSubview:imageTallyScrollView];
    
    imageTallyScrollView.showsHorizontalScrollIndicator = NO;  //水平方向
    
    int sum = 0;
    NSArray * imageTagsArr = [[NSArray alloc]initWithArray:self.imageDic[@"pictureTags"]];
    if ([self.imageDic[@"pictureTags"] isEqual:[NSNull null]]) {
        NSLog(@"图片下面的标签是空的！");
    }else{
        for (int i = 0; i < imageTagsArr.count; i++) {
            
            //         自适应button
            
            UIButton * imageTallyButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
            
            NSString * titleStr = imageTagsArr[i][@"tagName"];
            
            NSDictionary * attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
            
            CGSize size1 = [titleStr boundingRectWithSize:CGSizeMake(MAXFLOAT, imageTallyButton.frame.size.height) options:NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil].size;
            
            NSString * str = imageTagsArr[i][@"tagName"];
            NSInteger len = str.length + 1;
            
            [imageTallyButton setFrame:CGRectMake(sum*WIDTH_LENTH - 5*WIDTH_LENTH, 0, size1.width + 6 * len *WIDTH_LENTH, 30*HEIGHT_LENTH)];
            
            sum = CGRectGetWidth(imageTallyButton.bounds)  + sum;
            
            [imageTallyButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
            imageTallyButton.titleLabel.font = [UIFont systemFontOfSize:15*WIDTH_LENTH];
            
            [imageTallyButton setTitle:[NSString stringWithFormat:@"#%@",titleStr] forState:UIControlStateNormal];
            
            [imageTallyButton setTitleColor:MAIN_YELLOWCOLOR forState:UIControlStateNormal];
            
            imageTallyButton.tag = i;
            //    [_imageTallyButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [imageTallyScrollView setContentSize:CGSizeMake(sum*WIDTH_LENTH + 10*WIDTH_LENTH, 20*HEIGHT_LENTH)];
            
            [imageTallyScrollView addSubview:imageTallyButton];
      }
    }
    
    
#pragma mark - 底部文字
    
    NSString * imageContentStr = self.imageDic[@"title"];
    UILabel* imageContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 , 0, 600, 400)];
    imageContentLabel.text = imageContentStr;
    imageContentLabel.alpha = 1;
    imageContentLabel.tag = 101;
    imageContentLabel.font = [UIFont systemFontOfSize:15*WIDTH_LENTH];
    //设置文本行数（0为不限制行数）
    imageContentLabel.numberOfLines = 0;
    //自适应文本框大小
    CGSize contantSize = CGSizeMake(280*WIDTH_LENTH, 40*HEIGHT_LENTH);  //大小约束
    //获取能够显示完文本的大小
    CGRect autoRect = [imageContentStr boundingRectWithSize:contantSize options: NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:imageContentLabel.font} context:nil];
    //用这个大小重新设置frame
    imageContentLabel.frame = CGRectMake(0, 506*WIDTH_LENTH, autoRect.size.width, autoRect.size.height);
    [imageContentLabel setTextColor:[UIColor colorWithRed:225/255.0 green:211/255.0 blue:179/255.0 alpha:1]];
    [self.view addSubview:imageContentLabel];
    
    
#pragma mark - 底部时间和地址
    
    UILabel* imageTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(310* WIDTH_LENTH, 506* HEIGHT_LENTH, 60* WIDTH_LENTH, 20* HEIGHT_LENTH)];
    imageTimeLabel.font = [UIFont systemFontOfSize:10];
    imageTimeLabel.textColor = [UIColor colorWithRed:225/255.0 green:211/255.0 blue:179/255.0 alpha:1];
    
    if ([self.imageDic[@"createMinute"] integerValue] < 60) {
        imageTimeLabel.text = [NSString stringWithFormat:@"%@分钟",self.imageDic[@"createMinute"]];
            }else if ([self.imageDic[@"createMinute"]integerValue] >= 60 && [self.imageDic[@"createMinute"] integerValue] < 24 * 60) {
        imageTimeLabel.text = [NSString stringWithFormat:@"%ld小时",(long)[self.imageDic[@"createMinute"] integerValue]/60];
    }else{
        imageTimeLabel.text = [NSString stringWithFormat:@"%ld天前",(long)[self.imageDic[@"createMinute"] integerValue]/60/24];
    }
    
    [self.view addSubview:imageTimeLabel];
    
    UIImageView * addressImageView = [[UIImageView alloc]initWithFrame:CGRectMake(295*WIDTH_LENTH, 531*HEIGHT_LENTH, 8*WIDTH_LENTH, 10*HEIGHT_LENTH)];
    [addressImageView setImage:[UIImage imageNamed:@"position.png"]];
    [self.view addSubview:addressImageView];
    
    UILabel* imageAddresslabel = [[UILabel alloc]initWithFrame:CGRectMake(310* WIDTH_LENTH, 526* HEIGHT_LENTH, 60* WIDTH_LENTH, 20* HEIGHT_LENTH)];
    imageAddresslabel.font = [UIFont systemFontOfSize:10];
    imageAddresslabel.text = self.imageDic[@"location"];
    imageAddresslabel.textColor = [UIColor colorWithRed:225/255.0 green:211/255.0 blue:179/255.0 alpha:1];
    [self.view addSubview:imageAddresslabel];
    
#pragma mark - 底部按钮背景
    
    UIView * downBackGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 55*HEIGHT_LENTH, self.view.frame.size.width, 55*HEIGHT_LENTH)];
    downBackGroundView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:downBackGroundView];
    
#pragma mark - 点赞按钮
    
    _praiseButton = [[UIButton alloc]initWithFrame:CGRectMake(20*WIDTH_LENTH,15*HEIGHT_LENTH, 30*WIDTH_LENTH, 25*HEIGHT_LENTH)];
    [_praiseButton setImage:[UIImage imageNamed:@"like_normal.png"] forState:UIControlStateNormal];
    [_praiseButton setImage:[UIImage imageNamed:@"已赞.png"] forState:UIControlStateSelected];
    [_praiseButton addTarget:self action:@selector(pressDownButton:) forControlEvents:UIControlEventTouchUpInside];
    [downBackGroundView addSubview:_praiseButton];
    
#pragma mark - 点赞数量
    
    _praiseNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(55*WIDTH_LENTH,10*HEIGHT_LENTH, 50*WIDTH_LENTH, 25*HEIGHT_LENTH)];
    _praiseNumberLabel.font = [UIFont systemFontOfSize:15];
    _praiseNumberLabel.textColor = [UIColor colorWithRed:225/255.0 green:211/255.0 blue:179/255.0 alpha:1];
    _praiseNumberLabel.text = [NSString stringWithFormat:@"%@", self.imageDic[@"likeCount"]];
    [downBackGroundView addSubview:_praiseNumberLabel];
    
#pragma mark - 大表情按钮
    
    UIButton* bigface = [[UIButton alloc]initWithFrame:CGRectMake(130*WIDTH_LENTH,15*HEIGHT_LENTH, 25*WIDTH_LENTH, 25*HEIGHT_LENTH)];
    [bigface setImage:[UIImage imageNamed:@"big_smile.png"] forState:UIControlStateNormal];
    bigface.tag = 1001;
     [bigface addTarget:self action:@selector(pressDownButton:) forControlEvents:UIControlEventTouchUpInside];
    [downBackGroundView addSubview:bigface];
    
#pragma mark - 发消息按钮
    
    UIButton * messageButton = [[UIButton alloc]initWithFrame:CGRectMake(222*WIDTH_LENTH,15*HEIGHT_LENTH, 25*WIDTH_LENTH, 25*HEIGHT_LENTH)];
    [messageButton setImage:[UIImage imageNamed:@"comment.png"] forState:UIControlStateNormal];
    messageButton.tag = 1002;
    [messageButton addTarget:self action:@selector(pressDownButton:) forControlEvents:UIControlEventTouchUpInside];
    [downBackGroundView addSubview:messageButton];
    
#pragma mark - 其他按钮
     UIButton * otherButton = [[UIButton alloc]initWithFrame:CGRectMake(325*WIDTH_LENTH,15*HEIGHT_LENTH, 25*WIDTH_LENTH, 25*HEIGHT_LENTH)];
    [otherButton setImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];
    otherButton.tag = 1003;
    [otherButton addTarget:self action:@selector(pressDownButton:) forControlEvents:UIControlEventTouchUpInside];
    [downBackGroundView addSubview:otherButton];
    
#pragma mark -  添加弹幕

//    _timer =[NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(changeTimeAtTimedisplay) userInfo:nil repeats:YES];
//    
//    _timerTwo = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(changeTimeAtTimedisplayTwo) userInfo:nil repeats:YES];
    
    
//    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
//    [[NSRunLoop currentRunLoop] addTimer:_timerTwo forMode:NSRunLoopCommonModes];
    
//    [self setMoveView];
    
//    [self setMoveTwoView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - 点赞事件

- (void)pressDownButton:(UIButton *)sender{
    if (sender == _praiseButton) {
        _praiseButton.selected = YES;
        _praiseButton.userInteractionEnabled = NO;
        _praiseNumberLabel.text = [NSString stringWithFormat:@"%d",[_praiseNumberLabel.text intValue] + 1];
        
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        
        [dic setObject:@"2" forKey:@"type"];
//        [dic setObject:self.loginUserData] forKey:@"fromUser"];
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isTourist"]){

        }
        
               //接口请求
//        [_moveArrOne insertObject:dic atIndex:d+1];
        
        NSLog(@"--------- %@",_moveArrOne);
        NSLog(@"--------- %@",self.loginUserData);
        
        NSDictionary *parmasDic = [NSDictionary new];
        
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isTourist"]){
        
        parmasDic = @{@"userId":self.loginUserData[@"userId"],@"isVisitor":self.loginUserData[@"flag"],@"token":@"",@"pictureId":self.imageDic[@"pictureId"],@"fromUserId":self.loginUserData[@"userId"],@"toUserId":self.imageDic[@"author"][@"userId"],@"content":@"",@"type":@"2"};
        }else{
         parmasDic = @{@"userId":self.loginUserData[@"userId"],@"token":self.loginUserData[@"token"],@"isVisitor":self.loginUserData[@"isVisitor"],@"pictureId":self.imageDic[@"pictureId"],@"fromUserId":self.loginUserData[@"userId"],@"toUserId":self.imageDic[@"author"][@"userId"],@"content":@"",@"type":@"2"};
        }
        
        //请求地址
        NSString * methodStr = @"comment/doComment.cmd";
        //向后台请求提交的参数
        
        
        [WebRequest webRequestWithURLMethod:methodStr parmas:parmasDic success:^(id result) {
            /*
             请求返回数据
             */
            
            NSLog(@"成功啦 == %@",result);
            
        }fail:^(NSString *result) {
            NSLog(@"失败了！");
        }];

        
    }
    
    if (sender.tag == 1001) {
        _bigView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _bigView.backgroundColor = BACKGROUND_PUPCOLOR;
        _bigView.alpha = 0.9;
        [self.view addSubview:_bigView];
        
        self.navigationController.navigationBarHidden = YES;
        
        UIButton *returnBackButton = [[UIButton alloc]initWithFrame:CGRectMake(325*HEIGHT_LENTH, 20*HEIGHT_LENTH, 50*HEIGHT_LENTH, 30*HEIGHT_LENTH)];
        [returnBackButton setTitle:@"Back" forState:UIControlStateNormal];
        [returnBackButton addTarget:self action:@selector(pressReturnBack) forControlEvents:UIControlEventTouchUpInside];
        [_bigView addSubview:returnBackButton];
        
        
        for (int i = 0; i < 4 ; i++) {
            for (int j = 0; j < 5; j++) {
                
                UIImageView * bigImageView = [[UIImageView alloc]initWithFrame:CGRectMake(16 *HEIGHT_LENTH+ i * 89.75*HEIGHT_LENTH, 60*HEIGHT_LENTH + j * 89*HEIGHT_LENTH , 76*HEIGHT_LENTH , 76*HEIGHT_LENTH)];
                bigImageView.layer.masksToBounds = YES;
                bigImageView.layer.cornerRadius = bigImageView.frame.size.width / 2;
                [bigImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.find1000.com/ywkj-find-app-server/image/bigEmogj/%d.png",(j+1)*i ]] placeholderImage:[UIImage imageNamed:@"默认头像.jpg"]];
                [_bigView addSubview:bigImageView];
                
                
                UIButton * bigImageViewButton = [[UIButton alloc]initWithFrame:CGRectMake(16*HEIGHT_LENTH + i * 89.75*HEIGHT_LENTH, 40*HEIGHT_LENTH + j * 89*HEIGHT_LENTH , 76 *HEIGHT_LENTH, 76*HEIGHT_LENTH)];
                [bigImageViewButton addTarget:self action:@selector(pressBigImageViewButton:) forControlEvents:UIControlEventTouchUpInside];
                bigImageViewButton.layer.masksToBounds = YES;
                bigImageViewButton.layer.cornerRadius = bigImageViewButton.frame.size.width / 2;
                bigImageViewButton.tag = j;
                [_bigView addSubview:bigImageViewButton];
                
//                [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
                
                
            }
        }
        

    }
    
    if (sender.tag == 1002) {

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
        if(self.key==nil){
            self.key=[[YcKeyBoardView alloc]initWithFrame:CGRectMake(0, kWinSize.height-44, kWinSize.width, 44)];
        }
        self.key.delegate=self;
        [self.key.textView becomeFirstResponder];
        self.key.textView.returnKeyType=UIReturnKeySend;
        self.key.textView.transform = CGAffineTransformMakeTranslation(0, -60);
        
        [self.view addSubview:self.key];
    }
    if (sender.tag == 1003) {
        
#pragma - 其他
        
        POPBasicAnimation * anbasic = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        anbasic.toValue = @(_downView.center.y- 267);
        anbasic.beginTime = CACurrentMediaTime();
        [_downView pop_addAnimation:anbasic forKey:@"positionY"];
    
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(processTap)];
        [_downView addGestureRecognizer:tap];
    }
}


- (void)processTap{

    POPBasicAnimation * anbasic = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anbasic.toValue = @(_downView.center.y + 267);
    anbasic.beginTime = CACurrentMediaTime();
    [_downView pop_addAnimation:anbasic forKey:@"positionY"];
    
}

#pragma mark - 头像点击事件
- (void)pressButton{
//    PersonalCenterCollectionViewController * personVC = [[PersonalCenterCollectionViewController alloc]initWithNibName:@"PersonalCenterCollectionViewController" bundle:nil];
    
//    [self.navigationController pushViewController:personVC animated:YES];
}

- (void)respondsToLeftNavigationItem:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pressOtherButton:(UIButton *)sender{
    
    if (sender.tag == 3000) {
        
    }
    
    if (sender.tag == 3001) {
        
    }
    
    if (sender.tag == 3002) {
        
    }
    
    
    if (sender.tag == 3003) {
        
    }
    
    if (sender.tag == 3004) {
        
    }
    
    if (sender.tag == 4000) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@" \n亲，如果屏蔽此人以后将不会看到他发分享的照片哦！确定要屏蔽吗？" delegate:nil cancelButtonTitle:@"无情的屏蔽" otherButtonTitles:@"手抖啦", nil];
        [alert show];
    }
    
    if (sender.tag == 4001) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定举报这张照片" delegate:nil cancelButtonTitle:@"我要告老师" otherButtonTitles:@"好吧，饶了你", nil];
        [alert show];
    }
    
    if (sender.tag == 4002) {
        UIImageWriteToSavedPhotosAlbum(_bgImageView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    }
    
    
}

#pragma  mark - 把图片保存到本地相册
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"保存成功！";
    if (!error) {
        UIAlertView * alterView = [[UIAlertView alloc]initWithTitle:@"恭喜您!" message:@"成功保存到相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
    }else
    {
        message = [error description];
        UIAlertView * alterView = [[UIAlertView alloc]initWithTitle:@"很遗憾!" message:@"保存到相册失败!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
    }
    NSLog(@"message is %@",message);
}


#pragma mark - 大表情退出按钮
- (void)pressReturnBack{
    [_bigView removeFromSuperview];
//    self.navigationController.navigationBarHidden = NO;
}


- (void)pressBigImageViewButton:(UIButton *)sender{
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    if (sender.tag  == 0 ) {

//            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//            [dic setObject:@"3" forKey:@"type"];
//            [dic setObject:_moveArrOne[d][@"fromUser"] forKey:@"fromUser"];
//        [dic setObject:@"1" forKey:@"content"];
//        [_moveArrOne insertObject:dic atIndex:d+1];
        
    }
    if (sender.tag  == 1 ) {
//        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//        [dic setObject:@"3" forKey:@"type"];
//        [dic setObject:_moveArrOne[d][@"fromUser"] forKey:@"fromUser"];
//        [dic setObject:@"2" forKey:@"content"];
//        [_moveArrOne insertObject:dic atIndex:d+1];
    }
    if (sender.tag  == 2 ) {
//        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//        [dic setObject:@"3" forKey:@"type"];
//        [dic setObject:_moveArrOne[d][@"fromUser"] forKey:@"fromUser"];
//        [dic setObject:@"3" forKey:@"content"];
//        [_moveArrOne insertObject:dic atIndex:d+1];
    }
    if (sender.tag  == 3 ) {
//        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//        [dic setObject:@"3" forKey:@"type"];
//        [dic setObject:_moveArrOne[d][@"fromUser"] forKey:@"fromUser"];
//        [dic setObject:@"4" forKey:@"content"];
//        [_moveArrOne insertObject:dic atIndex:d+1];
    }
    if (sender.tag  == 4 ) {
//        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//        [dic setObject:@"3" forKey:@"type"];
//        [dic setObject:_moveArrOne[d][@"fromUser"] forKey:@"fromUser"];
//        [dic setObject:@"5" forKey:@"content"];
//        [_moveArrOne insertObject:dic atIndex:d+1];
    }
    
    [_bigView removeFromSuperview];
    self.navigationController.navigationBarHidden = NO;
}





#pragma mark - 自定义键盘
-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    self.keyBoardHeight=deltaY;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.key.transform=CGAffineTransformMakeTranslation(0, -deltaY);
    }];
}
-(void)keyboardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.key.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        self.key.textView.text=@"";
        [self.key removeFromSuperview];
    }];
    
}

#pragma mark - 封装键盘输入数据
-(void)keyBoardViewHide:(YcKeyBoardView *)keyBoardView textView:(UITextView *)contentView
{
    [contentView resignFirstResponder];
    
    if ([contentView.text isEqual:[NSNull null]]) {
        
    }else{
//        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//        //    [dic setObject:_moveArrOne[d][@"fromUser"] forKey:@"toUser"];
//        [dic setObject:@"1" forKey:@"type"];
//        [dic setObject:contentView.text forKey:@"content"];
//        [dic setObject:_moveArrOne[d][@"fromUser"] forKey:@"fromUser"];
//        [dic setObject:_moveArrOne[d][@"fromUser"] forKey:@"toUser"];
//        
//        //接口请求
//        [_moveArrOne insertObject:dic atIndex:d+1];

    }

}



#pragma mark - 弹幕实现

//- (void)setMoveView{
//    
//    if ([_moveArrOne[d] isEqual:[NSNull null]]) {
//        
//    }else{
//
//    // 延迟2秒执行：
//    double delayInSeconds = 0;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        // code to be executed on the main queue after delay
//        
//            [move removeFromSuperview];
//        
//        if ([_moveArrOne[d][@"toUser"] isEqual:[NSNull null]]) {
//
//            move  = [[MoveView alloc]initWithFrame:CGRectMake(500, 100, 200, 50) NSMutableDictionary:_moveArrOne[d]];
//        }else{
//            move  = [[MoveView alloc]initWithFrame:CGRectMake(500, 100, 260, 50) NSMutableDictionary:_moveArrOne[d]];
//        
//        }
//            [move.headButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
//            [move.headTwoButton addTarget:self action:@selector(pressHeadTwoButton:) forControlEvents:UIControlEventTouchUpInside];
//            [move.content addTarget:self action:@selector(pressContent:) forControlEvents:UIControlEventTouchUpInside];
//            move.headButton.tag = d;
//            move.headTwoButton.tag = d;
//            move.content.tag = d;
//            [_bgImageView addSubview:move];
//            a = 0 ;
//    });
//        
//    }
//}
//
//
//- (void)setMoveView2{
//    
//    if ([_moveArrOne[d] isEqual:[NSNull null]]) {
//        
//    }else{
//        
//        // 延迟2秒执行：
//        double delayInSeconds = 0;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            // code to be executed on the main queue after delay
//            
//            [move1 removeFromSuperview];
//            
//            if ([_moveArrOne[d][@"toUser"] isEqual:[NSNull null]]) {
//                
//                move1  = [[MoveView alloc]initWithFrame:CGRectMake(500, 100, 200, 50) NSMutableDictionary:_moveArrOne[d]];
//            }else{
//                move1  = [[MoveView alloc]initWithFrame:CGRectMake(500, 100, 260, 50) NSMutableDictionary:_moveArrOne[d]];
//                
//            }
//            [move1.headButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
//            [move1.headTwoButton addTarget:self action:@selector(pressHeadTwoButton:) forControlEvents:UIControlEventTouchUpInside];
//            [move1.content addTarget:self action:@selector(pressContent:) forControlEvents:UIControlEventTouchUpInside];
//            move1.headButton.tag = d;
//            move1.headTwoButton.tag = d;
//            move1.content.tag = d;
//            [_bgImageView addSubview:move1];
//            b = 0 ;
//        });
//        
//    }
//}
//
//- (void)setMoveView3{
//    
//    if ([_moveArrOne[d] isEqual:[NSNull null]]) {
//        
//    }else{
//        
//        // 延迟2秒执行：
//        double delayInSeconds = 0;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            // code to be executed on the main queue after delay
//            
//            [move2 removeFromSuperview];
//            
//            if ([_moveArrOne[d][@"toUser"] isEqual:[NSNull null]]) {
//                
//                move2  = [[MoveView alloc]initWithFrame:CGRectMake(500, 100, 200, 50) NSMutableDictionary:_moveArrOne[d]];
//            }else{
//                move2  = [[MoveView alloc]initWithFrame:CGRectMake(500, 100, 260, 50) NSMutableDictionary:_moveArrOne[d]];
//                
//            }
//            [move2.headButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
//            [move2.headTwoButton addTarget:self action:@selector(pressHeadTwoButton:) forControlEvents:UIControlEventTouchUpInside];
//            [move2.content addTarget:self action:@selector(pressContent:) forControlEvents:UIControlEventTouchUpInside];
//            move2.headButton.tag = d;
//            move2.headTwoButton.tag = d;
//            move2.content.tag = d;
//            [_bgImageView addSubview:move2];
//            c = 0 ;
//        });
//        
//    }
//
//}
//
//- (void)changeTimeAtTimedisplay{
//    a++;
//    b++;
//    c++;
//    move.transform = CGAffineTransformMakeTranslation(-a, 0);
//    
//    if (move.frame.origin.x + move.frame.size.width  ==  -200) {
//        [move removeFromSuperview];
//        [self setMoveView];
//        a = 0;
//    }
//    
//    move1.transform = CGAffineTransformMakeTranslation(-b, 0);
//    
//    if (move1.frame.origin.x + move1.frame.size.width  ==  -200) {
//        [move1 removeFromSuperview];
//        [self setMoveView];
//        b = 0;
//    }
//    
//    move2.transform = CGAffineTransformMakeTranslation(-c, 0);
//    
//    if (move2.frame.origin.x + move2.frame.size.width  ==  -200) {
//        [move2 removeFromSuperview];
//        [self setMoveView];
//        c = 0;
//    }
//    
//    if (move.frame.origin.x+ move.frame.size.width == 450) {
//        [self setMoveView2];
//        d++;
//        [self check];
//    }
//    
//    if (move1.frame.origin.x+ move1.frame.size.width == 450) {
//        [self setMoveView3];
//        d++;
//        [self check];
//    }
//    
//    if (move2.frame.origin.x + move2.frame.size.width== 450) {
//        [self setMoveView];
//        d++;
//        [self check];
//    }
//}
//
//
//- (void)check{
//    if (d == _moveArrOne.count) {
//        d = 0;
//    }
//}
//
//
//- (void)checkTwo{
//
//    if (h == _moveArrTwo.count) {
//        h = 0;
//    }
//}
//
//
//
//#pragma mark - 第二行弹幕
//
//- (void)setMoveTwoView{
//    
//    if ([_moveArrTwo[h] isEqual:[NSNull null]]) {
//        
//    }else{
//        
//        // 延迟2秒执行：
//        double delayInSeconds = 0;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            // code to be executed on the main queue after delay
//            
//            [moveTwo removeFromSuperview];
//            
//            if ([_moveArrTwo[h][@"toUser"] isEqual:[NSNull null]]) {
//                
//                moveTwo  = [[MoveView alloc]initWithFrame:CGRectMake(550, 200, 200, 50) NSMutableDictionary:_moveArrTwo[h]];
//            }else{
//                moveTwo  = [[MoveView alloc]initWithFrame:CGRectMake(550, 200, 260, 50) NSMutableDictionary:_moveArrTwo[h]];
//                
//            }
//            [moveTwo.headButton addTarget:self action:@selector(pressTwoButton:) forControlEvents:UIControlEventTouchUpInside];
//            [moveTwo.headTwoButton addTarget:self action:@selector(pressHeadTwoTwoButton:) forControlEvents:UIControlEventTouchUpInside];
//            [moveTwo.content addTarget:self action:@selector(pressTwoContent:) forControlEvents:UIControlEventTouchUpInside];
//            moveTwo.headButton.tag = h;
//            moveTwo.headTwoButton.tag = h;
//            moveTwo.content.tag = h;
//            [_bgImageView addSubview:moveTwo];
//            e = 0 ;
//        });
//        
//    }
//}
//
//
//- (void)setMoveTwoView2{
//    
//    if ([_moveArrTwo[h] isEqual:[NSNull null]]) {
//        
//    }else{
//        
//        // 延迟2秒执行：
//        double delayInSeconds = 0;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            // code to be executed on the main queue after delay
//            
//            [moveTwo1 removeFromSuperview];
//            
//            if ([_moveArrTwo[h][@"toUser"] isEqual:[NSNull null]]) {
//                
//                moveTwo1  = [[MoveView alloc]initWithFrame:CGRectMake(550, 200, 200, 50) NSMutableDictionary:_moveArrTwo[h]];
//            }else{
//                moveTwo1  = [[MoveView alloc]initWithFrame:CGRectMake(550, 200, 260, 50) NSMutableDictionary:_moveArrTwo[h]];
//                
//            }
//            [moveTwo1.headButton addTarget:self action:@selector(pressTwoButton:) forControlEvents:UIControlEventTouchUpInside];
//            [moveTwo1.headTwoButton addTarget:self action:@selector(pressHeadTwoTwoButton:) forControlEvents:UIControlEventTouchUpInside];
//            [moveTwo1.content addTarget:self action:@selector(pressTwoContent:) forControlEvents:UIControlEventTouchUpInside];
//            moveTwo1.headButton.tag = h;
//            moveTwo1.headTwoButton.tag = h;
//            moveTwo1.content.tag = h;
//            [_bgImageView addSubview:moveTwo1];
//            f = 0 ;
//        });
//        
//    }
//}
//
//- (void)setMoveTwoView3{
//    
//    if ([_moveArrTwo[h] isEqual:[NSNull null]]) {
//        
//    }else{
//        
//        // 延迟2秒执行：
//        double delayInSeconds = 0;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            // code to be executed on the main queue after delay
//            
//            [moveTwo2 removeFromSuperview];
//            
//            if ([_moveArrTwo[h][@"toUser"] isEqual:[NSNull null]]) {
//                
//                moveTwo2  = [[MoveView alloc]initWithFrame:CGRectMake(550, 200, 200, 50) NSMutableDictionary:_moveArrTwo[h]];
//            }else{
//                moveTwo2  = [[MoveView alloc]initWithFrame:CGRectMake(550, 200, 260, 50) NSMutableDictionary:_moveArrTwo[h]];
//                
//            }
//            [moveTwo2.headButton addTarget:self action:@selector(pressTwoButton:) forControlEvents:UIControlEventTouchUpInside];
//            [moveTwo2.headTwoButton addTarget:self action:@selector(pressHeadTwoTwoButton:) forControlEvents:UIControlEventTouchUpInside];
//            [moveTwo2.content addTarget:self action:@selector(pressTwoContent:) forControlEvents:UIControlEventTouchUpInside];
//            moveTwo2.headButton.tag = h;
//            moveTwo2.headTwoButton.tag = h;
//            moveTwo2.content.tag = h;
//            [_bgImageView addSubview:moveTwo2];
//            g = 0 ;
//        });
//        
//    }
//    
//}
//
//- (void)changeTimeAtTimedisplayTwo{
//    e++;
//    f++;
//    g++;
//    moveTwo.transform = CGAffineTransformMakeTranslation(-e, 0);
//    
//    if (moveTwo.frame.origin.x + moveTwo.frame.size.width  ==  -200) {
//        [moveTwo removeFromSuperview];
//        [self setMoveTwoView];
//        e = 0;
//    }
//    
//    moveTwo1.transform = CGAffineTransformMakeTranslation(-f, 0);
//    
//    if (moveTwo1.frame.origin.x + moveTwo1.frame.size.width  ==  -200) {
//        [moveTwo1 removeFromSuperview];
//        [self setMoveTwoView];
//        f = 0;
//    }
//    
//    moveTwo2.transform = CGAffineTransformMakeTranslation(-g, 0);
//    
//    if (moveTwo2.frame.origin.x + moveTwo2.frame.size.width  ==  -200) {
//        [moveTwo2 removeFromSuperview];
//        [self setMoveTwoView];
//        g = 0;
//    }
//    
//    if (moveTwo.frame.origin.x+ moveTwo.frame.size.width == 500) {
//        [self setMoveTwoView2];
//        h++;
//        [self checkTwo];
//    }
//    
//    if (moveTwo1.frame.origin.x+ moveTwo1.frame.size.width == 500) {
//        [self setMoveTwoView3];
//        h++;
//        [self checkTwo];
//    }
//    
//    if (moveTwo2.frame.origin.x+ moveTwo2.frame.size.width == 500) {
//        [self setMoveTwoView];
//        h++;
//        [self checkTwo];
//    }
//}



- (void)pressBackButton{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pressContent:(UIButton *)sender{
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    if(self.key==nil){
        self.key=[[YcKeyBoardView alloc]initWithFrame:CGRectMake(0, kWinSize.height-44, kWinSize.width, 44)];
    }
    self.key.delegate=self;
    [self.key.textView becomeFirstResponder];
    self.key.textView.returnKeyType=UIReturnKeySend;
    self.key.textView.transform = CGAffineTransformMakeTranslation(0, -60);
    
    [self.view addSubview:self.key];
    
    
}


- (void)pressHeadTwoButton:(UIButton *)sender{
    
    NSLog(@"%ld",(long)sender.tag);
//    PersonalCenterCollectionViewController * personVC = [[PersonalCenterCollectionViewController alloc]initWithNibName:@"PersonalCenterCollectionViewController" bundle:nil];
//    [self.navigationController pushViewController:personVC animated:YES];
    
    
}


- (void)pressButton:(UIButton *)sender{
    NSLog(@"%ld",(long)sender.tag);
//    PersonalCenterCollectionViewController * personVC = [[PersonalCenterCollectionViewController alloc]initWithNibName:@"PersonalCenterCollectionViewController" bundle:nil];
//    [self.navigationController pushViewController:personVC animated:YES];
    
}


- (void)pressTwoContent:(UIButton *)sender{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    if(self.key==nil){
        self.key=[[YcKeyBoardView alloc]initWithFrame:CGRectMake(0, kWinSize.height-44, kWinSize.width, 44)];
    }
    self.key.delegate=self;
    [self.key.textView becomeFirstResponder];
    self.key.textView.returnKeyType=UIReturnKeySend;
    self.key.textView.transform = CGAffineTransformMakeTranslation(0, -60);
    
    [self.view addSubview:self.key];
    
    
}


- (void)pressHeadTwoTwoButton:(UIButton *)sender{
    
    NSLog(@"%ld",(long)sender.tag);
//    PersonalCenterCollectionViewController * personVC = [[PersonalCenterCollectionViewController alloc]initWithNibName:@"PersonalCenterCollectionViewController" bundle:nil];
//    [self.navigationController pushViewController:personVC animated:YES];
    
    
}


- (void)pressTwoButton:(UIButton *)sender{
    NSLog(@"%ld",(long)sender.tag);
//    PersonalCenterCollectionViewController * personVC = [[PersonalCenterCollectionViewController alloc]initWithNibName:@"PersonalCenterCollectionViewController" bundle:nil];
//    [self.navigationController pushViewController:personVC animated:YES];
    
}





@end
