//
//  HeadView.m
//  Test广场
//
//  Created by APPLE on 15/5/28.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView
@synthesize delegate = _HeadViewDelegate;

- (instancetype)initWithFrame:(CGRect)frame Image:(UIImage *)image{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        _userId = @"123";
        _headImage = image;
        [self setView];
    }
    
    return self;
}

- (void)setView{
//    外部view
    UIView * externalView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    externalView.layer.borderColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5].CGColor;
    externalView.layer.borderWidth = 3;
    externalView.layer.cornerRadius = externalView.frame.size.width / 2;
    [self addSubview:externalView];
//    内部view
     _insideView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,externalView.frame.size.width - 6 , externalView.frame.size.height - 6)];
//    insideView.backgroundColor = [UIColor colorWithPatternImage:_headImage];
    _insideView.center = externalView.center;
    [_insideView setImage:_headImage forState:UIControlStateNormal];
    _insideView.layer.masksToBounds = YES;
    _insideView.layer.cornerRadius = _insideView.frame.size.width / 2;
//    [_insideView addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [externalView addSubview:_insideView];

}


//-(void)pressButton:(UIButton *)sender
//{
//    [self.delegate headViewDelegatedidSelectHeadView:_userId];
//    NSLog(@"%@",_userId);
//    
//}

@end

