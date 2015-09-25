//
//  MoveView.m
//  弹幕Demo1.2
//
//  Created by APPLE on 15/5/25.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "MoveView.h"

@implementation MoveView

- (instancetype)initWithFrame:(CGRect)frame NSMutableDictionary:(NSMutableDictionary *)dic{
    
    self = [super initWithFrame:frame];
    
    if (self) {
         _dic = [[NSMutableDictionary alloc]initWithDictionary:dic];
        [self setView];
    }
    return self;
}


- (void)setView{
    
    
#pragma mark - 评论内容
    
    _content = [[UIButton alloc]initWithFrame:CGRectMake(130, -20, 150, 100)];
    [_content setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
#pragma mark - 发言者头像

    //    外部view
    UIImageView * externalView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    externalView.layer.borderColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5].CGColor;
    externalView.layer.masksToBounds = YES;
    externalView.layer.borderWidth = 3;
    externalView.layer.cornerRadius = externalView.frame.size.width / 2;
    [self addSubview:externalView];
    
    UIImageView * fromHeadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, externalView.frame.size.width - 6 , externalView.frame.size.height - 6)];
    [fromHeadImageView sd_setImageWithURL:[NSURL URLWithString:_dic[@"fromUser"][@"avatar"]] placeholderImage:[UIImage imageNamed:@"默认头像.jpg"]];
    fromHeadImageView.center = externalView.center;
    fromHeadImageView.layer.masksToBounds = YES;
    fromHeadImageView.userInteractionEnabled = YES;
    fromHeadImageView.layer.cornerRadius = fromHeadImageView.frame.size.width / 2;
    _headButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    _headButton.layer.masksToBounds = YES;
    _headButton.layer.cornerRadius = 25;
    [fromHeadImageView addSubview:_headButton];
    [self addSubview:fromHeadImageView];
    
    
#pragma mark - 被评论者的头像
    
    //    判断json数据是否为空
    if ( [_dic[@"toUser"] isEqual:[NSNull null]]) {
        [_content setFrame:CGRectMake(60, -20, 150, 100)];
    }else{
        //    外部view
        self.toUserExternalView = [[UIImageView alloc]initWithFrame:CGRectMake(70, 0, 50, 50)];
        self.toUserExternalView.layer.borderColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5].CGColor;
        self.toUserExternalView.layer.masksToBounds = YES;
        self.toUserExternalView.layer.borderWidth = 3;
        self.toUserExternalView.layer.cornerRadius = self.toUserExternalView.frame.size.width / 2;
        [self addSubview:self.toUserExternalView];
    
        self.toUserHeadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(70, 0, self.toUserExternalView.frame.size.width - 6 , self.toUserExternalView.frame.size.height - 6)];
        [self.toUserHeadImageView sd_setImageWithURL:[NSURL URLWithString:_dic[@"toUser"][@"avatar"]] placeholderImage:[UIImage imageNamed:@"默认头像.jpg"]];
        self.toUserHeadImageView.center = self.toUserExternalView.center;
        self.toUserHeadImageView.layer.masksToBounds = YES;
        self.toUserHeadImageView.layer.cornerRadius = self.toUserHeadImageView.frame.size.width / 2;
        self.toUserExternalView.userInteractionEnabled = YES;
        
        _headTwoButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        _headTwoButton.layer.masksToBounds = YES;
        _headTwoButton.layer.cornerRadius = 25;
        [self.toUserExternalView addSubview:_headTwoButton];
        
        [self addSubview:self.toUserHeadImageView];
        
        if ([_dic[@"toUser"] isEqual:[NSNull null]]) {
        }else{
#pragma mark - @符号
            self.symbolLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 15, 20, 20)];
            self.symbolLabel.text = @"@";
            self.symbolLabel.font = [UIFont systemFontOfSize:20];
            self.symbolLabel.textColor = [UIColor whiteColor];
            self.symbolLabel.textAlignment = YES;
            [self addSubview:self.symbolLabel];
        }

    }


    
    if ([_dic[@"type"] integerValue] == 3) {
        
        [self.toUserExternalView removeFromSuperview];
        [self.symbolLabel removeFromSuperview];
        [self.toUserHeadImageView removeFromSuperview];
        
        [_content setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.210:8888/ywkj-find-app-server/image/bigEmogj/%@.png",_dic[@"content"]]]]] forState:UIControlStateNormal];
         [_content  setFrame:CGRectMake(60, -10, 100, 75)];
        
    }else if([_dic[@"type"] integerValue] == 2){
        
        [self.toUserExternalView removeFromSuperview];
        [self.symbolLabel removeFromSuperview];
        [self.toUserHeadImageView removeFromSuperview];
        
        [_content setTitle:@"点了一个赞" forState:UIControlStateNormal];
        //        设置button文字向左显示
        _content.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(95, 40, 18, 18)];
        [imageView setImage:[UIImage imageNamed:@"已赞.png"]];
        [_content addSubview:imageView];
        [_content  setFrame:CGRectMake(60, -20, 150, 100)];
        
    }else if ([_dic[@"type"] integerValue] == 1){
        
        [_content setTitle:_dic[@"content"] forState:UIControlStateNormal];
        _content.titleLabel.font = [UIFont systemFontOfSize:13];
        _content.titleLabel.lineBreakMode = 0;
        _content.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
        [self addSubview:_content];

    self.userInteractionEnabled = YES;

}

@end
