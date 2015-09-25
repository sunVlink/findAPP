//
//  MoveView.h
//  弹幕Demo1.2
//
//  Created by APPLE on 15/5/25.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import <UIKit/UIKit.h>


//@protocol MoveViewDelegate <NSObject>
//
//- (void)getImageNameArray:(NSArray *)name;
//
//@end



@interface MoveView : UIImageView

@property (nonatomic,strong)UIButton * headButton;
@property (nonatomic,strong)UIButton * headTwoButton;
@property (nonatomic,strong)UIButton * content;

@property (nonatomic,strong)NSMutableDictionary * dic;
@property (nonatomic,strong)NSArray * arr;
@property (nonatomic,assign)NSInteger a;
@property (nonatomic,strong)UIImageView * toUserExternalView;
@property (nonatomic,strong)UILabel * symbolLabel;
@property (nonatomic,strong)UIImageView * toUserHeadImageView;

- (instancetype)initWithFrame:(CGRect)frame NSMutableDictionary:(NSMutableDictionary *)dic;


//@property (copy, nonatomic)id <MoveViewDelegate> delegate;

@end
