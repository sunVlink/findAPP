//
//  PersonalDataViewController.m
//  SquareDemo1.1
//
//  Created by APPLE on 15/7/14.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "PersonalDataViewController.h"

@interface PersonalDataViewController ()
{
    UIButton * _headButton;
}

@property (retain, nonatomic)UIImageView *imageView;
@property (nonatomic,strong)UITextField * nickNameTextFiled;
@property (nonatomic,strong)UIButton * sexButton;
@property (nonatomic,strong)UIButton * birthdayButton;
@property (nonatomic,strong)UIButton * addressButton;
@property (nonatomic,strong)UIButton * passwordChangeButton;

@end

@implementation PersonalDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationController.navigationBarHidden = YES;
 
    UIImageView * backGroundView = [[UIImageView alloc]initWithFrame:self.view.frame];
    backGroundView.backgroundColor = BACKGROUND_PUPCOLOR;
    backGroundView.userInteractionEnabled = YES;
    [self.view addSubview:backGroundView];
    
    
    UILabel * personCenterLabel = [[UILabel alloc]initWithFrame:CGRectMake(100*WIDTH_LENTH, 35*HEIGHT_LENTH, 175*WIDTH_LENTH, 21*HEIGHT_LENTH)];
    personCenterLabel.text = @"个人中心";
    personCenterLabel.font = [UIFont systemFontOfSize:20*HEIGHT_LENTH];
    personCenterLabel.textAlignment = YES;
    personCenterLabel.textColor = MAIN_YELLOWCOLOR;
    [backGroundView addSubview:personCenterLabel];
    
    UIButton * backButton = [[UIButton alloc]initWithFrame:CGRectMake(15*WIDTH_LENTH, 35*HEIGHT_LENTH, 11*WIDTH_LENTH, 21*HEIGHT_LENTH)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(pressBackButton) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:backButton];
    
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 106*WIDTH_LENTH) / 2 , 100*HEIGHT_LENTH, 90*WIDTH_LENTH, 90*WIDTH_LENTH)];
    self.imageView.layer.masksToBounds = YES;
    [self.imageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.find1000.com/ywkj-find-app-server/%@",self.userData[@"data"][@"avatar"]]] andPlaceholderImage:[UIImage imageNamed:@"默认头像.jpg"] options:SDWebImageTransformAnimatedImage progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    self.imageView.layer.borderColor = MAIN_YELLOWCOLOR.CGColor;
    self.imageView.layer.borderWidth = 3*WIDTH_LENTH;
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width/2;
    [backGroundView addSubview:self.imageView];
    
    _headButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 90*WIDTH_LENTH, 90*WIDTH_LENTH)];
    _headButton.center = self.imageView.center;
    _headButton.backgroundColor = [UIColor clearColor];
    _headButton.layer.masksToBounds = YES;
    _headButton.layer.cornerRadius = _headButton.frame.size.width / 2;
    [_headButton addTarget:self action:@selector(pressHeadButton) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:_headButton];
    
    
    
    NSArray * titleNameArr = [[NSArray alloc]initWithObjects:@"ID号",@"昵称",@"性别",@"生日",@"地区",@"手机号",@"修改密码",@"绑定帐号", nil];
    
    NSString * sex = [NSString new];
    if ([self.userData[@"data"][@"gender"] isEqual:@1]) {
        sex = @"男";
    }else{
       sex = @"女";
    }
    
    NSString * phoneNumber = [NSString stringWithFormat:@"%@",self.userData[@"data"][@"phoneNumber"]];
    
