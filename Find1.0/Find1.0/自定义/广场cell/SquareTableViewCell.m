//
//  SquareTableViewCell.m
//  Find1.0
//
//  Created by APPLE on 15/8/22.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "SquareTableViewCell.h"
#import "PersonTagView.h"
#import "ImageTagView.h"

@interface SquareTableViewCell ()

@property (nonatomic, strong) PersonTagView *tagView;
@property (nonatomic, strong) ImageTagView * imageTagView;

@end

@implementation SquareTableViewCell
@synthesize delegate = _delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initWithInterFace];
    }
    return self;
}

#pragma mark - 设置cell数据

- (void)configureCell:(SquareListEntity *)entity
{
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:entity.author.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    
    }];
    
    self.topHeadButton.tag = [entity.author.userId integerValue];
    
    [self.topHeadButton addTarget:self action:@selector(pressTopHeadButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.userNameLabel.text = entity.author.nickName;
    
    if ([entity.author.gender isEqual:@"1"]) {
        [self.userSex setImage:[UIImage imageNamed:@"B.png"]];
    }else{
        [self.userSex setImage:[UIImage imageNamed:@"G.png"]];
    }
    
    [self.tagView layoutContent:entity.author.userTags];
    
    [self.imageTagView layoutContent:entity.pictureTags];
    
    
    [self.bgImageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:entity.pictureUrl] andPlaceholderImage:[UIImage imageNamed:@"无图.png"]  options:SDWebImageTransformAnimatedImage  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    self.userInformationAddress.text = [NSString stringWithFormat:@"%@岁 %@",entity.author.age,entity.author.city];
    self.imageContentLabel.text = entity.title;
    self.imageContentLabel.font = [UIFont systemFontOfSize:15*WIDTH_LENTH];
    
    if ([entity.expireSeconds integerValue] == -1) {
        [self.imageDismissLabel removeFromSuperview];
    }else if ([entity.expireSeconds integerValue] < 3600 ) {
        [self.imageDismissLabel setFrame:CGRectMake(290*WIDTH_LENTH, 373*WIDTH_LENTH, 70*WIDTH_LENTH, 25*WIDTH_LENTH)];
        self.imageDismissLabel.layer.masksToBounds = YES;
        self.imageDismissLabel.layer.cornerRadius = 3*WIDTH_LENTH;
        self.imageDismissLabel.text = @"即将消失!";
    }else{
        [self.imageDismissLabel setFrame:CGRectMake(260*WIDTH_LENTH, 373*WIDTH_LENTH, 100*WIDTH_LENTH, 25*WIDTH_LENTH)];
        self.imageDismissLabel.text = [NSString stringWithFormat:@"%ld小时后消失",[entity.expireSeconds integerValue]/3600];
        self.imageDismissLabel.layer.masksToBounds = YES;
        self.imageDismissLabel.layer.cornerRadius = 3*WIDTH_LENTH;
        
    }
    
#pragma mark - 发表时间
    
    if ([entity.createMinute integerValue] < 60) {
        self.imageTimeLabel.text = [NSString stringWithFormat:@"%ld分钟前",(long)[entity.createMinute integerValue]];
    }else if ([entity.createMinute integerValue] >= 60 && [entity.createMinute integerValue] < 24 * 60) {
        self.imageTimeLabel.text = [NSString stringWithFormat:@"%ld小时",(long)[entity.createMinute integerValue]/60];
    }else{
        self.imageTimeLabel.text = [NSString stringWithFormat:@"%ld天前",(long)[entity.createMinute integerValue]/60/24];
    }
    
    self.imageAddresslabel.text = entity.location;
    
#pragma mark - 点赞
    
    self.priseDic = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)self.praiseButton.tag],@"tag",entity.pictureId,@"pictureID", nil];
    
    self.canprise = entity.canLike;
    
    if ([self.canprise integerValue]== 1) {
        [self.praiseButton setImage:[UIImage imageNamed:@"like_normal.png"] forState:UIControlStateNormal];
    }else{
        [self.praiseButton setImage:[UIImage imageNamed:@"已赞.png"] forState:UIControlStateNormal];
    }
    
//    [self.praiseButton addTarget:self action:@selector(pressPriseButton:) forControlEvents:UIControlEventTouchUpInside];

    
#pragma mark - 点赞数量
    
    self.praiseNumberLabel.text = [NSString stringWithFormat:@"%@",entity.likeCount];

#pragma mark - 大表情
    
//    [self.bigface addTarget:self action:@selector(pressBigfaceButton:) forControlEvents:UIControlEventTouchUpInside];

    
#pragma mark - 发消息
    
//    [self.messageButton addTarget:self action:@selector(pressMessageButton:) forControlEvents:UIControlEventTouchUpInside];
//    self.messageButton.tag = indexPath.row;
    
#pragma mark - 其他
    
