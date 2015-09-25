//
//  SquareTableViewCell.h
//  Find1.0
//
//  Created by APPLE on 15/8/22.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SquareListEntity.h"
#import "PersonTagView.h"

@protocol SquareCellDelegate <NSObject>

- (void)pressPriseButton:(NSDictionary *)priseDic;
- (void)UserHeadImageViewChick:(NSString *)tag;

@end

@interface SquareTableViewCell : UITableViewCell
{
    id<SquareCellDelegate>delegate;
}

@property (nonatomic,weak)id<SquareCellDelegate>delegate;

@property (nonatomic,strong)PersonTagView * tagsView;
@property (nonatomic,strong)NSTimer * timer;             //计时器
@property (nonatomic,strong)UIImageView * bgImageView;    //背景图片
@property (nonatomic,strong)UIButton * topHeadButton;  //顶部头像
@property (nonatomic,strong)UIImageView * headImageView;  //头像图片
@property (nonatomic,strong)UILabel * praiseNumberLabel;  //点赞数量
@property (nonatomic,strong)UILabel * disappearTimeLabel;  //消失的时间
@property (nonatomic,strong)UILabel * imageContentLabel;  //图片发表的内容label
@property (nonatomic,strong)UILabel * imageAddresslabel;  //图片发表的地点
@property (nonatomic,strong)UILabel * imageTimeLabel;  //图片发表了多长时间
@property (nonatomic,strong)UILabel * userNameLabel;  //用户名
@property (nonatomic,strong)UIImageView * userSex;  //用户性别
@property (nonatomic,strong)UILabel * userInformationAddress;  //用户信息
@property (nonatomic,strong)UIScrollView * userTallyScrollView;  //用户标签
@property (nonatomic,strong)UILabel * imageDismissLabel;    //图片小时时间
@property (nonatomic,strong)UIButton * praiseButton;        //点赞按钮
@property (nonatomic,strong)UIButton * bigface;        //大表情按钮
@property (nonatomic,strong)UIButton * messageButton;        //发消息按钮
@property (nonatomic,strong)UIButton * otherButton;        //其他按钮
@property (nonatomic,strong)NSString * imageContentStr;        //图片发表的内容

@property (nonatomic,strong)NSDictionary * priseDic;
@property (nonatomic,strong)NSDictionary * bigfaceDic;

@property (nonatomic,strong)NSNumber * canprise;


- (void)configureCell:(SquareListEntity *)entity;

@end
