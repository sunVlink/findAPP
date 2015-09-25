//
//  RootViewController.h
//  Find1.0
//
//  Created by APPLE on 15/8/22.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SquareViewController.h"
#import "ListViewController.h"

@interface RootViewController : UIViewController

@property (nonatomic,strong)SquareViewController * squareVC;
@property (nonatomic,strong)ListViewController * listVC;

@property (nonatomic,strong)UIButton * squareButton;
@property (nonatomic,strong)UIButton * listButton;

@property (nonatomic,assign)BOOL isShow;


@property (nonatomic,strong)NSDictionary * loginUserData;
@property (nonatomic,strong)NSDictionary * UserData;

@end
