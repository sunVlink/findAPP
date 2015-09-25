//
//  ListTableViewCell.h
//  SquareDemo1.1
//
//  Created by APPLE on 15/6/17.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol imageButtonDelegate <NSObject>

- (void)PressImageButtonDoSomething:(NSString *)str;

@end

@interface ListTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)NSDictionary * dic;
@property (nonatomic,strong)UIButton * imageButton;
@property (nonatomic,assign)double length;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier lenght:(double)length listDic:(NSDictionary *)dic;

@property (nonatomic,weak)id<imageButtonDelegate>delegate;

@end