//    [self.otherButton addTarget:self action:@selector(pressOtherButton:) forControlEvents:UIControlEventTouchUpInside];
//    self.otherButton.tag = indexPath.row;
}

#pragma mark - 点赞的事件
- (void)pressPriseButton:(UIButton *)sender{
    self.canprise = 0;
    [_delegate pressPriseButton:self.priseDic];
    NSLog(@"赞了");
}

- (void)initWithInterFace{

#pragma mark - 大背景
    
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 31 * WIDTH_LENTH, 375* WIDTH_LENTH, 375* WIDTH_LENTH)];
    [self addSubview:_bgImageView];
    _bgImageView.userInteractionEnabled = YES;
    
#pragma mark - 个人信息挡板
    
    UIView * informationView = [[UIView alloc]initWithFrame:CGRectMake(50* WIDTH_LENTH, 12* WIDTH_LENTH, 135* WIDTH_LENTH, 40*WIDTH_LENTH)];
    informationView.layer.cornerRadius = 3;
    informationView.backgroundColor = [UIColor whiteColor];
    informationView.alpha = 0.5;
    [self addSubview:informationView];
    
#pragma mark - 用户名字
    
    _userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80* WIDTH_LENTH, 12* WIDTH_LENTH , 100* WIDTH_LENTH, 20* WIDTH_LENTH)];
    _userNameLabel.textAlignment = YES;
    _userNameLabel.font = [UIFont systemFontOfSize:13*WIDTH_LENTH];
    _userNameLabel.textColor = [UIColor whiteColor];
    [self addSubview:_userNameLabel];
    
#pragma mark - 用户性别
    
    _userSex = [[UIImageView alloc]initWithFrame:CGRectMake(75* WIDTH_LENTH, 33* WIDTH_LENTH, 15* WIDTH_LENTH, 15* WIDTH_LENTH)];
    [self addSubview:_userSex];
    
#pragma mark - 用户年龄和地址
    
    _userInformationAddress = [[UILabel alloc]initWithFrame:CGRectMake(95* WIDTH_LENTH, 32* WIDTH_LENTH, 90* WIDTH_LENTH, 20* WIDTH_LENTH)];
    _userInformationAddress.font = [UIFont systemFontOfSize:12*WIDTH_LENTH];
    [self addSubview:_userInformationAddress];
    
#pragma mark - 用户顶部头像
    
    //    外部view
    UIImageView * externalView = [[UIImageView alloc]initWithFrame:CGRectMake(15*WIDTH_LENTH, 0, 60*WIDTH_LENTH, 60*WIDTH_LENTH)];
    [externalView setImage:[UIImage imageNamed:@"默认头像.jpg"]];
    externalView.layer.borderColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5].CGColor;
    externalView.layer.masksToBounds = YES;
    externalView.layer.borderWidth = 3*WIDTH_LENTH;
    externalView.layer.cornerRadius = externalView.frame.size.width / 2;
    [self addSubview:externalView];
    
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, externalView.frame.size.width - 6*WIDTH_LENTH , externalView.frame.size.height - 6*WIDTH_LENTH)];
    _headImageView.center = externalView.center;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width / 2;
    [self addSubview:_headImageView];
    
    //    内部view
    _topHeadButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,externalView.frame.size.width, externalView.frame.size.height)];
    _topHeadButton.center = externalView.center;
    _topHeadButton.layer.masksToBounds = YES;
    _topHeadButton.layer.cornerRadius = _topHeadButton.frame.size.width / 2;
    _topHeadButton.backgroundColor = [UIColor clearColor];
    [self addSubview:_topHeadButton];
    
#pragma mark - 顶部标签
    
    self.tagView = [[PersonTagView alloc] initWithFrame:CGRectMake(230*WIDTH_LENTH, 8*WIDTH_LENTH, 145*WIDTH_LENTH, 20*WIDTH_LENTH)];
    [self addSubview:self.tagView];
    

#pragma mark - 顶部标签挡板
    
    UIImageView * disMissImageView = [[UIImageView alloc]initWithFrame:CGRectMake(220*WIDTH_LENTH, 0, 30* WIDTH_LENTH, 25* WIDTH_LENTH)];
    [disMissImageView setImage:[UIImage imageNamed:@"dismiss.png"]];
    [self addSubview:disMissImageView];
    

#pragma mark - 图片消失时间
    self.imageDismissLabel = [UILabel new];
    self.imageDismissLabel.backgroundColor = [UIColor blackColor];
    self.imageDismissLabel.alpha = 0.7;
    self.imageDismissLabel.textColor = [UIColor whiteColor];
    self.imageDismissLabel.textAlignment = YES;
    self.imageDismissLabel.font = [UIFont systemFontOfSize:14*WIDTH_LENTH];
    [self addSubview:self.imageDismissLabel];
    
#pragma mark - 图片下面的标签
    
    self.imageTagView = [[ImageTagView alloc] initWithFrame:CGRectMake(0, 415*WIDTH_LENTH,Screen_width, 20*WIDTH_LENTH)];
    [self addSubview:self.imageTagView];
    
    
