//
//  ImageButton.m
//  Find1.0
//
//  Created by APPLE on 15/9/7.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "ImageButton.h"

@implementation ImageButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initWithView];
    }
    return self;
}


- (void)initWithView{
    self.userInteractionEnabled = YES;
    
    self.downView = [[UIView alloc]initWithFrame:CGRectMake(0, 75*WIDTH_LENTH,self.frame.size.width , 20*WIDTH_LENTH)];
    self.downView.alpha = 0.5;
    self.downView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.downView];
    
#pragma mark - 榜单中的单张图片王冠
    self.listImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0 , 75*WIDTH_LENTH, 20*WIDTH_LENTH, 20*WIDTH_LENTH)];
    [self addSubview:self.listImageView];
    
    
    UIImageView * heartImage = [[UIImageView alloc]initWithFrame:CGRectMake(55*WIDTH_LENTH, 77*WIDTH_LENTH, 15*WIDTH_LENTH, 15*WIDTH_LENTH)];
    [heartImage setImage:[UIImage imageNamed:@"已赞.png"]];
    [self addSubview:heartImage];
    
#pragma mark - 榜单中的单张图片的点赞数量
    
    self.priseLabel = [[UILabel alloc]initWithFrame:CGRectMake(80*WIDTH_LENTH,75*WIDTH_LENTH, 30*WIDTH_LENTH, 20*WIDTH_LENTH)];
    self.priseLabel.font = [UIFont systemFontOfSize:12*WIDTH_LENTH];
    self.priseLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.priseLabel];

}


@end
