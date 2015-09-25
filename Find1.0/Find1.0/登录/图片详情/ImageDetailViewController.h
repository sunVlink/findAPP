//
//  ImageDetailViewController.h
//  SquareDemo1.1
//
//  Created by APPLE on 15/6/24.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageDetailViewController : UIViewController

@property (nonatomic,strong)NSString * imageID;
@property (nonatomic,strong)NSDictionary * imageDic;
@property (nonatomic,strong)NSMutableArray * moveViewArr;
@property (nonatomic,strong)NSTimer * timer;
@property (nonatomic,strong)NSTimer * timerTwo;
@end
