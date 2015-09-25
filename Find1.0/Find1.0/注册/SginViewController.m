//
//  SginViewController.m
//  SquareDemo1.1
//
//  Created by APPLE on 15/7/7.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "SginViewController.h"
#import "TSLocateView.h"
#import "PhoneBindViewController.h"

@interface SginViewController ()<UITextFieldDelegate>
{
    UITextField * _nickNameTextField;
    UITextField * _passWordTextField;
    UIButton * _addressButton;
    UIButton * _birthdayButton;
    UIButton * _sexButton;
    UIButton * _headButton;
    UIAlertView * _alterView;
    
    
    UIButton * testButton;
    int a;
    
    UIDatePicker * _birthdayPicker;
    UITapGestureRecognizer * _oneTap;
    
    BOOL isFullScreen;
    
}
@property (nonatomic,strong)UIDatePicker * datePicker;
@property (nonatomic,strong)TAlertView * tipsView;


@end

@implementation SginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self initWithUserinterface];
    
}


- (void)initWithUserinterface{

    UIImageView * backGroundView = [[UIImageView alloc]initWithFrame:self.view.frame];
    [backGroundView setImage:[UIImage imageNamed:@"背景.png"]];
    backGroundView.userInteractionEnabled = YES;
    [self.view addSubview:backGroundView];
    
    UIButton * backButton = [[UIButton alloc]initWithFrame:CGRectMake(15*WIDTH_LENTH, 35*HEIGHT_LENTH, 11*WIDTH_LENTH, 21*HEIGHT_LENTH)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(pressBackButton) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:backButton];
    
    
    UIView * headview = [[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 106*WIDTH_LENTH) / 2 , 80*HEIGHT_LENTH, 110*WIDTH_LENTH, 110*WIDTH_LENTH)];
    headview.backgroundColor = MAIN_YELLOWCOLOR;
    headview.layer.masksToBounds = YES;
    headview.layer.cornerRadius = headview.frame.size.width / 2;
    [backGroundView addSubview:headview];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100*WIDTH_LENTH, 100*WIDTH_LENTH)];
    self.imageView.center = headview.center;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width/2;
    [backGroundView addSubview:self.imageView];
    
    _headButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100*WIDTH_LENTH, 100*WIDTH_LENTH)];
    _headButton.center = headview.center;
    _headButton.backgroundColor = [UIColor clearColor];
    _headButton.layer.masksToBounds = YES;
    _headButton.layer.cornerRadius = _headButton.frame.size.width / 2;
    [_headButton addTarget:self action:@selector(pressHeadButton) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:_headButton];
    
    UIButton * cameraButton = [[UIButton alloc]initWithFrame:CGRectMake(215*WIDTH_LENTH, 155*HEIGHT_LENTH, 30*WIDTH_LENTH, 30*WIDTH_LENTH)];
    [cameraButton setBackgroundImage:[UIImage imageNamed:@"小相机.png"] forState:UIControlStateNormal];
    cameraButton.layer.masksToBounds = YES;
    cameraButton.layer.cornerRadius = cameraButton.frame.size.width/2;
    [backGroundView addSubview:cameraButton];
    
    
    UILabel * login = [[UILabel alloc]initWithFrame:CGRectMake(150*WIDTH_LENTH, 35*HEIGHT_LENTH, 75*WIDTH_LENTH, 21*HEIGHT_LENTH)];
    login.text = @"注册";
    login.font = [UIFont systemFontOfSize:20*HEIGHT_LENTH];
    login.textAlignment = YES;
    login.textColor = MAIN_YELLOWCOLOR;
    [backGroundView addSubview:login];
    
    NSArray * smallArr = [[NSArray alloc]initWithObjects:@"昵称.png",@"密码.png",@"定位.png",@"身份证.png",@"性别.png", nil];
    NSArray * cleanArr = [[NSArray alloc]initWithObjects:@"删除，W30，H30.png",@"显示，W30,H24.png", nil];
    
    for (int i = 0; i < 5; i++) {
        
        UIImageView * smallImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30*WIDTH_LENTH, (215+47*i)*HEIGHT_LENTH, 12*WIDTH_LENTH, 17*HEIGHT_LENTH)];
        [smallImageView setImage:[UIImage imageNamed:smallArr[i]]];
        [backGroundView addSubview:smallImageView];
        
        
        if (i < 2) {
            UIButton * cleanButton = [[UIButton alloc]initWithFrame:CGRectMake(343*WIDTH_LENTH, (215+47*i)*HEIGHT_LENTH, 15*WIDTH_LENTH, 15*HEIGHT_LENTH)];
            [cleanButton setBackgroundImage:[UIImage imageNamed:cleanArr[i]] forState:UIControlStateNormal];
            cleanButton.tag = i;
            [cleanButton addTarget:self action:@selector(pressCleanButton:) forControlEvents:UIControlEventTouchUpInside];
            [backGroundView addSubview:cleanButton];
        }
        
        UIImageView * lineOne = [[UIImageView alloc]initWithFrame:CGRectMake(10*WIDTH_LENTH, (243+47*i)*HEIGHT_LENTH, self.view.frame.size.width - 10*2*WIDTH_LENTH ,1)];
        [lineOne setImage:[UIImage imageNamed:@"底线，W710，H1.png"]];
        [backGroundView addSubview:lineOne];

    }
    
    _nickNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(45*WIDTH_LENTH, 212*HEIGHT_LENTH, 295*WIDTH_LENTH, 30*HEIGHT_LENTH)];
    _nickNameTextField.borderStyle = UITextBorderStyleNone;
    _nickNameTextField.placeholder = @"请输入昵称：";
    [_nickNameTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    _nickNameTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 0)];
    _nickNameTextField.leftViewMode = UITextFieldViewModeAlways;
    _nickNameTextField.delegate = self;
    [backGroundView addSubview:_nickNameTextField];
    
    
    _passWordTextField = [[UITextField alloc]initWithFrame:CGRectMake(45*WIDTH_LENTH, 259*HEIGHT_LENTH, 295*WIDTH_LENTH, 30*HEIGHT_LENTH)];
    _passWordTextField.borderStyle = UITextBorderStyleNone;
    _passWordTextField.placeholder = @"6-15位字符：";
    _passWordTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 0)];
    _passWordTextField.leftViewMode = UITextFieldViewModeAlways;
    [_passWordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    _passWordTextField.delegate = self;
    [backGroundView addSubview:_passWordTextField];
    
    
    _addressButton = [[UIButton alloc]initWithFrame:CGRectMake(45*WIDTH_LENTH, 306*HEIGHT_LENTH, 295*WIDTH_LENTH, 30*HEIGHT_LENTH)];
    [_addressButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_addressButton setTitle:@"选择地址：" forState:UIControlStateNormal];
    _addressButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _addressButton.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    [_addressButton addTarget:self action:@selector(pressAddressButton) forControlEvents:UIControlEventTouchUpInside];
    
    [backGroundView addSubview:_addressButton];
    
    
    _birthdayButton = [[UIButton alloc]initWithFrame:CGRectMake(45*WIDTH_LENTH, 353*HEIGHT_LENTH, 295*WIDTH_LENTH, 30*HEIGHT_LENTH)];

    [_birthdayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_birthdayButton setTitle:@"生日：" forState:UIControlStateNormal];
    _birthdayButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _birthdayButton.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    [_birthdayButton addTarget:self action:@selector(pressBirthdayButton) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:_birthdayButton];
    
    
    _sexButton = [[UIButton alloc]initWithFrame:CGRectMake(45*WIDTH_LENTH, 400*HEIGHT_LENTH, 295*WIDTH_LENTH, 30*HEIGHT_LENTH)];
    [_sexButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sexButton setTitle:@"性别：" forState:UIControlStateNormal];
    _sexButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _sexButton.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    [_sexButton addTarget:self action:@selector(pressSexButton:) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:_sexButton];
    
    
    UILabel * textlabel = [[UILabel alloc]initWithFrame:CGRectMake(10*WIDTH_LENTH, 440*HEIGHT_LENTH, 200*WIDTH_LENTH, 20*HEIGHT_LENTH)];
    textlabel.textColor = [UIColor grayColor];
    textlabel.font = [UIFont systemFontOfSize:13*WIDTH_LENTH];
    textlabel.text = @"注：注册后不能更改性别";
    [backGroundView addSubview:textlabel];
    
    UIButton * nextButton = [[UIButton alloc]initWithFrame:CGRectMake(10*WIDTH_LENTH, 470*HEIGHT_LENTH, 355*WIDTH_LENTH, 40*HEIGHT_LENTH)];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    nextButton.titleLabel.tintColor = MAIN_YELLOWCOLOR;
    [nextButton setBackgroundImage:[UIImage imageNamed:@"圆角矩形 5.png"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(pressNextButton) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:nextButton];
    
}

#pragma mark - 头像点击事件
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


#pragma mark - 下一步按钮点击事件
- (void)pressNextButton{
    
    if ([_nickNameTextField.text  isEqual: @""]) {
        self.tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"昵称不能为空!"];
        self.tipsView.timeToClose = 1;
        [self.tipsView show];
    }else if ([_passWordTextField.text  isEqual: @""]) {
        self.tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"密码不能为空!"];
        self.tipsView.timeToClose = 1;
        [self.tipsView show];
    }else if ([_addressButton.titleLabel.text  isEqual: @""]) {
        self.tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"地址不能为空!"];
        self.tipsView.timeToClose = 1;
        [self.tipsView show];
    }else if ([_birthdayButton.titleLabel.text  isEqual: @""]) {
        self.tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"生日不能为空!"];
        self.tipsView.timeToClose = 1;
        [self.tipsView show];
    }else if ([_sexButton.titleLabel.text  isEqual: @""]) {
        self.tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"性别不能为空!"];
        self.tipsView.timeToClose = 1;
        [self.tipsView show];
    }else if(_passWordTextField.text.length < 6){
        self.tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"密码最少为6位!"];
        self.tipsView.timeToClose = 1;
        [self.tipsView show];
    }else {
        PhoneBindViewController * phoneBindVC = [[PhoneBindViewController alloc]init];
        [self.navigationController pushViewController:phoneBindVC animated:YES];
    
    }

}

