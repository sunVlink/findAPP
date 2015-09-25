//
//  SingleListView.h
//  Find1.0
//
//  Created by APPLE on 15/9/2.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleListView : UIView


@property (nonatomic,strong)NSArray * imageListArr;
@property (nonatomic,strong)NSArray * buttonListArr;

- (void)layoutContent:(NSArray *)array;

@end
