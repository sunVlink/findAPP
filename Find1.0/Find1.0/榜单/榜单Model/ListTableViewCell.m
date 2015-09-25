//
//  ListTableViewCell.m
//  SquareDemo1.1
//
//  Created by APPLE on 15/6/17.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell
@synthesize delegate = _delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier lenght:(double)length listDic:(NSDictionary *)dic{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _length = length;
        self.dic = dic;
        [self settingView];
    }
    return self;

}

- (void)settingView{
    
#pragma  mark - 顶部标题
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200*_length, 30*_length)];
    self.titleLabel.textAlignment = UITextLayoutDirectionLeft;
    self.titleLabel.font = [UIFont systemFontOfSize:18*_length];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    
#pragma mark - UIScrollView
    UIScrollView * imageView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10*_length, 375*_length,115*_length)];
// 隐藏水平滚动条
    imageView.showsHorizontalScrollIndicator = NO;
    [self addSubview:imageView];
    
    NSArray * listArr = [[NSArray alloc]initWithArray:self.dic[@"listPicture"]];
    imageView.contentSize = CGSizeMake(listArr.count * 120*_length, 115*_length);
    NSArray * arr = [[NSArray alloc]initWithObjects:@"金王冠.png",@"银王冠.png",@"铜王冠.png", nil];
    
    for (int i  = 0; i < listArr.count; i++) {
#pragma mark - 榜单中的单张图片
        UIImageView * listImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0+120*i*_length, 20*_length, 115*_length, 115*_length)];
        [listImageView sd_setImageWithURL:[NSURL URLWithString:self.dic[@"listPicture"][i][@"pictureUrl"]] placeholderImage:[UIImage imageNamed:@"无图.png"]];
        [imageView addSubview:listImageView];
        
#pragma mark - 榜单中的单张图片的底部视图
        UIView * listDownView = [[UIView alloc]initWithFrame:CGRectMake(0, 75*_length,listImageView.frame.size.width , 20*_length)];
        listDownView.alpha = 0.5;
        listDownView.backgroundColor = [UIColor blackColor];
        [listImageView addSubview:listDownView];
        
        if (i < 3) {
#pragma mark - 榜单中的单张图片前三名的王冠
                UIImageView * listNumberImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0 , 75*_length, 20*_length, 20*_length)];
                [listNumberImageView setImage:[UIImage imageNamed:arr[i]]];
                [listImageView addSubview:listNumberImageView];
        }

        
        UIImageView * heartImage = [[UIImageView alloc]initWithFrame:CGRectMake(55*_length, 77*_length, 15*_length, 15*_length)];
        [heartImage setImage:[UIImage imageNamed:@"已赞.png"]];
        [listImageView addSubview:heartImage];
        
#pragma mark - 榜单中的单张图片的点赞数量
        UILabel * numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(80*_length,75*_length, 30*_length, 20*_length)];
        numberLabel.font = [UIFont systemFontOfSize:12*_length];
        numberLabel.text = [NSString stringWithFormat:@"%@",self.dic[@"listPicture"][i][@"likeCount"]];
        numberLabel.textColor = [UIColor whiteColor];
        [listImageView addSubview:numberLabel];
        
#pragma mark - 榜单点击按钮
         self.imageButton = [[UIButton alloc]initWithFrame:CGRectMake(0+120*i*_length, 20*_length, 115*_length, 115*_length)];
        self.imageButton.backgroundColor = [UIColor clearColor];
        self.imageButton.tag = [self.dic[@"listPicture"][i][@"pictureId"] integerValue];
        [self.imageButton addTarget:self action:@selector(PressImageButton:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:self.imageButton];
    }
}


- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)PressImageButton:(UIButton *)sender{
    [_delegate PressImageButtonDoSomething:[NSString stringWithFormat:@"%ld",sender.tag]];
}

@end
