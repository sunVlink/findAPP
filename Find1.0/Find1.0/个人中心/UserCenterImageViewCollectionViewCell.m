//
//  UserCenterImageViewCollectionViewCell.m
//  Find1.0
//
//  Created by APPLE on 15/9/15.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "UserCenterImageViewCollectionViewCell.h"

@implementation UserCenterImageViewCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}


- (void)initView{

    self.bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 117*WIDTH_LENTH, 117*WIDTH_LENTH)];
    [self addSubview:self.bgImageView];
    
    self.downView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 20*WIDTH_LENTH, self.frame.size.width, 20*WIDTH_LENTH)];
    self.downView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    [self addSubview:self.downView];
    
    self.priseImageView = [[UIImageView alloc]initWithFrame:CGRectMake(60*WIDTH_LENTH,2*WIDTH_LENTH , 15*WIDTH_LENTH, 15*WIDTH_LENTH)];
    [self.priseImageView setImage:[UIImage imageNamed:@"已赞@3x.png"]];
    [self.downView addSubview:self.priseImageView];
    
    self.priseLabel = [[UILabel alloc]initWithFrame:CGRectMake(80*WIDTH_LENTH, 0, 50*WIDTH_LENTH, 20*WIDTH_LENTH)];
    self.priseLabel.textColor = [UIColor whiteColor];
    self.priseLabel.textAlignment = NSTextAlignmentLeft;
    self.priseLabel.font = [UIFont systemFontOfSize:13*WIDTH_LENTH];
    [self.downView addSubview:self.priseLabel];
    
    self.timeUpLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 117*WIDTH_LENTH, 117*WIDTH_LENTH)];
    self.timeUpLabel.textColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    self.timeUpLabel.text = @"TIME UP";
    UIFont *yourFont = [UIFont fontWithName:@"Helvetica-BoldOblique" size:27*WIDTH_LENTH];
    self.timeUpLabel.font = yourFont;
    self.timeUpLabel.textAlignment = YES;
    [self addSubview:self.timeUpLabel];
    
    
}

@end
