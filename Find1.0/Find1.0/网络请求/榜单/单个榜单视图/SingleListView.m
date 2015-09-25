//
//  SingleListView.m
//  Find1.0
//
//  Created by APPLE on 15/9/2.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "SingleListView.h"
#import "PictureEntity.h"
#import "ImageButton.h"


@interface SingleListView ()

@property (nonatomic, strong) NSArray *pictureViews;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation SingleListView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 375*WIDTH_LENTH, 115*WIDTH_LENTH)];
    
    [self addSubview:self.scrollView];
    
    [self initPictureViews];
}

- (void)initPictureViews
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 10; i ++) {
        ImageButton * imageButton = [[ImageButton alloc]init];
        [array addObject:imageButton];
        [self.scrollView addSubview:imageButton];
    }
    self.pictureViews = array;
}


#pragma mark -

- (void)layoutContent:(NSArray *)array
{
    for (ImageButton *button in self.pictureViews) {
        button.hidden = YES;
    }
    
    for (int i = 0; i < array.count; i ++) {
        PictureEntity *entity = array[i];
        NSURL *picUrl = [NSURL URLWithString:entity.pictureUrl];
        ImageButton *button = self.pictureViews[i];
        button.hidden = NO;
        [button setFrame:CGRectMake(0+120*i*WIDTH_LENTH, 0*WIDTH_LENTH, 115*WIDTH_LENTH, 95*WIDTH_LENTH)];
        button.priseLabel.text = [NSString stringWithFormat:@"%@",entity.likeCount];
        [button sd_setImageWithPreviousCachedImageWithURL:picUrl andPlaceholderImage:[UIImage imageNamed:@"默认图片.png"] options:SDWebImageTransformAnimatedImage progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        
        if (i == 0) {
            [button.listImageView setImage:[UIImage imageNamed:@"金王冠.png"]];
        }
        if (i == 1) {
            [button.listImageView setImage:[UIImage imageNamed:@"银王冠.png"]];
        }
        if (i == 2) {
            [button.listImageView setImage:[UIImage imageNamed:@"铜王冠.png"]];
        }

        button.imageButton.tag = [entity.pictureId integerValue];
        [button.imageButton addTarget:self action:@selector(pressUserTagButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
    self.scrollView.contentSize = CGSizeMake(20000, 500);
    self.scrollView.userInteractionEnabled = YES;
}

- (void)pressUserTagButton:(UIButton *)sender{
    NSLog(@"%ld",sender.tag);
}

@end
