//
//  UserCenterViewController.h
//  Find1.0
//
//  Created by APPLE on 15/9/1.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCenterViewController : UIViewController

@property (nonatomic,strong)UIImageView * topImageView;
@property (nonatomic,strong)UIButton * backButton;
@property (nonatomic,strong)UIButton * aboutButton;
@property (nonatomic,strong)UIButton * settingButton;
@property (nonatomic,strong)UIImageView * topHeadImageView;
@property (nonatomic,strong)UILabel * nickNameLabel;
@property (nonatomic,strong)UILabel * idLabel;
@property (nonatomic,strong)UILabel * informationLabel;
@property (nonatomic,strong)UIImageView * sexImageView;

@property (nonatomic,strong)UILabel * photoNumberLabel;
@property (nonatomic,strong)UILabel * priseNumberLabel;
@property (nonatomic,strong)UILabel * CommentNumberLabel;
@property (nonatomic,strong)UILabel * friendNumberLabel;

@property (nonatomic,strong)YYAnimationIndicator *indicator;

@property (nonatomic,strong)UICollectionView * imageListCollectionView;

@property (nonatomic,strong)NSDictionary * userData;
@property (nonatomic,strong)NSMutableArray * userAllPicture;

@end