#pragma mark - 底部文字
    
    _imageContentStr = @"一段流年的时光，把握相随的温暖，世界那么大,回望平淡的人生，梳理成诗景意画.";
    _imageContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 , 0, 600, 400)];
    _imageContentLabel.text = _imageContentStr;
    _imageContentLabel.alpha = 1;
    _imageContentLabel.tag = 101;
    _imageContentLabel.font = [UIFont systemFontOfSize:15*WIDTH_LENTH];
    //设置文本行数（0为不限制行数）
    _imageContentLabel.numberOfLines = 0;
    //自适应文本框大小
    CGSize contantSize = CGSizeMake(280*WIDTH_LENTH, 40*WIDTH_LENTH);  //大小约束
    //获取能够显示完文本的大小
    CGRect autoRect = [_imageContentStr boundingRectWithSize:contantSize options: NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_imageContentLabel.font} context:nil];
    //用这个大小重新设置frame
    _imageContentLabel.frame = CGRectMake(0, 442*WIDTH_LENTH, autoRect.size.width, autoRect.size.height);
    [_imageContentLabel setTextColor:[UIColor colorWithRed:225/255.0 green:211/255.0 blue:179/255.0 alpha:1]];
    [self addSubview:_imageContentLabel];
    
    
#pragma mark - 底部时间和地址
    _imageTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(310* WIDTH_LENTH, 442* WIDTH_LENTH, 60* WIDTH_LENTH, 20* WIDTH_LENTH)];
    _imageTimeLabel.font = [UIFont systemFontOfSize:10];
    _imageTimeLabel.textColor = [UIColor colorWithRed:225/255.0 green:211/255.0 blue:179/255.0 alpha:1];
    [self addSubview:_imageTimeLabel];
    
    
    UIImageView * addressImageView = [[UIImageView alloc]initWithFrame:CGRectMake(295*WIDTH_LENTH, 467*WIDTH_LENTH, 8*WIDTH_LENTH, 10*WIDTH_LENTH)];
    [addressImageView setImage:[UIImage imageNamed:@"position.png"]];
    [self addSubview:addressImageView];
    
    _imageAddresslabel = [[UILabel alloc]initWithFrame:CGRectMake(310* WIDTH_LENTH, 462* WIDTH_LENTH, 60* WIDTH_LENTH, 20* WIDTH_LENTH)];
    _imageAddresslabel.font = [UIFont systemFontOfSize:10];
    
    _imageAddresslabel.textColor = [UIColor colorWithRed:225/255.0 green:211/255.0 blue:179/255.0 alpha:1];
    [self addSubview:_imageAddresslabel];
    
#pragma mark - 点赞按钮
    
    _praiseButton = [[UIButton alloc]initWithFrame:CGRectMake(20*WIDTH_LENTH,487*WIDTH_LENTH, 30*WIDTH_LENTH, 25*WIDTH_LENTH)];
    [self addSubview:_praiseButton];
    
#pragma mark - 点赞数量
    
    _praiseNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(55*WIDTH_LENTH,482*WIDTH_LENTH, 50*WIDTH_LENTH, 25*WIDTH_LENTH)];
    _praiseNumberLabel.font = [UIFont systemFontOfSize:15];
    _praiseNumberLabel.textColor = [UIColor colorWithRed:225/255.0 green:211/255.0 blue:179/255.0 alpha:1];
    [self addSubview:_praiseNumberLabel];
    
#pragma mark - 大表情按钮
    
    _bigface = [[UIButton alloc]initWithFrame:CGRectMake(130*WIDTH_LENTH,487*WIDTH_LENTH, 25*WIDTH_LENTH, 25*WIDTH_LENTH)];
    [_bigface setImage:[UIImage imageNamed:@"big_smile.png"] forState:UIControlStateNormal];
    [self addSubview:_bigface];
    
#pragma mark - 发消息按钮
    
    _messageButton = [[UIButton alloc]initWithFrame:CGRectMake(222*WIDTH_LENTH,487*WIDTH_LENTH, 25*WIDTH_LENTH, 25*WIDTH_LENTH)];
    [_messageButton setImage:[UIImage imageNamed:@"comment.png"] forState:UIControlStateNormal];
    [self addSubview:_messageButton];
    
#pragma mark - 其他按钮
    
    _otherButton = [[UIButton alloc]initWithFrame:CGRectMake(325*WIDTH_LENTH,487*WIDTH_LENTH, 25*WIDTH_LENTH, 25*WIDTH_LENTH)];
    [_otherButton setImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];
    //    [_otherButton addTarget:self action:@selector(pressOtherButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_otherButton];
    
}

#pragma mark - 头像点击事件
- (void)pressTopHeadButton:(UIButton *)sender{
    [_delegate UserHeadImageViewChick:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
