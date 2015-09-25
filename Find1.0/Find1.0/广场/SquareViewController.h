//
//  SquareViewController.h
//  SquareDemo1.1
//
//  Created by APPLE on 15/6/6.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SquareListEntity.h"

@interface SquareViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView * squareTaleView;
@property (nonatomic,strong)NSMutableArray * squareArr;
@property (nonatomic,strong)UIImageView * noInternetBackImageView;
@property (nonatomic,strong)WZActivityIndicatorView * wZActivityView;
@property (nonatomic,strong)YYAnimationIndicator *indicator;
@property (nonatomic,strong)UIButton * getSourceButton;

@property (nonatomic,strong)NSMutableArray * praiseArr;
@property (nonatomic,strong)NSMutableArray * praiseNumberArr;

@property (nonatomic,assign)BOOL willReload;



@end
