//
//  ImageTagView.m
//  Find1.0
//
//  Created by APPLE on 15/8/29.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "ImageTagView.h"
#import "ImageTagEntity.h"

#define padding 8

@interface ImageTagView ()

@property (nonatomic, strong) NSArray *tagViews;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ImageTagView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    [self addSubview:self.scrollView];
    
    [self initTagViews];
}

- (void)initTagViews
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 10; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0*WIDTH_LENTH];
        [array addObject:button];
        
        [self.scrollView addSubview:button];
    }
    self.tagViews = array;
}

#pragma mark -

- (void)layoutContent:(NSArray *)array
{
    for (UIButton *button in self.tagViews) {
        button.hidden = YES;
    }
    
    CGFloat width = 0;
    for (int i = 0; i < array.count; i ++) {
        ImageTagEntity * entity = array[i];
        NSString *title = entity.imageTitle;
        CGSize size = [title boundingRectWithSize:CGSizeMake(300*WIDTH_LENTH, CGFLOAT_MAX) options:(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11.0]} context:nil].size;
        UIButton *button = self.tagViews[i];
        [button setBackgroundImage:nil forState:(UIControlStateNormal)];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:(UIControlStateHighlighted)];
        [button sizeToFit];
        button.titleLabel.textAlignment = NSTextAlignmentLeft;
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 10*WIDTH_LENTH, 0, 0)];
        button.frame = CGRectMake(width, 0, size.width + 30*WIDTH_LENTH + title.length * 4*WIDTH_LENTH, 19*WIDTH_LENTH);
        
        UIImage *image = [UIImage imageNamed:@"图片标签.png"];
        CGFloat left = image.size.width * 0.5;
        CGFloat right = left - 1;
        CGFloat top = image.size.height * 0.5;
        CGFloat bottom = top - 1;
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right) resizingMode:UIImageResizingModeStretch];
        [button setBackgroundImage:image forState:(UIControlStateNormal)];
        width += CGRectGetWidth(button.bounds) + padding;
        button.hidden = NO;
        [button addTarget:self action:@selector(pressUserTagButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.scrollView.contentSize = CGSizeMake(width, 0);
}


#pragma mark - 点击标签的通知
- (void)pressUserTagButton:(UIButton *)sender{
    
    //添加 字典，将label的值通过key值设置传递
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:sender.titleLabel.text,@"title", nil];
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"getusertagtitle" object:nil userInfo:dict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

#pragma mark - getter

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}


@end
