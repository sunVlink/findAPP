//
//  HeadView.h
//  Test广场
//
//  Created by APPLE on 15/5/28.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import <UIKit/UIKit.h>

//协议
@protocol HeadViewDelegate <NSObject>

@optional

- (void)headViewDelegatedidSelectHeadView:(NSString *)userId;

@end

@interface HeadView : UIView 


- (instancetype)initWithFrame:(CGRect)frame Image:(UIImage *)image;


@property (nonatomic,strong)UIImage * headImage;
@property (nonatomic,strong)NSString *userId;
@property (nonatomic,strong)UIButton * insideView;

@property (nonatomic,assign)id<HeadViewDelegate> delegate;

@end