- (void)pressCleanButton:(UIButton *)sender{
    
    if (sender.tag == 0) {
      _nickNameTextField.text = @"";
    }else{
      _passWordTextField.secureTextEntry = NO;
    }
}




#pragma mark - 城市选择按钮点击事件
- (void)pressAddressButton{

    TSLocateView *locateView = [[TSLocateView alloc] initWithTitle:@"定位城市" delegate:self];
    [locateView showInView:self.view];
    
}

- (void)pressBirthdayButton{

#pragma mark - 添加点击手势
    _oneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OneTop)];
    _oneTap.numberOfTapsRequired = 1;
    _oneTap.delegate = self;
    [self.view addGestureRecognizer:_oneTap];
    
    _birthdayPicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 500*HEIGHT_LENTH, self.view.frame.size.width, 167*HEIGHT_LENTH)];
    _birthdayPicker.datePickerMode = UIDatePickerModeDate;
    
//    NSDate* minDate = [[NSDate alloc]initWithString:@"1900-01-01 00:00:00 -0500"];
//    NSDate* maxDate = [[NSDate alloc]initWithString:@"2015-01-01 00:00:00 -0500"];
    
    [ _birthdayPicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
//    _birthdayPicker.minimumDate = minDate;
//    _birthdayPicker.maximumDate = maxDate;
    
    [self.view addSubview:_birthdayPicker];
    
}