//    NSArray * detailArr = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%@",self.userData[@"data"][@"openId"]],self.userData[@"data"][@"nickName"],sex,self.userData[@"data"][@"birthDate"], self.userData[@"data"][@"city"],[NSString stringWithFormat:@"%@****%@",[phoneNumber substringToIndex:3],[phoneNumber substringFromIndex:7]],@"修改",nil];
    
    for (int i = 0; i < 8; i++) {
        
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15*WIDTH_LENTH, (220+40*i)*HEIGHT_LENTH,100*WIDTH_LENTH , 30*HEIGHT_LENTH)];
        titleLabel.text = titleNameArr[i];
        titleLabel.textColor = MAIN_YELLOWCOLOR;
        titleLabel.font = [UIFont systemFontOfSize:18*WIDTH_LENTH];
        [backGroundView addSubview:titleLabel];
        
        UIImageView * smallLine = [[UIImageView alloc]initWithFrame:CGRectMake(115*WIDTH_LENTH,(220+40*i)*HEIGHT_LENTH, 1, 20*HEIGHT_LENTH)];
        [smallLine setImage:[UIImage imageNamed:@"短线.png"]];
        [backGroundView addSubview:smallLine];
        
        UIImageView * lineOne = [[UIImageView alloc]initWithFrame:CGRectMake(10*WIDTH_LENTH, 250*HEIGHT_LENTH + i * 40*HEIGHT_LENTH, self.view.frame.size.width - 10*2*WIDTH_LENTH ,1)];
        [lineOne setImage:[UIImage imageNamed:@"底线，W710，H1.png"]];
        [backGroundView addSubview:lineOne];
    }
    
    

        UILabel * idLabel = [[UILabel alloc]initWithFrame:CGRectMake(130*WIDTH_LENTH, 220*HEIGHT_LENTH,200*WIDTH_LENTH , 30*HEIGHT_LENTH)];
        idLabel.text = [NSString stringWithFormat:@"%@",self.userData[@"data"][@"openId"]];
        idLabel.textAlignment = YES;
        idLabel.textColor = MAIN_YELLOWCOLOR;
        idLabel.font = [UIFont systemFontOfSize:18*WIDTH_LENTH];
        [backGroundView addSubview:idLabel];



    self.nickNameTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(130*WIDTH_LENTH, 260*HEIGHT_LENTH,200*WIDTH_LENTH , 30*HEIGHT_LENTH)];
    self.nickNameTextFiled.backgroundColor = [UIColor redColor];
    self.nickNameTextFiled.textAlignment = YES;
    self.nickNameTextFiled.textColor = MAIN_YELLOWCOLOR;
    self.nickNameTextFiled.font = [UIFont systemFontOfSize:18*WIDTH_LENTH];
    self.nickNameTextFiled.text = self.userData[@"data"][@"nickName"];
    [backGroundView addSubview:self.nickNameTextFiled];
    
    self.sexButton = [[UIButton alloc]initWithFrame:CGRectMake(130*WIDTH_LENTH, 300*HEIGHT_LENTH,200*WIDTH_LENTH , 30*HEIGHT_LENTH)];
    self.sexButton.backgroundColor = [UIColor greenColor];
    self.sexButton.titleLabel.textAlignment = YES;
    [self.sexButton setTitleColor:MAIN_YELLOWCOLOR forState:UIControlStateNormal];
    self.sexButton.titleLabel.font = [UIFont systemFontOfSize:18*WIDTH_LENTH];
    [self.sexButton setTitle:sex forState:UIControlStateNormal];
    [backGroundView addSubview:self.sexButton];
    
    self.birthdayButton = [[UIButton alloc]initWithFrame:CGRectMake(130*WIDTH_LENTH, 340*HEIGHT_LENTH,200*WIDTH_LENTH , 30*HEIGHT_LENTH)];
    self.birthdayButton.backgroundColor = [UIColor grayColor];
    self.birthdayButton.titleLabel.textAlignment = YES;
    [self.birthdayButton setTitleColor:MAIN_YELLOWCOLOR forState:UIControlStateNormal];
    self.birthdayButton.titleLabel.font = [UIFont systemFontOfSize:18*WIDTH_LENTH];
    [self.birthdayButton setTitle:self.userData[@"data"][@"birthDate"] forState:UIControlStateNormal];
    [backGroundView addSubview:self.birthdayButton];
    
    self.addressButton = [[UIButton alloc]initWithFrame:CGRectMake(130*WIDTH_LENTH, 380*HEIGHT_LENTH,200*WIDTH_LENTH , 30*HEIGHT_LENTH)];
    self.addressButton.backgroundColor = [UIColor grayColor];
    self.addressButton.titleLabel.textAlignment = YES;
    [self.addressButton setTitleColor:MAIN_YELLOWCOLOR forState:UIControlStateNormal];
    self.addressButton.titleLabel.font = [UIFont systemFontOfSize:18*WIDTH_LENTH];
    [self.addressButton setTitle:self.userData[@"data"][@"city"] forState:UIControlStateNormal];
    [backGroundView addSubview:self.addressButton];
    
    UILabel * phoneNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(130*WIDTH_LENTH, 420*HEIGHT_LENTH,200*WIDTH_LENTH , 30*HEIGHT_LENTH)];
    phoneNumberLabel.text = 
    phoneNumberLabel.textAlignment = YES;
    phoneNumberLabel.textColor = MAIN_YELLOWCOLOR;
    phoneNumberLabel.font = [UIFont systemFontOfSize:18*WIDTH_LENTH];
    [backGroundView addSubview:phoneNumberLabel];
    
    
    
    self.passwordChangeButton = [[UIButton alloc]initWithFrame:CGRectMake(130*WIDTH_LENTH, 460*HEIGHT_LENTH,200*WIDTH_LENTH , 30*HEIGHT_LENTH)];
    self.passwordChangeButton.backgroundColor = [UIColor grayColor];
    self.passwordChangeButton.titleLabel.textAlignment = YES;
    [self.passwordChangeButton setTitleColor:MAIN_YELLOWCOLOR forState:UIControlStateNormal];
    self.passwordChangeButton.titleLabel.font = [UIFont systemFontOfSize:18*WIDTH_LENTH];
    [self.passwordChangeButton setTitle:@"修改" forState:UIControlStateNormal];
    [backGroundView addSubview:self.passwordChangeButton];

    

}



- (void)pressBackButton{

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)pressHeadButton{

    UIActionSheet *sheet;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