#pragma mark -  性别选择
- (void)pressSexButton:(UIButton *)sender{
    NSLog(@"选择性别");
}


- (void)OneTop{

    [self.view endEditing:YES];
    [_birthdayPicker removeFromSuperview];
}

#pragma mark - 日期选择器的响应事件
-(void)dateChanged:(id)sender{
    UIDatePicker* control = (UIDatePicker*)sender;
    NSString * date =[NSString stringWithFormat:@"%@",control.date]
    ;
    /*添加你自己响应代码*/
    [_birthdayButton setTitle:[date substringToIndex:10] forState:UIControlStateNormal];
}

- (void)pressBackButton{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)pressDismissButton{
        [_alterView dismissWithClickedButtonIndex:0 animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag != 255) {
        TSLocateView *locateView = (TSLocateView *)actionSheet;
        TSLocation *location = locateView.locate;
        NSLog(@"city:%@ lat:%f lon:%f", location.city, location.latitude, location.longitude);
        if(buttonIndex == 0) {
            NSLog(@"Cancel");
        }else {
            [_addressButton setTitle:[NSString stringWithFormat:@"%@ %@",location.state,location.city] forState:UIControlStateNormal];
        }

    }
    
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
    }

}


#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self saveImage:image withName:@"currentImage.png"];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    isFullScreen = NO;
    [self.imageView setImage:savedImage];
    
    self.imageView.tag = 100;
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    isFullScreen = !isFullScreen;
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:self.view];
    
    CGPoint imagePoint = self.imageView.frame.origin;
    //touchPoint.x ，touchPoint.y 就是触点的坐标
    
    // 触点在imageView内，点击imageView时 放大,再次点击时缩小
    if(imagePoint.x <= touchPoint.x && imagePoint.x +self.imageView.frame.size.width >=touchPoint.x && imagePoint.y <=  touchPoint.y && imagePoint.y+self.imageView.frame.size.height >= touchPoint.y)
    {
        // 设置图片放大动画
        [UIView beginAnimations:nil context:nil];
        // 动画时间
        [UIView setAnimationDuration:1];
        
        if (isFullScreen) {
            // 放大尺寸
            self.imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 480*WIDTH_LENTH);
        }
        else {
            // 缩小尺寸
            self.imageView.frame = CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height);
        }
        // commit动画
        [UIView commitAnimations];
        
    }
    
}


#pragma mark - <UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{  //string就是此时输入的那个字符textField就是此时正在输入的那个输入框返回YES就是可以改变输入框的值NO相反
    
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (_nickNameTextField == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 11) { //如果输入框内容大于11则弹出警告
            textField.text = [toBeString substringToIndex:11];
            self.tipsView = [[TAlertView alloc]initWithTitle:@"提示:" andMessage:@"超过最大字数不能输入了!"];
            self.tipsView.timeToClose = 1;
            [self.tipsView show];
            return NO;
        }
    }
    
    if (_passWordTextField == textField)  //判断是否时我们想要限定的那个输入框
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
    
    if (textField == _nickNameTextField) {
        [_passWordTextField becomeFirstResponder];
    }
    
    if (textField == _passWordTextField) {
        [self.view endEditing:YES];
        [self pressAddressButton];
    }
    
    return YES;
}





@end
